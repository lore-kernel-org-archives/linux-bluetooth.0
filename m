Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456298;
	b=nbjhgbANYtLt68K/w8uAGqDS70hQNhulMm+dKUrwTW7vi/SSzNU7sOUsSOj6VI9ExSl3
	 XfEv+rjKJy/dhoM6qyv4Kdar0J4eTM3AcPmAeeczAYO/GKfLIH/SOZtTucEcxcRja5J+e
	 E3DnNbck5t/SNy62V+Ld+sZ69H863IGk99LuY5RIdlHmOBHaEhtB5erqtQHtYnPP2v1cB
	 lcER23UOC2yFEygJpSgksocnZXoxy/Nq8IQf5+IFfV+maoo3gyh/5ZqUmGypVcEflVC3L
	 2OyaKUGY/vZS8Jko2FydWaiW3VmKN8N8m6WKPlzNx1QYDz6+T0TwpT9lkBm63TUT85A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AHA1KrehPP3A6ZlKbbd51mDGoNEhWPk4PqsD6p7cM34=;
	b=qKkq9JgLGEQZs9gXG1BrfTxpeSl+KhicP1dwQIQA1IHTLw78At0cdf2q/RauhauCtkyt
	 SzK0InCsp/5/6eFbekDUi9emst3m3689UOJdlrIq04JscvveHAzY/9iii/IIpwkQR2Cpv
	 yh/vrp+kLGOHLh9jubn9vOjgh13DU438ZDHltEGixnuRRj5ZoEDaEumuzz5s6/ydImhhT
	 rv9RgJWiDfmrsOVCeTiolbAwT+TsCB4u3o/do1Pq+EQiMHSjuNe8QUV8l390O7soRzRQV
	 1KYrmsJRflrtmzz35BEiiK1zLybHOxVBtoCX5P5i1AD/srt9VzmFMwqx2A0IqkM0ipg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XdXS0hin;
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736B4606A335
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 736B4606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XdXS0hin
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-990fbae94f5so1926646241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795456297; x=1796061097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AHA1KrehPP3A6ZlKbbd51mDGoNEhWPk4PqsD6p7cM34=;
        b=XdXS0hinJnRmwOV+H2TfrKOJr1xIOg01yONk44k8thAX5tHpGETjlgTyS7McCaLaL5
         Y0mzr34qrao/OVdueWfbQ6zyQBliJ8vSMtkYNUBkKSiBsCaSxHU4sTSFVuFSbd+FIrnr
         QoJnJaoeXZ1SukEIlpxRPoRUYXD/PX9AuqyCbher4gYPPt0mcpbbEqJa53xK4rtd+wy+
         pJGDLWnGk1i6JdCLUUdLa/zaAsYOErQn/eu/3rwJWdc2BX/S3uwIr1juA6dym0PmkCOG
         UxfSov33pVef0z6N37t6u/Vk8VzVMav7srYKenNhjt3qmNxfDY1BFydPVsdWdgV9FBIQ
         Wbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456297; x=1796061097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AHA1KrehPP3A6ZlKbbd51mDGoNEhWPk4PqsD6p7cM34=;
        b=eNjesLSZ40fdIv3rvgDG1DfUT7ATYF2NSCN7HZJiJBIiOl8C22NLhj64UUk5ctvjmL
         SScDPnsPVXQ869GOhAHAgqVfwK/WNSrbmpRPB7gRs03F+aImsqiQ1/zwJNt29pgJ4m9q
         BpyV/8h7+e8IYkdz3c0hxTcKYlYE8YrhKfQBxXDlxoWuXUx4Q2RzPyX24BwqoIaLcX/r
         zlqYVhGf+j7TJKiIruhlKV/EpKV1ZtCL31VSNJRjxp+kAk6G3O12e3DfQpvIQlB1j2t1
         Htm9W+MUFDTL89fa3zVKjCd+iOHcXvsLg3laFa6lZdEg4lE8StzG9pp/lVZkHkToSZCo
         tv+Q==
X-Gm-Message-State: APuU4Z867CITC61WyE6zl71mHxvSxf8owg/27CM+fSSATPtY6S9KX+NU
	WW0QjJf50kJIssxDCpecX0vMH8a+a+rwoVdJ+i6WmNQKJg6h9/tUnaa1vVk/bQ==
X-Gm-Gg: AZFdTZduexLaw0neFsXFKvdofgfr+cN8YZ4SXKjreDH1dKBNdM30RIGQpF7z21tQUF7
	iv5j2VM3IqJqVupC/jckBE1ebX6WQQKl1/W/4GrTkMB/qU6sLqizw+e9ctvHPL5mZdFVgAccJ0y
	qF2zEipR6ff+fOcHU3E+5TmoBWh7w58M92Z4vPjBCofKxZZZAydfQy0esiaxq/rL0OR0AKhVMf3
	GgHcTOixQjQo1TZyYPWGFGh91H4/O8VYe7n9tiNonEZV54Z6WhBIF/ucdPQntfdZ2euHy117lXM
	zh6QAPY33aN53j6VsPIB9WMIke7AGZKrZpJsJqHTEioMY4P3ez/5AP8f6bxEbj/6aTNP/3tHpOT
	7LL0m7LX0XugVTwWUwcsBRhVAeEqvzRqECSy+5Zs4qMIgUfR1J6RtyKi7ZCwwvzK09QgdOhsOhZ
	sXj8IM7K4qAoj/s8BsayMB6Mc+Vx22lSQGuUGtjwSwKGGB6lSrvmTDPn/xN4mKrina1iaeNLDiL
	AUT9ee3bjJ4kZwxVJzY09y/Q968NK1LpI7MSVuqai2adV88qZMpKc26QnafTx+zn2OjB7rBDL+p
	jSgGJN23/J+a+r6gd9C4Kn973VNtr1qDQgYOGCQ5PayYJqj62O6I8WvI5ICcpxeVaaBadV1EC8e
	1xGb6FGZlww8j28Km57WFD7j+LKfL1tx9RcsBJ0LFP+MBQhlJMtH2YWbwXz+AvlBkDjZf40QtMq
	skzNR/gsf6tvXt++rj6ycjFUfl
X-Received: by 2002:a05:6102:f07:b0:7d0:6cf3:d8f3 with SMTP id ada2fe7eead31-7d739444d6cmr5983564137.18.1795456297264;
        Mon, 23 Nov 2026 09:51:37 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f92680sm12795393137.5.2026.11.23.09.51.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:51:36 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 13/18] profiles/ranging: Choose the CS antenna configuration from both ends
Date: Mon, 23 Nov 2026 12:51:16 -0500
Message-ID: <20261123175125.3642617-14-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123175125.3642617-1-luiz.dentz@gmail.com>
References: <20261123175125.3642617-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>

Set Procedure Parameters sent the configured antenna configuration as
is, ACI 7 unless the application gave another. ACI 7 is the 2:2
configuration and needs two antennas and four antenna paths on both
ends. Against a single-antenna peer, or on a single-antenna local
Controller, the command was rejected with Rejected Due to Limited
Resources and no procedure was started.

The capabilities of both ends are read during the setup phase, but the
antenna counts were only logged. Keep the antenna count and antenna path
limit from both, and check the requested configuration against them and
the eight configurations of Core v6.2 Vol 6 Part A, Table 5.3. If it
fits, use it as given; otherwise use the first one that fits, with a
Preferred_Peer_Antenna that has at least as many bits set as the peer has
antenna elements in it.

Table 5.3 is written as "device A:device B" where device A is the
initiator (Vol 6 Part B, 2.4.2.47), so a configuration is asymmetric:
one antenna locally and four on the peer is ACI 6 as the Initiator but
ACI 3 as the Reflector. Use the negotiated CS role to decide which end
contributes which count, and refuse to send the command until both
capability reads and the role are known.

Assisted-by: Claude:claude-sonnet-5-5
---
 profiles/ranging/rap_hci.c | 133 +++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 3a6d514cfcf9..6181bc0f12d5 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -89,6 +89,12 @@ struct cs_state_machine {
 	struct timespec last_chan_class_time;  /* For 1-second rate limit */
 	struct bt_rap_le_cs_config   cs_config;
 	struct bt_rap_le_cs_frequency cs_frequency;
+	uint8_t remote_num_antennas;  /* from Read Remote Supported Caps */
+	uint8_t remote_max_antenna_paths;
+	bool remote_caps_known;
+	uint8_t local_num_antennas;  /* from LE CS Read Local Supported Caps */
+	uint8_t local_max_antenna_paths;
+	bool local_caps_known;
 	cs_timeout_func_t timeout_func;
 	void *timeout_data;
 	void (*proc_active_func)(bool active, void *user_data);
@@ -441,6 +447,13 @@ static void rap_rd_loc_supp_cap_done_cb(const void *data, uint8_t size,
 		rsp->max_consecutive_procedures_supported);
 	DBG("  Num Antennas: %u", rsp->num_antennas_supported);
 	DBG("  Max Antenna Paths: %u", rsp->max_antenna_paths_supported);
+
+	/* Needed to pick the antenna configuration, which has to fit both
+	 * ends (Core v6.2 Vol 6 Part A, Table 5.3).
+	 */
+	sm->local_num_antennas = rsp->num_antennas_supported;
+	sm->local_max_antenna_paths = rsp->max_antenna_paths_supported;
+	sm->local_caps_known = true;
 	DBG("  Roles Supported: 0x%02X", rsp->roles_supported);
 	DBG("  Modes Supported: 0x%02X", rsp->modes_supported);
 	DBG("  RTT Capability: 0x%02X", rsp->rtt_capability);
@@ -621,6 +634,104 @@ static void rap_send_hci_cs_security_enable_command(
 	DBG("CS Security Enable command sent successfully");
 }
 
+/*
+ * Pick the antenna configuration for Set Procedure Parameters.
+ *
+ * The ACI values of Core v6.2 Vol 6 Part A, Table 5.3 are "device A:device B"
+ * antenna counts, where device A is the initiator (Vol 6 Part B, 2.4.2.47),
+ * so which end contributes which count depends on the local CS role. The
+ * entries are ordered so that the first match uses as many antenna paths as
+ * both ends allow.
+ */
+static const struct {
+	uint8_t aci;
+	uint8_t paths;
+	uint8_t init_ant;
+	uint8_t refl_ant;
+} cs_antenna_configs[] = {
+	{ 0x07, 4, 2, 2 },  /* 2:2 */
+	{ 0x03, 4, 4, 1 },  /* N_AP:1 */
+	{ 0x06, 4, 1, 4 },  /* 1:N_AP */
+	{ 0x02, 3, 3, 1 },
+	{ 0x05, 3, 1, 3 },
+	{ 0x01, 2, 2, 1 },
+	{ 0x04, 2, 1, 2 },
+	{ 0x00, 1, 1, 1 },  /* 1:1, always usable */
+};
+
+static bool cs_select_antenna_config(struct cs_state_machine *sm)
+{
+	uint8_t local_ant, peer_ant, max_paths, req, sel_peer = 0;
+	bool initiator;
+	size_t i, sel = ARRAY_SIZE(cs_antenna_configs);
+
+	/* Both capability reads have to be in before the configuration can be
+	 * known to fit: ACI 7 (2:2), the default, is rejected with Rejected
+	 * Due to Limited Resources if either end has a single antenna. The
+	 * role decides which end of the configuration is ours, so it has to
+	 * be settled as well.
+	 */
+	if (!sm->local_caps_known || !sm->remote_caps_known ||
+						!sm->cs_role_known) {
+		error("CS Set Proc Params: capabilities or role unknown");
+		return false;
+	}
+
+	initiator = sm->cs_role == CS_INITIATOR;
+	local_ant = sm->local_num_antennas;
+	peer_ant = sm->remote_num_antennas;
+	max_paths = MIN(sm->local_max_antenna_paths,
+			sm->remote_max_antenna_paths);
+	req = sm->cs_frequency.tone_antenna_config_selection;
+
+	for (i = 0; i < ARRAY_SIZE(cs_antenna_configs); i++) {
+		uint8_t need_local = initiator ?
+					cs_antenna_configs[i].init_ant :
+					cs_antenna_configs[i].refl_ant;
+		uint8_t need_peer = initiator ?
+					cs_antenna_configs[i].refl_ant :
+					cs_antenna_configs[i].init_ant;
+
+		if (cs_antenna_configs[i].paths > max_paths ||
+				need_local > local_ant || need_peer > peer_ant)
+			continue;
+
+		/* The requested configuration fits, so keep it as given */
+		if (cs_antenna_configs[i].aci == req) {
+			DBG("ACI 0x%02X fits both ends", req);
+			return true;
+		}
+
+		if (sel == ARRAY_SIZE(cs_antenna_configs)) {
+			sel = i;
+			sel_peer = need_peer;
+		}
+	}
+
+	/* The 1:1 entry needs one antenna on each side, so this only happens
+	 * if a side reported none.
+	 */
+	if (sel == ARRAY_SIZE(cs_antenna_configs)) {
+		error("No usable CS antenna configuration: local %u ant, "
+			"peer %u ant", local_ant, peer_ant);
+		return false;
+	}
+
+	sm->cs_frequency.tone_antenna_config_selection =
+					cs_antenna_configs[sel].aci;
+	/* Preferred_Peer_Antenna needs at least as many bits set as the peer
+	 * has antenna elements in this configuration.
+	 */
+	sm->cs_frequency.preferred_peer_antenna = (1 << sel_peer) - 1;
+
+	DBG("ACI 0x%02X does not fit, using 0x%02X: local %u ant, peer %u ant, "
+		"%u paths, peer mask 0x%02X, initiator=%d", req,
+		cs_antenna_configs[sel].aci, local_ant, peer_ant, max_paths,
+		sm->cs_frequency.preferred_peer_antenna, initiator);
+
+	return true;
+}
+
 static bool rap_send_hci_cs_set_procedure_parameters(
 		struct cs_state_machine *sm, uint16_t handle)
 {
@@ -632,6 +743,9 @@ static bool rap_send_hci_cs_set_procedure_parameters(
 		return false;
 	}
 
+	if (!cs_select_antenna_config(sm))
+		return false;
+
 	DBG("Sending CS Set Procedure Parameters for handle 0x%04X", handle);
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -849,6 +963,14 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 
 	DBG("status=0x%02X, handle=0x%04X", evt->status, evt->handle);
 
+	/* Every state machine on this adapter sees every CS event, so do not
+	 * let another link's capabilities overwrite this one's.
+	 */
+	if (!find_mapping_by_handle(sm, evt->handle)) {
+		DBG("Not for this link, ignoring");
+		return;
+	}
+
 	/* Check status */
 	if (evt->status != 0) {
 		error("Remote capabilities failed with status 0x%02X",
@@ -869,6 +991,16 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 	subfeatures_supported = le16_to_cpu(evt->subfeatures_supported);
 	DBG("subfeatures_supported=0x%04X", subfeatures_supported);
 
+	/* Remember the peer's antenna count: the antenna configuration used in
+	 * Set Procedure Parameters must fit both ends (Core v6.2 Vol 4 Part E
+	 * 7.8.140).
+	 */
+	sm->remote_num_antennas = evt->num_antennas_supported;
+	sm->remote_max_antenna_paths = evt->max_antenna_paths_supported;
+	sm->remote_caps_known = true;
+	DBG("remote antennas=%u paths=%u", sm->remote_num_antennas,
+		sm->remote_max_antenna_paths);
+
 	bt_rap_set_remote_sw_time(sm->rap, evt->t_sw_time_supported);
 
 	/* Check Bit 1 of subfeatures_supported (0x0002) */
@@ -2022,6 +2154,7 @@ void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle)
 	sm->procedure_active = false;
 	sm->cs_role_known = false;
 	sm->sec_enable_pending = false;
+	sm->remote_caps_known = false;
 	sm->current_state = CS_STATE_UNSPECIFIED;
 }
 
-- 
2.56.0

