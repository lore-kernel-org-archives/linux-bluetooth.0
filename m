Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <6E672510D37D58428215BDFDF097DB46012D653E@EXGNT01.sasken.com>
References: <6E672510D37D58428215BDFDF097DB46012D653E@EXGNT01.sasken.com>
Date: Mon, 10 Sep 2007 21:11:50 +0200
Message-Id: <1189451510.687.62.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] FW: Regarding USB Bluetooth Driver
	for	Linux.....(2.4.22 kernel)!
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Pintu,
> 
> I have a USB Bluetooth device which can be used to transfer/receive
> files from my Mobile. 
>  
> I am working on a PBX system which is running on Linux.
> I am planning to write a USB Bluetooth Driver for this in Linux.
> My  PBX Linux kernel version is - 2.4.22-ncgl-10.12.1.0
> (Note: This kernel is a modified kernel of "2.4.22" without bluetooth
> support)
> I dont have any means of re-compiling the whole kernel again and
> putting it on the box.
> Also its not possible for me to upgrade the kernel version to 2.6.

we don't support the 2.4 kernel series anymore. So you are own your own.

> Also this system doesnt have the kernel source as well.

Actually that is illegal.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
