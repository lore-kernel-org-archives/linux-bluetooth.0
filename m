Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <cd3ff4f20705022352u3451a87eub2e03a33f7bcf535@mail.gmail.com>
References: <cd3ff4f20705022352u3451a87eub2e03a33f7bcf535@mail.gmail.com>
Date: Fri, 04 May 2007 08:37:58 +0200
Message-Id: <1178260678.25425.22.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Device not detected (HP nx9420 / Kubuntu Feisty)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

> I can't see my bluetooth device on my HP nx9420 laptop with Kubuntu
> Feisty 7.04. Everything works well under Windows.
> 
> Here are some informations :
> 
> xav@xav-laptop:/$ uname -a
> Linux xav-laptop 2.6.20-15-generic #2 SMP Sun Apr 15 07:36:31 UTC 2007
> i686 GNU/Linux
> 
> xav@xav-laptop:/$ hciconfig -a
> 
> xav@xav-laptop:/$ hcitool scan
> Device is not available: No such device
> 
> xav@xav-laptop:/$ hcitool inq
> Inquiring ...
> Inquiry failed.: No such device
> 
> xav@xav-laptop:/$ hcitool dev
> Devices:
> 
> xav@xav-laptop:/$ lsusb
> Bus 002 Device 001: ID 0000:0000
> Bus 003 Device 002: ID 1267:0210 Logic3 / SpectraVideo plc
> Bus 003 Device 001: ID 0000:0000
> Bus 005 Device 001: ID 0000:0000
> Bus 004 Device 001: ID 0000:0000
> Bus 001 Device 001: ID 0000:0000

looks like you have to find the rfkill switch to enable the Bluetooth
USB dongle inside your computer.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
