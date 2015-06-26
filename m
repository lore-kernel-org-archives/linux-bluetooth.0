Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Jun 2015 23:27:55 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>, "An, Tedd" <tedd.an@intel.com>
Subject: [PATCH] Bluetooth: hidp: Initialize list header of hidp sesson user
Message-ID: <20150625232756.76568c95@tedd-fedora-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

When new hidp session is created, list header in l2cap_user is
not initialized and this causes list_empty() to fail in
l2cap_register_user() even if l2cap_user list is empty.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 net/bluetooth/hidp/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 9070dfd..f1a117f 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -915,6 +915,7 @@ static int hidp_session_new(struct hidp_session **out, const bdaddr_t *bdaddr,
 	session->conn = l2cap_conn_get(conn);
 	session->user.probe = hidp_session_probe;
 	session->user.remove = hidp_session_remove;
+	INIT_LIST_HEAD(&session->user.list);
 	session->ctrl_sock = ctrl_sock;
 	session->intr_sock = intr_sock;
 	skb_queue_head_init(&session->ctrl_transmit);
-- 
2.1.0
