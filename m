Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=81AdVX-F8Z=eDnMbc7S2mWK0s=BFLujmEU0x8@mail.gmail.com>
References: <AANLkTi=81AdVX-F8Z=eDnMbc7S2mWK0s=BFLujmEU0x8@mail.gmail.com>
Date: Thu, 16 Dec 2010 20:01:18 -0300
Message-ID: <AANLkTim03oK2+aD0ZMup_rheOzqMKuQTjDaJUXDSS_bH@mail.gmail.com>
Subject: Fwd: Initialization script for CC2540 Low energy dev kit
From: =?ISO-8859-1?B?Sm9z6SBMde1z?= <jose.nascimento@signove.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi people,

I'm trying to start with Low energy CC2540 Mini Development kit of TI on Linux,
but I can't get the usb dongle work properly. When I try to attach the hci
interface to the device with the command:

hciattach /dev/ttyACM0 texas 57600 flow

I got the message:

Found a Texas Instruments' chip!
Firmware file : /lib/firmware/TIInit_0.2.0.bts
can't open firmware file: No such file or directory
Warning: cannot find BTS file: /lib/firmware/TIInit_0.2.0.bts
Device setup complete

I would like to know where I can found this firmware initialization
script (TIInit_0.2.0.bts) or a driver to make this dongle work.
I'm using the git master version of bluez, and kernel 2.6.37-rc1+
of vcgomes git tree (git://git.infradead.org/users/vcgomes/linux-2.6.git devel)

More information:
lsusb shows:
Bus 004 Device 004: ID 0451:16aa Texas Instruments, Inc.
dmesg:
[ 8125.944210] usb 4-2: new full speed USB device using uhci_hcd and address 4
[ 8126.106197] cdc_acm 4-2:1.0: This device cannot do calls on its
own. It is not a modem.
[ 8126.106267] cdc_acm 4-2:1.0: ttyACM1: USB ACM device

hcitool lescan, returns:
Enable scan failed: Connection timed out
with the following hcidump:
hcidump -X
HCI sniffer - Bluetooth packet analyzer ver 0.17
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
  0000: 01 10 00 10 00 00 00                              .......
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Parameters (0x08|0x000b) ncmd 1
    0000: 00                                                .
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
  0000: 01 00


Thanks for any tip in advance

[]'s

--
José Luís do Nascimento
Signove - Seamless Technologies for Life!
Home page: http://www.signove.com
