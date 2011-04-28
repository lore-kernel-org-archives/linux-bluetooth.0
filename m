Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>, <padovan@profusion.mobi>
CC: <linux-bluetooth@vger.kernel.org>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v3 4/7] Bluetooth: Ignore key unauthenticated for high security
Date: Thu, 28 Apr 2011 12:07:56 +0200
Message-ID: <1303985279-3944-5-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1303985279-3944-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1303985279-3944-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

High security level for pre v2.1 devices requires combination link key
authenticated by at least 16 digit PIN code.

It's also necessary to update key_type and pin_length when the key
exists and is sufficently secured for the connection as there will be
no link key notify event in that case.

Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
---
 net/bluetooth/hci_event.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 655af8b..40e96cd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2059,11 +2059,23 @@ static inline void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff
 	}
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
+	if (conn) {
+		if (key->type == HCI_LK_UNAUTH_COMBINATION &&
+				conn->auth_type != 0xff &&
+				(conn->auth_type & 0x01)) {
+			BT_DBG("%s ignoring unauthenticated key", hdev->name);
+			goto not_found;
+		}
 
-	if (key->type == HCI_LK_UNAUTH_COMBINATION && conn &&
-			conn->auth_type != 0xff && (conn->auth_type & 0x01)) {
-		BT_DBG("%s ignoring unauthenticated key", hdev->name);
-		goto not_found;
+		if (key->type == HCI_LK_COMBINATION && key->pin_len < 16 &&
+				conn->pending_sec_level == BT_SECURITY_HIGH) {
+			BT_DBG("%s ignoring key unauthenticated for high \
+							security", hdev->name);
+			goto not_found;
+		}
+
+		conn->key_type = key->type;
+		conn->pin_length = key->pin_len;
 	}
 
 	bacpy(&cp.bdaddr, &ev->bdaddr);
-- 
1.7.1

