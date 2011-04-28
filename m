Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>, <padovan@profusion.mobi>
CC: <linux-bluetooth@vger.kernel.org>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v3 5/7] Bluetooth: Double check sec req for pre 2.1 device
Date: Thu, 28 Apr 2011 12:07:57 +0200
Message-ID: <1303985279-3944-6-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1303985279-3944-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1303985279-3944-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case of pre v2.1 devices authentication request will return
success immediately if the link key already exists without any
authentication process.

That means, it's not possible to re-authenticate the link if you
already have combination key and for instance want to re-authenticate
to get the high security (use 16 digit pin).

Therefore, it's necessary to check security requirements on auth
complete event to prevent not enough secure connection.

Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
---
 net/bluetooth/rfcomm/core.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 121a5c1..676fdec 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -2057,6 +2057,21 @@ static int rfcomm_run(void *unused)
 	return 0;
 }
 
+static int rfcomm_accept_secure(struct hci_conn *conn, struct rfcomm_dlc *d)
+{
+	BT_DBG("");
+
+	if (d->sec_level != BT_SECURITY_HIGH)
+		return 1; /* Accept */
+
+	if (conn->key_type == HCI_LK_AUTH_COMBINATION ||
+			(conn->key_type == HCI_LK_COMBINATION &&
+			conn->pin_length == 16))
+		return 1;
+
+	return 0; /* Reject */
+}
+
 static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 {
 	struct rfcomm_session *s;
@@ -2096,7 +2111,7 @@ static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 		if (!test_and_clear_bit(RFCOMM_AUTH_PENDING, &d->flags))
 			continue;
 
-		if (!status)
+		if (!status && rfcomm_accept_secure(conn, d))
 			set_bit(RFCOMM_AUTH_ACCEPT, &d->flags);
 		else
 			set_bit(RFCOMM_AUTH_REJECT, &d->flags);
-- 
1.7.1

