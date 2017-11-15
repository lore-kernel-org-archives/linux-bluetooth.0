Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: abhijeet.kumar@intel.com
To: Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: abhijeet.kumar@intel.com
Subject: [PATCH] Bluettoth: btusb: Prevent USB devices to autosuspend while setting interface
Date: Wed, 15 Nov 2017 17:41:28 +0530
Message-Id: <1510747888-13912-1-git-send-email-abhijeet.kumar@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Abhijeet Kumar <abhijeet.kumar@intel.com>

Runtime resume USB device in order to ensure that PM framework knows
that the we might be using the device in a short time and doesn't
autosuspend the device while we update it's interface.

Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
---
 drivers/bluetooth/btusb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7a5c06aaa181..588aabf991be 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1444,6 +1444,12 @@ static void btusb_work(struct work_struct *work)
 			data->sco_skb = NULL;
 			spin_unlock_irqrestore(&data->rxlock, flags);
 
+			 /*
+			  *Letting runtime PM know that we wish to use
+			  *the device in a short time.
+			  */
+			  pm_runtime_get(&data->udev->dev);
+
 			if (__set_isoc_interface(hdev, new_alts) < 0)
 				return;
 		}
-- 
1.9.1

