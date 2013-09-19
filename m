Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 4/8] Remove not needed sdp_init_services_list function
Date: Thu, 19 Sep 2013 16:00:44 +0200
Message-ID: <1379599248-7923-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1379599248-7923-1-git-send-email-szymon.janc@tieto.com>
References: <1379599248-7923-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is doing nothing now and can be removed.
---
 src/adapter.c       |  2 --
 src/sdpd-database.c | 21 ---------------------
 src/sdpd.h          |  2 --
 3 files changed, 25 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index fb005a6..b99bff9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5622,8 +5622,6 @@ static int adapter_register(struct btd_adapter *adapter)
 		agent_unref(agent);
 	}
 
-	sdp_init_services_list(&adapter->bdaddr);
-
 	btd_adapter_gatt_server_start(adapter);
 
 	load_config(adapter);
diff --git a/src/sdpd-database.c b/src/sdpd-database.c
index e4d4f98..f65a526 100644
--- a/src/sdpd-database.c
+++ b/src/sdpd-database.c
@@ -296,24 +296,3 @@ uint32_t sdp_next_handle(void)
 
 	return handle;
 }
-
-void sdp_init_services_list(bdaddr_t *device)
-{
-	sdp_list_t *p;
-
-	DBG("");
-
-	for (p = access_db; p != NULL; p = p->next) {
-		sdp_access_t *access = p->data;
-		sdp_record_t *rec;
-
-		if (bacmp(BDADDR_ANY, &access->device))
-			continue;
-
-		rec = sdp_record_find(access->handle);
-		if (rec == NULL)
-			continue;
-
-		SDPDBG("adding record with handle %x", access->handle);
-	}
-}
diff --git a/src/sdpd.h b/src/sdpd.h
index 9a0e1e9..6de0af7 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -81,5 +81,3 @@ void stop_sdp_server(void);
 
 int add_record_to_server(const bdaddr_t *src, sdp_record_t *rec);
 int remove_record_from_server(uint32_t handle);
-
-void sdp_init_services_list(bdaddr_t *device);
-- 
1.8.4

