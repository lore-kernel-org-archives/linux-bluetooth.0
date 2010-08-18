Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 3/5] Add set fast connectable to adapter
Date: Wed, 18 Aug 2010 13:35:58 +0300
Message-Id: <1282127760-12655-4-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1282127760-12655-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1282127760-12655-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set fast connectable added to adapter interface. Enables or disables
faster page scanning. It does not interfere with any other adapter's
interfaces.
---
 src/adapter.c |   12 ++++++++++++
 src/adapter.h |    6 ++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 4ad4165..b023c01 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3454,3 +3454,15 @@ void btd_adapter_unregister_powered_callback(struct btd_adapter *adapter,
 	adapter->powered_callbacks =
 			g_slist_remove(adapter->powered_callbacks, cb);
 }
+
+int btd_adapter_set_fast_connectable(struct btd_adapter *adapter,
+							gboolean enable)
+{
+	if (!adapter_ops)
+		return -EINVAL;
+
+	if (!adapter->up)
+		return -EINVAL;
+
+	return adapter_ops->set_fast_connectable(adapter->dev_id, enable);
+}
diff --git a/src/adapter.h b/src/adapter.h
index 657e035..5352731 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -196,3 +196,9 @@ void btd_adapter_register_powered_callback(struct btd_adapter *adapter,
 						btd_adapter_powered_cb cb);
 void btd_adapter_unregister_powered_callback(struct btd_adapter *adapter,
 						btd_adapter_powered_cb cb);
+
+/* If TRUE, enables fast connectabe, i.e. reduces page scan interval and changes
+ * type. If FALSE, disables fast connectable, i.e. sets page scan interval and
+ * type to default values. Valid for both connectable and discoverable modes. */
+int btd_adapter_set_fast_connectable(struct btd_adapter *adapter,
+							gboolean enable);
-- 
1.7.0.4

