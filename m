Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 04/16] adapter: Read device class in storage at init
Date: Thu, 18 Oct 2012 15:01:39 +0200
Message-Id: <1350565311-18330-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1350565311-18330-1-git-send-email-frederic.danis@linux.intel.com>
References: <1350565311-18330-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   21 ++++++++++-----------
 src/adapter.h |    2 +-
 src/mgmt.c    |    2 +-
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 233527a..dd06d46 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2177,18 +2177,11 @@ void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
 		*pairable = adapter->pairable;
 }
 
-void btd_adapter_read_class(struct btd_adapter *adapter, uint8_t *major,
+void btd_adapter_get_major_minor(struct btd_adapter *adapter, uint8_t *major,
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
+	*major = (adapter->dev_class >> 8) & 0xFF;
+	*minor = adapter->dev_class & 0xFF;
 }
 
 uint32_t btd_adapter_get_class(struct btd_adapter *adapter)
@@ -2257,7 +2250,6 @@ void btd_adapter_start(struct btd_adapter *adapter)
 
 	ba2str(&adapter->bdaddr, address);
 
-	adapter->dev_class = 0;
 	adapter->off_requested = FALSE;
 	adapter->up = TRUE;
 	adapter->discov_timeout = get_discoverable_timeout(address);
@@ -2509,6 +2501,7 @@ void btd_adapter_unref(struct btd_adapter *adapter)
 static void load_config(struct btd_adapter *adapter)
 {
 	char name[MAX_NAME_LENGTH + 1];
+	uint8_t class[3];
 
 	/* Get name */
 	if (read_local_name(&adapter->bdaddr, name) < 0)
@@ -2516,6 +2509,12 @@ static void load_config(struct btd_adapter *adapter)
 	else
 		adapter->name = g_strdup(name);
 
+	/* Get class */
+	if (read_local_class(&adapter->bdaddr, class) == 0)
+		adapter->dev_class = class[0] | (class[1] << 8) |
+					(class[2] << 16);
+	else
+		adapter->dev_class = main_opts.class;
 }
 
 gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
diff --git a/src/adapter.h b/src/adapter.h
index d53c658..be69781 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -85,7 +85,7 @@ void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
 						uint16_t *discoverable_timeout,
 						gboolean *pairable);
 
-void btd_adapter_read_class(struct btd_adapter *adapter, uint8_t *major,
+void btd_adapter_get_major_minor(struct btd_adapter *adapter, uint8_t *major,
 							uint8_t *minor);
 
 uint32_t btd_adapter_get_class(struct btd_adapter *adapter);
diff --git a/src/mgmt.c b/src/mgmt.c
index 627fb4b..ad180c3 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -1105,7 +1105,7 @@ static void read_info_complete(int sk, uint16_t index, void *buf, size_t len)
 	else
 		adapter_name_changed(adapter, (char *) rp->name);
 
-	btd_adapter_read_class(adapter, &major, &minor);
+	btd_adapter_get_major_minor(adapter, &major, &minor);
 	mgmt_set_dev_class(index, major, minor);
 
 	btd_adapter_get_mode(adapter, &mode, NULL, NULL, NULL);
-- 
1.7.9.5

