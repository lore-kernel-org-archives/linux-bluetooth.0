Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Mar 2009 06:59:36 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: Newbie, can't find device
In-Reply-To: <200903252037.03024.gene.heskett@verizon.net>
Message-ID: <alpine.LNX.2.00.0903260643010.22668@nge2.ngu.pk>
References: <200903252037.03024.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Wed, 25 Mar 2009, Gene Heskett wrote:

> gnubie to bluetooth that is.  I bought some dongles to replace a cable that is
> just long enough to present EMP surge problems between this box and a
> bluetooth kit installed to replace the connector in an RS-232 pack for a
> legacy computer, an old TRS-80 Color Computer 3 that has all the goodies in it
> that 20 some years of development can give.
>
> I get this from demsg:
> [    8.884948] Bluetooth: Core ver 2.14
> [    8.885051] Bluetooth: HCI device and connection manager initialized
> [    8.885054] Bluetooth: HCI socket layer initialized
> [    9.112240] Bluetooth: Generic Bluetooth USB driver ver 0.4
> [   21.015636] Bluetooth: L2CAP ver 2.11
> [   21.015639] Bluetooth: L2CAP socket layer initialized
> [   21.165128] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [   21.165131] Bluetooth: BNEP filters: protocol multicast
> [   21.245887] Bluetooth: SCO (Voice Link) ver 0.6
> [   21.245890] Bluetooth: SCO socket layer initialized
> [   22.084606] Bluetooth: RFCOMM socket layer initialized
> [   22.084616] Bluetooth: RFCOMM TTY layer initialized
> [   22.084618] Bluetooth: RFCOMM ver 1.10
>
> But no new devices are being created by udev.
>
> hciconfig -a:
> hci0:   Type: USB
>        BD Address: 11:11:11:11:11:11 ACL MTU: 672:3 SCO MTU: 48:1
>        UP RUNNING PSCAN ISCAN
>        RX bytes:1104 acl:0 sco:0 events:45 errors:0
>        TX bytes:445 acl:0 sco:0 commands:45 errors:0
>        Features: 0xff 0x3e 0x85 0x38 0x18 0x18 0x00 0x00
>        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>        Link policy: RSWITCH HOLD SNIFF PARK
>        Link mode: SLAVE ACCEPT
>        Name: 'coyote.coyote.den-0'
>        Class: 0x4a2100
>        Service Classes: Networking, Capturing, Telephony
>        Device Class: Computer, Uncategorized
>        HCI Ver: 2.0 (0x3) HCI Rev: 0x1f4 LMP Ver: 2.0 (0x3) LMP Subver: 0x1f4
>        Manufacturer: CONWISE Technology Corporation Ltd (66)
>
> Where do I go from here.  What I need to do is run a session of minicom to it
> but minicom cannot find the device either.


I don't use udev, but maybe you can adapt this to your setup. I think you need 
an rfcomm device. udev may create the devices when they are actually opened. 
They list in /proc/devices on my system, major number 216, minors 0 and 1.

crw-rw-rw- 1 root root 216, 0 2009-02-22 23:01 /dev/rfcomm0
crw-rw-rw- 1 root root 216, 1 2007-12-16 07:29 /dev/rfcomm1


Using bluez-3.36 -

Scan for your device -

# hcitool scan

# passkey-agent --default (PIN) (address of your device) &
# auth-agent &

Find the channel the thing you want is on -

# sdptool browse 00:1C:62:19:B1:6A


...

Service Name: Bluetooth Modem
Service RecHandle: 0x10006
Service Class ID List:
   "Dialup Networking" (0x1103)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 8
Language Base Attr List:
   code_ISO639: 0x656e
   encoding:    0x6a
   base_offset: 0x100
Profile Descriptor List:
   "Dialup Networking" (0x1103)
     Version: 0x0100


Bind the rfcomm device to the btaddress and channel, here an example with a 
btmodem at 00:1C:62:19:B1:6A channel 8 -

# rfcomm bind 0 00:1C:62:19:B1:6A 8

Means bind to rfcomm0 the address 00:1C:62:19:B1:6A at ch. 8.


Now give /dev/rfcomm0 to Minicom, etc. I find Kermit (ckermit, 
http://www.columbia.edu/kermit/ckermit.html) more usable. When you're done, 
unbind it -

# rfcomm release 0



