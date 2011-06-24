Return-Path: <cyrus@holtmann.org>
Date: Fri, 24 Jun 2011 17:21:04 +0200
From: YuGiOhJCJ Mailing-List <yugiohjcj-mailinglist@laposte.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: [BUG] Problem between SDL and bluez
Message-Id: <20110624172104.1ebeef72.yugiohjcj-mailinglist@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hello,

I submit a bug : there is a problem between SDL 1.2.14[1] and bluez 4.94[2] on Debian squeeze[3].

I have edited the audio/pcm_bluetooth.c file in order to display some debug messages (the two numbers displayed are the name and the type of the variable of bt_audio_msg_header_t type).

If I run vlc the sound works (because VLC doesn't use the SDL library) :
$ vlc ~/documents/downloads/audio/playlist
VLC media player 1.1.10 The Luggage (revision exported)
Blocked: call to unsetenv("DBUS_ACTIVATION_ADDRESS")
Blocked: call to unsetenv("DBUS_ACTIVATION_BUS_TYPE")
[0x8cdee5c] main interface error: no suitable interface module
[0x8cb78fc] main libvlc error: interface "globalhotkeys,none" initialization failed
[0x8cb78fc] main libvlc: Running vlc with the default interface. Use 'cvlc' to use vlc without interface.
Blocked: call to setlocale(6, "")
[0x8de270c] main playlist: stopping playback
Warning: call to rand()
Warning: call to rand()
Warning: call to rand()
Warning: call to rand()
[0x8de3314] signals interface error: signal 17 overriden (0xb48ce3b0)
[0x8de3314] signals interface error:  /usr/lib/libQtCore.so.4(?)[(nil)]
[0x8f6ef94] pulse audio output error: cannot connect to server: Connection refused
Warning: call to rand()
Blocked: call to setlocale(1, "C")
Blocked: call to setlocale(1, "en_US.utf8")
Blocked: call to setlocale(1, "C")
Blocked: call to setlocale(1, "en_US.utf8")
Oulala! (0, 0)
Ahah oui! (1, 0)
On remet ça! (1, 0)
Attend c'est Woodstock! (0, 1)
Du gâteau! (0, 1)
Ouh punaise! (0, 1)
Oulala! (0, 0)
Ahah oui! (1, 0)
On remet ça! (1, 0)
Attend c'est Woodstock! (0, 1)
Du gâteau! (0, 1)
Ouh punaise! (0, 1)
Oulala! (1, 0)
Ahah oui! (1, 1)
On remet ça! (1, 1)
Attend c'est Woodstock! (1, 1)
Du gâteau! (1, 1)
Ouh punaise! (1, 1)
Oulala! (2, 0)
Ahah oui! (1, 2)
On remet ça! (1, 2)
Attend c'est Woodstock! (2, 1)
Du gâteau! (2, 1)
Ouh punaise! (2, 1)
Oulala! (4, 0)
Ahah oui! (1, 4)
On remet ça! (1, 4)
Attend c'est Woodstock! (4, 1)
Du gâteau! (4, 1)
Ouh punaise! (4, 1)
Oulala! (4, 1)
Ahah oui! (1, 3)
On remet ça! (1, 3)
Attend c'est Woodstock! (3, 1)
Du gâteau! (3, 1)
Ouh punaise! (3, 1)

If I run milkytracker the sound doesn't work (because milkytracker use the SDL library) :
$ milkytracker 
Oulala! (0, 0)
Ahah oui! (1, 0)
On remet ça! (1, 0)
Attend c'est Woodstock! (0, 1)
Du gâteau! (0, 1)
Ouh punaise! (0, 1)
Oulala! (0, 0)
Ahah oui! (1, 0)
On remet ça! (1, 0)
Attend c'est Woodstock! (0, 1)
Du gâteau! (0, 1)
Ouh punaise! (0, 1)
Oulala! (1, 0)
Ahah oui! (1, 1)
On remet ça! (1, 1)
Attend c'est Woodstock! (1, 1)
Du gâteau! (1, 1)
Ouh punaise! (1, 1)
Oulala! (2, 0)
Ahah oui! (1, 2)
On remet ça! (1, 2)
Attend c'est Woodstock! (2, 1)
Du gâteau! (2, 1)
Ouh punaise! (2, 1)
Oulala! (4, 0)
Ahah oui! (1, 4)
On remet ça! (1, 4)
Attend c'est Woodstock! (4, 1)
Du gâteau! (4, 1)
Ouh punaise! (4, 1)
Oulala! (4, 1)
Ahah oui! (1, 3)
On remet ça! (1, 3)
Attend c'est Woodstock! (3, 1)
Du gâteau! (3, 1)
Ouh punaise! (3, 1)
Oulala! (1, 0)
Ahah oui! (3, 1)
On remet ça! (3, 1)
Attend c'est Woodstock! (1, 3)
Du gâteau! (1, 3)
Ouh punaise! (1, 3)
ALSA lib audio/pcm_bluetooth.c:1621:(audioservice_expect) BT_OPEN failed : Invalid argument(22)
Oulala! (1, 0)
Ahah oui! (3, 1)
On remet ça! (3, 1)
Attend c'est Woodstock! (1, 3)
Du gâteau! (1, 3)
Ouh punaise! (1, 3)
ALSA lib audio/pcm_bluetooth.c:1621:(audioservice_expect) BT_OPEN failed : Invalid argument(22)
SDL: Failed to open audio device! (buffer = 8192 bytes)..
SDL: Try setting "Force 2^n sizes" in the config menu and restarting.

This problem is only when we use ALSA without PulseAudio. With PulseAudio, the sound in SDL applications works correctly.

Can you give me a solution editing this audio/pcm_bluetooth.c file to resolve the problem?

Thank you.

[1] http://www.libsdl.org/
[2] http://www.bluez.org/
[3] http://www.debian.org/

