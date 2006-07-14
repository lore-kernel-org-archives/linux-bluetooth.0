Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Dan Williams <dcbw@redhat.com>
In-Reply-To: <1152894617.14037.45.camel@localhost.localdomain>
References: <1152893105.14037.21.camel@localhost.localdomain>
	<1152894124.25660.33.camel@localhost>
	<1152894617.14037.45.camel@localhost.localdomain>
Date: Fri, 14 Jul 2006 18:39:18 +0200
Message-Id: <1152895158.25660.37.camel@localhost>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SCO MTU fix needed for Kensington Bluetooth USB
	Adapter
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Dan,

> > > It's a dongle, already listed in the blacklist, but might need more
> > > quirks.
> > > 
> > > "Kensington Bluetooth USB Adapter"
> > > Model #33085
> > > FCCID: QVZ10350001
> > > 
> > > lsusb
> > > --------------------------
> > > Bus 002 Device 009: ID 0a5c:3535 Broadcom Corp. 
> > > 
> > > hciconfig -a
> > > --------------------------
> > > hci0:   Type: USB
> > >         BD Address: xx:xx:xx:xx:xx:xx ACL MTU: 377:10 SCO MTU: 16:0
> > >         UP RUNNING PSCAN ISCAN AUTH ENCRYPT 
> > >         RX bytes:379 acl:0 sco:0 events:17 errors:0
> > >         TX bytes:318 acl:0 sco:0 commands:17 errors:0
> > 
> > please give us the full "hciconfig -a" to check the HCI version and
> > revision of the chip.
> 
> Sorry...
> 
> hci0:   Type: USB
>         BD Address: xx:xx:xx:xx:xx:xx ACL MTU: 377:10 SCO MTU: 16:0
>         UP RUNNING PSCAN ISCAN AUTH ENCRYPT 
>         RX bytes:379 acl:0 sco:0 events:17 errors:0
>         TX bytes:318 acl:0 sco:0 commands:17 errors:0
>         Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: RSWITCH HOLD SNIFF PARK 
>         Link mode: SLAVE ACCEPT 
>         Name: 'localhost.localdomain-0'
>         Class: 0x120104
>         Service Classes: Networking
>         Device Class: Computer, Desktop workstation
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x6965
>         Manufacturer: Broadcom Corporation (15)

please also send "hciconfig hci0 features" (I don't like to decode that
by hand). And check if "hciconfig hci0 inqmode 1" succeeds.

Regards

Marcel




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
