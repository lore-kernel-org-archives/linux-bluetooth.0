Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/8] Bluetooth: Set discon_timeout to 0 in l2cap_conn_del
Date: Mon, 18 Aug 2014 20:33:28 +0300
Message-Id: <1408383214-16366-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1408383214-16366-1-git-send-email-johan.hedberg@gmail.com>
References: <1408383214-16366-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When the l2cap_conn_del() function is used we do not want to wait around
"in case something happens" before disconnecting. This patch sets the
disconnection timeout to 0 so that the disconnection routines get
immediately scheduled.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cb36169ef300..2d550afe4322 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1640,6 +1640,9 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	l2cap_unregister_all_users(conn);
 
+	/* Force the connection to be immediately dropped */
+	hcon->disc_timeout = 0;
+
 	mutex_lock(&conn->chan_lock);
 
 	/* Kill channels */
-- 
1.9.3

