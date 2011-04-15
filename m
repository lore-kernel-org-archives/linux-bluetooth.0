Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH 3/3] Bluetooth: Ignore key unauthenticated for high security
Date: Fri, 15 Apr 2011 13:06:57 +0200
Message-ID: <1302865617-32704-4-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1302865617-32704-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1302865617-32704-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
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
 net/bluetooth/hci_event.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5c5e614..337da2b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2044,11 +2044,24 @@ static inline void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff
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
+		if (key->type == HCI_LK_COMBINATION &&
+					conn->sec_level == BT_SECURITY_HIGH &&
+					conn->pin_length < 16) {
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

