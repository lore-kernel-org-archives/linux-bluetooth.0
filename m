Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: List powered down AMP controllers correctly
Date: Mon,  7 Oct 2013 00:26:07 -0700
Message-Id: <1381130767-42488-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Within the AMP discover response, list powered down AMP controllers
as powered down. No point in trying to make them look any different.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/a2mp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 9410e27..b38d074 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -89,7 +89,10 @@ static void __a2mp_add_cl(struct amp_mgr *mgr, struct a2mp_cl *cl)
 		if (hdev->dev_type == HCI_AMP) {
 			cl[i].id = hdev->id;
 			cl[i].type = hdev->amp_type;
-			cl[i].status = hdev->amp_status;
+			if (test_bit(HCI_UP, &hdev->flags))
+				cl[i].status = hdev->amp_status;
+			else
+				cl[i].status = AMP_STATUS_POWERED_DOWN;
 			i++;
 		}
 	}
-- 
1.8.3.1

