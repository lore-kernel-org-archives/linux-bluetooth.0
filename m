Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300804291959m6589b95fse31e8227c37c8f1f@mail.gmail.com>
Date: Tue, 29 Apr 2008 20:59:47 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <4817DAE3.6050406@gmail.com>
MIME-Version: 1.0
References: <48171A58.8060200@powercraft.nl> <4817DAE3.6050406@gmail.com>
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

Guys

I've moved the advanced/programming stuff to the end of this page
since it was mixed in with the basic howto.

http://wiki.bluez.org/wiki/HOWTO/AudioDevices

let's work on getting this more usable. The programming stuff needs
its own page probably and we could get more debugging tips in there.

Brad

On Tue, Apr 29, 2008 at 8:35 PM, Terry Johnson <terryrjohnson@gmail.com> wrote:
> Hi All,
>
>  I've got a BlueAnt T8 that I've had working under Ubuntu for about 10
>  seconds. Ever since that early success, the device will pair, but that's
>  about the extent of it.
>
>  I've installed Blueman and that works marvelously, except for getting
>  actual audio out. I'm running out of hair and wish there was some
>  documented way to debug this process. Even being able to identify the
>  failing subsystem would be wonderful. If such a process could be
>  detailed in a Wiki I'd be more than grateful.
>
>  Terry
>
>
>
>
>  Jelle de Jong wrote:
>  > Hello everybody,
>  >
>  > I have been playing around with bluetooth devices under linux the last
>  > month or so. I got some very good and some very bad experience with it.
>  >
>  > I am planning to create some wiki pages when I can get things working
>  > 100%. However I still got some major issues that I need to overcome.
>  >
>  > I bought a Motorola Bluetooth S805 stereo headset. It should get the
>  > following functionality:
>  >
>  > - Playback of stereo quality audio without distortions and without delay
>  > when playing audio and video at the same time.
>  > - Generic playback controls like playpause/stop/next/previous.
>  > - Internal microphone to record audio, used for audio recordings and
>  > audio video conferences.
>  >
>  > I was planning to get things up and running step by step:
>  > - alsa configuration
>  > - bluetooth configuration
>  > - input device configuration
>  >
>  > So the alsa configuration exist out of:
>  > -- handle multiple audio streams (slave devices)
>  > -- make the device default or as a plugin
>  > -- use multiple bluetooth headset for the same audio (conference)
>  > -- use multiple bluetooth headset per user based (multiseat)
>  > -- force audio to use the correct bit-rate and frequency for the devices?
>  > -- set-up correct buffer so that playback is without distortions of out
>  > of sync audio and video. (testing with totem-xine?)
>  > -- configure multiple profiles for stereo recording/playback
>  >
>  > Would somebody be willing to sent his working alsa configuration files
>  > that can do some of the above functions:
>  >
>  > On this moment the headset plays stereo audio, but when watching video
>  > with and audio dvd on totem-xine the audio is out of sync and when
>  > scrolling or skipping chapters it get worse and hidd can even crash with
>  > segmentation faults. There is also a lot of noise distortions.
>  >
>  > Kind regards,
>  >
>  > Jelle
>  >
>  >
>  >
>  > -------------------------------------------------------------------------
>  > This SF.net email is sponsored by the 2008 JavaOne(SM) Conference
>  > Don't miss this year's exciting event. There's still time to save $100.
>  > Use priority code J8TL2D2.
>  > http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
>  > _______________________________________________
>  > Bluez-users mailing list
>  > Bluez-users@lists.sourceforge.net
>  > https://lists.sourceforge.net/lists/listinfo/bluez-users
>  >
>
>  -------------------------------------------------------------------------
>  This SF.net email is sponsored by the 2008 JavaOne(SM) Conference
>  Don't miss this year's exciting event. There's still time to save $100.
>  Use priority code J8TL2D2.
>  http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
>  _______________________________________________
>  Bluez-users mailing list
>  Bluez-users@lists.sourceforge.net
>  https://lists.sourceforge.net/lists/listinfo/bluez-users
>



-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
