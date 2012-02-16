Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/4] Bluetooth: Prepare start_discovery
Date: Thu, 16 Feb 2012 18:50:38 -0300
Message-Id: <1329429041-30715-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1329429041-30715-1-git-send-email-andre.guedes@openbossa.org>
References: <1329429041-30715-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch does some code refactoring in start_discovery function
in order to prepare it for interleaved discovery support.

The discovery type macros were defined according to mgmt-api.txt
specification:

Possible values for the Type parameter are a bit-wise or of the
following bits:

	1	BR/EDR
	2	LE Public
	3	LE Random

By combining these e.g. the following values are possible:

	1	BR/EDR
	6	LE (public & random)
	7	BR/EDR/LE (interleaved discovery)

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    4 ++++
 net/bluetooth/mgmt.c             |   15 ++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b20d990..9982179 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -28,6 +28,10 @@
 #include <linux/interrupt.h>
 #include <net/bluetooth/hci.h>
 
+#define DISCOV_TYPE_BREDR		(BIT(0))
+#define DISCOV_TYPE_LE			(BIT(1) | BIT(2))
+#define DISCOV_TYPE_INTERLEAVED		(BIT(0) | BIT(1) | BIT(2))
+
 /* HCI priority */
 #define HCI_PRIO_MAX	7
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 066d338..410392e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2037,7 +2037,6 @@ static int start_discovery(struct sock *sk, u16 index,
 						void *data, u16 len)
 {
 	struct mgmt_cp_start_discovery *cp = data;
-	unsigned long discov_type = cp->type;
 	struct pending_cmd *cmd;
 	struct hci_dev *hdev;
 	int err;
@@ -2073,14 +2072,20 @@ static int start_discovery(struct sock *sk, u16 index,
 		goto failed;
 	}
 
-	if (test_bit(MGMT_ADDR_BREDR, &discov_type))
+	switch (cp->type) {
+	case DISCOV_TYPE_BREDR:
+	case DISCOV_TYPE_INTERLEAVED:
 		err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
-	else if (test_bit(MGMT_ADDR_LE_PUBLIC, &discov_type) &&
-				test_bit(MGMT_ADDR_LE_RANDOM, &discov_type))
+		break;
+
+	case DISCOV_TYPE_LE:
 		err = hci_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
 					LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY);
-	else
+		break;
+
+	default:
 		err = -EINVAL;
+	}
 
 	if (err < 0)
 		mgmt_pending_remove(cmd);
-- 
1.7.9.1

