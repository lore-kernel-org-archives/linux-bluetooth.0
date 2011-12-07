Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 7/8] Bluetooth: Disconnect the link if encryption fails
Date: Tue,  6 Dec 2011 21:48:11 -0300
Message-Id: <1323218892-15785-8-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1323218892-15785-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1323218892-15785-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The most common case of error is that the encryption keys don't agree, so
the best solution is to disconnect the link and inform the user that there
was a problem during encryption.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/l2cap_core.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9da7ebf..15d1a3b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4532,10 +4532,11 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 	BT_DBG("conn %p", conn);
 
-	if (hcon->type == LE_LINK) {
+	if (hcon->type == LE_LINK && !status) {
 		smp_distribute_keys(conn, 0);
 		del_timer(&conn->security_timer);
-	}
+	} else if (hcon->type == LE_LINK)
+		l2cap_conn_del(hcon, bt_to_errno(status));
 
 	read_lock(&conn->chan_lock);
 
-- 
1.7.8

