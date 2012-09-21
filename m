Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 17/18] adapter: Add btd_adapter_get_class function
Date: Fri, 21 Sep 2012 12:02:29 +0200
Message-ID: <1348221750-15345-18-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1348221750-15345-1-git-send-email-szymon.janc@tieto.com>
References: <1348221750-15345-1-git-send-email-szymon.janc@tieto.com>
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
index 23ecca5..d0e9e53 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2200,6 +2200,11 @@ void btd_adapter_read_class(struct btd_adapter *adapter, uint8_t *major,
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
index b9142a0..2afdd31 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -86,6 +86,8 @@ void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
 
 void btd_adapter_read_class(struct btd_adapter *adapter, uint8_t *major,
 							uint8_t *minor);
+
+uint32_t btd_adapter_get_class(struct btd_adapter *adapter);
 const char *btd_adapter_get_name(struct btd_adapter *adapter);
 struct btd_device *adapter_get_device(DBusConnection *conn,
 				struct btd_adapter *adapter, const char *address);
-- 
1.7.9.5

