Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 7/7] Bluetooth: MGMT start discovery LE-Only support
Date: Tue, 10 Jan 2012 18:20:55 -0300
Message-Id: <1326230455-9117-8-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1326230455-9117-1-git-send-email-andre.guedes@openbossa.org>
References: <1326230455-9117-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds LE-Only discovery procedure support to MGMT Start
Discovery command.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e7bbad8..05e6c1f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -35,7 +35,16 @@
 #define MGMT_VERSION	0
 #define MGMT_REVISION	1
 
-#define INQUIRY_LEN_BREDR 0x08 /* TGAP(100) */
+/*
+ * These LE scan and inquiry parameters were chosen according to LE General
+ * Discovery Procedure specification.
+ */
+#define LE_SCAN_TYPE			0x01
+#define LE_SCAN_WIN			0x12
+#define LE_SCAN_INT			0x12
+#define LE_SCAN_TIMEOUT_LE_ONLY		10240	/* TGAP(gen_disc_scan_min) */
+
+#define INQUIRY_LEN_BREDR		0x08	/* TGAP(100) */
 
 #define SERVICE_CACHE_TIMEOUT (5 * 1000)
 
@@ -1895,6 +1904,7 @@ static int start_discovery(struct sock *sk, u16 index,
 						unsigned char *data, u16 len)
 {
 	struct mgmt_cp_start_discovery *cp = (void *) data;
+	unsigned long discov_type = cp->type;
 	struct pending_cmd *cmd;
 	struct hci_dev *hdev;
 	int err;
@@ -1930,7 +1940,16 @@ static int start_discovery(struct sock *sk, u16 index,
 		goto failed;
 	}
 
-	err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
+	if (test_bit(MGMT_ADDR_BREDR, &discov_type))
+		err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
+	else if (test_bit(MGMT_ADDR_LE_PUBLIC, &discov_type) &&
+				test_bit(MGMT_ADDR_LE_RANDOM, &discov_type))
+		err =  hci_do_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
+					LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY);
+	else
+		err = cmd_status(sk, index, MGMT_OP_START_DISCOVERY,
+						MGMT_STATUS_NOT_SUPPORTED);
+
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 	else
-- 
1.7.8.1

