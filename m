Return-Path: <giochi@telvia.it>
Date: Mon, 26 Apr 2004 22:55:52 +0200
From: giochi <giochi@telvia.it>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm problem
Message-Id: <20040426225552.68b1ab36@bizio.slackware-italia.com>
In-Reply-To: <1082697339.23959.84.camel@pegasus>
References: <20040422233858.1bb6a766@bizio.slackware-italia.com>
	<1082697339.23959.84.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel, 

sorry for delay on answer but in these days, I'm very busy.
Here's some major details about my problem:

/var/log/messages

Apr 26 22:33:24 bizio kernel: usb 1-2: new full speed USB device using address 2
Apr 26 22:33:28 bizio kernel: Bluetooth: Core ver 2.4
Apr 26 22:33:28 bizio kernel: NET: Registered protocol family 31
Apr 26 22:33:28 bizio kernel: Bluetooth: HCI device and connection manager initialized
Apr 26 22:33:28 bizio kernel: Bluetooth: HCI socket layer initialized
Apr 26 22:33:28 bizio kernel: Bluetooth: HCI USB driver ver 2.5
Apr 26 22:33:28 bizio kernel: drivers/usb/core/usb.c: registered new driver hci_usb


lsmod

...

rfcomm                 29976  0 
l2cap                  25476  3 rfcomm
sco                    15108  0 
hci_usb                11264  0 
bluetooth              51172  4 rfcomm,l2cap,sco,hci_usb

...

Some other info in /var/log/messages

..
Apr 26 22:38:40 bizio kernel: Bluetooth: SCO (Voice Link) ver 0.3
Apr 26 22:38:40 bizio kernel: Bluetooth: SCO socket layer initialized
Apr 26 22:38:43 bizio kernel: Bluetooth: L2CAP ver 2.1
Apr 26 22:38:43 bizio kernel: Bluetooth: L2CAP socket layer initialized
Apr 26 22:38:43 bizio kernel: Bluetooth: RFCOMM ver 1.2
Apr 26 22:38:43 bizio kernel: Bluetooth: RFCOMM socket layer initialized
Apr 26 22:42:15 bizio hcid[12354]: HCI daemon ver 2.6 started
Apr 26 22:42:15 bizio hcid[12354]: HCI dev 0 up
Apr 26 22:42:15 bizio hcid[12354]: Starting security manager 0
Apr 26 22:42:18 bizio sdpd[12358]: sdpd v1.5 started 
..

Requesting information ...
        BD Address:  00:0A:28:B1:9C:6E
        Device Name: Motorola Phone
        LMP Version: 1.1 (0x1) LMP Subversion: 0x700
        Manufacturer: Broadcom Corporation (15)
        Features: 0xff 0xff 0x0d 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset> 
                <timing accuracy> <role switch> <hold mode> <sniff mode> 
                <park state> <RSSI> <channel quality> <SCO link> 
                <HV2 packets> <HV3 packets> <u-law log> <A-law log> 
                <CVSD> <power control> <transparent SCO> 




root@bizio:~# find / -name rfcomm
/lib/modules/2.6.5/kernel/net/bluetooth/rfcomm
/usr/bin/rfcomm
/usr/src/linux-2.6.5/net/bluetooth/rfcomm
/usr/src/linux-2.6.5/include/config/bt/rfcomm
/proc/bluetooth/rfcomm
/second/bluez-utils-2.6/rfcomm
/second/bluez-utils-2.6/rfcomm/rfcomm
root@bizio:~# ll /usr/bin/rfcomm 
-rwxr-xr-x    1 root     root        45547 Apr 21 01:13 /usr/bin/rfcomm* (the only executable that I have on my system)

root@bizio:~# sdptool add --channel=9 OPUSH
OBEX Object Push service registered
root@bizio:~# sdptool add --channel=8 OPUSH
OBEX Object Push service registered

root@bizio:/home/disco# rfcomm bind /dev/rfcomm0 00:0A:28:B1:9C:6E 8
Wrong number of parameters.
root@bizio:/home/disco# rfcomm bind /dev/rfcomm0 00:0A:28:B1:9C:6E 9
Wrong number of parameters.
root@bizio:/home/disco# rfcomm connect 0 00:0A:28:B1:9C:6E 8
Wrong number of parameters.
root@bizio:/home/disco# rfcomm connect 0 00:0A:28:B1:9C:6E 9
Wrong number of parameters.


But rfcomm doesn't works...
Did you have another idea ?
Thanks a lot.
BR,
Fab





On Fri, 23 Apr 2004 07:15:39 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi,
> 
> > Alls work fine till the rfcomm initialization:
> > 
> > root@bizio:~# rfcomm bind 0 00:0A:28:B1:9C:6E 8
> > Wrong number of parameters.
> > root@bizio:~# rfcomm bind 0 00:0A:28:B1:9C:6E 9
> > Wrong number of parameters.
> > root@bizio:~# rfcomm bind 0                    
> > Device USSP not registered: No such device
> 
> you used the wrong rfcomm utility. Don't install my old rfcomm code. You
> only have to install bluez-utils and everything will be in place.
> 
> > root@bizio:~# hcitool inq
> > Inquiring ...
> >         00:0A:28:B1:9C:6E       clock offset: 0x3ea0    class: 0x000100
> > root@bizio:~# hcitool scann
> > Scanning ...
> >         00:0A:28:B1:9C:6E       Motorola Phone
> 
> Please do a "hcitool info 00:0A:28:B1:9C:6E" (as root) for me so I can
> add your Motorola mobile phone to my hardware list.
> 
> > root@bizio:~# sdptool browse 00:0A:28:B1:9C:6E
> > Browsing 00:0A:28:B1:9C:6E ...
> > Service RecHandle: 0x0
> > Service Class ID List:
> >   "SDP Server" (0x1000)
> > Protocol Descriptor List:
> >   "L2CAP" (0x0100)
> >   "SDP" (0x0001)
> > Profile Descriptor List:
> >   "" (0x1000)
> >     Version: 0x0100
> > 
> > ...
> > Service Name: OBEX Object Push
> > Service Description: OBEX Object Push
> > Service Provider: Motorola
> > Service RecHandle: 0x10008
> > Service Class ID List:
> >   "OBEX Object Push" (0x1105)
> > Protocol Descriptor List:
> >   "L2CAP" (0x0100)
> >   "RFCOMM" (0x0003)
> >     Channel: 8
> >   "OBEX" (0x0008)
> > Language Base Attr List:
> >   code_ISO639: 0x656e
> >   encoding:    0x6a
> >   base_offset: 0x100
> >   code_ISO639: 0x6672
> >   encoding:    0x6a
> >   base_offset: 0xd800
> >   code_ISO639: 0x6465
> >   encoding:    0x6a
> >   base_offset: 0xd803
> >   code_ISO639: 0x6974
> >   encoding:    0x6a
> >   base_offset: 0xd806
> >   code_ISO639: 0x6573
> >   encoding:    0x6a
> >   base_offset: 0xd809
> >   code_ISO639: 0x6e6c
> >   encoding:    0x6a
> >   base_offset: 0xd80c
> >   code_ISO639: 0x7472
> >   encoding:    0x6a
> >   base_offset: 0xd80f
> >   code_ISO639: 0x7074Profile Descriptor List:
> >   "OBEX Object Push" (0x1105)
> >     Version: 0x0100
> > 
> > Service Name: OBEX file transfer
> > Service Description: OBEX file transfer
> > Service Provider: Motorola
> > Service RecHandle: 0x10009
> > Service Class ID List:
> >   "OBEX File Transfer" (0x1106)
> > Protocol Descriptor List:
> >   "L2CAP" (0x0100)
> >   "RFCOMM" (0x0003)
> >     Channel: 9
> >   "OBEX" (0x0008)
> > Language Base Attr List:
> >   code_ISO639: 0x656e
> >   encoding:    0x6a
> >   base_offset: 0x100
> >   code_ISO639: 0x6672
> >   encoding:    0x6a
> >   base_offset: 0xd800
> >   code_ISO639: 0x6465
> >   encoding:    0x6a
> >   base_offset: 0xd803
> >   code_ISO639: 0x6974
> >   encoding:    0x6a
> >   base_offset: 0xd806
> >   code_ISO639: 0x6573
> >   encoding:    0x6a
> >   base_offset: 0xd809
> >   code_ISO639: 0x6e6c
> >   encoding:    0x6a
> >   base_offset: 0xd80c
> >   code_ISO639: 0x7472
> >   encoding:    0x6a
> >   base_offset: 0xd812
> >   encoding:    0x6a
> >   base_offset: 0xd80f
> >   code_ISO639: 0x7074
> >   encoding:    0x6a
> >   base_offset: 0xd812
> > Profile Descriptor List:
> >   "OBEX File Transfer" (0x1106)
> >     Version: 0x0100
> > 
> > So, as appears 8 and 9 channels are designed for OBEX.
> > When I found these channels I type:
> > sdptool add --channel=9 OPUSH
> > sdptool add --channel=8 OPUSH
> 
> This is not needed unless you wan't to receive OBEX connection from your
> phone. And in that case you also have to run somekind of OBEX push or
> file transfer daemon.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
> For a limited time only, get FREE Ground shipping on all orders of $35
> or more. Hurry up and shop folks, this offer expires April 30th!
> http://www.thinkgeek.com/freeshipping/?cpg=12297
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
