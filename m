Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 05/14] adapter: Add btd_adapter_get_powered function
Date: Thu, 7 Feb 2013 09:13:55 +0100
Message-ID: <1360224844-12280-6-git-send-email-szymon.janc@tieto.com>
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
index 9ddd2fc..cd104a1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2764,6 +2764,14 @@ bool btd_adapter_get_pairable(struct btd_adapter *adapter)
 	return false;
 }
 
+bool btd_adapter_get_powered(struct btd_adapter *adapter)
+{
+	if (adapter->current_settings & MGMT_SETTING_POWERED)
+		return true;
+
+	return false;
+}
+
 uint32_t btd_adapter_get_class(struct btd_adapter *adapter)
 {
 	return adapter->dev_class;
diff --git a/src/adapter.h b/src/adapter.h
index 2787631..2610479 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -86,6 +86,7 @@ struct btd_adapter *adapter_get_default(void);
 void adapter_foreach(adapter_cb func, gpointer user_data);
 
 bool btd_adapter_get_pairable(struct btd_adapter *adapter);
+bool btd_adapter_get_powered(struct btd_adapter *adapter);
 
 uint32_t btd_adapter_get_class(struct btd_adapter *adapter);
 const char *btd_adapter_get_name(struct btd_adapter *adapter);
-- 
1.8.1.1

