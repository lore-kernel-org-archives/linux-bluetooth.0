Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41DE36E2.5030404@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco under FC3
References: <5256d0b05010520461ad68ff3@mail.gmail.com>	 <1105014278.4299.19.camel@pegasus> <5256d0b05010622152c32d3f4@mail.gmail.com>
In-Reply-To: <5256d0b05010622152c32d3f4@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 07 Jan 2005 00:14:42 -0700

Peter,

It's not a real daemon. You run it in the foreground and click the 
connect button on the headset. Then you can send and receive audio from 
another app.

Brad

Peter Robinson wrote:
>>>Just trying to compile btsco under FC3 and have run into a little
>>>trouble compiling the latest CVS version. I can't actually get it to
>>>compile as yet but will include the HW details FYI.
>>>
>>>D-Link DBT-120 rev B2
>>>Headset Motorola HS-810
>>>I also have a Motorola HS-850 on the way (the 810 is actually a friends).
>>>
>>>The actual problem is that it can't locate the @AO_CFLAGS@ directory
>>>during compile. I'm following the directions on the website.
>>
>>what about installing the AO library development package.
> 
> 
> OK with a Motorola HS-810 headset I get it all compiled and when
> following the instructions on the web site I get the following.
> 
> The one question I have is regarding btsco. When you run the command
> with a BT Mac address is it suppose to return to the command prompt or
> is it like a daemon?
> 
> As seen below it detects the device, the voice settings and connects
> with a RFCOMM channel but then it just sits there. I end up just
> putting it into the background and try running the varoius examples.
> Output of all included below. I get no sound at all. any ideas or
> suggestions?
> 
> Pete
> 
> [root@trinity btsco]# btsco 00:07:A4:0E:69:3D
> Device is 1:0
> Voice setting: 0x0060
> RFCOMM channel 1 connected
> 
> 
> [1]+  Stopped                 btsco 00:07:A4:0E:69:3D
> [root@trinity btsco]# bg
> [1]+ btsco 00:07:A4:0E:69:3D &
> [root@trinity btsco]# mpg123 --au -
> /home/audio/mp3/green_day/american_idiot/green_day-boulevard_of_broken_dreams.mp3
> | sbc/sbcenc - | ./a2play 00:07:A4:0E:69:3D
> High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2, and 3.
> Version 0.59q (2002/03/23). Written and copyrights by Joe Drew.
> Uses code from various people. See 'README' for more!
> THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!
> Title  : Boulevard Of Broken Dreams      Artist: Green Day
> Album  : American Idiot                  Year  : 2004
> Comment:                                 Genre : Punk Rock
> 
> Directory: /home/audio/mp3/green_day/american_idiot/
> Playing MPEG stream from green_day-boulevard_of_broken_dreams.mp3 ...
> MPEG 1.0 layer III, 128 kbit/s, 44100 Hz joint-stereo
> subbands = 1
> allocation method = 1
> channel_mode = 2
> blocks = 3
> sampling frequency = 2
> bitpool = 32
> frame len = 72
> Using address: 00:07:A4:0E:69:3D
> Can't connect to 3D:69:0E:A4:07:00. Invalid argument(22)
> cannot open psm_cmd = 0
> [root@trinity btsco]# mpg123 --au -
> /home/audio/mp3/green_day/american_idiot/green_day-boulevard_of_broken_dreams.mp3
> | sbc/sbcenc - | ./sbc/rcplay 00:07:A4:0E:69:3D -
> High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2, and 3.
> Version 0.59q (2002/03/23). Written and copyrights by Joe Drew.
> Uses code from various people. See 'README' for more!
> THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!
> Title  : Boulevard Of Broken Dreams      Artist: Green Day
> Album  : American Idiot                  Year  : 2004
> Comment:                                 Genre : Punk Rock
> 
> Directory: /home/audio/mp3/green_day/american_idiot/
> Playing MPEG stream from green_day-boulevard_of_broken_dreams.mp3 ...
> MPEG 1.0 layer III, 128 kbit/s, 44100 Hz joint-stereo
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
