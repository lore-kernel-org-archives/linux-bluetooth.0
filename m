Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 1 Aug 2018 16:06:18 +0200
From: Dominik 'Rathann' Mierzejewski <dominik@greysector.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ] connection failure or profile unavailability when connecting
 two devices with overlapping profiles
Message-ID: <20180801140618.GD10915@sakura.greysector.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear list,
I reported this originally in Fedora 27
(https://bugzilla.redhat.com/show_bug.cgi?id=1541575), but maybe someone
here has a better idea, since it's still reproducible on Fedora 28 with
newer versions of bluez and pulseaudio.

Description of problem:
I'm unable to connect the Creative MUVO 2c speaker if a Jabra Evolve 65
headset is connected already. If I connect the speaker first, then I'm
able to connect the Jabra headset, but only HFP profile works (A2DP sink
is not selectable). There are no issues adding an Android phone to the
mix in any order, seemingly because it only has non-overlapping profiles
A2DP source and HFP audio gateway).

Version-Release number of selected component (if applicable):
bluez-5.50-1.fc28.x86_64
pulseaudio-12.2-1.fc28.x86_64

How reproducible:
Always.

Case 1:
Steps to Reproduce:
1. bluetoothctl
2. connect 50:1A:A5:xx:xx:xx # Jabra Evolve 65
3. connect 00:02:3C:yy:yy:yy # Creative MUVO 2c

Actual results:
Attempting to connect to 00:02:3C:yy:yy:yy
Failed to connect: org.bluez.Error.Failed

Expected results:
Attempting to connect to 00:02:3C:yy:yy:yy
[CHG] Device 00:02:3C:yy:yy:yy Connected: yes
Connection successful
[CHG] Device 00:02:3C:yy:yy:yy ServicesResolved: yes

Case 2:
Steps to Reproduce:
1. bluetoothctl
2. connect 00:02:3C:yy:yy:yy # Creative MUVO 2c
3. connect 50:1A:A5:xx:xx:xx # Jabra Evolve 65
4. pactl set-card-profile bluez_card.50_1A_A5_xx_xx_xx a2dp_sink
5. pactl list sinks short |grep bluez

Actual results:
$ pactl set-card-profile bluez_card.50_1A_A5_xx_xx_xx a2dp_sink
Failure: Input/Output error
$ pactl list sinks short |grep bluez
26	bluez_sink.00_02_3C_yy_yy_yy.a2dp_sink	module-bluez5-device.c	s16le 2ch 44100Hz	SUSPENDED
27	bluez_sink.50_1A_A5_xx_xx_xx.headset_head_unit	module-bluez5-device.c	s16le 1ch 8000Hz	IDLE

Expected results:
$ pactl set-card-profile bluez_card.50_1A_A5_xx_xx_xx a2dp_sink
$ pactl list sinks short |grep bluez
26	bluez_sink.00_02_3C_yy_yy_yy.a2dp_sink	module-bluez5-device.c	s16le 2ch 44100Hz	SUSPENDED
27	bluez_sink.50_1A_A5_D7_43_93.a2dp_sink	module-bluez5-device.c	s16le 2ch 44100Hz	SUSPENDED

Additional info:
Selecting a2dp_sink when Jabra is the only device with a2dp_sink
connected works just fine.

Regards,
Dominik
-- 
Fedora   https://getfedora.org  |  RPMFusion   http://rpmfusion.org
There should be a science of discontent. People need hard times and
oppression to develop psychic muscles.
        -- from "Collected Sayings of Muad'Dib" by the Princess Irulan
