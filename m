Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4550E041.80201@op.pl>
References: <4550E041.80201@op.pl>
Date: Mon, 13 Nov 2006 09:19:01 +0100
Message-Id: <1163405941.26272.43.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] can't add bnep0 to bridge pan0: Invalid argument
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

Hi,

> First of all I'm not completely sure if this is the right group to post
> to but since I get no error messages in logs, I hope nobody will feel
> offended.
> 
> I'm trying to create an NAP under kernel 2.6.18.2 (description from
> http://bluez.sourceforge.net/contrib/HOWTO-PAN). I use an USB BT dongle
> from Integrated System Solution Corp. and it's been recognised as follows:
> 
> ~# hciconfig -a
> hci0:   Type: USB
>         BD Address: 11:11:11:11:11:11 ACL MTU: 678:8 SCO MTU: 48:10
>         UP RUNNING PSCAN ISCAN AUTH ENCRYPT
>         RX bytes:101 acl:0 sco:0 events:13 errors:0
>         TX bytes:299 acl:0 sco:0 commands:13 errors:0
>         Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: ACCEPT MASTER
>         Name: 'tempac'
>         Class: 0x020100
>         Service Classes: Networking
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2 (0x2) LMP Subver:
> 0x1fe
>         Manufacturer: Integrated System Solution Corp. (57)
> 
> The problem turn up when I try (after establishing connection) to add
> bnep0 interface to pan0 bridge interface. After
> 
> ~# brctl addif pan0 bnep0
> 
> I get:
> 
> can't add bnep0 to bridge pan0: Invalid argument
> 
> (bnep0 has IP 0.0.0.0 after ifconfig bnep0 0.0.0.0 and is up, though I
> get no answer on ping which I could be a routing problem actually. Also
> adding eth1 makes no problems).
> 
> As I said, no messages in logs, no more information. What's wrong?

you have a dongle with an invalid BD_ADDR. Return that dongle and get
one which has a valid address. Dongles using this address can't be added
to a bridge.

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
