package;

import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;
	public var furiosityScale:Float = 1.02;
	public var canDance:Bool = true;

	public var nativelyPlayable:Bool = false;

	public var globaloffset:Array<Float> = [0,0];
	
	public var barColor:FlxColor;
	
	public var canSing:Bool = true;
	public var recursedSkin:String = 'bf-recursed';
	public var positionOffset:FlxPoint;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		
		antialiasing = true;

		switch (curCharacter)
		{
			case 'bf':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND', 'shared');
				frames = tex;
				
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
				animation.addByPrefix('dodge', "boyfriend dodge", 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24);
				animation.addByPrefix('hit', 'BF hit', 24, false);

				loadOffsetFile(curCharacter);

				barColor = FlxColor.fromRGB(49, 176, 209);

				playAnim('idle');

				nativelyPlayable = true;

				flipX = true;
			case 'bf-pixel':
				frames = Paths.getSparrowAtlas('weeb/bfPixel', 'shared');
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				loadOffsetFile(curCharacter);
					
				globaloffset[0] = -200;
				globaloffset[1] = -175;

				barColor = FlxColor.fromRGB(49, 176, 209);
				
				
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				
				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				nativelyPlayable = true;

				flipX = true;
				
			case 'bf-pixel-dead':
				frames = Paths.getSparrowAtlas('weeb/bfPixelsDEAD', 'shared');
				animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
				animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
				
				loadOffsetFile(curCharacter);

				playAnim('firstDeath');
				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
				nativelyPlayable = true;
				flipX = true;
			
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assets', 'shared');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				loadOffsetFile(curCharacter);

				barColor = FlxColor.fromString('#33de39');

				playAnim('danceRight');
			case 'gf-pixel':
				tex = Paths.getSparrowAtlas('weeb/gfPixel', 'shared');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				globaloffset[0] = -200;
				globaloffset[1] = -175;
				
				loadOffsetFile(curCharacter);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

			case 'dave':
				// DAVE SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('dave/characters/dave_sheet', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', '${anim}0', 24, false);
					animation.addByPrefix('sing${anim.toUpperCase()}miss', '$anim miss', 24, false);
				}
				animation.addByPrefix('hey', 'hey', 24, false);
	
				recursedSkin = 'dave-recursed';
				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
				
				barColor = FlxColor.fromRGB(15, 95, 255);

				playAnim('idle');
			case 'dave-annoyed':
				// DAVE SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('dave/characters/Dave_insanity_lol', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('scared', 'scared', 24, true);
				animation.addByPrefix('hey', 'hey', 24, false);
	
				loadOffsetFile(curCharacter);
				
				barColor = FlxColor.fromRGB(15, 95, 255);

				playAnim('idle');
			case 'dave-cool':
				// DAVE SHITE ANIMATION LOADING CODE
				frames = Paths.getSparrowAtlas('dave/characters/thecoolerdave', 'shared');
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
	
				loadOffsetFile(curCharacter);
				
				barColor = FlxColor.fromRGB(15, 95, 255);
	
				playAnim('idle');

			case 'dave-angey':
				// DAVE SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('dave/characters/Dave_3D', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
		
				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
				
				barColor = FlxColor.fromRGB(249, 180, 207);

				setGraphicSize(Std.int((width * 0.8) / furiosityScale));
				updateHitbox();
				antialiasing = false;
		
				playAnim('idle');
			case 'dave-fnaf':
				frames = Paths.getSparrowAtlas('dave/characters/dave_fnaf', 'shared');
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);

				loadOffsetFile(curCharacter);

				barColor = FlxColor.fromRGB(15, 95, 255);

				playAnim('idle');
				
			case 'dave-splitathon':
				frames = Paths.getSparrowAtlas('splitathon/Splitathon_Dave', 'shared');
				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}
				animation.addByPrefix('scared', 'waiting', 24, true);
				animation.addByPrefix('what', 'bruh', 24, true);
				animation.addByPrefix('happy', 'happy', 24, true);

				loadOffsetFile(curCharacter);
				
				barColor = FlxColor.fromRGB(15, 95, 255);

				playAnim('idle');
			case 'dave-recursed':
				frames = Paths.getSparrowAtlas('recursed/Dave_Recursed', 'shared');

				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', '${anim}0', 24, false);
					animation.addByPrefix('sing${anim.toUpperCase()}miss', '$anim miss', 24, false);
				}

				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));

				barColor = FlxColor.WHITE;

				playAnim('idle');
			case 'dave-death':
				frames = Paths.getSparrowAtlas('dave/characters/Dave_Dead', 'shared');

				animation.addByPrefix('firstDeath', 'dave dead hit', 24, false);
				animation.addByPrefix('deathLoop', 'dave dead loop', 24, true);
				animation.addByPrefix('deathConfirm', 'dave dead retry confirm', 24, false);

				loadOffsetFile(curCharacter);
				playAnim('firstDeath');
				
			case 'bambi':
				var tex = Paths.getSparrowAtlas('bambi/characters/bambi', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS0', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS0', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS0', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS0', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
	
				barColor = FlxColor.fromRGB(37, 191, 55);

				loadOffsetFile(curCharacter);

				playAnim('idle');

				nativelyPlayable = true;
				flipX = true;

			case 'bambi-new':
				frames = Paths.getSparrowAtlas('bambi/bambiRemake', 'shared');
				animation.addByPrefix('idle', 'bambi idle', 24, false);
				animation.addByPrefix('singDOWN', 'bambi down', 24, false);
				animation.addByPrefix('singUP', 'bambi up', 24, false);
				animation.addByPrefix('singLEFT', 'bambi left', 24, false);
				animation.addByPrefix('singRIGHT', 'bambi right', 24, false);
				animation.addByPrefix('singSmash', 'bambi phone', 24, false);

				barColor = FlxColor.fromRGB(37, 191, 55);

				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));

				playAnim('idle');

			case 'baldi':
				frames = Paths.getSparrowAtlas('characters/BaldiInRoof', 'shared');
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);

				loadOffsetFile(curCharacter);

				barColor = FlxColor.fromRGB(14, 174, 44);

				playAnim('idle');

			case 'bambi-splitathon':
				frames = Paths.getSparrowAtlas('splitathon/Splitathon_Bambi', 'shared');
				animation.addByPrefix('idle', 'splitathon idle', 24, true);
				animation.addByPrefix('singDOWN', 'splitathon down', 24, false);
				animation.addByPrefix('singUP', 'splitathon up', 24, false);
				animation.addByPrefix('singLEFT', 'splitathon left', 24, false);
				animation.addByPrefix('singRIGHT', 'splitathon right', 24, false);
				animation.addByPrefix('yummyCornLol', 'splitathon corn', 24, true);
				animation.addByPrefix('umWhatIsHappening', 'confused Idle', 24, true);
							
				loadOffsetFile(curCharacter);
				
				barColor = FlxColor.fromRGB(37, 191, 55);

				playAnim('idle');

			case 'bambi-angey':
				frames = Paths.getSparrowAtlas('bambi/bambimaddddd', 'shared');
				animation.addByPrefix('idle', 'idle', 24, true);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);

				barColor = FlxColor.fromRGB(37, 191, 55);

				loadOffsetFile(curCharacter);

				playAnim('idle');
	
			case 'bambi-3d':
				// BAMBI SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('bambi/characters/Cheating', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('singUP', 'Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Right', 24, false);
				animation.addByPrefix('singDOWN', 'Down', 24, false);
				animation.addByPrefix('singLEFT', 'Left', 24, false);
		
				barColor = FlxColor.fromRGB(17, 223, 10);

				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));

				globaloffset[0] = 150;
				globaloffset[1] = 450; //this is the y
				setGraphicSize(Std.int((width * 1.5) / furiosityScale));
				updateHitbox();
				antialiasing = false;
		
				playAnim('idle');
			

			case 'bambi-unfair':
				// BAMBI SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('bambi/unfair_bambi', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'singUP', 24, false);
				animation.addByPrefix('singRIGHT', 'singRIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'singDOWN', 24, false);
				animation.addByPrefix('singLEFT', 'singLEFT', 24, false);
		
				barColor = FlxColor.fromRGB(178, 7, 7);

				loadOffsetFile(curCharacter);
				playAnim('idle');

				antialiasing = false;
				
				globaloffset[0] = 150 * 1.3;
				globaloffset[1] = 450 * 1.3; //this is the y
				setGraphicSize(Std.int((width * 1.3) / furiosityScale));
				updateHitbox();
				
			case 'expunged':
				// EXPUNGED SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('bambi/ExpungedFinal', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('singUP', 'Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Right', 24, false);
				animation.addByPrefix('singDOWN', 'Down', 24, false);
				animation.addByPrefix('singLEFT', 'Left', 24, false);
		
				loadOffsetFile(curCharacter);
				playAnim('idle');

				barColor = FlxColor.fromRGB(82, 15, 15);
				antialiasing = false;
				
				globaloffset[0] = 150 * 0.8;
				globaloffset[1] = 450 * 0.8; //this is the y
				
				setGraphicSize(Std.int((width * 0.8) / furiosityScale));
				updateHitbox();
			case 'bambi-old':
				var tex = Paths.getSparrowAtlas('bambi/characters/bambi-old', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'MARCELLO idle dance', 24, false);
				animation.addByPrefix('singUP', 'MARCELLO NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'MARCELLO NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'MARCELLO NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'MARCELLO NOTE DOWN0', 24, false);
				animation.addByPrefix('idle', 'MARCELLO idle dance', 24, false);
				animation.addByPrefix('singUPmiss', 'MARCELLO MISS UP0', 24, false);
				animation.addByPrefix('singLEFTmiss', 'MARCELLO MISS LEFT0', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'MARCELLO MISS RIGHT0', 24, false);
				animation.addByPrefix('singDOWNmiss', 'MARCELLO MISS DOWN0', 24, false);

				animation.addByPrefix('firstDeath', "MARCELLO dead0", 24, false);
				animation.addByPrefix('deathLoop', "MARCELLO dead0", 24, true);
				animation.addByPrefix('deathConfirm', "MARCELLO dead0", 24, false);

				loadOffsetFile(curCharacter);
				playAnim('idle');

				barColor = FlxColor.fromRGB(12, 181, 0);
				nativelyPlayable = true;
				flipX = true;

			case 'bambi-shredder':
				frames = Paths.getSparrowAtlas('festival/bambi_shredder', 'shared');
				animation.addByPrefix('idle', 'shredder idle', 24, false);
				animation.addByPrefix('singLEFT', 'shredder left', 24, false);
				animation.addByPrefix('singDOWN', 'shredder down', 24, false);
				animation.addByPrefix('singUP', 'shredder up', 24, false);
				animation.addByPrefix('singRIGHT', 'shredder right', 24, false);
				animation.addByPrefix('takeOut', 'shredder take out', 24, false);

				barColor = FlxColor.fromRGB(37, 191, 55);

				loadOffsetFile(curCharacter);
			case 'tristan':
				frames = Paths.getSparrowAtlas('dave/Tristan', 'shared');
				
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				for (anim in ['LEFT', 'DOWN', 'UP', 'RIGHT'])
				{
					animation.addByPrefix('sing$anim', 'BF NOTE ${anim} instance', 24, false);
					animation.addByPrefix('sing${anim}miss', 'BF NOTE $anim MISS', 24, false);
				}
				animation.addByPrefix('hey', 'BF HEY', 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24);
	
				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));

				playAnim('idle');

				barColor = FlxColor.fromRGB(255, 19, 15);
				nativelyPlayable = true;
				flipX = true;

				recursedSkin = 'tristan-recursed';

			case 'tristan-death':
				frames = Paths.getSparrowAtlas('dave/Tristan_Dead', 'shared');

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				loadOffsetFile(curCharacter);
				playAnim('firstDeath');

			case 'tristan-golden':
			   var tex = Paths.getSparrowAtlas('dave/tristan_golden', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
	
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
				animation.addByPrefix('dodge', "boyfriend dodge", 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24);
				animation.addByPrefix('hit', 'BF hit', 24, false);
	
				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
				
				barColor = FlxColor.fromRGB(255, 222, 0);
				
				playAnim('idle');

				nativelyPlayable = true;
				recursedSkin = 'tristan-recursed';
	
				flipX = true;
			case 'tristan-golden-glowing':
				var tex = Paths.getSparrowAtlas('dave/tristan_golden_glowing', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
		
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
				animation.addByPrefix('dodge', "boyfriend dodge", 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24);
				animation.addByPrefix('hit', 'BF hit', 24, false);
		
				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
					
				barColor = FlxColor.fromRGB(255, 222, 0);
					
				playAnim('idle');
	
				nativelyPlayable = true;
		
				flipX = true;	
			case 'tristan-festival':
				frames = Paths.getSparrowAtlas('festival/tristan_festival');
				
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				
				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
				
				barColor = FlxColor.fromRGB(255, 19, 15);
				
				nativelyPlayable = true;
				flipX = true;
				playAnim('idle');
			case 'exbungo':
				var tex = Paths.getSparrowAtlas('bambi/exbungo', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);

				loadOffsetFile(curCharacter);
				
				barColor = FlxColor.fromRGB(253, 39, 33);

				playAnim('idle');
	
				nativelyPlayable = true;
	
				flipX = true;

				setGraphicSize(Std.int((width * 1.3) / furiosityScale));
				updateHitbox();
	
				antialiasing = false;

			case 'recurser':
				frames = Paths.getSparrowAtlas('recursed/Recurser', "shared");

				animation.addByPrefix('idle', 'recursedIdle', 24, false);
				animation.addByPrefix('singLEFT', 'recursedLeft', 24, false);
				animation.addByPrefix('singDOWN', 'recursedDown', 24, false);
				animation.addByPrefix('singUP', 'recursedUp', 24, false);
				animation.addByPrefix('singRIGHT', 'recursedRight', 24, false);

				barColor = FlxColor.fromRGB(44, 44, 44);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'bf-recursed':
				frames = Paths.getSparrowAtlas('recursed/Recursed_BF', 'shared');

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				for (anim in ['LEFT', 'DOWN', 'UP', 'RIGHT'])
				{
					animation.addByPrefix('sing$anim', 'BF NOTE ${anim}0', 24, false);
					animation.addByPrefix('sing${anim}miss', 'BF NOTE $anim MISS', 24, false);
				}
				animation.addByPrefix('firstDeath', 'BF dies', 24, false);
				animation.addByPrefix('deathLoop', 'BF Dead Loop', 24, false);
				animation.addByPrefix('deathConfirm', 'BF Dead confirm', 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24, false);

				loadOffsetFile(curCharacter);
				
				barColor = FlxColor.WHITE;
				nativelyPlayable = true;
				flipX = true;

				playAnim('idle');
				case 'tristan-recursed':
					frames = Paths.getSparrowAtlas('recursed/TristanRecursed', 'shared');
	
					animation.addByPrefix('idle', 'BF idle dance', 24, false);
					animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
					animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
					animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
					animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
	
					animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
					animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
					animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
	
					animation.addByPrefix('firstDeath', 'BF dies', 24, false);
					animation.addByPrefix('deathLoop', 'BF Dead Loop', 24, false);
					animation.addByPrefix('deathConfirm', 'BF Dead confirm', 24, false);
					animation.addByPrefix('scared', 'BF idle shaking', 24, false);
	
					flipX = true;
					barColor = FlxColor.WHITE;
					
					loadOffsetFile(curCharacter);
					
					nativelyPlayable = true;
	
					playAnim('idle');	
				case 'tb-funny-man':
					tex = Paths.getSparrowAtlas('characters/DONT_GO_SNOOPING_WHERE_YOURE_NOT_SUPPOSED_TO', 'shared');
					frames = tex;
	
					animation.addByPrefix('idle', 'idle dance', 24, false);
					animation.addByPrefix('singUP', 'NOTE UP0', 24, false);
					animation.addByPrefix('singLEFT', 'NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHT', 'NOTE RIGHT0', 24, false);
					animation.addByPrefix('singDOWN', 'NOTE DOWN0', 24, false);
					animation.addByPrefix('singUPmiss', 'NOTE UP MISS', 24, false);
					animation.addByPrefix('singLEFTmiss', 'NOTE LEFT MISS', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'NOTE RIGHT MISS', 24, false);
					animation.addByPrefix('singDOWNmiss', 'NOTE DOWN MISS', 24, false);
					animation.addByPrefix('hey', 'HEY!!', 24, false);
	
					//animation.addByPrefix('firstDeath', "LOL NO RESTARTING FOR YOU BUCKO", 24, false);
					//animation.addByPrefix('deathLoop', "YOU GONNA HAVE TO RESTART", 24, true);
					//animation.addByPrefix('deathConfirm', "IF YOU CAN SEE THIS YOU HAVE BEEN EPICLY TROLLED!!!", 24, false);
					animation.addByPrefix('scared', 'idle shaking', 24);
	
					loadOffsetFile(curCharacter);

					recursedSkin = 'tb-recursed';
	
					flipX = true;
					barColor = FlxColor.fromRGB(102, 255, 0);
	
					nativelyPlayable = true;
					
				playAnim('idle');
				case 'tb-recursed':
					tex = Paths.getSparrowAtlas('recursed/STOP_LOOKING_AT_THE_FILES', 'shared');
					frames = tex;
	
					animation.addByPrefix('idle', 'BF idle dance', 24, false);
					animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
					animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
					animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
					animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
					animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
					animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
					animation.addByPrefix('hey', 'BF HEY!!', 24, false);
	
					//animation.addByPrefix('firstDeath', "LOL NO RESTARTING FOR YOU BUCKO", 24, false);
					//animation.addByPrefix('deathLoop', "YOU GONNA HAVE TO RESTART", 24, true);
					//animation.addByPrefix('deathConfirm', "IF YOU CAN SEE THIS YOU HAVE BEEN EPICLY TROLLED!!!", 24, false);
					animation.addByPrefix('scared', 'BF idle shaking', 24);
	
					loadOffsetFile(curCharacter);
	
					flipX = true;
					barColor = FlxColor.WHITE;
	
					nativelyPlayable = true;
					
				playAnim('idle');

			case 'stereo':
				tex = Paths.getSparrowAtlas('characters/IM_GONNA_TORNADER_YOU_AWAY', 'shared');
				frames = tex;

				animation.addByPrefix('idle', 'bump', 24, false);

				loadOffsetFile(curCharacter);
					
				playAnim('idle');	
		}
		dance();

		if(isPlayer)
		{
			flipX = !flipX;
		}
	}
	function loadOffsetFile(character:String)
	{
		var offsetStuffs:Array<String> = CoolUtil.coolTextFile(Paths.offsetFile(character));
		
		for (offsetText in offsetStuffs)
		{
			var offsetInfo:Array<String> = offsetText.split(' ');

			addOffset(offsetInfo[0], Std.parseFloat(offsetInfo[1]), Std.parseFloat(offsetInfo[2]));
		}
	}

	override function update(elapsed:Float)
	{
		if (animation == null)
		{
			super.update(elapsed);
			return;
		}
		else if (animation.curAnim == null)
		{
			super.update(elapsed);
			return;
		}
		if (!nativelyPlayable && !isPlayer)
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode && canDance)
		{
			switch (curCharacter)
			{
				case 'gf' | 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight', true);
						else
							playAnim('danceLeft', true);
					}
				default:
					playAnim('idle', true);
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		if (animation.getByName(AnimName) == null)
		{
			return; //why wasn't this a thing in the first place
		}
		if(AnimName.toLowerCase() == 'idle' && !canDance)
		{
			return;
		}
		
		if(AnimName.toLowerCase().startsWith('sing') && !canSing)
		{
			return;
		}
		
		animation.play(AnimName, Force, Reversed, Frame);
	
		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			if (isPlayer)
			{
				if(!nativelyPlayable)
				{
					offset.set((daOffset[0] * -1) + globaloffset[0], daOffset[1] + globaloffset[1]);
				}
				else
				{
					offset.set(daOffset[0] + globaloffset[0], daOffset[1] + globaloffset[1]);
				}
			}
			else
			{
				if(nativelyPlayable)
				{
					offset.set((daOffset[0] * -1), daOffset[1]);
				}
				else
				{
					offset.set(daOffset[0], daOffset[1]);
				}
			}
		}
		
		else
			offset.set(0, 0);
	
		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}
	
			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
