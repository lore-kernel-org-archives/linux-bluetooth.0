Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v4 09/15] core: Replace interleaved by LE scanning
Date: Thu, 30 Aug 2012 19:15:54 -0300
Message-Id: <1346364960-7699-10-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1346364960-7699-1-git-send-email-jprvita@openbossa.org>
References: <1346364960-7699-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patches replaces the interleaved discovery by LE scanning when LE
re-connection is required.
---
 src/adapter.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index fdd9cf9..c30dd83 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2243,7 +2243,7 @@ void btd_adapter_start(struct btd_adapter *adapter)
 	info("Adapter %s has been enabled", adapter->path);
 
 	if (g_slist_length(adapter->connect_list))
-		mgmt_start_discovery(adapter->dev_id);
+		mgmt_start_scanning(adapter->dev_id);
 }
 
 static void reply_pending_requests(struct btd_adapter *adapter)
@@ -2573,14 +2573,22 @@ void adapter_set_discovering(struct btd_adapter *adapter,
 
 	connect_list_size = g_slist_length(adapter->connect_list);
 
-	if (!adapter_has_discov_sessions(adapter) && !connect_list_size)
+	if (adapter_has_discov_sessions(adapter)) {
+		adapter->discov_id = g_idle_add(discovery_cb, adapter);
+
+		DBG("hci%u restarting discovery: disc_sessions %u",
+				adapter->dev_id,
+				g_slist_length(adapter->disc_sessions));
 		return;
+	}
 
-	DBG("hci%u restarting discovery: disc_sessions %u, connect_list size "
-		"%u", adapter->dev_id, g_slist_length(adapter->disc_sessions),
-							connect_list_size);
+	if (connect_list_size) {
+		mgmt_start_scanning(adapter->dev_id);
 
-	adapter->discov_id = g_idle_add(discovery_cb, adapter);
+		DBG("hci%u restarting scanning connect_list size %u",
+				adapter->dev_id, connect_list_size);
+		return;
+	}
 }
 
 static void suspend_discovery(struct btd_adapter *adapter)
@@ -2895,7 +2903,7 @@ static gboolean clean_connecting_state(GIOChannel *io, GIOCondition cond, gpoint
 
 	if (adapter->waiting_to_connect == 0 &&
 					g_slist_length(adapter->connect_list))
-		mgmt_start_discovery(adapter->dev_id);
+		mgmt_start_scanning(adapter->dev_id);
 
 	btd_device_unref(device);
 
-- 
1.7.11.4

