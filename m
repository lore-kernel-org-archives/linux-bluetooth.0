Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <41458.156.116.2.246.1148041722.squirrel@webmail.uio.no>
References: <41458.156.116.2.246.1148041722.squirrel@webmail.uio.no>
Date: Mon, 29 May 2006 15:18:04 +0200
Message-Id: <1148908684.31689.38.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Internal bluetooth on d610
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

Hi Markus,

> I have a dell latitude d610 with internal bluetooth. I have recently
> installed ubuntu linux. I am using the bluez version distributed wiht
> ubuntu. But I have some problems with my internal bluetooth device. The
> hcitool dev gives me the output:
>  hciconfig
> hci0:   Type: USB
>         BD Address: 00:16:41:0B:19:64 ACL MTU: 384:8 SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:226 acl:0 sco:0 events:20 errors:0
>         TX bytes:413 acl:0 sco:0 commands:19 errors:0
> 
> so the bluetooth device is recognized by the system. But when i try
> hcitool inq no devices are found, using a Belkin usb bluetooth adapter mye
> cellular phone is recognized. Why does my internal bluetooth device not
> recognize my phone? What is wrong here?

I don't have any Dell machine at hand for testing, but maybe some weird
ACPI or BIOS setting deactivated your antenna.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
