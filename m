Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Naresh Gupta <naresh.gupta@stericsson.com>,
	Hemant Gupta <hemantgupta.ste@gmail.com>,
	Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH] Use correct flags for checking HCI_SSP_ENABLED bit
Date: Wed, 28 Mar 2012 17:09:09 +0530
Message-ID: <1332934749-12765-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch uses the correct flags for checking the HCI_SSP_ENABLED bit.
Without this authentication request was not being initiated.

Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
---
 include/net/bluetooth/hci_core.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fa2c778..c8d5beb 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -431,7 +431,7 @@ enum {
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
-	return (test_bit(HCI_SSP_ENABLED, &hdev->flags) &&
+	return (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) &&
 				test_bit(HCI_CONN_SSP_ENABLED, &conn->flags));
 }
 
-- 
1.7.0.4

