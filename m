Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] adapter: Remove unused struct btd_adapter members
Date: Fri, 28 Sep 2012 11:35:29 +0200
Message-ID: <1348824929-9884-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

stop_discov_id and state are not used anymore.

---
 src/adapter.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b1ea3ea..48d6294 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -112,7 +112,6 @@ struct btd_adapter {
 	uint32_t dev_class;		/* Class of Device */
 	char *name;			/* adapter name */
 	gboolean allow_name_changes;	/* whether the adapter name can be changed */
-	guint stop_discov_id;		/* stop inquiry/scanning id */
 	uint32_t discov_timeout;	/* discoverable time(sec) */
 	guint pairable_timeout_id;	/* pairable timeout id */
 	uint32_t pairable_timeout;	/* pairable time(sec) */
@@ -122,8 +121,6 @@ struct btd_adapter {
 					 * limited */
 	uint8_t global_mode;		/* last valid global mode */
 	struct session_req *pending_mode;
-	int state;			/* standard inq, periodic inq, name
-					 * resolving, suspended discovery */
 	GSList *found_devices;
 	GSList *oor_devices;		/* out of range device list */
 	struct agent *agent;		/* For the new API */
-- 
1.7.9.5

