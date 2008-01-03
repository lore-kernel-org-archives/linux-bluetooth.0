Return-Path: <cyrus@holtmann.org>
To: bluez-users@lists.sourceforge.net
From: paul Rushworth <paul@rushworth.co.nz>
Date: Thu, 3 Jan 2008 04:06:55 +0000 (UTC)
Message-ID: <loom.20080103T040638-726@post.gmane.org>
References: <200801012109.19744.lists@spudulike.me.uk>
	<d89ddf300801012103l48e26e3ax379e391055e31e72@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users]
	=?utf-8?q?Stereo_audio_headset_-_half_a_second_of_a?=
	=?utf-8?q?udio=2C=098_seconds_of_silence=2C_then_disconnection=2E?=
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

Brad Midgley <bmidgley <at> gmail.com> writes:

> 
> Colin
> 
> > On hitting the 'play' button there is a 2 second delay before XMMS begins to
> > play, and the Graphic EQ bars start to dance.  Half a second, or so, of audio
> > can be heard from the headphones, after which they go silent
> 
> this could be the scatternet problem we've been working over.
> 
> what does
>  hcitool con
> show during the audio playing?
> 
> what other bluetooth devices are you using?
> is the headset trying to connect to a phone at the same time?
> do you know which bluetooth adapter your pc uses?
> 
> if you have "master" in hcid.conf's lm setting and you take "rswitch"
> out of the lp setting, you are making the pc prefer to be master and
> to hopefully behave better.
> 

I have a similar problem. I'm using Creative CB2530 headphones, and they work
absolutely fine for around 2-3 minutes and then audio stops working (does seem
slightly random, but always within 2-3 minutes.) This is with an audio sink
setup, my headphones connect automatically and work with all applications.

I saw your tips above about changing the settings in hcid.conf, which i have
done, and it has made no difference.

I'm seeing this in the syslog:

15:27:17  audio[5742]: stream state changed: OPEN -> STREAMING (starts working)
Then suddenly it stops:
15:30:16  audio[5742]: session_cb
15:30:16  audio[5742]: Received CLOSE_CMD
15:30:16  audio[5742]: SBC Source: Close_Ind
15:30:16  audio[5742]: stream state changed: STREAMING -> CLOSING
15:30:16  audio[5742]: stream state changed: CLOSING -> IDLE
15:30:16  audio[5742]: avdtp_unref(0x806b598): ref=2
15:30:16  audio[5742]: SBC Source SEP 0x80694b8 unlocked
15:30:16  audio[5742]: avdtp_unref(0x806b598): ref=1
15:30:16  audio[5742]: session_cb
15:30:16  audio[5742]: Disconnected from 00:12:0E:09:CF:9E

If i run ~$ hcitool con before it fails:
Connections:
        < ACL 00:12:0E:09:CF:9E handle 41 state 1 lm MASTER 



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
