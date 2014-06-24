Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/11] android/health: Refactor setting mcl callbacks to function
Date: Tue, 24 Jun 2014 15:11:59 +0300
Message-Id: <1403611922-26901-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403611922-26901-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403611922-26901-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Function will be used in other places as well.
---
 android/health.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/android/health.c b/android/health.c
index a9287f6..c4df17a 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1252,6 +1252,18 @@ static int get_mdep(struct health_channel *channel)
 						get_mdep_cb, channel, NULL, 0);
 }
 
+static bool set_mcl_cb(struct mcap_mcl *mcl, gpointer user_data, GError **err)
+{
+	return mcap_mcl_set_cb(mcl, user_data, err,
+			MCAP_MDL_CB_CONNECTED, mcap_mdl_connected_cb,
+			MCAP_MDL_CB_CLOSED, mcap_mdl_closed_cb,
+			MCAP_MDL_CB_DELETED, mcap_mdl_deleted_cb,
+			MCAP_MDL_CB_ABORTED, mcap_mdl_aborted_cb,
+			MCAP_MDL_CB_REMOTE_CONN_REQ, mcap_mdl_conn_req_cb,
+			MCAP_MDL_CB_REMOTE_RECONN_REQ, mcap_mdl_reconn_req_cb,
+			MCAP_MDL_CB_INVALID);
+}
+
 static void create_mcl_cb(struct mcap_mcl *mcl, GError *err, gpointer data)
 {
 	struct health_channel *channel = data;
@@ -1271,14 +1283,7 @@ static void create_mcl_cb(struct mcap_mcl *mcl, GError *err, gpointer data)
 	channel->dev->mcl_conn = true;
 	info("MCL connected");
 
-	ret = mcap_mcl_set_cb(channel->dev->mcl, channel, &gerr,
-			MCAP_MDL_CB_CONNECTED, mcap_mdl_connected_cb,
-			MCAP_MDL_CB_CLOSED, mcap_mdl_closed_cb,
-			MCAP_MDL_CB_DELETED, mcap_mdl_deleted_cb,
-			MCAP_MDL_CB_ABORTED, mcap_mdl_aborted_cb,
-			MCAP_MDL_CB_REMOTE_CONN_REQ, mcap_mdl_conn_req_cb,
-			MCAP_MDL_CB_REMOTE_RECONN_REQ, mcap_mdl_reconn_req_cb,
-			MCAP_MDL_CB_INVALID);
+	ret = set_mcl_cb(channel->dev->mcl, channel->dev, &gerr);
 	if (!ret) {
 		error("health: error setting mdl callbacks on mcl");
 		g_error_free(gerr);
-- 
1.8.3.2

