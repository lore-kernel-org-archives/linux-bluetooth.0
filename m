Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: sonnyrao@google.com
From: Sonny Rao <sonnyrao@chromium.org>
Date: Mon, 27 Aug 2012 03:30:55 -0700
Message-ID: <CAPz6YkVEwWzosE5Tda+SvtmV1=0Q9g5uyW+RZsOVgOxT79c15Q@mail.gmail.com>
Subject: kernel crashes coming from btusb
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, vpalatin@chromium.org, keybuk@chromium.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, I've been investigating an issue where we were seeing random
kernel crashes soon after resume and after using the great debugging
facilities in SLUB I started getting output which pointed to "use
after free" from the btusb driver.

Here's an example output:


[ 5805.135620] ===============================================================
 [ 5805.135627] BUG kmalloc-16 (Not tainted): Poison overwritten
 [ 5805.135631] -------------------------------------------------------------
 [ 5805.135633]
 [ 5805.135638] INFO: 0xf4f0ae40-0xf4f0ae4e. First byte 0xe instead of 0x6b
 [ 5805.135647] INFO: Allocated in 0xf8dab31c age=130 cpu=0 pid=27759
 [ 5805.135657]         __slab_alloc.constprop.71+0x27c/0x2b7
 [ 5805.135663]         __kmalloc+0xc4/0x12c
 [ 5805.135666]         0xf8dab31c
 [ 5805.135668]         0xf8dac6d4
 [ 5805.135677]         hci_dev_open+0xcc/0x2a6 [bluetooth]
 [ 5805.135685]         hci_dev_open+0x25c/0x2a6 [bluetooth]
 [ 5805.135690]         process_one_work+0x142/0x227
 [ 5805.135694]         worker_thread+0xfc/0x1cc
 [ 5805.135698]         kthread+0x6c/0x71
 [ 5805.135705]         kernel_thread_helper+0x6/0x10
 [ 5805.135712] INFO: Freed in urb_destroy+0x19/0x23 age=60 cpu=0 pid=1434
 [ 5805.135718]         __slab_free+0x33/0x1af
 [ 5805.135722]         kfree+0xb5/0xbe
 [ 5805.135725]         urb_destroy+0x19/0x23
 [ 5805.135729]         usb_free_urb+0x1c/0x1e
 [ 5805.135734]         usb_kill_anchored_urbs+0x34/0x4b
 [ 5805.135737]         0xf8dac5dc
 [ 5805.135744]         hci_alloc_dev+0x29d/0x491 [bluetooth]
 [ 5805.135751]         hci_dev_close+0x43/0x56 [bluetooth]
 [ 5805.135759]         mgmt_device_unblocked+0x6ce/0xddd [bluetooth]
 [ 5805.135765]         sock_ioctl+0x1ca/0x1ec
 [ 5805.135770]         do_vfs_ioctl+0x455/0x489
 [ 5805.135775]         sys_ioctl+0x46/0x67
 [ 5805.135780]         sysenter_do_call+0x12/0x26
 [ 5805.135785] INFO: Slab 0xf6e9a140 objects=21 used=21 fp=0x  (null)
flags=0x6800080
 [ 5805.135790] INFO: Object 0xf4f0ae40 @offset=3648 fp=0xf4f0a180
 [ 5805.135792]
 [ 5805.135796] Bytes b4 f4f0ae30: 14 00 00 00 9e 1c 54 00 5a 5a 5a 5a
5a 5a 5a 5a  ......T.ZZZZZZZZ
 [ 5805.135801] Object f4f0ae40: 0e 0e 01 04 10 00 01 01 00 00 00 00
00 00 00 00  ................
 [ 5805.135806] Redzone f4f0ae50: bb bb bb bb
            ....
 [ 5805.135810] Padding f4f0aef8: 5a 5a 5a 5a 5a 5a 5a 5a
            ZZZZZZZZ
 [ 5805.135816] Pid: 16386, comm: grep Not tainted 3.4.0 #1
 [ 5805.135819] Call Trace:

from my tracing it looks like the object in kmalloc-16 was the
transfer buffer from the intr urb as far as I can tell there isn't an
actual use after free issue with the code, but rather it looks like
sometimes hardware is still dma'ing over that buffer after the kernel
has freed it which is what causes this issue.

I'm not very familiar with USB, but I tried to trace when that URB and
it's transfer buffer get unmapped from dma and I wasn't able to see
where that happens.  I was looking for a call to unmap_urb_for_dma()
in drivers/usb/core/hcd.c.

Is it possible btusb isn't properly disabling the URB somehow before
close and the USB host controller continues to process interrupts for
that URB after it has been freed?

Unfortunately this can be difficult to reproduce because the
suspend/resume crash is only happening after a few hundred suspend
resume cycles on average. However, I'm also able to get a large number
of kernel crashes (not necessarily the use after free poison overwritten
detection) which might be related to whether or not things are being
properly shut down, if I do this:

while true ; rmmod btusb ; modprobe btusb; done

while bluetoothd is active in the background.

That's so far the best way I've found to see issues here,

Thanks for any assistance!
Sonny
