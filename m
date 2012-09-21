Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 16/18] adapter: Rename btd_adapter_get_class to btd_adapter_read_class
Date: Fri, 21 Sep 2012 14:36:33 +0200
Message-ID: <1348230995-8967-17-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
References: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It better suits what this function really does.

---
 src/adapter.c |    2 +-
 src/adapter.h |    2 +-
 src/mgmt.c    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index a938c24..ae61f6d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2171,7 +2171,7 @@ void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
 		*pairable = adapter->pairable;
 }
 
-void btd_adapter_get_class(struct btd_adapter *adapter, uint8_t *major,
+void btd_adapter_read_class(struct btd_adapter *adapter, uint8_t *major,
 								uint8_t *minor)
 {
 	uint8_t cls[3];
diff --git a/src/adapter.h b/src/adapter.h
index 4afe40f..f7c4237 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -84,7 +84,7 @@ void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
 						uint16_t *discoverable_timeout,
 						gboolean *pairable);
 
-void btd_adapter_get_class(struct btd_adapter *adapter, uint8_t *major,
+void btd_adapter_read_class(struct btd_adapter *adapter, uint8_t *major,
 							uint8_t *minor);
 const char *btd_adapter_get_name(struct btd_adapter *adapter);
 struct btd_device *adapter_get_device(struct btd_adapter *adapter,
diff --git a/src/mgmt.c b/src/mgmt.c
index a3f31dd..8902836 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -1116,7 +1116,7 @@ static void read_info_complete(int sk, uint16_t index, void *buf, size_t len)
 	else
 		adapter_name_changed(adapter, (char *) rp->name);
 
-	btd_adapter_get_class(adapter, &major, &minor);
+	btd_adapter_read_class(adapter, &major, &minor);
 	mgmt_set_dev_class(index, major, minor);
 
 	btd_adapter_get_mode(adapter, &mode, NULL, NULL, NULL);
-- 
1.7.9.5

