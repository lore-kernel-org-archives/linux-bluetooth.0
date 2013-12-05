Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 21/32] Bluetooth: Reject LE CoC commands when the feature is not enabled
Date: Thu,  5 Dec 2013 15:11:19 +0200
Message-Id: <1386249090-10236-22-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
References: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since LE CoC support needs to be enabled through a module option for now
we need to reject any related signaling PDUs in addition to rejecting
the creation of LE CoC sockets (which we already do).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7dd4aca46d44..ef9d22a3689a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5595,6 +5595,17 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 {
 	int err = 0;
 
+	if (!enable_lecoc) {
+		switch (cmd->code) {
+		case L2CAP_LE_CONN_REQ:
+		case L2CAP_LE_CONN_RSP:
+		case L2CAP_LE_CREDITS:
+		case L2CAP_DISCONN_REQ:
+		case L2CAP_DISCONN_RSP:
+			return -EINVAL;
+		}
+	}
+
 	switch (cmd->code) {
 	case L2CAP_COMMAND_REJ:
 		break;
-- 
1.8.4.2

