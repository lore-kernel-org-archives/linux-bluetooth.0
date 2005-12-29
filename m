Return-Path: <david@dgreaves.com>
Message-ID: <43B41B63.3050406@dgreaves.com>
Date: Thu, 29 Dec 2005 17:22:43 +0000
From: David Greaves <david@dgreaves.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Cc: marcel@holtmann.org
Subject: Belkin F8T009 USB dongle uses Broadcom
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <bluez-users.lists.sourceforge.net>

Hi

I have a Nokia HDW-3 and a Belkin F8T009 USB dongle.

This is mainly just a report that Belkin have reverted to using Broadcom
chips

I guess I'm returning this one since I wanted to use SCO to get a voice
connection to my headset. It actually connects perfectly and I can see
the button presses coming back - just no sound. Searching the archives
seems to indicate that Broadcom =  no SCO = no sound (please yell if I'm
wrong)

snd-bt-sco installed fine and I could run btsco and alsamixer picked up
the Headset as hw1,0.
Oh, it was a bit misleading that I get the following during the ./btsco
-v output:
...
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
...

it certainly implied that SCO was working.

My system is running kernel 2.6.14.5.

# hciconfig -a
hci0:   Type: USB
        BD Address: 00:0A:3A:68:47:68 ACL MTU: 377:10 SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN
        RX bytes:17248 acl:517 sco:0 events:640 errors:0
        TX bytes:9888 acl:499 sco:0 commands:59 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'ash-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
        Manufacturer: Broadcom Corporation (15)
# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:0A:3A:68:47:68 ACL MTU: 377:10 SCO MTU: 16:0
        Firmware 0.3 / 9

Marcel, cc'ed you in case you want to update the page on:
  http://www.holtmann.org/linux/bluetooth/features.html

Also, by the way, you say on:
  http://www.holtmann.org/linux/bluetooth/devices.html
"If the HCI Version field is filled in this table, then this device
should also work perfect with Linux."
You may want to change that since clearly only CSR chipsets (IIRC)
support SCO.

Also - thanks for all the work on BlueZ - I'm looking forward to getting
another (CSR) dongle and getting it working.

David

-- 
