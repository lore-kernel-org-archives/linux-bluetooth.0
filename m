Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sat, 14 Nov 2009 20:26:49 +0200
Message-ID: <dfb262380911141026x72fafeb8tbffd8692bd0c1ad5@mail.gmail.com>
Subject: bluetooth audio fails
From: Ramagudi Naziir <naziirr@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

Can anyone pls help me debug this:

# aplay -D bluetooth /startup.wav
ALSA lib audio/pcm_bluetooth.c:1607:(audioservice_expect)
BT_GET_CAPABILITIES failed : Input/output error(5)
aplay: main:608: audio open error: Input/output error

I'm running the latest bluez git sources with a 9xxPlantronics HFP headset.
I tried both "auto" and "voice" in .asoundrc:

pcm.bluetooth {
        type bluetooth
        device mybdaddr
        profile “voice”
}


Any idea what this could be and how to debug/fix it ?

thank you
naziirr
