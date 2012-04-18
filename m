Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH] Bluetooth: Don't distribute keys in case of Encryption Failure
Date: Wed, 18 Apr 2012 10:48:59 +0530
Message-ID: <1334726339-21809-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SMP Keys should only be distributeed when encryption is successful.

Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 20dbebb..42d3e97 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4812,7 +4812,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 	BT_DBG("conn %p", conn);
 
-	if (hcon->type == LE_LINK) {
+	if (hcon->type == LE_LINK && !status && encrypt) {
 		smp_distribute_keys(conn, 0);
 		cancel_delayed_work(&conn->security_timer);
 	}
-- 
1.7.0.4

