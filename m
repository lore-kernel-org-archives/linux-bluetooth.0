Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031940;
	b=Aa15dDoCkO7lxjOBQcBOEyN/fNIeKZ+Cltj11lkst48lWdDes8h9w+3LD0vcf2j6B7nV
	 gCkfDxjhRuJ3GLvEhORVqNLg/qsmOvEZ2YzyDXE4s/EHAxk9tWCmUjo0elnXmAYrVzhyW
	 AIGYTBLus7x3zULXkMYQby9XswrQaN8509jl4k6RP1nUU8hp9UDFTB5Zu1B5G9AZs/1wi
	 Ba5C7PZhIuth1U7j4Ar2C+14aF9SXoVvvmApuJRaEirGNjKEh4qQXGBiuEjcXQSoJYS0n
	 xGsv1BRUIKtk6WeqgWmBBgRdpU6ZepnpEXk4QuUJTm/f/ocEwByDD1tdiMWiJLi7E6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XvMVs4nk6pEbBMOhWyoby+TC91OaKNQX4fuS9cS3Y+s=;
	b=lMfXDw5k81SQ+LJ1HyM2xIiqP03ybC5hJkC7YlCwmIGRTQ/nIANzB3Pw+gTQ9ZI9upK6
	 PSyirVe7W8GkMQBexMhwzTO2jds/zyx2qKsaP4amsUWLri2v4NnA3epGayuLPnrSMsd+u
	 q4GX5DoYKZf2pOyBU24UK6EYcCiawjsMLFRBRr9q580VJv5cmWtQLoPDsFvOvOXDCcgfM
	 S4LAvyJJcSJpmiqx5RIwa3Yt6Fv4acmsNQTDTKBM1KbBtIBlj+1CYVqOEe/o8b699rys8
	 2kUVSppG7CZ3LObHHZt2QcIuUfI4FEc1UEoByFPIT2/4lR/pxI1rfTVdTXlIhPn1OdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h0EoowIv;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9A1606A33F
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA9A1606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h0EoowIv
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7d2d95c5d81so162217137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795031939; x=1795636739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XvMVs4nk6pEbBMOhWyoby+TC91OaKNQX4fuS9cS3Y+s=;
        b=h0EoowIv6VBJNW+J7Q5RHkT16GVa97BvYQ2fgyoqGpiiblwBM3DTPAeAvKqxNIFHce
         w/sEIkW3/lnlFzC6TSiCValMHzSpo3omq7elINoGUytdZAVNQ/PH16cWBbSD6/ti1cXL
         DN4jOhSAmwWAGLnmVmw8Fic3wIEsmQ+p15qm/9PaN5wcX2QYrLuxBaH4n0oYeq9bMd7u
         rkvWRP58+crQxpPyZy/1AZ1B+zyY7cFBr6kAmWljnlc6fw1Yjht6Cs+9LgyjG/zoY/CI
         +JQZ2Waqp70Q3JMNXN6M7slOPWcHvHPnPAlPEkI/JW58XT2GU/3MilgZAoa/vyQ3/VLq
         TPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031939; x=1795636739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XvMVs4nk6pEbBMOhWyoby+TC91OaKNQX4fuS9cS3Y+s=;
        b=kqMaGaUhR+WLTOsveJ7PPFijqEh4HpRaq6w45fOuNoKhABRfpGdKxQ6r2RpGK6kcqn
         qrmWWRxiS8yyQdU9ZXFZYi/LTThfxbNsBhCKehggtCQB+CeeSBD8J+7hs5eb5OpY1WaK
         ty6Lt4RX44a7oZFp1c9GAHSWwvBRftbILNnm6gw6qCb4bXusmu4j/rTvffux+UUUTfVb
         OC5jXR6rdPbvEbyJiFVqu3tT11YUPccS++VJtsJYJrGVHnix4gbnxUBJUKo2JIaXV8Dn
         Zz+qyeWyzTsRUi7ia4EXwSn7qXvLq+9gqoVAYg63xJtL6D89sf8jfiT1AVujncwxrrke
         ha8Q==
X-Gm-Message-State: APuU4Z9DhmE3himtAcaBc5sKJqB98JktvlNb//AOVZFCJJTRGvx+F3IU
	xoPtk7yPGDC8jMUmluo7Jl6QKIPXu5TnAwIdA4my4xCOcHpo9PhkptZ6ndcwpZNK
X-Gm-Gg: AYBFou2XfP6iXDC4LEv+wQm0TCNlmtMTHqrOcN+HQ7/z9f/vvtqzzkpaLU0d1Y4lP/h
	AF9UdMNuON+teEy5U1p8BQuXdqjB3TwdqKRi0vlYWv3eUyQ67MbfT4NJpENOIxKyE4wVucmdn89
	c5W0qAgevFJhg2MFn+Zwefe1GbMi0aFvxF8Ow8a+tFGstFRlucslBrbIT7xi6CHfBfNc8FQE9En
	FfYbbfSSfKoRvU6i/v1CyMVXVVbLrTkl2CFS9i69MOKNE940S5iONvwyOhWUHN4GyYnKThZt44R
	9fOrDXYi+GKVz4ClbavgFw+Q5RVVD4f4EHNS/nZpOuIRe0jGwAlLXOrakIzGJpTxwzoJs4/Wknu
	rUXGRUrIoY/A3OgSdn3DH1oVHc68FjXCwhkhiHfyrmS+s3sAeK5rxVTxbYuPc/ugzXShW4K4RQl
	zReqi0RcC2i1Gw2YDeYFluSpiT6DhfkxQpA2ozlMy1LNNjudL38yvqOfKbyRtPyH7xRRte8RSPE
	jH3Gm4Vor0pdnEJaYg7ekBeqf1nDeAghWN+6FtO9uZFtKTzsdutHY/uLeK1upxyfY8uZH9FjI9g
	H3qBXN9onXxpjjdIKNyEzMhK3P2nG47p598jzluoImAklaY3NcwJwpM8ZwedGxvHAKvFdoeArzM
	2zRR49VlJg1SZRY5w4IsorRseLvlqu0X9kcmlOz+0wMAhDMwy3G52vI/8wxzT+5gEgUrFLuwbZh
	s9XX0=
X-Received: by 2002:a05:6102:f12:b0:7bb:64cc:1362 with SMTP id ada2fe7eead31-7d6cb5b7af0mr192385137.6.1795031938679;
        Wed, 18 Nov 2026 11:58:58 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b91e87f4sm2685571137.7.2026.11.18.11.58.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:58:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 13/16] profiles/ranging: Choose the CS antenna configuration from both ends
Date: Wed, 18 Nov 2026 14:58:41 -0500
Message-ID: <20261118195846.393710-14-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118195846.393710-1-luiz.dentz@gmail.com>
References: <20261118195846.393710-1-luiz.dentz@gmail.com>
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
index ad9c4c0feb9b..80379598d510 100644
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
@@ -841,6 +955,14 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 
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
@@ -861,6 +983,16 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
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
@@ -1992,6 +2124,7 @@ void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle)
 	sm->procedure_active = false;
 	sm->cs_role_known = false;
 	sm->sec_enable_pending = false;
+	sm->remote_caps_known = false;
 	sm->current_state = CS_STATE_UNSPECIFIED;
 }
 
-- 
2.56.0

