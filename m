Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 08/14] core: Replace interleaved by LE scanning
Date: Fri, 27 Jul 2012 19:29:52 -0300
Message-Id: <1343428198-23621-9-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1343428198-23621-1-git-send-email-jprvita@openbossa.org>
References: <1343428198-23621-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patches replaces the interleaved discovery by LE scanning when LE
re-connection is required.
---
 src/adapter.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 4c2505a..46b32d7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2224,7 +2224,7 @@ void btd_adapter_start(struct btd_adapter *adapter)
 	info("Adapter %s has been enabled", adapter->path);
 
 	if (g_slist_length(adapter->connect_list))
-		mgmt_start_discovery(adapter->dev_id);
+		mgmt_start_scanning(adapter->dev_id);
 }
 
 static void reply_pending_requests(struct btd_adapter *adapter)
@@ -2558,14 +2558,22 @@ void adapter_set_discovering(struct btd_adapter *adapter,
 
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
@@ -2872,7 +2880,7 @@ static gboolean clean_connecting_state(GIOChannel *io, GIOCondition cond, gpoint
 
 	if (!g_slist_length(adapter->connecting_list) &&
 					g_slist_length(adapter->connect_list))
-		mgmt_start_discovery(adapter->dev_id);
+		mgmt_start_scanning(adapter->dev_id);
 
 	btd_device_unref(device);
 
-- 
1.7.10.4

