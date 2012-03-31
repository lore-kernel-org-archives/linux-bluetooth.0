Return-Path: <cyrus@holtmann.org>
Date: Sat, 31 Mar 2012 18:11:28 +0200
From: Fabrice DELENTE <delentef@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: /org/bluez/audio not found?
Message-ID: <20120331161128.GA22869@smtp.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello.

In trying to get A2DP service sound on my BT headset, I did

$ strace mplayer -ao alsa:device=bt file.mp3

where bt is a PCM I created in my .asoundrc:

pcm.bt_audioraw {
        type bluetooth
        device 00:18:91:D0:7A:24
        profile "auto"
}

pcm.bt {
    type plug
        slave.pcm "bt_audioraw"
        hint {
            show on
            description "Halterrego H.EAR 01 Bluetooth Headset"
        }
}

The result of the strace shows

connect(4, {sa_family=AF_FILE, path=@"/org/bluez/audio"}, 110) = -1 ECONNREFUSED (Connection refused)

which seems to mean thaht /org/bluez/audio is not available.

How can I fix this?

Thanks.
