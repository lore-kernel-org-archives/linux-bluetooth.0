Return-Path: <cyrus@holtmann.org>
Sender: Larry Finger <larry.finger@gmail.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	Champion Chen <champion_chen@realsil.com.cn>,
	Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH V2] bluetooth: btusb: Fix issue with suspend
Date: Sat,  6 Sep 2014 14:06:08 -0500
Message-Id: <1410030368-23289-1-git-send-email-Larry.Finger@lwfinger.net>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Champion Chen <champion_chen@realsil.com.cn>

Suspend could fail for some platforms because
btusb_suspend==> btusb_stop_traffic ==> usb_kill_anchored_urbs,

When btusb_bulk_complete returns before system suspend and resubmits an urb,
the system cannot enter suspend state.

Signed-off-by: Champion Chen <champion_chen@realsil.com.cn>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
V2 - Fix incorrect test as noted by Marcel.

---
Johan,

To help Champion with the process, I have formatted the patch in
the correct manner. I hope I understand the issue correctly and
stated it in a coherent manner in the commit message.

Larry
---
 drivers/bluetooth/btusb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux-2.6/drivers/bluetooth/btusb.c
===================================================================
--- linux-2.6.orig/drivers/bluetooth/btusb.c
+++ linux-2.6/drivers/bluetooth/btusb.c
@@ -330,6 +330,9 @@ static void btusb_intr_complete(struct u
 			BT_ERR("%s corrupted event packet", hdev->name);
 			hdev->stat.err_rx++;
 		}
+	} else if (urb->status == -ENOENT) {
+		/* Avoid suspend failed when usb_kill_urb */
+		return;
 	}
 
 	if (!test_bit(BTUSB_INTR_RUNNING, &data->flags))
@@ -418,6 +421,9 @@ static void btusb_bulk_complete(struct u
 			BT_ERR("%s corrupted ACL packet", hdev->name);
 			hdev->stat.err_rx++;
 		}
+	} else if (urb->status == -ENOENT) {
+		/* Avoid suspend failed when usb_kill_urb */
+		return;
 	}
 
 	if (!test_bit(BTUSB_BULK_RUNNING, &data->flags))
@@ -512,6 +518,9 @@ static void btusb_isoc_complete(struct u
 				hdev->stat.err_rx++;
 			}
 		}
+	} else if (urb->status == -ENOENT) {
+		/* Avoid suspend failed when usb_kill_urb */
+		return;
 	}
 
 	if (!test_bit(BTUSB_ISOC_RUNNING, &data->flags))
