Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <6ae1569005030612313e3f21c0@mail.gmail.com>
From: Adis Beglerovic <emerge.gentoo@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] DBT-120 and Siemens S65
In-Reply-To: <1110118790.8302.17.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <6ae1569005030604105d08a56e@mail.gmail.com>
	 <1110111350.8302.9.camel@pegasus>
	 <6ae1569005030605485547bf58@mail.gmail.com>
	 <1110117308.8302.12.camel@pegasus>
	 <6ae15690050306060128edc405@mail.gmail.com>
	 <1110117912.8302.14.camel@pegasus>
	 <6ae156900503060610175d3992@mail.gmail.com>
	 <1110118790.8302.17.camel@pegasus>
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
Date: Sun, 6 Mar 2005 21:31:29 +0100

Finaly I got great results with modules in kernel and now 
hcicionfig -a shows this:
hciconfig -a
hci0:   Type: USB
        BD Address: 00:11:95:6F:DE:D1 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN 
        RX bytes:1754 acl:38 sco:0 events:80 errors:0
        TX bytes:1007 acl:34 sco:0 commands:29 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'BlueZ (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)
But when I try to use obexftp I get to the part where it asks for pass
and pass is not good.
Where do I look for pass ? In /etc/bluetooth/pin ?
Thanks


On Sun, 06 Mar 2005 15:19:50 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Adis,
> 
> > Was following this howto http://gentoo-wiki.com/HOWTO_The_host-to-host_Bluetooth
> > and stuff that was added are as following:Device Drivers  --->
> >   Networking Support  --->
> >     <*> Bluetooth subsystem support  --->
> >         <*> L2CAP protocol support
> >         <*> SCO links support
> >         <*> RFCOMM protocol support
> >             [*] RFCOMM TTY support
> >         <*> BNEP protocol support
> >             [*] Multicast filter support
> >             [*] Protocol filter support
> >               Bluetooth device drivers  --->
> >                 <*> HCI USB driver
> >                     [*] SCO (voice) support
> > USB support  --->
> >    <*> Support for Host-side USB
> >    --- USB Host Controller Drivers
> >    <M> EHCI HCD (USB 2.0) support
> >    <M> OHCI HCD support
> >    <*> UHCI HCD (most Intel and VIA) support
> >    --- USB Device Class drivers
> >    <*> USB Audio support
> >
> > Please tell me if this is wrong and.
> > You are also suggesting modules? Which one as a module ?
> > Can you point me to a howto that explains it ?
> 
> I never checked again, if Bluetooth built-in is still working. Most
> people are using a full modular kernel and this includes Bluetooth as
> well as USB.
> 
> Regards
> 
> Marcel
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
