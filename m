Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH 2/8] adapter: add API to find an existing device by D-Bus path
Date: Thu,  8 Mar 2012 15:57:06 +0200
Message-Id: <1331215032-27695-3-git-send-email-arik@wizery.com>
In-Reply-To: <1331215032-27695-1-git-send-email-arik@wizery.com>
References: <1331215032-27695-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows us to get a btd_device from information passed in D-Bus
method calls or signals.
---
 src/adapter.c |   15 +++++++++++++++
 src/adapter.h |    2 ++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index acb845e..f817975 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3531,3 +3531,18 @@ int btd_adapter_remove_remote_oob_data(struct btd_adapter *adapter,
 {
 	return adapter_ops->remove_remote_oob_data(adapter->dev_id, bdaddr);
 }
+
+struct btd_device *adapter_get_device_by_path(struct btd_adapter *adapter,
+					      const char *path)
+{
+	GSList *l;
+
+	for (l = adapter->devices; l != NULL; l = g_slist_next(l))
+		if (g_strcmp0(device_get_path(l->data), path) == 0)
+			break;
+
+	if (!l)
+		return NULL;
+
+	return l->data;
+}
diff --git a/src/adapter.h b/src/adapter.h
index ceebb97..4933baf 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -294,3 +294,5 @@ int btd_adapter_remove_remote_oob_data(struct btd_adapter *adapter,
 
 int btd_adapter_gatt_server_start(struct btd_adapter *adapter);
 void btd_adapter_gatt_server_stop(struct btd_adapter *adapter);
+struct btd_device *adapter_get_device_by_path(struct btd_adapter *adapter,
+					      const char *path);
-- 
1.7.5.4

