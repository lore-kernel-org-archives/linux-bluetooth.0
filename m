Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20080905162654.GA17843@lapse.rw.madduck.net>
References: <20080822073628.GA5989@piper.oerlikon.madduck.net>
	<1219394015.7591.441.camel@violet.holtmann.net>
	<20080826163544.GA5068@lapse.rw.madduck.net>
	<8C64B784-7758-40B0-AE1B-C15F475693D4@holtmann.org>
	<20080905162654.GA17843@lapse.rw.madduck.net>
Date: Fri, 05 Sep 2008 19:00:42 +0200
Message-Id: <1220634042.6714.89.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] "unable to install hw params" to bluetooth
	(SCO)	headset (was:	btusb+sco failing to play sound through
	Jabra BT500v headset)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Martin,

> > don't use headsetd. Use the audio stuff that comes with bluez-utils.
> 
> So I am trying, and I got a little further, installing the right
> lines into .asoundrc as per
> http://wiki.bluez.org/wiki/HOWTO/AudioDevices. I have gotten beyond
> issues of
> 
>   bt_audio_service_open: connect() failed: Connection refused (111)
>   aplay: main:564: audio open error: Connection refused 
> 
> but it still doesn't want to work. If I execute
> 
>   arecord -D bt500v -f S16_LE | aplay -D bt500v -f S16_LE
> 
> then the headset makes a noise, the bluetooth LED flashes and
> arecord prints
> 
>   Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
> 
> But then after about 30 or 40 seconds, it all fails:
> 
>   ALSA lib pcm_bluetooth.c:464:(bluetooth_hsp_hw_params) BT_SETCONFIGURATION failed : Input/output error(5)
>   arecord: set_params:979: Unable to install hw params:
>   ACCESS:  RW_INTERLEAVED
>   FORMAT:  S16_LE
>   SUBFORMAT:  STD
>   SAMPLE_BITS: 16
>   FRAME_BITS: 16
>   CHANNELS: 1
>   RATE: 8000
>   PERIOD_TIME: 125000
>   PERIOD_SIZE: 1000
>   PERIOD_BYTES: 2000
>   PERIODS: 4
>   BUFFER_TIME: 500000
>   BUFFER_SIZE: 4000
>   BUFFER_BYTES: 8000
>   TICK_TIME: [0 0]
>   aplay: playback:2019: read error
> 
> I have bluez-audio installed, but /etc/bluetooth/audio.conf is
> default. No PulseAudio or anything other than plain ALSA here...
> 
> Any clues?

actually I have none. It simply works for me. And I have tested it a
lot. There are some rare conditions where the btusb driver is off on the
16-bit boundaries, but I am looking at a fix for it. However this will
not disturb the audio service. You just don't here anything.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
