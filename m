Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] HDP: trivial: Remove empty lines
Date: Tue, 24 Jun 2014 15:07:45 +0300
Message-Id: <1403611666-26060-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403611666-26060-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403611666-26060-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/health/hdp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 65800fa..eaf3e46 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -1193,7 +1193,6 @@ gboolean hdp_set_mcl_cb(struct hdp_device *device, GError **err)
 		MCAP_MDL_CB_REMOTE_CONN_REQ, hdp_mcap_mdl_conn_req_cb,
 		MCAP_MDL_CB_REMOTE_RECONN_REQ, hdp_mcap_mdl_reconn_req_cb,
 		MCAP_MDL_CB_INVALID);
-
 	if (ret)
 		return TRUE;
 
@@ -1350,7 +1349,6 @@ static gboolean update_adapter(struct hdp_adapter *hdp_adapter)
 				mcl_disconnected, mcl_uncached,
 				NULL, /* CSP is not used by now */
 				hdp_adapter, &err);
-
 	if (hdp_adapter->mi == NULL) {
 		error("Error creating the MCAP instance: %s", err->message);
 		g_error_free(err);
-- 
1.8.3.2

