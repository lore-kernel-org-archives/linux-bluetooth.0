Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Consider the type param in start_discovery
Date: Tue, 22 Nov 2011 16:50:25 -0300
Message-Id: <1321991425-1783-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Management Interface API has been changed and now the Start
Discovery Command has the 'type' parameter. This parameters has
been define as follows:

Possible values for the Type parameter are a bit-wise or of the
following bits:

	1       BR/EDR
	2       LE Public
	3       LE Random

By combining these e.g. the following values are possible:

	1       BR/EDR
	6       LE (public & random)
	7       BR/EDR/LE (interleaved discovery)

Further information about Start Discovery Command see mgmt-api.txt
in BlueZ source.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/mgmt.c             |   27 ++++++++++++++++++++++++++-
 3 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 376c574..81943f7 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -202,6 +202,7 @@ enum {
 
 #define LMP_EV4		0x01
 #define LMP_EV5		0x02
+#define LMP_NO_BREDR	0x20
 #define LMP_LE		0x40
 
 #define LMP_SNIFF_SUBR	0x02
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1795257..62c5445 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -674,6 +674,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_ssp_capable(dev)       ((dev)->features[6] & LMP_SIMPLE_PAIR)
 #define lmp_no_flush_capable(dev)  ((dev)->features[6] & LMP_NO_FLUSH)
 #define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
+#define lmp_bredr_capable(dev)     (!((dev)->features[4] & LMP_NO_BREDR))
 
 /* ----- Extended LMP capabilities ----- */
 #define lmp_host_le_capable(dev)   ((dev)->extfeatures[0] & LMP_HOST_LE)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c06a05c..f615a5a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -33,6 +33,10 @@
 #define MGMT_VERSION	0
 #define MGMT_REVISION	1
 
+#define DISCOV_BREDR		(1 << 0)
+#define DISCOV_LE_PUBLIC	(1 << 1)
+#define DISCOV_LE_RANDOM	(1 << 2)
+
 #define INQUIRY_LEN_BREDR 0x08 /* TGAP(100) */
 
 struct pending_cmd {
@@ -1853,7 +1857,28 @@ static int start_discovery(struct sock *sk, u16 index,
 		goto failed;
 	}
 
-	err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
+	switch (cp->type) {
+	case DISCOV_BREDR:
+		if (!lmp_bredr_capable(hdev)) {
+			err = cmd_status(sk, index, MGMT_OP_START_DISCOVERY,
+						MGMT_STATUS_NOT_SUPPORTED);
+			break;
+		}
+
+		err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
+		break;
+
+	case (DISCOV_LE_PUBLIC | DISCOV_LE_RANDOM):
+	case (DISCOV_BREDR | DISCOV_LE_PUBLIC | DISCOV_LE_RANDOM):
+		err = cmd_status(sk, index, MGMT_OP_START_DISCOVERY,
+						MGMT_STATUS_NOT_SUPPORTED);
+		break;
+
+	default:
+		err = cmd_status(sk, index, MGMT_OP_START_DISCOVERY,
+						MGMT_STATUS_INVALID_PARAMS);
+	}
+
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
-- 
1.7.7.1

