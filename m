Return-Path: <cyrus@holtmann.org>
From: Larry Finger <Larry.Finger@lwfinger.net>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	Champion Chen <champion_chen@realsil.com.cn>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Stable <stable@vger.kernel.org>
Subject: [PATCH] bluetooth: btusb: Fix issue with suspend
Date: Fri,  5 Sep 2014 10:16:34 -0500
Message-Id: <1409930194-6318-1-git-send-email-Larry.Finger@lwfinger.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Champion Chen <champion_chen@realsil.com.cn>

Suspend could fail for some platforms because
btusb_suspend==> btusb_stop_traffic ==> usb_kill_anchored_urbs,

When btusb_bulk_complete returns before system suspend and resubmits an urb,
the system cannot enter suspend state.

Signed-off-by: Champion Chen <champion_chen@realsil.com.cn>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Stable <stable@vger.kernel.org>
---
Johan,

To help Champion with the process, I have formatted the patch in
the correct manner. I hope I understand the issue correctly and
stated it in a coherent manner in the commit message.

Larry
---
 drivers/bluetooth/btusb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 292c38e..45a7211 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -330,6 +330,9 @@ static void btusb_intr_complete(struct urb *urb)
 			BT_ERR("%s corrupted event packet", hdev->name);
 			hdev->stat.err_rx++;
 		}
+	} else if (urb->status == -ENOENT) {
+		/* Avoid suspend failed when usb_kill_urb */
+		return;
 	}
 
 	if (!test_bit(BTUSB_INTR_RUNNING, &data->flags))
@@ -417,6 +420,9 @@ static void btusb_bulk_complete(struct urb *urb)
 						urb->actual_length) < 0) {
 			BT_ERR("%s corrupted ACL packet", hdev->name);
 			hdev->stat.err_rx++;
+		} else if (urb->status == -ENOENT) {
+			/* Avoid suspend failed when usb_kill_urb */
+			return;
 		}
 	}
 
@@ -512,6 +518,9 @@ static void btusb_isoc_complete(struct urb *urb)
 				hdev->stat.err_rx++;
 			}
 		}
+	} else if (urb->status == -ENOENT) {
+		/* Avoid suspend failed when usb_kill_urb */
+		return;
 	}
 
 	if (!test_bit(BTUSB_ISOC_RUNNING, &data->flags))
-- 
1.8.4.5

