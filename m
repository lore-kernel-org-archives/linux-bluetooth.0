Return-Path: <jjjessen@control.auc.dk>
Date: Mon, 29 Sep 2003 12:58:45 +0200 (MEST)
From: "Jan J. Jessen" <jjjessen@control.auc.dk>
To: Marcel Holtmann <marcel@holtmann.org>
cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Digianswer USB driver
In-Reply-To: <1064307381.26572.162.camel@pegasus>
Message-ID: <Pine.GSO.4.40.0309291248010.923-100000@prosit.control.auc.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

On 23 Sep 2003, Marcel Holtmann wrote:

> Hi Jan,
>
> these are good news. Your initial problem setting scan mode can only be
> solved with a USB sniffer, I think.

Well I've tried it a few times now, and it is a rare event.

>
> Do you have any H:2 USB Bluetooth devices? If yes, please attach them
> along with a Digianswer one to the same host and use them both. I want
> to make sure that a Digianswer device works in conjunction with a H:2
> device.

I've just tried it with a 3com device, and it works:-)

>
> Have you ever updated the firmware of the Digianswer device? I though
> that Digianswer already had a USB device at the time they are not a
> subsidiary of Motorola. So the manufacturer should be 12.

I have no idea. I've never updated the firmware on their devices.
Digianswer has - at least in the past - been very restrictive about
getting access to the firmware and related issues. A few years ago, former
students at Aalborg University wrote a linux driver for their first pcmcia
cards, but a lot of NDA stuff has prevented the publishing of this driver.
But that's a whole different story.

> Please do my test above and send me "hciconfig -a" of a machine with two
> different dongles. If this works I apply this patch to mainline and your
> students can start working with BlueZ very easy ;)

# lsmod
Module                  Size  Used by    Not tainted
hci_usb                 9212   0  (unused)
bluez                  36452   0  [hci_usb]
usb-uhci               24460   0  (unused)
usbcore                66272   0  [hci_usb usb-uhci]

# hciconfig hci0 up
# hciconfig hci1 up
# hciconfig -a
hci0:   Type: USB
        BD Address: 00:0B:AC:E8:21:B1 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:69 acl:0 sco:0 events:8 errors:0
        TX bytes:27 acl:0 sco:0 commands:7 errors:0
        Features: 0xff 0xff 0x0f 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'VIP'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20e LMP Ver: 1.1 (0x1) LMP Subver: 0x20e
        Manufacturer: Cambridge Silicon Radio (10)

hci1:   Type: USB
        BD Address: 00:50:CD:00:42:2B ACL MTU: 384:6  SCO MTU: 32:7
        UP RUNNING PSCAN ISCAN
        RX bytes:42673 acl:0 sco:0 events:7 errors:0
        TX bytes:27 acl:0 sco:0 commands:7 errors:0
        Features: 0xff 0xfa 0x21 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: ''
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver: 0x37
        Manufacturer: Motorola (8)


It seems to work perfectly now. Apply Your patch, and everyone is happy...
regards,
Jan Jakob


Best regards, Jan Jakob
------------------------------------
Jan Jakob Jessen
Ph.D. Student, M.Sc.E.E.
Center for Embedded Software Systems
Aalborg University
Fredrik Bajers Vej 7C, B2-212
DK-9220 Aalborg East
