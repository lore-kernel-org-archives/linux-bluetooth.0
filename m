Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-Id: <6EE8D368-C303-400A-B4FE-811228391639@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Dave Young <hidave.darkstar@gmail.com>
In-Reply-To: <a8e1da0711290006x4bd3cc45x1ae8dcaa9c0ab462@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Date: Thu, 29 Nov 2007 21:19:03 +0100
References: <1196009038.14897.6.camel@pico> <1196056187.4217.54.camel@aeonflux>
	<1196305426.23029.12.camel@pico>
	<a8e1da0711290006x4bd3cc45x1ae8dcaa9c0ab462@mail.gmail.com>
Cc: bgsmith@bendcable.com, BlueZ users <bluez-users@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Bluez-users] Lost connections - mouse and keyboard
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

Hi Dave,

>> apparently does manage bluetooth devices using bluetooth-input- 
>> service.
>> I  still have the problem of the devices disappearing if idle for too
>> long such as when i lock the desktop or log out for  a long period.
>> Sometimes I can re-enable the devices, but sometimes I cannot.   
>> This is
>> frustrating.
>>
>> I see a the following several times in the system log if i restart
>> bluetooth:
>> Nov 28 18:53:39 pico kernel: WARNING: at drivers/hid/hid-core.c:784
>> implement() (Tainted: P       )
>> Nov 28 18:53:39 pico kernel:
>> Nov 28 18:53:39 pico kernel: Call Trace:
>> Nov 28 18:53:39 pico kernel:  [<ffffffff811d8549>] hid_output_report
>> +0x1c5/0x232
>> Nov 28 18:53:39 pico kernel:  [<ffffffff811ddaf1>] hid_submit_ctrl
>> +0x60/0x24b
>> Nov 28 18:53:39 pico kernel:  [<ffffffff811dde45>]  
>> usbhid_submit_report
>> +0x169/0x19e
>> Nov 28 18:53:39 pico kernel:  [<ffffffff811e030b>] hiddev_ioctl
>> +0x368/0x919
>> Nov 28 18:53:39 pico kernel:  [<ffffffff810f54c5>] inode_has_perm
>> +0x65/0x72
>> Nov 28 18:53:39 pico kernel:  [<ffffffff81120c17>] __up_read 
>> +0x19/0x7f
>> Nov 28 18:53:39 pico kernel:  [<ffffffff8125eecc>] do_page_fault
>> +0x490/0x7e4
>> Nov 28 18:53:39 pico kernel:  [<ffffffff810a7399>] do_ioctl+0x55/0x6b
>> Nov 28 18:53:39 pico kernel:  [<ffffffff810a75f2>] vfs_ioctl 
>> +0x243/0x25c
>> Nov 28 18:53:39 pico kernel:  [<ffffffff810a7664>] sys_ioctl 
>> +0x59/0x79
>> Nov 28 18:53:39 pico kernel:  [<ffffffff8100bd45>] tracesys+0xd5/0xda
>>
>
> Does bluetooth input devices have something to do with usbhid? I don't
> know, perhaps this is another problem in kernel.

in case you have a HID proxy dongle the usbhid driver can be involved.  
And since this is hiddev, then it will be caused by the hid2hci program.

Regards

Marcel


-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
