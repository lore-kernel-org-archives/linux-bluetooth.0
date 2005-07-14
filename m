Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050714133309.85262.qmail@web53208.mail.yahoo.com>
From: Filipa Duarte <filipa_duarte@yahoo.com>
Subject: Re: [Bluez-users] BlueZ in embedded linux
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1121273152.18272.34.camel@justakiss>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 14 Jul 2005 06:33:09 -0700 (PDT)

Hello again,

You were right! I am able now to go one step forward
however it is not working yet...

hcid -n:
hcid[294]: Bluetooth HCI daemon
hcid[294]: HCI dev 0 up
hcid[294]: Starting security manager 0

hciconfig -a:
hci0:   Type: USB
        BD Address: 00:10:60:AA:B0:CC ACL MTU: 192:8
SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:9459 acl:0 sco:0 events:213 errors:0
        TX bytes:3066 acl:0 sco:0 commands:212
errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00
0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2
HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ(hci0,ml310)'
        Class: 0x3e0100
        Service Classes: Networking, Rendering,
Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1
(0x1) LMP Subver: 0x33c
        Manufacturer: Cambridge Silicon Radio (10)

For me both seamed ok. However hcitool dev does not
return any device!

An there is something else which is interesting. If I
run hciconfig hci0 revision the result is:
hci0:   Type: USB
        BD Address: 00:10:60:AA:B0:CC ACL MTU: 192:8
SCO MTU: 64:8
        HCI 16.14
hci_cmd_task: hci0 command tx timeout
        Max key size: 16 bit

and the next 3 hciconfig -a will return:
hci0hci_cmd_task: hci0 command tx timeout
:       Type: USB
        BD Address: 00:10:60:AA:B0:CC ACL MTU: 192:8
SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:9813 acl:0 sco:0 events:220 errors:0
        TX bytes:3144 acl:0 sco:0 commands:219
errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00
0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2
HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
Can't read local name on hci0: Connection timed out
(110)

dmesg| grep hci returns:
usb-ohci-pci.c: USB OHCI at membase 0xc901b000, IRQ 31
usb-ohci-pci.c: usb-00:0f.0, PCI device 10b9:5237
usb.c: registered new driver hci_usb
usb.c: hci_usb driver claimed interface c7f5b1f8
usb.c: hci_usb driver claimed interface c7f5b1e0
hci_cmd_task: hci0 command tx timeout
hci_cmd_task: hci0 command tx timeout
hci_cmd_task: hci0 command tx timeout

and my /proc/bus/usb/devices is::  Ad=03(O)
Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01
Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01
Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01
Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01
Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00
Driver=(none)

Any idea why I do not see any devices?

Regards,

Filipa


--- Erwin Authried <eauth@softsys.co.at> wrote:

> Am Mit, den 13.07.2005 schrieb Filipa Duarte um
> 18:12:
> > Hello,
> > 
> > I am trying to have the bluez-utils-2.14 running
> on my
> > embedded ppc with linux 2.4.20.
> > 
> > Are the bluez-utils-2.14 and bluez-libs-2.15 ok to
> run
> > with a kernel 2.4.20?
> > 
> > 
> > I was able to cross-compile without much problems
> and
> > have enable the kernel support, however I am not
> able
> > to run the hcid.  When I type hcid -n the result
> is: 
> > hcid[479]: Bluetooth HCI daemon 
> > and it does not go on from this point.
> > 
> > If I run hciconfig hci0 up;  hciconfig -a the
> result
> > is: 
> > hci0:   Type: USB
> >         BD Address: 00:10:60:AA:B0:CC ACL MTU:
> 192:8
> > SCO MTU: 64:8
> >         UP RUNNING PSCAN ISCAN
> >         RX bytes:2838 acl:0 sco:0 events:67
> errors:0
> >         TX bytes:228 acl:0 sco:0 commands:66
> errors:0
> >         Features: 0xff 0xff 0x0f 0x00 0x00 0x00
> 0x00
> > 0x00
> >         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1
> HV2
> > HV3
> >         Link policy: RSWITCH HOLD SNIFF PARK
> >         Link mode: SLAVE ACCEPT
> >         Name: 'BlueZ (0)'
> >         Class: 0x000000
> >         Service Classes: Unspecified
> >         Device Class: Miscellaneous,
> >         HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver:
> 1.1
> > (0x1) LMP Subver: 0x33c
> >         Manufacturer: Cambridge Silicon Radio (10)
> > 
> > which seams ok. However I changed the hcid.conf to
> a
> > diferent Name and Class. It seams it is not
> reading
> > from the hcid.conf file but from somewhere else. 
> > 
> > Any idea of what is happening?
> > 
> > Regards,
> > 
> > Filipa Duarte
> > 
> > 
> are you sure that you killed the previously running
> hcid first? ps
> should show exactly one hcid process after running
> hcid: 
> "hcid: processing events".
> 
> Erwin
> 
> 
> 
> 
>
-------------------------------------------------------
> This SF.Net email is sponsored by the 'Do More With
> Dual!' webinar happening
> July 14 at 8am PDT/11am EDT. We invite you to
> explore the latest in dual
> core and dual graphics technology at this free one
> hour event hosted by HP, 
> AMD, and NVIDIA.  To register visit
> http://www.hp.com/go/dualwebinar
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
