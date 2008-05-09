Return-Path: <cyrus@holtmann.org>
From: "Phil Endecott" <spam_from_bluez_users@chezphil.org>
To: <bluez-users@lists.sourceforge.net>
Date: Fri, 09 May 2008 17:45:57 +0100
Message-ID: <1210351557416@dmwebmail.dmwebmail.chezphil.org>
In-Reply-To: <1210336299.28002.24.camel@violet.holtmann.net>
References: <1210336299.28002.24.camel@violet.holtmann.net>
MIME-Version: 1.0
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

Marcel Holtmann wrote:
> Hi Phil,
>
>> I've acquired a second USB bluetooth dongle, and this one does have a
>> CSR chip:
>> 
>> $ lsusb|grep -i bluetooth
>> Bus 003 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
>> Dongle (HCI mode)
>> 
>> I've got this working in normal Bluetooth mode in the same way that I
>> did with the other dongle and it works.  But I have failed to put it
>> into HID mode.  Am I doing the right thing?  I've tried this either
>> with the keyboard connected in HCI mode or with it not connected, with
>> the bluez daemons running or not running, and in all cases I get:
>> 
>> # hid2hci --tohid
>> Switching device 0a12:0001 to HID mode failed (Broken pipe)
>> 
>> strace shows this:
>> 
>> open("/dev/bus/usb/003/002", O_RDWR)    = 3
>> ioctl(3, USBDEVFS_CONTROL, 0xbfa9f64c)  = -1 EPIPE (Broken pipe)
>> 
>> Does anyone have any clues?  According to the kernel's
>> Documentation/usb/error-codes.txt, EPIPE means that the endpoint is stalled.
>
> not all CSR dongles are HID proxy dongles. Actually the majority of them
> are not.

Right.  But mine matches the USB vendor/product ID in the table in 
hid2hci.c.  So even in that case, it might not support HID proxy mode, 
right?  (I have a vague recollection of a firmware upgrade possibility 
using a windows program, but I may be thinking of something else; does 
that ring a bell with anyone?)

Does anyone reading this actually have one of these elusive devices in 
their possession?  If so I'd love to know the brand etc. and even to 
get a photo.  I know it still doesn't guarantee anything, but it would 
be better than my current "random guess" approach to finding one.

On the other hand, if I won't be able to get HID proxy mode to work, I 
need to understand some more about how normal bluetooth keyboard mode 
works.  In particular, the kernel has some input quirks for Apple 
keyboards that seem to be keyed on the USB vendor/product IDs; for 
example, FN+UP => PgUp.  These don't seem to be applied on my system, 
presumably because the USB ID matching has nothing to do with bluetooth 
devices.  How is this supposed to work?

Cheers,

Phil.





-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
