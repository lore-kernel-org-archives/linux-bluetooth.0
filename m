Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 2/2] Fix potential NULL pointer access in MCAP CSP code
Date: Mon, 20 Sep 2010 10:35:29 +0200
Message-Id: <1284971729-20509-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1284971729-20509-1-git-send-email-sancane@gmail.com>
References: <1284971729-20509-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

NULL pointer acces may hapen when an attemp to send a
synchronization command happens over a closed MCL.
---
 health/mcap_sync.c |   43 ++++++++++++++++++++++---------------------
 1 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/health/mcap_sync.c b/health/mcap_sync.c
index ae7ab5b..260cd71 100644
--- a/health/mcap_sync.c
+++ b/health/mcap_sync.c
@@ -80,17 +80,27 @@ static inline uint64_t ntoh64(uint64_t n)
 
 #define hton64(x)     ntoh64(x)
 
+static int send_sync_cmd(struct mcap_mcl *mcl, const void *buf, uint32_t size)
+{
+	int sock;
+
+	if (mcl->cc == NULL)
+		return -1;
+
+	sock = g_io_channel_unix_get_fd(mcl->cc);
+	return mcap_send_data(sock, buf, size);
+}
+
 static int send_unsupported_cap_req(struct mcap_mcl *mcl)
 {
 	mcap_md_sync_cap_rsp *cmd;
-	int sock, sent;
+	int sent;
 
 	cmd = g_new0(mcap_md_sync_cap_rsp, 1);
 	cmd->op = MCAP_MD_SYNC_CAP_RSP;
 	cmd->rc = MCAP_REQUEST_NOT_SUPPORTED;
 
-	sock = g_io_channel_unix_get_fd(mcl->cc);
-	sent = mcap_send_data(sock, cmd, sizeof(*cmd));
+	sent = send_sync_cmd(mcl, cmd, sizeof(*cmd));
 	g_free(cmd);
 
 	return sent;
@@ -99,14 +109,13 @@ static int send_unsupported_cap_req(struct mcap_mcl *mcl)
 static int send_unsupported_set_req(struct mcap_mcl *mcl)
 {
 	mcap_md_sync_set_rsp *cmd;
-	int sock, sent;
+	int sent;
 
 	cmd = g_new0(mcap_md_sync_set_rsp, 1);
 	cmd->op = MCAP_MD_SYNC_SET_RSP;
 	cmd->rc = MCAP_REQUEST_NOT_SUPPORTED;
 
-	sock = g_io_channel_unix_get_fd(mcl->cc);
-	sent = mcap_send_data(sock, cmd, sizeof(*cmd));
+	sent = send_sync_cmd(mcl, cmd, sizeof(*cmd));
 	g_free(cmd);
 
 	return sent;
@@ -457,7 +466,6 @@ static int send_sync_cap_rsp(struct mcap_mcl *mcl, uint8_t rspcode,
 {
 	mcap_md_sync_cap_rsp *rsp;
 	int sent;
-	int sock;
 
 	rsp = g_new0(mcap_md_sync_cap_rsp, 1);
 
@@ -469,8 +477,7 @@ static int send_sync_cap_rsp(struct mcap_mcl *mcl, uint8_t rspcode,
 	rsp->timestnr = htons(tmstampres);
 	rsp->timestna = htons(tmstampacc);
 
-	sock = g_io_channel_unix_get_fd(mcl->cc);
-	sent = mcap_send_data(sock, rsp, sizeof(*rsp));
+	sent = send_sync_cmd(mcl, rsp, sizeof(*rsp));
 	g_free(rsp);
 
 	return sent;
@@ -519,7 +526,7 @@ static int send_sync_set_rsp(struct mcap_mcl *mcl, uint8_t rspcode,
 			uint16_t tmstampres)
 {
 	mcap_md_sync_set_rsp *rsp;
-	int sock, sent;
+	int sent;
 
 	rsp = g_new0(mcap_md_sync_set_rsp, 1);
 
@@ -529,8 +536,7 @@ static int send_sync_set_rsp(struct mcap_mcl *mcl, uint8_t rspcode,
 	rsp->timestst = hton64(timestamp);
 	rsp->timestsa = htons(tmstampres);
 
-	sock = g_io_channel_unix_get_fd(mcl->cc);
-	sent = mcap_send_data(sock, rsp, sizeof(*rsp));
+	sent = send_sync_cmd(mcl, rsp, sizeof(*rsp));
 	g_free(rsp);
 
 	return sent;
@@ -786,7 +792,7 @@ static gboolean sync_send_indication(gpointer user_data)
 	uint32_t btclock;
 	uint64_t tmstamp;
 	struct timespec base_time;
-	int sock, sent;
+	int sent;
 
 	if (!user_data)
 		return FALSE;
@@ -803,8 +809,7 @@ static gboolean sync_send_indication(gpointer user_data)
 	cmd->timestst = hton64(tmstamp);
 	cmd->timestsa = htons(caps(mcl)->latency);
 
-	sock = g_io_channel_unix_get_fd(mcl->cc);
-	sent = mcap_send_data(sock, cmd, sizeof(*cmd));
+	sent = send_sync_cmd(mcl, cmd, sizeof(*cmd));
 	g_free(cmd);
 
 	return !sent;
@@ -940,7 +945,6 @@ void mcap_sync_cap_req(struct mcap_mcl *mcl, uint16_t reqacc,
 {
 	struct mcap_sync_cap_cbdata *cbdata;
 	mcap_md_sync_cap_req *cmd;
-	int sock;
 
 	if (!mcl->ms->csp_enabled || !mcl->csp) {
 		g_set_error(err,
@@ -969,8 +973,7 @@ void mcap_sync_cap_req(struct mcap_mcl *mcl, uint16_t reqacc,
 	cbdata->user_data = user_data;
 	mcl->csp->csp_priv_data = cbdata;
 
-	sock = g_io_channel_unix_get_fd(mcl->cc);
-	mcap_send_data(sock, cmd, sizeof(*cmd));
+	send_sync_cmd(mcl, cmd, sizeof(*cmd));
 
 	g_free(cmd);
 }
@@ -981,7 +984,6 @@ void mcap_sync_set_req(struct mcap_mcl *mcl, uint8_t update, uint32_t btclock,
 {
 	mcap_md_sync_set_req *cmd;
 	struct mcap_sync_set_cbdata *cbdata;
-	int sock;
 
 	if (!mcl->ms->csp_enabled || !mcl->csp) {
 		g_set_error(err,
@@ -1022,8 +1024,7 @@ void mcap_sync_set_req(struct mcap_mcl *mcl, uint8_t update, uint32_t btclock,
 	cbdata->user_data = user_data;
 	mcl->csp->csp_priv_data = cbdata;
 
-	sock = g_io_channel_unix_get_fd(mcl->cc);
-	mcap_send_data(sock, cmd, sizeof(*cmd));
+	send_sync_cmd(mcl, cmd, sizeof(*cmd));
 
 	g_free(cmd);
 }
-- 
1.7.0.4

