Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 17/18] adapter: Add btd_adapter_get_class function
Date: Fri, 21 Sep 2012 14:36:34 +0200
Message-ID: <1348230995-8967-18-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
References: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a simple getter to get current Class Of Device of adapter.

---
 src/adapter.c |    5 +++++
 src/adapter.h |    2 ++
 2 files changed, 7 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index ae61f6d..43df465 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2185,6 +2185,11 @@ void btd_adapter_read_class(struct btd_adapter *adapter, uint8_t *major,
 	*minor = cls[0];
 }
 
+uint32_t btd_adapter_get_class(struct btd_adapter *adapter)
+{
+	return adapter->dev_class;
+}
+
 const char *btd_adapter_get_name(struct btd_adapter *adapter)
 {
 	return adapter->name;
diff --git a/src/adapter.h b/src/adapter.h
index f7c4237..4f2f39f 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -86,6 +86,8 @@ void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
 
 void btd_adapter_read_class(struct btd_adapter *adapter, uint8_t *major,
 							uint8_t *minor);
+
+uint32_t btd_adapter_get_class(struct btd_adapter *adapter);
 const char *btd_adapter_get_name(struct btd_adapter *adapter);
 struct btd_device *adapter_get_device(struct btd_adapter *adapter,
 							const char *address);
-- 
1.7.9.5

