Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH v1] Bluetooth: Don't distribute keys in case of Encryption Failure
Date: Wed, 18 Apr 2012 14:46:26 +0530
Message-ID: <1334740586-22347-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SMP Keys should only be distributeed when encryption is successful.

Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
---
 net/bluetooth/l2cap_core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 20dbebb..c33d714 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4813,7 +4813,8 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 	BT_DBG("conn %p", conn);
 
 	if (hcon->type == LE_LINK) {
-		smp_distribute_keys(conn, 0);
+		if (!status && encrypt)
+			smp_distribute_keys(conn, 0);
 		cancel_delayed_work(&conn->security_timer);
 	}
 
-- 
1.7.0.4

