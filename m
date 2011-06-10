Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix L2CAP security check
Date: Fri, 10 Jun 2011 15:50:24 +0900
Message-Id: <1307688624-5519-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With older userspace versions (using hciops) it might not have the
key type to check if the key has sufficient security for any security
level so it is necessary to check the return of hci_conn_auth to make
sure the connection is authenticated

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Acked-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3163330..efda44c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -611,8 +611,8 @@ auth:
 	if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend))
 		return 0;
 
-	hci_conn_auth(conn, sec_level, auth_type);
-	return 0;
+	if (!(hci_conn_auth(conn, sec_level, auth_type)))
+		return 0;
 
 encrypt:
 	if (conn->link_mode & HCI_LM_ENCRYPT)
-- 
1.7.5.2

