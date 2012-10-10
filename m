Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/7] adapter: Read device class in storage at init
Date: Wed, 10 Oct 2012 10:58:35 +0200
Message-Id: <1349859520-8824-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1349859520-8824-1-git-send-email-frederic.danis@linux.intel.com>
References: <1349859520-8824-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8b9af28..93dc0fb 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -117,6 +117,7 @@ struct service_auth {
 
 struct btd_adapter_config {
 	char *name;
+	uint8_t class[3];
 };
 
 struct btd_adapter {
@@ -729,6 +730,10 @@ void btd_adapter_class_changed(struct btd_adapter *adapter, uint8_t *new_class)
 	if (class == adapter->dev_class)
 		return;
 
+	adapter->config.class[0] = new_class[0];
+	adapter->config.class[1] = new_class[1];
+	adapter->config.class[2] = new_class[2];
+
 	write_local_class(&adapter->bdaddr, new_class);
 
 	adapter->dev_class = class;
@@ -2353,15 +2358,8 @@ void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
 void btd_adapter_read_class(struct btd_adapter *adapter, uint8_t *major,
 								uint8_t *minor)
 {
-	uint8_t cls[3];
-
-	if (read_local_class(&adapter->bdaddr, cls) < 0) {
-		uint32_t class = htobl(main_opts.class);
-		memcpy(cls, &class, 3);
-	}
-
-	*major = cls[1];
-	*minor = cls[0];
+	*major = adapter->config.class[1];
+	*minor = adapter->config.class[0];
 }
 
 uint32_t btd_adapter_get_class(struct btd_adapter *adapter)
@@ -2694,6 +2692,11 @@ static void load_config(struct btd_adapter *adapter)
 	else
 		adapter->config.name = g_strdup(name);
 
+	/* Get class */
+	if (read_local_class(&adapter->bdaddr, adapter->config.class) < 0) {
+		uint32_t class = htobl(main_opts.class);
+		memcpy(adapter->config.class, &class, 3);
+	}
 }
 
 gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
-- 
1.7.9.5

