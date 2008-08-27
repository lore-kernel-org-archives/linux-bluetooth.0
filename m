Return-Path: <cyrus@holtmann.org>
Message-Id: <34CE4798-1CBA-4F76-BA4D-A5E814D84C0E@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20080826203451.GA13267@lapse.rw.madduck.net>
Mime-Version: 1.0 (Apple Message framework v928.1)
Date: Wed, 27 Aug 2008 07:18:53 +0200
References: <20080822073628.GA5989@piper.oerlikon.madduck.net>
	<1219394015.7591.441.camel@violet.holtmann.net>
	<20080826163544.GA5068@lapse.rw.madduck.net>
	<8C64B784-7758-40B0-AE1B-C15F475693D4@holtmann.org>
	<20080826203451.GA13267@lapse.rw.madduck.net>
Subject: Re: [Bluez-devel] btusb+sco failing to play sound through
	Jabra	BT500v headset (was: SCO flowcontrol patch v4.4 on
	2.6.25/6	causes) hardlocks when connecting to BT device
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

>> don't use headsetd. Use the audio stuff that comes with
>> bluez-utils.
>
> The dbus API documented at /usr/share/doc/bluez-utils/audio-api.txt?
> How would I make existing applications speak to that?
>
> Sorry, but dpkg -L bluez-utils (3.36-1) doesn't list anything else
> audio-related. Is the version outdated?

you don't have to. The bluez-utils-3.36 comes with an audio plugin  
that does all this for you. You just have to add 4 magic lines  
into .asoundrc. See wiki.bluez.org for these for it.

We have native support for ALSA and GStreamer with the audio plugin  
and it can either use the headset profile or A2DP. And native  
PulseAudio support is in the making :)

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
