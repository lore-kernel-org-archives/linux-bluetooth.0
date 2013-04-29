Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/13] Bluetooth: Add clarifying comment to l2cap_conn_ready()
Date: Mon, 29 Apr 2013 19:35:39 +0300
Message-Id: <1367253345-12482-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
References: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There is an extra call to smp_conn_security() for outgoing LE
connections from l2cap_conn_ready() but the reason for this call is far
from clear. After a bit of commit history research and using git blame I
found out that this extra call is for socket-less pairing processes
added by commit 160dc6ac1. This patch adds a clarifying comment to the
code for this.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index dd7f9b3..60d13bc 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1387,6 +1387,9 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 	if (!hcon->out && hcon->type == LE_LINK)
 		l2cap_le_conn_ready(conn);
 
+	/* For outgoing pairing which doesn't necessarily have an
+	 * associated socket (e.g. mgmt_pair_device).
+	 */
 	if (hcon->out && hcon->type == LE_LINK)
 		smp_conn_security(hcon, hcon->pending_sec_level);
 
-- 
1.7.10.4

