Return-Path: <baijiaju1990@gmail.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] bluetooth: hci_ll: Replace mdelay with msleep in download_firmware
Date: Sat, 27 Jan 2018 18:03:52 +0800
Message-Id: <1517047432-23420-1-git-send-email-baijiaju1990@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

download_firmware() is never called from atomic context.

It is only called by ll_setup() that is called only via function pointer 
"->setup" used in hci_uart_setup() in drivers/bluetooth/hci_serdev.c and
drivers/bluetooth/hci_ldisc.c. hci_uart_setup() is called only 
via function pointer "->setup" used in hci_dev_do_open() 
in net/bluetooth/hci_core.c.
All of the above functions do not enter atomic context.

Besides, ll_setup() calls msleep() and hci_dev_do_open calls mutex_lock().
So it indicates that all the above functions call functions that can sleep.

Despite never getting called from atomic context, download_firmware() 
calls mdelay() for busy wait.
That is not necessary and can be replaced with msleep to avoid busy wait.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/bluetooth/hci_ll.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index e2c078d..f804adc 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -644,7 +644,7 @@ static int download_firmware(struct ll_device *lldev)
 			break;
 		case ACTION_DELAY:	/* sleep */
 			bt_dev_info(lldev->hu.hdev, "sleep command in scr");
-			mdelay(((struct bts_action_delay *)action_ptr)->msec);
+			msleep(((struct bts_action_delay *)action_ptr)->msec);
 			break;
 		}
 		len -= (sizeof(struct bts_action) +
-- 
1.7.9.5
