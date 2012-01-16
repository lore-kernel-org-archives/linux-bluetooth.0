Return-Path: <cyrus@holtmann.org>
From: Yu A Wang <arron.wang@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Yu A Wang <arron.wang@intel.com>
Subject: [PATCH 1/2] adapter: Export set powered operation
Date: Mon, 16 Jan 2012 04:02:42 -0500
Message-Id: <1326704562-22825-1-git-send-email-arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    5 +++++
 src/adapter.h |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 7e4bbb6..e124010 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3363,6 +3363,11 @@ int adapter_ops_setup(void)
 	return ret;
 }
 
+int adapter_ops_set_powered(int index, gboolean powered)
+{
+	return adapter_ops->set_powered(index, powered);
+}
+
 void btd_adapter_register_powered_callback(struct btd_adapter *adapter,
 						btd_adapter_powered_cb cb)
 {
diff --git a/src/adapter.h b/src/adapter.h
index fb1dcdf..9dfd927 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -214,6 +214,7 @@ struct btd_adapter_ops {
 int btd_register_adapter_ops(struct btd_adapter_ops *ops, gboolean priority);
 void btd_adapter_cleanup_ops(struct btd_adapter_ops *btd_adapter_ops);
 int adapter_ops_setup(void);
+int adapter_ops_set_powered(int index, gboolean powered);
 
 typedef void (*btd_adapter_powered_cb) (struct btd_adapter *adapter,
 						gboolean powered);
-- 
1.7.2.2

