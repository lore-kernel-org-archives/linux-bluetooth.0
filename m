Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/2] Bluetooth: Fix sending a HCI Authorization Request over LE links
Date: Thu, 23 Aug 2012 21:32:44 -0300
Message-Id: <1345768364-9546-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1345768364-9546-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1345768364-9546-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In the case that the link is already in the connected state and a
Pairing request arrives from the mgmt interface, hci_conn_security()
would be called but it was not considering LE links.

Reported-by: João Paulo Rechi Vita <jprvita@openbossa.org>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_conn.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3e65c02..2f8013d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -29,6 +29,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/a2mp.h>
+#include <net/bluetooth/smp.h>
 
 static void hci_le_create_connection(struct hci_conn *conn)
 {
@@ -645,6 +646,9 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 {
 	BT_DBG("hcon %p", conn);
 
+	if (conn->type == LE_LINK)
+		return smp_conn_security(conn, sec_level);
+
 	/* For sdp we don't need the link key. */
 	if (sec_level == BT_SECURITY_SDP)
 		return 1;
-- 
1.7.12

