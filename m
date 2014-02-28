Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/4] Bluetooth: Fix updating connection state to BT_CONNECT too early
Date: Fri, 28 Feb 2014 12:54:15 +0200
Message-Id: <1393584857-30375-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393584857-30375-1-git-send-email-johan.hedberg@gmail.com>
References: <1393584857-30375-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We shouldn't update the hci_conn state to BT_CONNECT until the moment
that we're ready to send the initiating HCI command for it. If the
connection has the BT_CONNECT state too early the code responsible for
updating the local random address may incorrectly think there's a
pending connection in progress and refuse to update the address.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 5b0802994cbb..818330c1b2a2 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -588,6 +588,8 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
 	cp.max_ce_len = __constant_cpu_to_le16(0x0000);
 
 	hci_req_add(req, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
+
+	conn->state = BT_CONNECT;
 }
 
 static void stop_scan_complete(struct hci_dev *hdev, u8 status)
@@ -689,7 +691,6 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 
 	conn->dst_type = dst_type;
 
-	conn->state = BT_CONNECT;
 	conn->out = true;
 	conn->link_mode |= HCI_LM_MASTER;
 	conn->sec_level = BT_SECURITY_LOW;
-- 
1.8.5.3

