Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Max Krasnyansky <maxk@qualcomm.com>
In-Reply-To: <471DA835.2060308@qualcomm.com>
References: <471DA835.2060308@qualcomm.com>
Date: Tue, 23 Oct 2007 13:35:36 +0200
Message-Id: <1193139336.6184.191.camel@violet>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] What's the purpose of the new btusb driver ?
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

Hi Max,

> I was going through latest 2.6 updates and noticed
> 	"Generic Bluetooth USB driver"
> Why do we need it ?
> 
> The driver code looks awfully similar to my very first implementation of the hci_usb.
> ie No URB queuing, etc.
> I think the only thing that is wrong with hci_usb is the custom urb queuing code
> (ie _urb stuff). That code was temporary at the time I put it in (year ago now). 
> Greg and I were discussing merging it into USB core. I think we should just do 
> that instead.
> If you think URB queuing is no longer needed (I doubt it) then maybe we can just
> rip that part out.

the USB subsystem changed a lot in the last two years and everything
goes into the direction of one-shot URBs or is using USB anchors to
track them. The btusb driver is a full re-write from scratch to make use
of it. The driver is still marked as experimental and you can't select
it if you enable hci_usb. I pushed it into the mainline kernel since we
are currently trying to make it work with autosuspend and also with USB
remote wakeup. Both are tricky parts and will need a lot of quirks. In
the long run this driver should also do the correct alternate switching
in case of SCO connections. So it is meant as a full replacement, but we
are not there yet. The hci_usb driver works and I didn't wanna touch it
unless we have a full replacement.

My latest tests with the bpa10x and bfusb drivers showed that the URB
queuing code is not really needed. The USB core does this already for us
and in case of control, interrupt and bulk URBs we can fire at will. The
USB core will handle it. The re-submitting can be easily handled and we
can attach an anchor to a number of URBs to later on kill them all at
once. Latest edition was a flag to let the USB core free the buffer by
itself so that the driver doesn't have to care about it anymore. All
URBs now have a reference count and so the users are known.

I still have some minor troubles with the isochronous URBs for SCO
support and this one-shot model, but that should be fixed soon.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
