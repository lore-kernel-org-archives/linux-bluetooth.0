Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <a93c18c0905011530x549db871l4c07a74271e4e76d@mail.gmail.com>
References: <a93c18c0905011530x549db871l4c07a74271e4e76d@mail.gmail.com>
Date: Fri, 1 May 2009 16:31:15 -0600
Message-ID: <a93c18c0905011531o7d873255mc90ae23feb446f8d@mail.gmail.com>
Subject: Fwd: Windows mobile 6.1 no services seen.
From: Dylan Thurston <dylan.thurston@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I've been trying to get bluez to work with asterisk and my windows
mobile phone. I followed the instructions here
(http://trixbox.org/wiki/chan-mobile). I'm able to pair, but when i
search for services provided by my linux box nothing shows up on my
windows mobile phone. The list is empty no matter how many times i
click refresh (on the services page on my phone). I've tried changing
the hcid.conf and tried changing the classes. I've tried searching
while the linux box is discoverable. Nothing seems to work. My phone
is a samsung i760 with windows mobile 6.1 and i'm using a dlink
dbt-120 usb adapter. below is my hcid.conf file, as well as the output
from the hciconfig -a command.

# hciconfig -a
hci0:   Type: USB
        BD Address: 00:15:E9:6A:00:12 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN
        RX bytes:121050 acl:3670 sco:0 events:4169 errors:0
        TX bytes:66037 acl:3679 sco:0 commands:251 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'Asterisk'
        Class: 0x240406
        Service Classes: Rendering, Audio
        Device Class: Audio/Video, Device conforms to the Headset profile
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)

cat hcid.conf
    # HCId options
    options {
    autoinit yes;
    security auto;
    pairing multi;
    passkey "1234";
    }

    device {
    name "Asterisk";
    class 0x240406;
    #class 0x200404;
    iscan enable;
    pscan enable;
    lm accept;
    lp rswitch,hold,sniff,park;
    }

options {
   autoinit yes;
   security auto;
   pairing multi;
   pin_helper /etc/bluetooth/pin;
}

If anyone has any clue what might be going on i could really use the help.
