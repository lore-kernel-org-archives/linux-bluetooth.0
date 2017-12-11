Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH] Bluetooth: Remove redundant disable_advertising()
Date: Mon, 11 Dec 2017 20:26:47 +0530
Message-Id: <1513004207-2584-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is already __hci_req_disable_advertising() function for disabling,
so use it.

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 net/bluetooth/hci_request.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index abc0f32..da59f82 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1985,13 +1985,6 @@ static void le_scan_restart_work(struct work_struct *work)
 	hci_dev_unlock(hdev);
 }
 
-static void disable_advertising(struct hci_request *req)
-{
-	u8 enable = 0x00;
-
-	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
-}
-
 static int active_scan(struct hci_request *req, unsigned long opt)
 {
 	uint16_t interval = opt;
@@ -2017,7 +2010,7 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 		cancel_adv_timeout(hdev);
 		hci_dev_unlock(hdev);
 
-		disable_advertising(req);
+		__hci_req_disable_advertising(req);
 	}
 
 	/* If controller is scanning, it means the background scanning is
-- 
2.7.4

