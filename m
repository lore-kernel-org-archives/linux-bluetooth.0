Return-Path: <jslaby@suse.cz>
From: Jiri Slaby <jslaby@suse.cz>
To: johan.hedberg@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	"stable 3 . 13+" <stable@vger.kernel.org>
Subject: [PATCH] Bluetooth: vhci, fix open_timeout vs. hdev race
Date: Sat, 19 Mar 2016 10:47:32 +0100
Message-Id: <1458380852-7533-1-git-send-email-jslaby@suse.cz>
List-ID: <linux-bluetooth.vger.kernel.org>

Both vhci_get_user and vhci_release race with open_timeout work. They
both contain cancel_delayed_work_sync, but do not test whether the
work actually created hdev or not. Since the work can be in progress
and _sync will wait for finishing it, we can have data->hdev allocated
when cancel_delayed_work_sync returns. But the call sites do 'if
(data->hdev)' *before* cancel_delayed_work_sync.

As a result:
* vhci_get_user allocates a second hdev and puts it into
  data->hdev. The former is leaked.
* vhci_release does not release data->hdev properly as it thinks there
  is none.

Fix both cases by moving the actual test *after* the call to
cancel_delayed_work_sync.

This can be hit by this program:
	#include <err.h>
	#include <fcntl.h>
	#include <stdio.h>
	#include <stdlib.h>
	#include <time.h>
	#include <unistd.h>

	#include <sys/stat.h>
	#include <sys/types.h>

	int main(int argc, char **argv)
	{
		char buf[] = { 0xff, 0 };
		struct iovec iov = {
			.iov_base = buf,
			.iov_len = sizeof(buf),
		};
		int fd;

		srand(time(NULL));

		while (1) {
			const int delta = (rand() % 200 - 100) * 100;

			fd = open("/dev/vhci", O_RDWR);
			if (fd < 0)
				err(1, "open");

			usleep(100000 + delta);

			close(fd);
		}

		return 0;
	}

Fixes: 23424c0d31 (Bluetooth: Add support creating virtual AMP controllers)
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: stable 3.13+ <stable@vger.kernel.org>
---
 drivers/bluetooth/hci_vhci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 7287d774e107..f67ea1c090cb 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -189,13 +189,13 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
 		break;
 
 	case HCI_VENDOR_PKT:
+		cancel_delayed_work_sync(&data->open_timeout);
+
 		if (data->hdev) {
 			kfree_skb(skb);
 			return -EBADFD;
 		}
 
-		cancel_delayed_work_sync(&data->open_timeout);
-
 		opcode = *((__u8 *) skb->data);
 		skb_pull(skb, 1);
 
@@ -333,10 +333,12 @@ static int vhci_open(struct inode *inode, struct file *file)
 static int vhci_release(struct inode *inode, struct file *file)
 {
 	struct vhci_data *data = file->private_data;
-	struct hci_dev *hdev = data->hdev;
+	struct hci_dev *hdev;
 
 	cancel_delayed_work_sync(&data->open_timeout);
 
+	hdev = data->hdev;
+
 	if (hdev) {
 		hci_unregister_dev(hdev);
 		hci_free_dev(hdev);
-- 
2.7.4
