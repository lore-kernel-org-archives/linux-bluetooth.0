Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 1/3] health: Fix possible use after free
Date: Mon, 21 Jan 2013 19:03:29 +0530
Message-id: <1358775211-31005-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A pointer to freed memory is dereferenced if we call function
hdp_get_dcpsm_cb() with out any earlier reference.
---
 profiles/health/hdp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index c15f06a..a42ca48 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -542,9 +542,9 @@ static void hdp_get_dcpsm_cb(uint16_t dcpsm, gpointer user_data, GError *err)
 					hdp_tmp_dc_data_destroy, &gerr))
 		return;
 
-	hdp_tmp_dc_data_unref(hdp_conn);
 	hdp_conn->cb(hdp_chann->mdl, err, hdp_conn);
 	g_error_free(gerr);
+	hdp_tmp_dc_data_unref(hdp_conn);
 }
 
 static void device_reconnect_mdl_cb(struct mcap_mdl *mdl, GError *err,
-- 
1.7.9.5

