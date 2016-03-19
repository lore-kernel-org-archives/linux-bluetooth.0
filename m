Return-Path: <jslaby@suse.cz>
From: Jiri Slaby <jslaby@suse.cz>
To: johan.hedberg@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org,
	"stable 3 . 13+" <stable@vger.kernel.org>
Subject: [PATCH] Bluetooth: purge unhandled skbs
Date: Sat, 19 Mar 2016 11:49:43 +0100
Message-Id: <1458384583-10005-1-git-send-email-jslaby@suse.cz>
List-ID: <linux-bluetooth.vger.kernel.org>

The write handler allocates skbs and queues them into data->readq.
Read side should read them, if there is any. If there is none, skbs
should be dropped by hdev->flush. But this happens only if the device
is HCI_UP, i.e. hdev->power_on work was triggered already. When it was
not, skbs stay allocated in the queue when /dev/vhci is closed. So
purge the queue in ->release.

Program to reproduce:
	#include <err.h>
	#include <fcntl.h>
	#include <stdio.h>
	#include <unistd.h>

	#include <sys/stat.h>
	#include <sys/types.h>
	#include <sys/uio.h>

	int main()
	{
		char buf[] = { 0xff, 0 };
		struct iovec iov = {
			.iov_base = buf,
			.iov_len = sizeof(buf),
		};
		int fd;

		while (1) {
			fd = open("/dev/vhci", O_RDWR);
			if (fd < 0)
				err(1, "open");

			usleep(50);

			if (writev(fd, &iov, 1) < 0)
				err(1, "writev");

			usleep(50);

			close(fd);
		}

		return 0;
	}

Result:
kmemleak: 4609 new suspected memory leaks
unreferenced object 0xffff88059f4d5440 (size 232):
  comm "vhci", pid 1084, jiffies 4294912542 (age 37569.296s)
  hex dump (first 32 bytes):
    20 f0 23 87 05 88 ff ff 20 f0 23 87 05 88 ff ff   .#..... .#.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
...
    [<ffffffff81ece010>] __alloc_skb+0x0/0x5a0
    [<ffffffffa021886c>] vhci_create_device+0x5c/0x580 [hci_vhci]
    [<ffffffffa0219436>] vhci_write+0x306/0x4c8 [hci_vhci]

Fixes: 23424c0d31 (Bluetooth: Add support creating virtual AMP controllers)
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
Cc: stable 3.13+ <stable@vger.kernel.org>
---
 drivers/bluetooth/hci_vhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 3ec580e38c17..f67ea1c090cb 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -344,6 +344,7 @@ static int vhci_release(struct inode *inode, struct file *file)
 		hci_free_dev(hdev);
 	}
 
+	skb_queue_purge(&data->readq);
 	file->private_data = NULL;
 	kfree(data);
 
-- 
2.7.4
