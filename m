Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 02/16] Replace inquiry/scanning calls by discovery calls
Date: Fri, 29 Apr 2011 21:27:18 -0300
Message-Id: <1304123252-14464-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
References: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces calls to btd_adapter_ops callbacks start_inquiry,
start_scanning, stop_inquiry and stop_scanning by start_discovery and
stop_discovery.
---
 src/adapter.c |   23 ++---------------------
 1 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8dbd62c..1dfa9a6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -726,10 +726,7 @@ static void stop_discovery(struct btd_adapter *adapter, gboolean suspend)
 		return;
 	}
 
-	if (adapter->state & STATE_LE_SCAN)
-		adapter_ops->stop_scanning(adapter->dev_id);
-	else
-		adapter_ops->stop_inquiry(adapter->dev_id);
+	adapter_ops->stop_discovery(adapter->dev_id);
 }
 
 static void session_remove(struct session_req *req)
@@ -1218,8 +1215,6 @@ static gboolean stop_scanning(gpointer user_data)
 
 static int start_discovery(struct btd_adapter *adapter)
 {
-	int type;
-
 	/* Do not start if suspended */
 	if (adapter->state & STATE_SUSPENDED)
 		return 0;
@@ -1230,21 +1225,7 @@ static int start_discovery(struct btd_adapter *adapter)
 
 	pending_remote_name_cancel(adapter);
 
-	type = adapter_get_discover_type(adapter) & ~DISC_RESOLVNAME;
-
-	switch (type) {
-	case DISC_STDINQ:
-	case DISC_INTERLEAVE:
-		return adapter_ops->start_inquiry(adapter->dev_id,
-							0x08, FALSE);
-	case DISC_PINQ:
-		return adapter_ops->start_inquiry(adapter->dev_id,
-							0x08, TRUE);
-	case DISC_LE:
-		return adapter_ops->start_scanning(adapter->dev_id);
-	default:
-		return -EINVAL;
-	}
+	return adapter_ops->start_discovery(adapter->dev_id);
 }
 
 static gboolean discovery_cb(gpointer user_data)
-- 
1.7.1

