Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 06/16] Bluetooth: Create do_inquiry()
Date: Mon, 11 Jul 2011 18:11:49 -0300
Message-Id: <1310418719-12296-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1310418719-12296-1-git-send-email-andre.guedes@openbossa.org>
References: <1310418719-12296-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves all inquiry code from start_discovery() to a new
function called do_inquiry().

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d673ea3..7ea8f95 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1616,10 +1616,20 @@ static int remove_remote_oob_data(struct sock *sk, u16 index,
 	return err;
 }
 
-static int start_discovery(struct sock *sk, u16 index)
+static int do_inquiry(struct hci_dev *hdev, __u8 inq_length)
 {
 	u8 lap[3] = { 0x33, 0x8b, 0x9e };
 	struct hci_cp_inquiry cp;
+
+	memset(&cp, 0, sizeof(cp));
+	memcpy(&cp.lap, lap, 3);
+	cp.length  = inq_length;
+
+	return hci_send_cmd(hdev, HCI_OP_INQUIRY, sizeof(cp), &cp);
+}
+
+static int start_discovery(struct sock *sk, u16 index)
+{
 	struct pending_cmd *cmd;
 	struct hci_dev *hdev;
 	int err;
@@ -1644,12 +1654,7 @@ static int start_discovery(struct sock *sk, u16 index)
 		goto failed;
 	}
 
-	memset(&cp, 0, sizeof(cp));
-	memcpy(&cp.lap, lap, 3);
-	cp.length  = 0x08;
-	cp.num_rsp = 0x00;
-
-	err = hci_send_cmd(hdev, HCI_OP_INQUIRY, sizeof(cp), &cp);
+	err = do_inquiry(hdev, 0x08);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
-- 
1.7.4.1

