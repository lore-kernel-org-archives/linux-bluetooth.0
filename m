Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 55/60] Change the get_addres function to match with other bluez functions
Date: Thu, 22 Jul 2010 10:58:12 +0200
Message-Id: <1279789097-2420-7-git-send-email-sancane@gmail.com>
In-Reply-To: <1279789097-2420-6-git-send-email-sancane@gmail.com>
References: <1279789001-4587-30-git-send-email-santoscadenas@gmail.com>
 <1279789097-2420-1-git-send-email-sancane@gmail.com>
 <1279789097-2420-2-git-send-email-sancane@gmail.com>
 <1279789097-2420-3-git-send-email-sancane@gmail.com>
 <1279789097-2420-4-git-send-email-sancane@gmail.com>
 <1279789097-2420-5-git-send-email-sancane@gmail.com>
 <1279789097-2420-6-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c     |    4 ++--
 mcap/mcap_lib.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index e9d5d36..a91f4b1 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -929,9 +929,9 @@ void mcap_mcl_set_cb(struct mcap_mcl *mcl, GError **gerr,
 	return;
 }
 
-bdaddr_t mcap_mcl_get_addr(struct mcap_mcl *mcl)
+void mcap_mcl_get_addr(struct mcap_mcl *mcl, bdaddr_t *addr)
 {
-	return mcl->addr;
+	bacpy(addr, &mcl->addr);
 }
 
 static void mcap_delete_mdl(gpointer elem, gpointer user_data)
diff --git a/mcap/mcap_lib.h b/mcap/mcap_lib.h
index 3d6e0b6..54b40ad 100644
--- a/mcap/mcap_lib.h
+++ b/mcap/mcap_lib.h
@@ -134,7 +134,7 @@ void mcap_create_mcl(struct mcap_instance *ms,
 void mcap_close_mcl(struct mcap_mcl *mcl, gboolean cache);
 void mcap_mcl_set_cb(struct mcap_mcl *mcl, GError **gerr,
 					gpointer user_data, McapMclCb cb1, ...);
-bdaddr_t mcap_mcl_get_addr(struct mcap_mcl *mcl);
+void mcap_mcl_get_addr(struct mcap_mcl *mcl, bdaddr_t *addr);
 
 struct mcap_mcl *mcap_mcl_ref(struct mcap_mcl *mcl);
 void mcap_mcl_unref(struct mcap_mcl *mcl);
-- 
1.6.3.3

