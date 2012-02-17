Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 1/4] Bluetooth: Prepare start_discovery
Date: Fri, 17 Feb 2012 20:39:35 -0300
Message-Id: <1329521978-8537-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1329521978-8537-1-git-send-email-andre.guedes@openbossa.org>
References: <1329521978-8537-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch does some code refactoring in start_discovery function
in order to prepare it for interleaved discovery support.

MGMT_ADDR_* macros were moved to hci_core.h since they are now used
to define discovery type macros.

Discovery type macros were defined according to mgmt-api.txt
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
 include/net/bluetooth/hci_core.h |   12 ++++++++++++
 include/net/bluetooth/mgmt.h     |    5 -----
 net/bluetooth/mgmt.c             |   15 ++++++++++-----
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 43e0b1e..be8da5d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -956,6 +956,18 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb,
 							struct sock *skip_sk);
 
 /* Management interface */
+#define MGMT_ADDR_BREDR			0x00
+#define MGMT_ADDR_LE_PUBLIC		0x01
+#define MGMT_ADDR_LE_RANDOM		0x02
+#define MGMT_ADDR_INVALID		0xff
+
+#define DISCOV_TYPE_BREDR		(BIT(MGMT_ADDR_BREDR))
+#define DISCOV_TYPE_LE			(BIT(MGMT_ADDR_LE_PUBLIC) | \
+						BIT(MGMT_ADDR_LE_RANDOM))
+#define DISCOV_TYPE_INTERLEAVED		(BIT(MGMT_ADDR_BREDR) | \
+						BIT(MGMT_ADDR_LE_PUBLIC) | \
+						BIT(MGMT_ADDR_LE_RANDOM))
+
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
 int mgmt_index_added(struct hci_dev *hdev);
 int mgmt_index_removed(struct hci_dev *hdev);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index ee625a6..ad54b5f 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -48,11 +48,6 @@ struct mgmt_hdr {
 	__le16 len;
 } __packed;
 
-#define MGMT_ADDR_BREDR			0x00
-#define MGMT_ADDR_LE_PUBLIC		0x01
-#define MGMT_ADDR_LE_RANDOM		0x02
-#define MGMT_ADDR_INVALID		0xff
-
 struct mgmt_addr_info {
 	bdaddr_t bdaddr;
 	__u8 type;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f9f3e4c..196215c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2157,7 +2157,6 @@ static int start_discovery(struct sock *sk, u16 index,
 						void *data, u16 len)
 {
 	struct mgmt_cp_start_discovery *cp = data;
-	unsigned long discov_type = cp->type;
 	struct pending_cmd *cmd;
 	struct hci_dev *hdev;
 	int err;
@@ -2193,14 +2192,20 @@ static int start_discovery(struct sock *sk, u16 index,
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

