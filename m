Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 04/32] Bluetooth: Allow l2cap_chan_check_security() to be used for LE links.
Date: Thu,  5 Dec 2013 15:11:02 +0200
Message-Id: <1386249090-10236-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
References: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

With connection oriented L2CAP channels some code paths will be shared
with BR/EDR links. It is therefore necessary to allow the
l2cap_chan_check_security function to be usable also for LE links in
addition to BR/EDR ones. This means that smp_conn_security() needs to be
called instead of hci_conn_security() in the case of an LE link.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 03b641c2f39d..510a17cefd26 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -726,6 +726,9 @@ int l2cap_chan_check_security(struct l2cap_chan *chan)
 	struct l2cap_conn *conn = chan->conn;
 	__u8 auth_type;
 
+	if (conn->hcon->type == LE_LINK)
+		return smp_conn_security(conn->hcon, chan->sec_level);
+
 	auth_type = l2cap_get_auth_type(chan);
 
 	return hci_conn_security(conn->hcon, chan->sec_level, auth_type);
-- 
1.8.4.2

