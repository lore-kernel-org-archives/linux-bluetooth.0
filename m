Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Pass all message parameters to mgmt_start_discovery
Date: Sat, 12 Nov 2011 11:58:22 +0200
Message-Id: <1321091902-6815-1-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1321091515-6543-1-git-send-email-johan.hedberg@gmail.com>
References: <1321091515-6543-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The mgmt_start_discovery command contains the type of discovery that
should be started so this should be passed to the start_discovery
function. This patch doesn't yet add any action depending on the type of
the requested discovery.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
v2: Fix stupid copy-paste error with the MGMT_OP in case of an invalid
message length.

 include/net/bluetooth/mgmt.h |    3 +++
 net/bluetooth/mgmt.c         |   10 ++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index bd6995d..2e50182 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -232,6 +232,9 @@ struct mgmt_cp_remove_remote_oob_data {
 } __packed;
 
 #define MGMT_OP_START_DISCOVERY		0x001B
+struct mgmt_cp_start_discovery {
+	__u8 type;
+} __packed;
 
 #define MGMT_OP_STOP_DISCOVERY		0x001C
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b761359..1482455 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1779,14 +1779,20 @@ static int remove_remote_oob_data(struct sock *sk, u16 index,
 	return err;
 }
 
-static int start_discovery(struct sock *sk, u16 index)
+static int start_discovery(struct sock *sk, u16 index,
+						unsigned char *data, u16 len)
 {
+	struct mgmt_cp_start_discovery *cp = (void *) data;
 	struct pending_cmd *cmd;
 	struct hci_dev *hdev;
 	int err;
 
 	BT_DBG("hci%u", index);
 
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_START_DISCOVERY,
+						MGMT_STATUS_INVALID_PARAMS);
+
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_START_DISCOVERY,
@@ -2083,7 +2089,7 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 									len);
 		break;
 	case MGMT_OP_START_DISCOVERY:
-		err = start_discovery(sk, index);
+		err = start_discovery(sk, index, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_STOP_DISCOVERY:
 		err = stop_discovery(sk, index);
-- 
1.7.7.2

