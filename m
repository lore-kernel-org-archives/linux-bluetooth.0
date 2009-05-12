Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 1/7] Using hci_send_cmd instead of hci_send_req to set scan mode.
Date: Tue, 12 May 2009 17:56:50 +0530
Message-Id: <1242131216-4081-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 src/adapter.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index a54078c..2efdbc8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -416,14 +416,8 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode)
 		return -EIO;
 
 	if (adapter->up && scan_enable == SCAN_DISABLED) {
-		struct hci_request rq = {
-			.ogf = OGF_HOST_CTL,
-			.ocf = OCF_WRITE_SCAN_ENABLE,
-			.cparam = &scan_enable,
-			.clen = sizeof(scan_enable),
-		};
-
-		hci_send_req(dd, &rq, HCI_REQ_TIMEOUT);
+		hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_SCAN_ENABLE,
+					1, &scan_enable);
 		hci_close_dev(dd);
 
 		err = adapter_ops->stop(adapter->dev_id);
-- 
1.5.6.3

