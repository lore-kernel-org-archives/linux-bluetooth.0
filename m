Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20060824104106.36b89a2e@debian>
References: <20060824104106.36b89a2e@debian>
Date: Thu, 24 Aug 2006 13:24:12 +0200
Message-Id: <1156418652.4133.85.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] CSR Bluetooth firmware upgrade
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

> my HP Ipaq h2200 has a CSR Bluetooth chipset and I use Familiar
> (GNU/Linux) v0.8.4 on it; this is the output of "hciconfig -a":
> 
> hci0:   Type: UART
>         BD Address: XX:XX:XX:XX:XX:XX ACL MTU: 192:8 SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN AUTH ENCRYPT 
>         RX bytes:569 acl:0 sco:0 events:29 errors:0
>         TX bytes:1334 acl:0 sco:0 commands:28 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: RSWITCH HOLD SNIFF PARK 
>         Link mode: SLAVE ACCEPT 
>         Name: 'h2200'
>         Class: 0x120112
>         Service Classes: Networking
>         Device Class: Computer, Handheld
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP
> Subver: 0x20d Manufacturer: Cambridge Silicon Radio (10)
> 
> and this one is the output of "hciconfig hci0 revision":
> 
> hci0:   Type: UART
>         BD Address: XX:XX:XX:XX:XX:XX ACL MTU: 192:8 SCO MTU: 64:8
>         HCI 16.4
>         Chip version: BlueCore02-External
>         Max key size: 56 bit
>         SCO mapping:  HCI
> 
> It is possible to upgrade the CSR Bluetooth firmware to get 128-bit
> encryption?

in general it is possible, but you need an official firmware from HP and
a firmware upgrade utility that can be used over UART.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
