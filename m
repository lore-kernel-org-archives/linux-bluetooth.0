Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/14] adapter: Add btd_adapter_get_connectable function
Date: Thu, 7 Feb 2013 09:13:57 +0100
Message-ID: <1360224844-12280-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
References: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c | 8 ++++++++
 src/adapter.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index cd104a1..2338e60 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2772,6 +2772,14 @@ bool btd_adapter_get_powered(struct btd_adapter *adapter)
 	return false;
 }
 
+bool btd_adapter_get_connectable(struct btd_adapter *adapter)
+{
+	if (adapter->current_settings & MGMT_SETTING_CONNECTABLE)
+		return true;
+
+	return false;
+}
+
 uint32_t btd_adapter_get_class(struct btd_adapter *adapter)
 {
 	return adapter->dev_class;
diff --git a/src/adapter.h b/src/adapter.h
index 2610479..8d23a64 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -87,6 +87,7 @@ void adapter_foreach(adapter_cb func, gpointer user_data);
 
 bool btd_adapter_get_pairable(struct btd_adapter *adapter);
 bool btd_adapter_get_powered(struct btd_adapter *adapter);
+bool btd_adapter_get_connectable(struct btd_adapter *adapter);
 
 uint32_t btd_adapter_get_class(struct btd_adapter *adapter);
 const char *btd_adapter_get_name(struct btd_adapter *adapter);
-- 
1.8.1.1

