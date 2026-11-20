Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193726;
	b=w+ChEyHpE0ONcoY9NPw2DDkinrGAq30uuKhVVMSyaxp0OR8q6vZIpOYeTnK/gpxUz077
	 YJrr3+ENkMRtSCWDUuTUGcllDkvd0cgs9tI7ENBbZOKiIz/e7M+1r0ygYtXAxfQJlQqFh
	 A2xSEyUygduA82CSgVCWiApbD7Wal1BLI+A/HlxrrUCMDTW3bouLf7qf3R3UyrO/wsz6l
	 R7PoIKbu7XjWUai3fkUmwm8TVLXEO6T4iQt5RXXPWtmpUVC6/44RbnX/SY/fUbHljfUnc
	 Xcii/iVWtPwqI1s5RhwrodCeLD7tv16OtF20qFUAjMAi8Jid15sTs6xP3hX9lzGjJMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193726;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AHA1KrehPP3A6ZlKbbd51mDGoNEhWPk4PqsD6p7cM34=;
	b=i49o+kB7iQmAPnfV62Wo3HyBX/k0inn+ruvJlicVr1esaDUfMe3vuTUijm5zJSnSHtL2
	 cVd+c7dCpN5wb5DyBB+E1+w2tGngenhSrn9ACIVS2a7wwmaF5/QvSaBkcmtXxVZ3AuMdB
	 SBJa70/iYGpiNZZ/nt9FJ7KjwX9jhcDKA6p58ezRQ/F8P3L554J4/0GOTzIgbFznKmXW7
	 z1KjZiJOJiKQOx3n1ClRAQXyhEBsv+I3UKPznrhDHH1pwQAuHZX7gNnHgcA3qhYifS9G6
	 nWeGrGBUNMYe+jkd3fEmaff4r4VRSuRVYfeZL3iziZvA9J5JKOuOdmD6lR5tJVxfQRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Idd7vpGF;
	arc=none smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B3660A260A
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 16:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99B3660A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Idd7vpGF
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-99ac154431bso226387241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 08:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193723; x=1795798523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AHA1KrehPP3A6ZlKbbd51mDGoNEhWPk4PqsD6p7cM34=;
        b=Idd7vpGFmeuMAtloWB0y1kqJb8UTGK2EoU3crobOWiajxW8BF8ONm1pWhytX5deiqA
         OQp9+NzfUXaUlwN5elLMpnqYO9xXep5G9CeNV4YqYreBNqEXE7KotnudzYYqZma/piYL
         7ObeMbgu1/3HAsupTTbnsmRVBuCo+93bLXitcnykDxJ8a3BGbfnn9vBTcNLm292/zuOz
         lDuCRznGIKOpDlbF2A20B625tLhO1AchdOARXTIU11iDfblj08+Zj7tqXp3bkblRfYWJ
         G8J0AodE8ynPmHXTtrURy6kto7JhrWwsa7bZ3nUvN7NaWmoklV3sCgkTc1u4ibVPjQTb
         W64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193723; x=1795798523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AHA1KrehPP3A6ZlKbbd51mDGoNEhWPk4PqsD6p7cM34=;
        b=Q6UYMLflC6VRfNjShgoUgoCNjuUm/vLOGAdRJf9DXAgfVO28qFgKTCsQQLIzDkJrR8
         wrEBxeLbAalpXSPdSUK9WerTgFe5xzkI++5C8YC72uwOjfpa9zlHsVE2OvYS7/JqV7cp
         /tdJX/qHpULBKHobkKYTt629laOTQIs8VVkXNYkSfGgIvLysU1TRfN4NkYPm6gIFKDux
         TzrjcPNRfvW0TKS06Nb/9HG27gR7l85ppc7Ggv29nJor8oOfUowbdlDQhMS8o19eOmwI
         BPE75d1UWqfb0qHhnT7NXojJ295PgE1oxxaA++fpjfQxkfFEYCUVGL6paWASqp+jVfDW
         3Ubw==
X-Gm-Message-State: APuU4Z808H5bT2w4hDGGChmEDYd+726S0g09qHFI2LK0GzoYceE1Dh1R
	HNBeMRU7panV4YzWTHxt51KwpSymQuyhMBmYoCz2aGMhdMDZRK+Sa3k2t7tJWGhw
X-Gm-Gg: AZFdTZfL/7um/9wUhPl/wv7QwMSjjb+kIxZE3Kg9q5O0c4G4eBd6opYJT+CB5OFQ0cA
	hKg+mIvwmlkTKsAMb7I/ecnb8tytm9NUKopGjRSMAPeMsBWkY2iIkAjInEPONNWSL1tHeJTO8lJ
	ItcWzQc73L/JG/ZbtHfnWCo3CWIMts8D15J5HfzUpWK+HwLh9plsNz6eMmZ9lHbqSKCj6C7bb7c
	e175Tdixj5B9Ebmfhcfxq5RXcUA95rOEzqJ17sNNA/5z3RsnZTUK/I4WAifRayIABOrWMsWEm4C
	YXZi9k3P8ROmdYJG1hXXUdABQm011xg+c7Xm5qzBTL/XOcOIrxMpaeseTABsYasChig2QM9SNa5
	ftV+o1Luwh0qadPSiKX1TgDESRHvC+3yxj68xjYKnfK7ChoBYvWdsTcQdptnSUx9gMY8m0a3Xz+
	WJ4eCFARl9q1ss4Xng5d9eR9mvpPGAdn4TKxBA7dO1c57J8FYG/Kue9CTRf8j7iTDVun9PYjeqO
	z99CXutc4GRoZuaGQOS5bHizjgeAUrI9T0szIZKT3iunqRCo2VPX4ZIJulsBESjJMk+uOkZ7PTA
	b9v/t5syjUKH4IjotGcJ3WUoHyxqeoJptry02kUnLcZwvIk9LbZZ1ouuCj2jT0nJgqx6pPAaAdC
	hZL6ONVqFxCq2/zcSDPLTJPAWNhcdynDtGweCO/4iOxtIDvsQt1Vqlmj8N7IiEehv
X-Received: by 2002:a05:6102:84c8:b0:7d0:6db8:dc43 with SMTP id ada2fe7eead31-7d7395e6e50mr1208422137.24.1795193723067;
        Fri, 20 Nov 2026 08:55:23 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6df8a28dsm3486193241.4.2026.11.20.08.55.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:55:22 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 13/18] profiles/ranging: Choose the CS antenna configuration from both ends
Date: Fri, 20 Nov 2026 11:55:03 -0500
Message-ID: <20261120165510.1858959-14-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120165510.1858959-1-luiz.dentz@gmail.com>
References: <20261120165510.1858959-1-luiz.dentz@gmail.com>
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

