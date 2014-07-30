Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Always use non-bonding requirement when not bondable
Date: Wed, 30 Jul 2014 09:22:24 +0300
Message-Id: <1406701344-23842-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1406701344-23842-1-git-send-email-johan.hedberg@gmail.com>
References: <1406701344-23842-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we're not bondable we should never send any other SSP
authentication requirement besides one of the non-bonding ones.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c43cee4fcffd..be35598984d9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3671,13 +3671,18 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			if (conn->io_capability != HCI_IO_NO_INPUT_OUTPUT &&
 			    conn->auth_type != HCI_AT_NO_BONDING)
 				conn->auth_type |= 0x01;
-
-			cp.authentication = conn->auth_type;
 		} else {
 			conn->auth_type = hci_get_auth_req(conn);
-			cp.authentication = conn->auth_type;
 		}
 
+		/* If we're not bondable, force one of the non-bondable
+		 * authentication requirement values.
+		 */
+		if (!test_bit(HCI_BONDABLE, &hdev->dev_flags))
+			conn->auth_type &= HCI_AT_NO_BONDING_MITM;
+
+		cp.authentication = conn->auth_type;
+
 		if (hci_find_remote_oob_data(hdev, &conn->dst) &&
 		    (conn->out || test_bit(HCI_CONN_REMOTE_OOB, &conn->flags)))
 			cp.oob_data = 0x01;
-- 
1.9.3

