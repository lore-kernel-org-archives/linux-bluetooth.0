Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v8 3/8] core: Replace interleaved by LE scanning
Date: Mon,  1 Oct 2012 18:24:06 -0300
Message-Id: <1349126651-749-3-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1349126651-749-1-git-send-email-jprvita@openbossa.org>
References: <1349126651-749-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patches replaces the interleaved discovery by LE scanning when LE
re-connection is required.
---
 src/adapter.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 40d0b07..05bcb79 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2305,7 +2305,7 @@ void btd_adapter_start(struct btd_adapter *adapter)
 	info("Adapter %s has been enabled", adapter->path);
 
 	if (g_slist_length(adapter->connect_list) > 0)
-		mgmt_start_discovery(adapter->dev_id);
+		mgmt_start_le_scanning(adapter->dev_id);
 }
 
 static void reply_pending_requests(struct btd_adapter *adapter)
@@ -2652,14 +2652,22 @@ void adapter_set_discovering(struct btd_adapter *adapter,
 
 	connect_list_len = g_slist_length(adapter->connect_list);
 
-	if (!adapter_has_discov_sessions(adapter) && connect_list_len == 0)
+	if (adapter_has_discov_sessions(adapter)) {
+		adapter->discov_id = g_idle_add(discovery_cb, adapter);
+
+		DBG("hci%u restarting discovery: disc_sessions %u",
+				adapter->dev_id,
+				g_slist_length(adapter->disc_sessions));
 		return;
+	}
 
-	DBG("hci%u restarting discovery: disc_sessions %u connect_list_len %u",
-		adapter->dev_id, g_slist_length(adapter->disc_sessions),
-							connect_list_len);
+	if (connect_list_len > 0) {
+		mgmt_start_le_scanning(adapter->dev_id);
 
-	adapter->discov_id = g_idle_add(discovery_cb, adapter);
+		DBG("hci%u restarting scanning connect_list_len %u",
+				adapter->dev_id, connect_list_len);
+		return;
+	}
 }
 
 static void suspend_discovery(struct btd_adapter *adapter)
@@ -2974,7 +2982,7 @@ static gboolean clean_connecting_state(GIOChannel *io, GIOCondition cond,
 
 	if (adapter->waiting_to_connect == 0 &&
 				g_slist_length(adapter->connect_list) > 0)
-		mgmt_start_discovery(adapter->dev_id);
+		mgmt_start_le_scanning(adapter->dev_id);
 
 	btd_device_unref(device);
 
-- 
1.7.11.4

