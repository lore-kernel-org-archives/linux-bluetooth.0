Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <4665E3BA.1040309@gmail.com>
References: <4665E3BA.1040309@gmail.com>
Date: Sat, 16 Jun 2007 09:52:06 +0200
Message-Id: <1181980327.6846.80.camel@aeonflux.inter-touch.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users] dfutool problems
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
> mode?  I don't want to have to buy a new adapter...  :)

if it is Broadcom then it will fail. And it is possible to get this back
out of the mode, but no tool supports it. Or maybe the dfu-util from the
OpenMoko project.

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
