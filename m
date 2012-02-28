Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/6] core: remove set_limited_discoverable from adapter_ops driver
Date: Tue, 28 Feb 2012 13:23:24 +0200
Message-Id: <1330428206-8185-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1330428206-8185-1-git-send-email-luiz.dentz@gmail.com>
References: <1330428206-8185-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Core should not longer need to take care of details of discoverable bits
---
 src/adapter.c |    8 --------
 src/adapter.h |    1 -
 2 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 208f4c8..c5f4d0d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -206,14 +206,6 @@ static uint8_t get_mode(const bdaddr_t *bdaddr, const char *mode)
 		return MODE_UNKNOWN;
 }
 
-static void adapter_set_limited_discoverable(struct btd_adapter *adapter,
-							gboolean limited)
-{
-	DBG("%s", limited ? "TRUE" : "FALSE");
-
-	adapter_ops->set_limited_discoverable(adapter->dev_id, limited);
-}
-
 static struct session_req *session_ref(struct session_req *req)
 {
 	req->refcount++;
diff --git a/src/adapter.h b/src/adapter.h
index 611e86f..345e308 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -186,7 +186,6 @@ struct btd_adapter_ops {
 	int (*set_discoverable) (int index, gboolean discoverable,
 							uint16_t timeout);
 	int (*set_pairable) (int index, gboolean pairable);
-	int (*set_limited_discoverable) (int index, gboolean limited);
 	int (*start_discovery) (int index);
 	int (*stop_discovery) (int index);
 
-- 
1.7.7.6

