Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oneukum@suse.de>
In-Reply-To: <200705161355.22934.oneukum@suse.de>
References: <200705161345.58587.oneukum@suse.de>
	<1179316209.10069.70.camel@violet> <200705161355.22934.oneukum@suse.de>
Date: Wed, 16 May 2007 14:08:59 +0200
Message-Id: <1179317339.10069.73.camel@violet>
Mime-Version: 1.0
Cc: bluez-devel@lists.sf.net, linux-usb-devel@lists.sourceforge.net,
        maxk@qualcomm.com
Subject: Re: [Bluez-devel] [patch]quirky dongle for hci_usb
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

Hi Oliver,

> > > here's an additional device with the reset quirk.
> > > 
> > > 	Regards
> > > 		Oliver
> > > Signed-off-by: Oliver Neukum <oneukum@suse.de>
> > 
> > that patch doesn't apply since we already have this:
> > 
> >         /* Dell laptop with Broadcom chip */
> >         { USB_DEVICE(0x413c, 0x8126), .driver_info = HCI_WRONG_SCO_MTU },
> > 
> > Why do you think HCI_RESET is needed? Did Dell switched to using a HID
> > proxy dongle or what?
> 
> A user reported that his dongle needs a reset to work. A manual reset, the
> module option and that patch solved the issue.

an manual reset is not possible. The HCI_RESET quirk only end up sending
HCI Reset as the first command. This actually only resets the Bluetooth
chip and nothing on the USB bus. Only in cases of Broadcom HID proxy it
triggers the HID to HCI switch.

I am simply not convinced that this is a HID proxy adapter and thus this
patch is not needed at all.

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
