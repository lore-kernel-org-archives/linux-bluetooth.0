Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607568;
	b=Rb+jyIeq41YOgzkJ7Y9ZP0MzEVPwHsjy1JwocrsC7baSB+r1DYwpX4yfTrb+KYTyI5Yz
	 mDhEFvJajuUgyNowfAX00rntXB48f6z3dv+t4Dez2iuuMdTL289SaPdATos4dl4Ayf7qo
	 MIgtA0nZJxnlLXrB6NW1ZrAtQLSiIhnvYPLTiUA5QF4CSuIGVdXJStVpzWHjeGWNgNGFB
	 8MxnuVAJ09pCWCYF19g/axWqOunnMQZR9mkUTBFarBNo/vsm0qEN5NU4snGXaM2HbQRXy
	 TZznBm4ekIrXhCQPxbA2TJNQpjePSq5SO/lcPRMjypUxvs8v8AfphOk2LvDXCtzjiZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607568;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-QCInternal:X-QCInternal:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=SfaqOG+LUp+Kf2gvsVcvmOdkgOa8kGRlnI1+umsmAbU=;
	b=wc6EWVOqN5TPZGDvY3Q1Nu9Q83OWWPb8P67LmJvlapcu9vduHZYmaNEJBqabV9gZANl2
	 hn5/dvdfrCH2FMR7EqZ6kNNbPU1PsdW3wDztQvloovZyvyxAgx3n+xPA44sX4W0pKPCGb
	 Vkd7waP3lbGy5tAxJoacl+gF1B8Q1uCSfSXmtiWDGl36oU/4xAsXw23NOh2lb0628yebF
	 fk2IC+NW22kHJADNcA1N9rfWJ2u8U89i89FhUcAAs6mJr3u76KTs/vp0lMMWle+CMn/Lm
	 yCEqFCdOPQCqJ0ysMq958kT7zEFm3th7TZYwJ6xX4ImAIQlWghFccxhKrE9P50D4qVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l2fMZQrs;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EA8606A33A
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 08:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74EA8606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l2fMZQrs
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A23vJAh1676177
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=SfaqOG+LUp+
	Kf2gvsVcvmOdkgOa8kGRlnI1+umsmAbU=; b=l2fMZQrsJBZIyAk3uDXGYU8hlT4
	X417qmbjqGadI/sdlzPT1e1OD7u+PPsFmKbzhchAxLwsf907gyp4EkZX1l7+gjrY
	vM+40ukNz88jfkGguDRfOnzIAGlP/CbtwzDQa8Uf4fVzyLX0r6iDQ5NPrnHFVNk8
	56YqrHM808V7d9PKJ3TvJ1Qz2ocrF0p0qP/nHOKRNkPkSs4ZvKzp2cIo3gPPm6gH
	i4BDKZtfMbTyVCUiF8vSvYg04VYPW3z7IePCmL/GQ6SWOEOLwjM3yyyAzQFrKNa9
	1lfQ9zVhcDCch0LHczn1RBTxZ7aTuUcPDw+e3IZbQe9kAVpQmj2mz29ring==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8q7wv1x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 08:19:26 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A28JKnn3331062
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:24 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 6A28JJg43331043;
	Mon, 02 Nov 2026 08:19:24 +0000 (GMT)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH BlueZ 09/15] profiles/ranging: Take the CS role from Config Complete
Date: Mon,  2 Nov 2026 16:19:06 +0800
Message-ID: <20261102081913.1623864-10-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: CXt6GIQuXfVamg89616A55j0AuGCmT-0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX8QlvHoq5MfvN
 CfWml3KASu14CXFX0lPq3M2TKmLzhKjhBiTd11qbDPWowkpuqzhiALYtuOvmmA4Kddl8NTSvdPU
 r2HuzgQufd2bBOOJ2UE3o1nKT2XL+Io=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX9tISxdWLMktt
 ETV+Dql3ak0jpK3/E9pcRVggA2Cg0rFGclB3jnoyY94kS1rcuJg0DzDfoR/6uB39LdOmlqnisAI
 1FJHL74wBj6lFy2FaYWR6tgbi57PxyGuQLkwsTpxgyV3W3ov/yC3dwOhBSG/L3P7tuSlRq5RgJB
 CH4S8xKJpfo7pJxJ57UqpQloa1GGujWGunbNb3MJsC17kFb2LNFv7z7J/gN2bIN+RuN9scB8u2j
 fRka99F+lPUC+P2XJSi8Mx6n1yc5lSnoPLE8LDLrJdnqhgyij6DF02zB7q0OtlvKzF2GRIqqwms
 s2sd8MnnslhFJcJ65/N4lZ/Q54V1X6Z2mFTlF8UN4ufYJPn/kvLzBJ43GlwHoEmEZsfkYxqGu8b
 tdgfGfSlUEvFIVvKKEKD4fNa6Jk+AKucS/qT4lKOFbeI3W9zic6ZRMKF5iUaE/mb+3JFlK0k5oD
 oBGesGU5gBER5pLeiyQ==
X-Proofpoint-GUID: CXt6GIQuXfVamg89616A55j0AuGCmT-0
X-Authority-Analysis: v=2.4 cv=PucG/AM3 c=1 sm=1 tr=0 ts=6ae8478e cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=sBTt2lbyhS9PV3alP38A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020032

The LE CS Config Complete handler stored the CS role it reports in
cs_opt.role, overwriting the Role_Enable value set by StartMeasurement().
StartMeasurement() seeds its settings from that field, so a second call
without a role key sent Set Default Settings with the negotiated role
instead: 0x00 for an Initiator, which is not a valid Role_Enable, and
0x01, Initiator only, for a Reflector.

Keep the negotiated role in its own field, known only once Config
Complete has arrived, and report Role_Enable back to StartMeasurement().

With the Reflector now running the setup phase, StopMeasurement() can
also be reached on a Reflector whose procedure is running. Only the
Initiator enables a procedure, so do not send Procedure Enable from a
Reflector to stop it.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/ranging/rap_hci.c | 29 ++++++++++++++++++++---------
 src/shared/rap.h           |  1 -
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index f23e89cfe..ef01e60c5 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -75,6 +75,13 @@ struct cs_state_machine {
 	bool procedure_active;
 	struct bt_rap_hci_cs_options cs_opt;  /* Per-instance CS options */
 	uint8_t role_enable;  /* Role value for HCI commands (1, 2, or 3) */
+	/* Negotiated CS role for this config (CS_INITIATOR/CS_REFLECTOR), taken
+	 * from LE CS Config Complete. Unknown until that event arrives, which
+	 * is why it is kept apart from role_enable: the latter is the bitmask
+	 * of roles the host permits, not the role actually in use.
+	 */
+	uint8_t cs_role;
+	bool cs_role_known;
 	struct queue *conn_mappings;  /* Per-instance connection mappings */
 	uint16_t active_conn_handle;  /* current measurement handle */
 	struct timespec last_chan_class_time;  /* For 1-second rate limit */
@@ -129,7 +136,6 @@ bool bt_rap_set_default_settings_params(void *hci_sm,
 		return false;
 
 	sm->role_enable            = settings->role;
-	sm->cs_opt.role            = settings->role;
 	sm->cs_opt.cs_sync_ant_sel = settings->cs_sync_ant_sel;
 	sm->cs_opt.max_tx_power    = settings->max_tx_power;
 	return true;
@@ -167,7 +173,7 @@ bool bt_rap_get_default_settings_params(void *hci_sm,
 	if (!sm || !settings)
 		return false;
 
-	settings->role            = sm->cs_opt.role;
+	settings->role            = sm->role_enable;
 	settings->cs_sync_ant_sel = sm->cs_opt.cs_sync_ant_sel;
 	settings->max_tx_power    = sm->cs_opt.max_tx_power;
 	return true;
@@ -277,7 +283,7 @@ static void cs_state_machine_init(struct cs_state_machine *sm,
 
 	/* Store role_enable for HCI commands (1, 2, or 3 from config) */
 	sm->role_enable = role;
-	sm->cs_opt.role            = role;
+	sm->cs_role_known = false;
 	sm->cs_opt.cs_sync_ant_sel = cs_sync_ant_sel;
 	sm->cs_opt.max_tx_power    = max_tx_power;
 	sm->cs_opt.rtt_type        = 0;
@@ -956,7 +962,8 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 		return;
 	}
 
-	sm->cs_opt.role = rap_ev.role;
+	sm->cs_role = rap_ev.role;
+	sm->cs_role_known = true;
 	sm->cs_opt.rtt_type = rap_ev.rtt_type;
 
 	DBG("config_id=%u, action=%u, ",
@@ -1042,7 +1049,7 @@ static void rap_cs_sec_enable_cmplt_evt(const void *data, uint8_t size,
 		cs_set_state(sm, CS_STATE_WAIT_PROC_CMPLT);
 
 		/* Check if role is initiator */
-		if (sm->cs_opt.role == CS_INITIATOR) {
+		if (sm->cs_role_known && sm->cs_role == CS_INITIATOR) {
 			DBG("Initiator role: Sending CS Set Procedure Params");
 			if (!rap_send_hci_cs_set_procedure_parameters(
 							sm, handle)) {
@@ -1516,7 +1523,7 @@ static void rap_cs_subevt_result_evt(const void *data, uint8_t size,
 		return;
 	}
 
-	cs_role = sm->cs_opt.role;
+	cs_role = sm->cs_role;
 	cs_rtt_type = sm->cs_opt.rtt_type;
 	max_paths = MIN((num_ant_paths + 1), CS_MAX_ANT_PATHS);
 	steps = MIN(num_steps_reported, CS_MAX_STEPS);
@@ -1608,7 +1615,7 @@ static void rap_cs_subevt_result_cont_evt(const void *data, uint8_t size,
 		return;
 	}
 
-	cs_role = sm->cs_opt.role;
+	cs_role = sm->cs_role;
 	cs_rtt_type = sm->cs_opt.rtt_type;
 	max_paths = MIN((num_ant_paths + 1), CS_MAX_ANT_PATHS);
 	steps = MIN(num_steps_reported, CS_MAX_STEPS);
@@ -1832,9 +1839,12 @@ bool bt_rap_stop_measurement(void *hci_sm)
 	 * there is nothing to disable, and the Controller answers Procedure
 	 * Enable with Invalid HCI Command Parameters. A procedure that is
 	 * being enabled has not reported yet, so still disable that one.
+	 * Only the Initiator enables a procedure, so the same holds for a
+	 * Reflector once the Initiator's procedure is running.
 	 */
-	if (!sm->procedure_active &&
-			cs_get_current_state(sm) != CS_STATE_WAIT_PROC_CMPLT) {
+	if ((!sm->procedure_active &&
+			cs_get_current_state(sm) != CS_STATE_WAIT_PROC_CMPLT) ||
+			!sm->cs_role_known || sm->cs_role != CS_INITIATOR) {
 		DBG("No local CS procedure active, nothing to disable");
 		return true;
 	}
@@ -1891,6 +1901,7 @@ void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle)
 	DBG("Clearing connection mapping: handle=0x%04X", handle);
 	remove_conn_mapping(sm, handle);
 	sm->procedure_active = false;
+	sm->cs_role_known = false;
 	sm->current_state = CS_STATE_UNSPECIFIED;
 }
 
diff --git a/src/shared/rap.h b/src/shared/rap.h
index 7ee51143c..7ff5de227 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -19,7 +19,6 @@ struct bt_att;
 
 /* Channel Sounding Events */
 struct bt_rap_hci_cs_options {
-	uint8_t role;
 	uint8_t cs_sync_ant_sel;
 	int8_t max_tx_power;
 	int rtt_type;
-- 
2.43.0

