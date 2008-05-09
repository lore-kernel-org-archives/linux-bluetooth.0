Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1210324444433@dmwebmail.dmwebmail.chezphil.org>
References: <1210324444433@dmwebmail.dmwebmail.chezphil.org>
Date: Fri, 09 May 2008 14:31:39 +0200
Message-Id: <1210336299.28002.24.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Apple wireless keyboard [hid2hci]
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

Hi Phil,

> I've acquired a second USB bluetooth dongle, and this one does have a
> CSR chip:
> 
> $ lsusb|grep -i bluetooth
> Bus 003 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
> Dongle (HCI mode)
> 
> I've got this working in normal Bluetooth mode in the same way that I
> did with the other dongle and it works.  But I have failed to put it
> into HID mode.  Am I doing the right thing?  I've tried this either
> with the keyboard connected in HCI mode or with it not connected, with
> the bluez daemons running or not running, and in all cases I get:
> 
> # hid2hci --tohid
> Switching device 0a12:0001 to HID mode failed (Broken pipe)
> 
> strace shows this:
> 
> open("/dev/bus/usb/003/002", O_RDWR)    = 3
> ioctl(3, USBDEVFS_CONTROL, 0xbfa9f64c)  = -1 EPIPE (Broken pipe)
> 
> Does anyone have any clues?  According to the kernel's
> Documentation/usb/error-codes.txt, EPIPE means that the endpoint is stalled.

not all CSR dongles are HID proxy dongles. Actually the majority of them
are not.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
