Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v16 13/14] adapter: Add API to get fast connectable mode
Date: Wed,  1 Aug 2012 11:08:49 +0200
Message-Id: <1343812131-19395-14-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1343812131-19395-1-git-send-email-frederic.danis@linux.intel.com>
References: <1343812131-19395-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   15 ++++++++++++++-
 src/adapter.h |    1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index b7691d0..24fa704 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -151,6 +151,8 @@ struct btd_adapter {
 	GSList *pin_callbacks;
 
 	GSList *loaded_drivers;
+
+	gboolean fast_connectable;
 };
 
 static void dev_info_free(void *data)
@@ -3391,10 +3393,21 @@ void btd_adapter_unregister_powered_callback(struct btd_adapter *adapter,
 int btd_adapter_set_fast_connectable(struct btd_adapter *adapter,
 							gboolean enable)
 {
+	int ret;
+
 	if (!adapter->up)
 		return -EINVAL;
 
-	return mgmt_set_fast_connectable(adapter->dev_id, enable);
+	ret = mgmt_set_fast_connectable(adapter->dev_id, enable);
+	if (ret == 0)
+		adapter->fast_connectable = enable;
+
+	return ret;
+}
+
+gboolean btd_adapter_get_fast_connectable(struct btd_adapter *adapter)
+{
+	return adapter->fast_connectable;
 }
 
 int btd_adapter_read_clock(struct btd_adapter *adapter, bdaddr_t *bdaddr,
diff --git a/src/adapter.h b/src/adapter.h
index d8a1bb1..6e22dbc 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -185,6 +185,7 @@ void btd_adapter_unregister_powered_callback(struct btd_adapter *adapter,
  * type to default values. Valid for both connectable and discoverable modes. */
 int btd_adapter_set_fast_connectable(struct btd_adapter *adapter,
 							gboolean enable);
+gboolean btd_adapter_get_fast_connectable(struct btd_adapter *adapter);
 
 int btd_adapter_read_clock(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				int which, int timeout, uint32_t *clock,
-- 
1.7.9.5

