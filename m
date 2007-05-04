Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Ohad Ben-Cohen <ohad@bencohen.org>
In-Reply-To: <200704301140.46336.ohad@bencohen.org>
References: <200704301140.46336.ohad@bencohen.org>
Date: Fri, 04 May 2007 08:52:08 +0200
Message-Id: <1178261528.25425.38.camel@violet>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH 2.6.21] Bluetooth: add support for TI's
	HCILL UART	protocol
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

Hi Ohad,

> Add support for Texas Instruments' HCI Low Level (HCILL) UART Bluetooth
> protocol. HCILL is a runtime power management extension to H4,
> which is widely used by TI's BRF63xx Bluetooth chips.

please explain the usefulness of HCIUARTGETDEVICE to me.

And the ll_dbg_data() has to go away. On LKML they discussing a generic
hexdump function. I could accept the usage of that, but no crazy own
debug routine in the kernel code.

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
