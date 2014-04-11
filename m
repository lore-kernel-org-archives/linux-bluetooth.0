Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix redundant encryption request for reauthentication
Date: Fri, 11 Apr 2014 12:02:32 -0700
Message-Id: <1397242952-3997-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1397242952-3997-1-git-send-email-johan.hedberg@gmail.com>
References: <1397242952-3997-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we're performing reauthentication (in order to elevate the
security level from an unauthenticated key to an authenticated one) we
do not need to issue any encryption command once authentication
completes. Since the trigger for the encryption HCI command is the
ENCRYPT_PEND flag this flag should not be set in this scenario.
Instead, the REAUTH_PEND flag takes care of all necessary steps for
reauthentication.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 55a174317925..095943c02d6e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -884,14 +884,17 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 	if (!test_and_set_bit(HCI_CONN_AUTH_PEND, &conn->flags)) {
 		struct hci_cp_auth_requested cp;
 
-		/* encrypt must be pending if auth is also pending */
-		set_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
-
 		cp.handle = cpu_to_le16(conn->handle);
 		hci_send_cmd(conn->hdev, HCI_OP_AUTH_REQUESTED,
 			     sizeof(cp), &cp);
+
+		/* If we're already encrypted set the REAUTH_PEND flag,
+		 * otherwise set the ENCRYPT_PEND.
+		 */
 		if (conn->key_type != 0xff)
 			set_bit(HCI_CONN_REAUTH_PEND, &conn->flags);
+		else
+			set_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 	}
 
 	return 0;
-- 
1.9.0

