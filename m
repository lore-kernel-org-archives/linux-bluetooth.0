Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 2/3] Remove unwanted GError* assignment to NULL
Date: Thu, 24 Nov 2011 19:44:35 +0530
Message-id: <1322144076-1913-2-git-send-email-s.syam@samsung.com>
In-reply-to: <1322144076-1913-1-git-send-email-s.syam@samsung.com>
References: <1322144076-1913-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index d167ab0..403d4c8 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -551,7 +551,6 @@ static void hdp_get_dcpsm_cb(uint16_t dcpsm, gpointer user_data, GError *err)
 	hdp_tmp_dc_data_unref(hdp_conn);
 	hdp_conn->cb(hdp_chann->mdl, err, hdp_conn);
 	g_error_free(gerr);
-	gerr = NULL;
 }
 
 static void device_reconnect_mdl_cb(struct mcap_mdl *mdl, GError *err,
-- 
1.7.4.1

