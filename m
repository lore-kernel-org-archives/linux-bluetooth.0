Return-Path: <cyrus@holtmann.org>
Message-ID: <482356E2.3050909@jlab.org>
Date: Thu, 08 May 2008 15:39:14 -0400
From: Chris Carlin <carlin@jlab.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <48171A58.8060200@powercraft.nl>
In-Reply-To: <48171A58.8060200@powercraft.nl>
Subject: Re: [Bluez-users] step by step - how to get your bluetooth stereo
 headset fully working with the bluez software stack under linux
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Just to finish this up, Jelle, what type of bluetooth adapter do you have?

~Chris

Jelle de Jong wrote:
> Hello everybody,
>
> I have been playing around with bluetooth devices under linux the last 
> month or so. I got some very good and some very bad experience with it.
>
> I am planning to create some wiki pages when I can get things working 
> 100%. However I still got some major issues that I need to overcome.
>
> I bought a Motorola Bluetooth S805 stereo headset. It should get the 
> following functionality:
>
> - Playback of stereo quality audio without distortions and without delay 
> when playing audio and video at the same time.
> - Generic playback controls like playpause/stop/next/previous.
> - Internal microphone to record audio, used for audio recordings and 
> audio video conferences.
>
> I was planning to get things up and running step by step:
> - alsa configuration
> - bluetooth configuration
> - input device configuration
>
> So the alsa configuration exist out of:
> -- handle multiple audio streams (slave devices)
> -- make the device default or as a plugin
> -- use multiple bluetooth headset for the same audio (conference)
> -- use multiple bluetooth headset per user based (multiseat)
> -- force audio to use the correct bit-rate and frequency for the devices?
> -- set-up correct buffer so that playback is without distortions of out 
> of sync audio and video. (testing with totem-xine?)
> -- configure multiple profiles for stereo recording/playback
>
> Would somebody be willing to sent his working alsa configuration files 
> that can do some of the above functions:
>
> On this moment the headset plays stereo audio, but when watching video 
> with and audio dvd on totem-xine the audio is out of sync and when 
> scrolling or skipping chapters it get worse and hidd can even crash with 
> segmentation faults. There is also a lot of noise distortions.
>
> Kind regards,
>
> Jelle
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
> Don't miss this year's exciting event. There's still time to save $100. 
> Use priority code J8TL2D2. 
> http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>   


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
