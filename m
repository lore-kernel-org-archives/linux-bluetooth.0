Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH] Cleanup: 'features' in btd_adapter is no longer used.
Date: Thu, 16 Jun 2011 19:13:46 -0300
Message-Id: <1308262426-27637-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b189841..2650b56 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -135,8 +135,6 @@ struct btd_adapter {
 	guint scheduler_id;		/* Scheduler handle */
 	sdp_list_t *services;		/* Services associated to adapter */
 
-	uint8_t  features[8];
-
 	gboolean pairable;		/* pairable state */
 	gboolean initialized;
 
@@ -2570,8 +2568,6 @@ void btd_adapter_unref(struct btd_adapter *adapter)
 
 gboolean adapter_init(struct btd_adapter *adapter)
 {
-	int err;
-
 	/* adapter_ops makes sure that newly registered adapters always
 	 * start off as powered */
 	adapter->up = TRUE;
@@ -2583,14 +2579,6 @@ gboolean adapter_init(struct btd_adapter *adapter)
 		return FALSE;
 	}
 
-	err = adapter_ops->read_local_features(adapter->dev_id,
-							adapter->features);
-	if (err < 0) {
-		error("Can't read features for hci%d: %s (%d)",
-					adapter->dev_id, strerror(-err), -err);
-		return FALSE;
-	}
-
 	if (read_local_name(&adapter->bdaddr, adapter->name) < 0)
 		expand_name(adapter->name, MAX_NAME_LENGTH, main_opts.name,
 							adapter->dev_id);
-- 
1.7.4.1

