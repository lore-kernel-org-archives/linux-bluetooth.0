Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607570;
	b=PftksexUu0Y65bwSmCBrilhp0CBe79/SgvIUfHQXTGytLI/5aBKDD+UNsym/jEU0FFy7
	 0rxL0cmuh8bvPCRzJ4+DdSdTenMEqzcjIg4A47qRaUD/F6CtlGClwAPOBYg8kAfqS1evv
	 KekY4P4h12ibGSecBwxSJiqX9WdJdqUKx2lnldyn4JfL/R0ZdUfYD8J3AQPU8TrBPudkB
	 b74Afw9423iAS3DtUtAfiZSufs+lmqWGcxDiSpukAfqLqm0VmaqxkHk5punM0LwN3vQB/
	 EEBW+tyDCbwsSwG8WngLhVoO2Xj6L0Pa48d2mSBVqomukLJ4ovvAX33wtc9oVcuu3rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607570;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-QCInternal:X-QCInternal:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=oCFgv/g0kNzGxrV/wF5e0lncoaflaDjAxTJQfZO1VZo=;
	b=KkHpQJlHIu/Npmo5fa4XdYJcXTet4ms6Z48O0dTNYA6DPBBRcBKfMWTl//62XFvYoVKK
	 L+PR01j6kJLBE2gQ3KNAgWMKDiaNYxaCxox7BrDJ7in/pxl13JkTuDWwOfPha774LU+XS
	 jVUfxl83cc4xBvC8vryTnbxcn6AlZJVFJNpmasCb7R/0x3SCOBXE2VmGw6/l/gluqi1yg
	 EO8fRen68Q4w/wBvr0iwtPs+/BJk/Nrl4nMgFUrYfVnfQf6eMCLGZuDYvSxqP0jWUkFyV
	 4MWKFXbR7AKe16BqLbFELYQz/bRbDrZ0jP4Uk1z496+9MDLIZBEijVH48LX1bs9SbfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="X0o9Uir/";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9812E606A33D
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 08:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9812E606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X0o9Uir/
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A27qgEU3863014
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=oCFgv/g0kNz
	GxrV/wF5e0lncoaflaDjAxTJQfZO1VZo=; b=X0o9Uir/Ec7VrwdO6SgKKv6XAwZ
	ld/lef7I2DhaHo0QZF3NuFL1VOpDPXh0hQImSzGAPOWMwq+Ttzb6xduh0XJKIbqA
	KuSbrVFn/uHPFobKMHKZoAdoiPUcYubMwJmW+05pgycQTxoxcpE01+Tqtn7bXlBu
	JET/frDWDl2l0/UOF9oVwK8J36amyyr6dl2Rw+hSO+NIzIElsFSSI+x2qzkFuaW6
	QPOTZP/c0kM4u37o0ARGulOQf6yNN0wJ7Av2TmawRJqFUc1RIf5fByaIG2rp6HrY
	yVvNfEC4+W+Kh8Nt9E0HbH+F1P6gL0OjJwHss9WOYLjx/FhGQJnHZ5PAD6A==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpph183m9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 08:19:28 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A28JLF33331094
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:25 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 6A28JJg83331043;
	Mon, 02 Nov 2026 08:19:25 +0000 (GMT)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH BlueZ 13/15] profiles/ranging: Choose the CS antenna configuration from both ends
Date: Mon,  2 Nov 2026 16:19:10 +0800
Message-ID: <20261102081913.1623864-14-cheng.jiang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102081913.1623864-1-cheng.jiang@oss.qualcomm.com>
References: <20261102081913.1623864-1-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: Gp_IIA7Sfx9Wrh698MWkXeuEk8B1UEGK
X-Authority-Analysis: v=2.4 cv=IruL47/g c=1 sm=1 tr=0 ts=6ae84790 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=a4-2IXoX8E5-LTlficEA:9
X-Proofpoint-ORIG-GUID: Gp_IIA7Sfx9Wrh698MWkXeuEk8B1UEGK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX0oWXwjmKeoZn
 TtqiRNxNkzvi87ho+oSdm4gVisaCVzrtTF3ULEngxgm8Hp37S58at3ByD5UPQX86z+kvB4xQqu/
 qG+mgwviB+yrxPQm4XscePbtGlyOC7Q06og7Tffg1r7ZkYDNcLyfOSV5q1P1pw5TqQaUiEueTQX
 s6DL9vDeQ6yynjGkspHcjCiQv36LPJbyJ0dfhB7he7/7ProkA7E2JShogVkOZXTBbY4K0A5Gwmd
 ovHGuIUFP/1l8sSvqRolgXecV35Er9e9HmipxX42cAnxGGqMVTm8zUUNZcbMixsy4nBLLccxcbR
 ZwETdy5Hxk8W9bIzyw8wc136ojWzClNXgLU6phIeSoV9g0VgBNfUFdsZSLK2kOIdCAIRgqZQhtM
 3LMYoAOxvwr2u9FFaUq6qpcOTRSO9I0C4u75d2dzPZpsgW65LW8FFR4emqJSOLJkY5FslyTOXIR
 YFD1rEb3CrDhFGrxX9A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX/N5oYyMFdFuK
 KlpthobZ/UXyLIeZalLH80/RpVgwNERsK6OOajmSYH8KswaEFjyCud+lbwup50dPchccWQXEqpL
 f6P1EUex8wDRLga1g6hq7xKfRjfL6Rs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020032

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
 profiles/ranging/rap_hci.c | 125 +++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 2e7f216aa..4a1a2ad5e 100644
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
@@ -624,6 +637,104 @@ static void rap_send_hci_cs_security_enable_command(
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
@@ -635,6 +746,9 @@ static bool rap_send_hci_cs_set_procedure_parameters(
 		return false;
 	}
 
+	if (!cs_select_antenna_config(sm))
+		return false;
+
 	DBG("Sending CS Set Procedure Parameters for handle 0x%04X", handle);
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -864,6 +978,16 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
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
@@ -1989,6 +2113,7 @@ void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle)
 	sm->procedure_active = false;
 	sm->cs_role_known = false;
 	sm->sec_enable_pending = false;
+	sm->remote_caps_known = false;
 	sm->current_state = CS_STATE_UNSPECIFIED;
 }
 
-- 
2.43.0

