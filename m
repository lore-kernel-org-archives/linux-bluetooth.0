Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH] Code reorganization to avoid unnecessary forward declarations
Date: Tue, 21 Sep 2010 17:32:32 +0200
Message-Id: <1285083152-27170-1-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <AANLkTi=L_iB7Evf9OdRxhVH+-dwdH8sdJ79Mu5tab8Oj@mail.gmail.com>
References: <AANLkTi=L_iB7Evf9OdRxhVH+-dwdH8sdJ79Mu5tab8Oj@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap_sync.c |  355 +++++++++++++++++++++++++---------------------------
 1 files changed, 173 insertions(+), 182 deletions(-)

diff --git a/health/mcap_sync.c b/health/mcap_sync.c
index 25fc2d4..0943e41 100644
--- a/health/mcap_sync.c
+++ b/health/mcap_sync.c
@@ -111,15 +111,6 @@ static inline uint64_t ntoh64(uint64_t n)
 static gboolean csp_caps_initialized = FALSE;
 struct csp_caps _caps;
 
-static void proc_sync_cap_req(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
-static void proc_sync_set_req(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
-static void proc_sync_cap_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
-static void proc_sync_set_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
-static void proc_sync_info_ind(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
-
-static gboolean sync_send_indication(gpointer user_data);
-static gboolean proc_sync_set_req_phase2(gpointer user_data);
-
 static int send_sync_cmd(struct mcap_mcl *mcl, const void *buf, uint32_t size)
 {
 	int sock;
@@ -161,39 +152,6 @@ static int send_unsupported_set_req(struct mcap_mcl *mcl)
 	return sent;
 }
 
-void proc_sync_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
-{
-	if (!mcl->ms->csp_enabled || !mcl->csp) {
-		switch (cmd[0]) {
-		case MCAP_MD_SYNC_CAP_REQ:
-			send_unsupported_cap_req(mcl);
-			break;
-		case MCAP_MD_SYNC_SET_REQ:
-			send_unsupported_set_req(mcl);
-			break;
-		}
-		return;
-	}
-
-	switch (cmd[0]) {
-	case MCAP_MD_SYNC_CAP_REQ:
-		proc_sync_cap_req(mcl, cmd, len);
-		break;
-	case MCAP_MD_SYNC_CAP_RSP:
-		proc_sync_cap_rsp(mcl, cmd, len);
-		break;
-	case MCAP_MD_SYNC_SET_REQ:
-		proc_sync_set_req(mcl, cmd, len);
-		break;
-	case MCAP_MD_SYNC_SET_RSP:
-		proc_sync_set_rsp(mcl, cmd, len);
-		break;
-	case MCAP_MD_SYNC_INFO_IND:
-		proc_sync_info_ind(mcl, cmd, len);
-		break;
-	}
-}
-
 static void reset_tmstamp(struct mcap_csp *csp, struct timespec *base_time,
 				uint64_t new_tmstamp)
 {
@@ -552,126 +510,6 @@ static int send_sync_set_rsp(struct mcap_mcl *mcl, uint8_t rspcode,
 	return sent;
 }
 
-static void proc_sync_set_req(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
-{
-	mcap_md_sync_set_req *req;
-	uint32_t sched_btclock, cur_btclock;
-	uint16_t btres;
-	uint8_t update;
-	uint64_t timestamp;
-	struct sync_set_data *set_data;
-	int phase2_delay, ind_freq, when;
-
-	if (len != sizeof(mcap_md_sync_set_req)) {
-		send_sync_set_rsp(mcl, MCAP_INVALID_PARAM_VALUE, 0, 0, 0);
-		return;
-	}
-
-	req = (mcap_md_sync_set_req *) cmd;
-	sched_btclock = ntohl(req->btclock);
-	update = req->timestui;
-	timestamp = ntoh64(req->timestst);
-
-	if (sched_btclock != MCAP_BTCLOCK_IMMEDIATE &&
-			!valid_btclock(sched_btclock)) {
-		send_sync_set_rsp(mcl, MCAP_INVALID_PARAM_VALUE, 0, 0, 0);
-		return;
-	}
-
-	if (update > 1) {
-		send_sync_set_rsp(mcl, MCAP_INVALID_PARAM_VALUE, 0, 0, 0);
-		return;
-	}
-
-	if (!mcl->csp->remote_caps) {
-		/* Remote side did not ask our capabilities yet */
-		send_sync_set_rsp(mcl, MCAP_INVALID_PARAM_VALUE, 0, 0, 0);
-		return;
-	}
-
-	if (!read_btclock_retry(mcl, &cur_btclock, &btres)) {
-		send_sync_set_rsp(mcl, MCAP_UNSPECIFIED_ERROR, 0, 0, 0);
-		return;
-	}
-
-	if (sched_btclock == MCAP_BTCLOCK_IMMEDIATE)
-		phase2_delay = 0;
-	else {
-		phase2_delay = btdiff(cur_btclock, sched_btclock);
-
-		if (phase2_delay < 0) {
-			/* can not reset in the past tense */
-			send_sync_set_rsp(mcl, MCAP_INVALID_PARAM_VALUE,
-						0, 0, 0);
-			return;
-		}
-
-		/* Convert to miliseconds */
-		phase2_delay = bt2ms(phase2_delay);
-
-		if (phase2_delay > 61*1000) {
-			/* More than 60 seconds in the future */
-			send_sync_set_rsp(mcl, MCAP_INVALID_PARAM_VALUE,
-						0, 0, 0);
-			return;
-		} else if (phase2_delay < caps(mcl)->latency / 1000) {
-			/* Too fast for us to do in time */
-			send_sync_set_rsp(mcl, MCAP_INVALID_PARAM_VALUE,
-						0, 0, 0);
-			return;
-		}
-	}
-
-	if (update) {
-		/* Indication frequency: required accuracy divided by ours */
-		/* Converted to milisseconds */
-		ind_freq = (1000 * mcl->csp->rem_req_acc) / caps(mcl)->ts_acc;
-
-		if (ind_freq < MAX(caps(mcl)->latency * 2 / 1000, 100)) {
-			/* Too frequent, we can't handle */
-			send_sync_set_rsp(mcl, MCAP_INVALID_PARAM_VALUE,
-						0, 0, 0);
-			return;
-		}
-
-		DBG("CSP: indication every %dms", ind_freq);
-	} else
-		ind_freq = 0;
-
-	if (mcl->csp->ind_timer) {
-		/* Old indications are no longer sent */
-		g_source_remove(mcl->csp->ind_timer);
-		mcl->csp->ind_timer = 0;
-	}
-
-	if (!mcl->csp->set_data)
-		mcl->csp->set_data = g_new0(struct sync_set_data, 1);
-
-	set_data = (struct sync_set_data *) mcl->csp->set_data;
-
-	set_data->update = update;
-	set_data->sched_btclock = sched_btclock;
-	set_data->timestamp = timestamp;
-	set_data->ind_freq = ind_freq;
-	set_data->role = get_btrole(mcl);
-
-	/* TODO is there some way to schedule a call based directly on
-	 * a BT clock value, instead of this estimation that uses
-	 * the SO clock? */
-
-	if (phase2_delay > 0) {
-		when = phase2_delay + caps(mcl)->syncleadtime_ms;
-		mcl->csp->set_timer = g_timeout_add(when,
-						proc_sync_set_req_phase2,
-						mcl);
-	} else
-		proc_sync_set_req_phase2(mcl);
-
-	/* First indication is immediate */
-	if (update)
-		sync_send_indication(mcl);
-}
-
 static gboolean get_all_clocks(struct mcap_mcl *mcl, uint32_t *btclock,
 				struct timespec *base_time,
 				uint64_t *timestamp)
@@ -701,6 +539,36 @@ static gboolean get_all_clocks(struct mcap_mcl *mcl, uint32_t *btclock,
 	return TRUE;
 }
 
+static gboolean sync_send_indication(gpointer user_data)
+{
+	struct mcap_mcl *mcl;
+	mcap_md_sync_info_ind *cmd;
+	uint32_t btclock;
+	uint64_t tmstamp;
+	struct timespec base_time;
+	int sent;
+
+	if (!user_data)
+		return FALSE;
+
+	mcl = user_data;
+
+	if (!get_all_clocks(mcl, &btclock, &base_time, &tmstamp))
+		return FALSE;
+
+	cmd = g_new0(mcap_md_sync_info_ind, 1);
+
+	cmd->op = MCAP_MD_SYNC_INFO_IND;
+	cmd->btclock = htonl(btclock);
+	cmd->timestst = hton64(tmstamp);
+	cmd->timestsa = htons(caps(mcl)->latency);
+
+	sent = send_sync_cmd(mcl, cmd, sizeof(*cmd));
+	g_free(cmd);
+
+	return !sent;
+}
+
 static gboolean proc_sync_set_req_phase2(gpointer user_data)
 {
 	struct mcap_mcl *mcl;
@@ -783,34 +651,124 @@ static gboolean proc_sync_set_req_phase2(gpointer user_data)
 	return FALSE;
 }
 
-static gboolean sync_send_indication(gpointer user_data)
+static void proc_sync_set_req(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
-	struct mcap_mcl *mcl;
-	mcap_md_sync_info_ind *cmd;
-	uint32_t btclock;
-	uint64_t tmstamp;
-	struct timespec base_time;
-	int sent;
+	mcap_md_sync_set_req *req;
+	uint32_t sched_btclock, cur_btclock;
+	uint16_t btres;
+	uint8_t update;
+	uint64_t timestamp;
+	struct sync_set_data *set_data;
+	int phase2_delay, ind_freq, when;
 
-	if (!user_data)
-		return FALSE;
+	if (len != sizeof(mcap_md_sync_set_req)) {
+		send_sync_set_rsp(mcl, MCAP_INVALID_PARAM_VALUE, 0, 0, 0);
+		return;
+	}
 
-	mcl = user_data;
+	req = (mcap_md_sync_set_req *) cmd;
+	sched_btclock = ntohl(req->btclock);
+	update = req->timestui;
+	timestamp = ntoh64(req->timestst);
 
-	if (!get_all_clocks(mcl, &btclock, &base_time, &tmstamp))
-		return FALSE;
+	if (sched_btclock != MCAP_BTCLOCK_IMMEDIATE &&
+			!valid_btclock(sched_btclock)) {
+		send_sync_set_rsp(mcl, MCAP_INVALID_PARAM_VALUE, 0, 0, 0);
+		return;
+	}
 
-	cmd = g_new0(mcap_md_sync_info_ind, 1);
+	if (update > 1) {
+		send_sync_set_rsp(mcl, MCAP_INVALID_PARAM_VALUE, 0, 0, 0);
+		return;
+	}
 
-	cmd->op = MCAP_MD_SYNC_INFO_IND;
-	cmd->btclock = htonl(btclock);
-	cmd->timestst = hton64(tmstamp);
-	cmd->timestsa = htons(caps(mcl)->latency);
+	if (!mcl->csp->remote_caps) {
+		/* Remote side did not ask our capabilities yet */
+		send_sync_set_rsp(mcl, MCAP_INVALID_PARAM_VALUE, 0, 0, 0);
+		return;
+	}
 
-	sent = send_sync_cmd(mcl, cmd, sizeof(*cmd));
-	g_free(cmd);
+	if (!read_btclock_retry(mcl, &cur_btclock, &btres)) {
+		send_sync_set_rsp(mcl, MCAP_UNSPECIFIED_ERROR, 0, 0, 0);
+		return;
+	}
 
-	return !sent;
+	if (sched_btclock == MCAP_BTCLOCK_IMMEDIATE)
+		phase2_delay = 0;
+	else {
+		phase2_delay = btdiff(cur_btclock, sched_btclock);
+
+		if (phase2_delay < 0) {
+			/* can not reset in the past tense */
+			send_sync_set_rsp(mcl, MCAP_INVALID_PARAM_VALUE,
+						0, 0, 0);
+			return;
+		}
+
+		/* Convert to miliseconds */
+		phase2_delay = bt2ms(phase2_delay);
+
+		if (phase2_delay > 61*1000) {
+			/* More than 60 seconds in the future */
+			send_sync_set_rsp(mcl, MCAP_INVALID_PARAM_VALUE,
+						0, 0, 0);
+			return;
+		} else if (phase2_delay < caps(mcl)->latency / 1000) {
+			/* Too fast for us to do in time */
+			send_sync_set_rsp(mcl, MCAP_INVALID_PARAM_VALUE,
+						0, 0, 0);
+			return;
+		}
+	}
+
+	if (update) {
+		/* Indication frequency: required accuracy divided by ours */
+		/* Converted to milisseconds */
+		ind_freq = (1000 * mcl->csp->rem_req_acc) / caps(mcl)->ts_acc;
+
+		if (ind_freq < MAX(caps(mcl)->latency * 2 / 1000, 100)) {
+			/* Too frequent, we can't handle */
+			send_sync_set_rsp(mcl, MCAP_INVALID_PARAM_VALUE,
+						0, 0, 0);
+			return;
+		}
+
+		DBG("CSP: indication every %dms", ind_freq);
+	} else
+		ind_freq = 0;
+
+	if (mcl->csp->ind_timer) {
+		/* Old indications are no longer sent */
+		g_source_remove(mcl->csp->ind_timer);
+		mcl->csp->ind_timer = 0;
+	}
+
+	if (!mcl->csp->set_data)
+		mcl->csp->set_data = g_new0(struct sync_set_data, 1);
+
+	set_data = (struct sync_set_data *) mcl->csp->set_data;
+
+	set_data->update = update;
+	set_data->sched_btclock = sched_btclock;
+	set_data->timestamp = timestamp;
+	set_data->ind_freq = ind_freq;
+	set_data->role = get_btrole(mcl);
+
+	/* TODO is there some way to schedule a call based directly on
+	 * a BT clock value, instead of this estimation that uses
+	 * the SO clock? */
+
+	if (phase2_delay > 0) {
+		when = phase2_delay + caps(mcl)->syncleadtime_ms;
+		mcl->csp->set_timer = g_timeout_add(when,
+						proc_sync_set_req_phase2,
+						mcl);
+	} else
+		proc_sync_set_req_phase2(mcl);
+
+	/* First indication is immediate */
+	if (update)
+		sync_send_indication(mcl);
 }
 
 static void proc_sync_cap_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
@@ -937,6 +895,39 @@ static void proc_sync_info_ind(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 		mcl->ms->mcl_sync_infoind_cb(mcl, &data);
 }
 
+void proc_sync_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
+{
+	if (!mcl->ms->csp_enabled || !mcl->csp) {
+		switch (cmd[0]) {
+		case MCAP_MD_SYNC_CAP_REQ:
+			send_unsupported_cap_req(mcl);
+			break;
+		case MCAP_MD_SYNC_SET_REQ:
+			send_unsupported_set_req(mcl);
+			break;
+		}
+		return;
+	}
+
+	switch (cmd[0]) {
+	case MCAP_MD_SYNC_CAP_REQ:
+		proc_sync_cap_req(mcl, cmd, len);
+		break;
+	case MCAP_MD_SYNC_CAP_RSP:
+		proc_sync_cap_rsp(mcl, cmd, len);
+		break;
+	case MCAP_MD_SYNC_SET_REQ:
+		proc_sync_set_req(mcl, cmd, len);
+		break;
+	case MCAP_MD_SYNC_SET_RSP:
+		proc_sync_set_rsp(mcl, cmd, len);
+		break;
+	case MCAP_MD_SYNC_INFO_IND:
+		proc_sync_info_ind(mcl, cmd, len);
+		break;
+	}
+}
+
 void mcap_sync_cap_req(struct mcap_mcl *mcl, uint16_t reqacc,
 			mcap_sync_cap_cb cb, gpointer user_data,
 			GError **err)
-- 
1.7.0.4

