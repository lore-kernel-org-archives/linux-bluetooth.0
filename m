Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix check for connection encryption
Date: Tue, 10 Jun 2014 09:54:24 +0300
Message-Id: <1402383264-24508-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The conn->link_key variable tracks the type of link key in use. It is
set whenever we respond to a link key request as well as when we get a
link key notification event.

These two events do not however always guarantee that encryption is
enabled: getting a link key request and responding to it may only mean
that the remote side has requested authentication but not encryption. On
the other hand, the encrypt change event is a certain guarantee that
encryption is enabled. The real encryption state is already tracked in
the conn->link_mode variable through the HCI_LM_ENCRYPT bit.

This patch fixes a check for encryption in the hci_conn_auth function to
use the proper conn->link_mode value and thereby eliminates the chance
of a false positive result.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b9b2bd464bec..ca01d1861854 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -889,7 +889,7 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 		/* If we're already encrypted set the REAUTH_PEND flag,
 		 * otherwise set the ENCRYPT_PEND.
 		 */
-		if (conn->key_type != 0xff)
+		if (conn->link_mode & HCI_LM_ENCRYPT)
 			set_bit(HCI_CONN_REAUTH_PEND, &conn->flags);
 		else
 			set_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
-- 
1.9.3

