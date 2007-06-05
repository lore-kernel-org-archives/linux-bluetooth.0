Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4665E314.8050609@gmail.com>
References: <4665E314.8050609@gmail.com>
Date: Wed, 06 Jun 2007 00:30:43 +0200
Message-Id: <1181082643.13429.143.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] dfutool problems
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

Hi Jarom,

> I recently ran "dfutool archive foo" on my IBM bluetooth adapter
> (Broadcom) thinking it would save my firmware to the file "foo".  It
> created a zero-length file, said that the operation timed out, and
> exited.  Ever since, by bluetooth adapter has been stuck in DFU mode:
> 
> # dfutool archive foo
> Available devices with DFU support:
> 
>          1) Bus 003 Device 034: ID 0a5c:2000 Interface 0 (DFU mode)
> 
> Select device (abort with 0): 1
> 
> Firmware upload ...
> Can't upload next block: Connection timed out (110)
> 
> from dmesg:
> usb 3-1: Product: Broadcom Bluetooth Download Device
> 
> Does anyone know why it did that and how to get the adapter out of DFU
> mode?  I don't want to have to buy a new adapter... :)

the Broadcom ones fail for no reason. Seems that their implementation of
DFU is buggy. I have seen that before.

However there is no tool to get it back into normal. It is not that
complicated, but you have to poke around the source code of dfutool for
that.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
