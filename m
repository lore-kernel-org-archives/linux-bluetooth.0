Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Don't send ERTM configuration option when disabled
Date: Wed,  9 Jul 2014 11:53:35 +0200
Message-Id: <1404899615-4918-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When ERTM support is disabled, then do not even send ERTM configuration
option even if the remote side supports it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bf379a379fa0..87eb4b37e243 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3233,6 +3233,9 @@ done:
 
 	switch (chan->mode) {
 	case L2CAP_MODE_BASIC:
+		if (disable_ertm)
+			break;
+
 		if (!(chan->conn->feat_mask & L2CAP_FEAT_ERTM) &&
 		    !(chan->conn->feat_mask & L2CAP_FEAT_STREAMING))
 			break;
-- 
1.9.3

