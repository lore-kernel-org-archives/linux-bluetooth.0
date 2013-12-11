Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 04/10] profiles/network/server: Delete function which does nothing
Date: Wed, 11 Dec 2013 12:13:39 +0200
Message-Id: <1386756825-934-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/network/manager.c | 2 --
 profiles/network/server.c  | 4 ----
 profiles/network/server.h  | 1 -
 3 files changed, 7 deletions(-)

diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index 8ac2dec..47aebcb 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -200,8 +200,6 @@ static int network_init(void)
 
 static void network_exit(void)
 {
-	server_exit();
-
 	btd_profile_unregister(&panu_profile);
 	btd_profile_unregister(&gn_profile);
 	btd_profile_unregister(&nap_profile);
diff --git a/profiles/network/server.c b/profiles/network/server.c
index cf34932..73741ec 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -493,10 +493,6 @@ int server_init(gboolean secure)
 	return 0;
 }
 
-void server_exit(void)
-{
-}
-
 static uint32_t register_server_record(struct network_server *ns)
 {
 	sdp_record_t *record;
diff --git a/profiles/network/server.h b/profiles/network/server.h
index 2edd342..a76e6f7 100644
--- a/profiles/network/server.h
+++ b/profiles/network/server.h
@@ -22,6 +22,5 @@
  */
 
 int server_init(gboolean secure);
-void server_exit(void);
 int server_register(struct btd_adapter *adapter, uint16_t id);
 int server_unregister(struct btd_adapter *adapter, uint16_t id);
-- 
1.8.3.2

