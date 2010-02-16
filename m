Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 16 Feb 2010 17:07:54 +0100
Message-ID: <889018151002160807g779e128cnb6bd93eee0108aed@mail.gmail.com>
Subject: a2dp with mouse input device - skipping,pitch change in stream
From: "Pal Z. Illes" <illespal@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I wanted to ask if you are aware of the following issue:

Using a2dp and BT mouse together with bluez it very frequently results
in pitch changes and skipping in the audio stream.

I am using 2 notebooks with my Sony dr-bt21g  stereo headset and a
gigabyte BT mouse. One notebook is with 2.0 and the other with 2.1
profile. (The thing is not reproducible under Windows.) A bunch of
ubuntu users opened a bug on the launchpad (
http://bugs.launchpad.net/ubuntu/+source/bluez/+bug/424215 )

I'm using arch linux amd64. kernel 2.6.32 + bluez-git. Tried 4.60 too.
Tried with simple ALSA bluetooth, and with pulseaudio too. I have
hcidump and am running 'bluetoothd -dn'. Couldn't spot any special
hints in the dump or logs. I can possibly try kernel 2.6.33-rc* too if
there's something related (i have checked changelog of the kernel,
couldnt spot anything related, but you will know it better).

If this is new to you, or even old, anyway how can I help you to
discover the cause of it?

Or is there a configuration option I'm missing here? (I have tried
hciconfig parameters lm,lp, different settings, modifying mtu size and
whatever i could, no avail.)

Regards,
Pal Zoltan Illes


-----

The 2.0 device:

hciconfig -a

hci0:   Type: BR/EDR  Bus: USB
        BD Address: 00:1D:92:1E:13:01  ACL MTU: 310:10  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:3293882 acl:115129 sco:0 events:188738 errors:0
        TX bytes:56340728 acl:196228 sco:0 commands:352 errors:8
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'CSR - bc4'
        Class: 0x1a010c
        Service Classes: Networking, Capturing, Object Transfer
        Device Class: Computer, Laptop
        HCI Ver: 2.0 (0x3)  HCI Rev: 0xc5c
        LMP Ver: 2.0 (0x3)  LMP Subver: 0xc5c
        Manufacturer: Cambridge Silicon Radio (10)

(link policies already tried: with or without RSWITCH, lm
master,accept / slave / etc etc...)
