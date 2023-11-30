Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C182CF
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Nov 2023 05:58:11 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 64CE220003;
	Thu, 30 Nov 2023 13:58:09 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [RESEND PATCH v2] Bluetooth: Fix bogus check for re-auth no supported with non-ssp
Date: Thu, 30 Nov 2023 14:58:03 +0100
Message-ID: <20231130135808.286908-1-hadess@hadess.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reverts 19f8def031bfa50c579149b200bfeeb919727b27
"Bluetooth: Fix auth_complete_evt for legacy units" which seems to be
working around a bug on a broken controller rather then any limitation
imposed by the Bluetooth spec, in fact if there ws not possible to
re-auth the command shall fail not succeed.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_conn.c         |  8 +++-----
 net/bluetooth/hci_event.c        | 11 ++---------
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 20988623c5cc..878622a4dde8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -952,7 +952,6 @@ void hci_inquiry_cache_flush(struct hci_dev *hdev);
 /* ----- HCI Connections ----- */
 enum {
 	HCI_CONN_AUTH_PEND,
-	HCI_CONN_REAUTH_PEND,
 	HCI_CONN_ENCRYPT_PEND,
 	HCI_CONN_RSWITCH_PEND,
 	HCI_CONN_MODE_CHANGE_PEND,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2cee330188ce..d01db89fcb46 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2421,12 +2421,10 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 		hci_send_cmd(conn->hdev, HCI_OP_AUTH_REQUESTED,
 			     sizeof(cp), &cp);
 
-		/* If we're already encrypted set the REAUTH_PEND flag,
-		 * otherwise set the ENCRYPT_PEND.
+		/* Set the ENCRYPT_PEND to trigger encryption after
+		 * authentication.
 		 */
-		if (test_bit(HCI_CONN_ENCRYPT, &conn->flags))
-			set_bit(HCI_CONN_REAUTH_PEND, &conn->flags);
-		else
+		if (!test_bit(HCI_CONN_ENCRYPT, &conn->flags))
 			set_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 	}
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0849e0dafa95..da3e9226c037 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3484,14 +3484,8 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, void *data,
 
 	if (!ev->status) {
 		clear_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
-
-		if (!hci_conn_ssp_enabled(conn) &&
-		    test_bit(HCI_CONN_REAUTH_PEND, &conn->flags)) {
-			bt_dev_info(hdev, "re-auth of legacy device is not possible.");
-		} else {
-			set_bit(HCI_CONN_AUTH, &conn->flags);
-			conn->sec_level = conn->pending_sec_level;
-		}
+		set_bit(HCI_CONN_AUTH, &conn->flags);
+		conn->sec_level = conn->pending_sec_level;
 	} else {
 		if (ev->status == HCI_ERROR_PIN_OR_KEY_MISSING)
 			set_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
@@ -3500,7 +3494,6 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, void *data,
 	}
 
 	clear_bit(HCI_CONN_AUTH_PEND, &conn->flags);
-	clear_bit(HCI_CONN_REAUTH_PEND, &conn->flags);
 
 	if (conn->state == BT_CONFIG) {
 		if (!ev->status && hci_conn_ssp_enabled(conn)) {
-- 
2.43.0

