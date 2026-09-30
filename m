Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D0A3921ED
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 05:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790747137; cv=none; b=WyruhiZUTKz3C1OfQSo/Q3ulikpU0/AbJypSUEp9SQnsy84Xtv/3kuYeDcN1KtCl1kILjSMGWFY8WTqGkbA3YpG/i5jTOmMYwFc+9Xaubs4yxRBG7CxtYszQutnNvh+JkVgVMG7HkM4bQQcbCpHWh3k+8YIYv+mpYfiNhkLXh4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790747137; c=relaxed/simple;
	bh=PnHqpmJ4G2zNvU+eht3F6PrPhLPcnjGnEWE0nVojFMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TOZv28XpjmC++0cg8pfBJ/MYkPyfaVhF6L6UwoBce5zBgn41S8AwULoKXvde4PsGkax9rdsGGZNNJ7d2+7CzxarGOeKEdOgc8NIUtCBRB5VlquEH+r8jvmrYlTG4YRCWYX7uekiH0Ufy7xyLgapetiHmCVd7B4XV1zJYZbhsBCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ItvxVuTc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ItvxVuTc"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TNQK9P484483
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 05:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ZKlSEGiy+KrHAgY4sXIhNPgUxzPD0FyVduY
	rV1m1NQE=; b=ItvxVuTcs/V2j730SHv01x9HaKKiE8Ac6Sq25WVVlKbevrde/ia
	rst63lAhJvxTE9h6RV1lsZoR8jKCZpu0KfLdPm9/LcwmytfvElJLEbW0Qyz+6v29
	Yl5l3sgmHidNQGJMF0XBSZ0u6gzzpaL1CirNVRSOMUJ3D/WGb+g+ifkKUlhbMn5U
	fK5pOebtVhKqfFVp17OSUsL16QBAUzOZbrjC1GaBYOBNrejMI7RueW67QE9rFb1a
	eirEZXKgaEeTvvEqqw34tcW4z0K5Kaf2teDW8JMjxB4XSyHSmA6brL/t5CAT/CCd
	r4azGOxGZZPEXA3HloVX71Mozu1ymjFZgiQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0dsx3yyj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 05:45:34 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68U5jWrh206957;
	Wed, 30 Sep 2026 05:45:32 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 68U5jWmb206951
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 05:45:32 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 5B58343505; Wed, 30 Sep 2026 13:45:31 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH] ranging: Route CS subevent results by connection and configuration
Date: Wed, 30 Sep 2026 13:45:28 +0800
Message-ID: <20260930054528.2258948-1-cheng.jiang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyMiBTYWx0ZWRfX8UYm71Wp6JyZ
 opWFNUpjBfaD5eFlvklUm9tSkstgf6QNTaydqvICTce0KreJ7zMzhnrtJbB6WF2e/wvGKWb/i29
 EHgQHyJ5J+r/W2LzCFxiQjaj3blArSX3Y/O2MIStocBQlLmKCrFhKG5E42+RQOI3E5VFlizfmds
 iXs5G+498rMQ1d6nkeM6fYq/Y4UKZF5uGeJuzBu3bOXa+rlKtSjTDJaii5XfGHarCPN+YgLOg58
 4aSMRTJzyViujjZ8mmvC8I4hWCrtSTfaj58My1UMiR5OUwFjpGBkuaXhzfmoaaeclsMK8JLIYzl
 Ke6CL0J9vN7QL+uDhKJaU3h2dSFiWyXUC8MK4KPi62v8Fc6J/akB+NITN7fS3ZQJbZsbjTR/zBW
 6uHGoyGa5ASRDS6QQVWL67tXek0MiA5w1golYe8vP9BVSXgzVBOM2uMT2pKzT3LZ9Pi4cJsmxv1
 OstkPPs8Y04mlVplpzQ==
X-Proofpoint-ORIG-GUID: 7NpklXy_8v4cvGNOVZZVBwwb0XjlBYTt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyMiBTYWx0ZWRfXyt1SnRcbONEX
 VAq2WfCgLXIIJ0chESh5Ib+wknIsexNz241/POi9Fgdkjlm1Pt1pcuQoc2huCHL2DD7/P8v06lz
 5EhKCFI0l4DBgg2yYVpzGF5DRU5zPv8=
X-Proofpoint-GUID: 7NpklXy_8v4cvGNOVZZVBwwb0XjlBYTt
X-Authority-Analysis: v=2.4 cv=DqvDa2/+ c=1 sm=1 tr=0 ts=6abca1ff cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=ugJ-K1IX9m-DhwbvJJgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300022

bt_rap_attach_hci() allocates a state machine per device and registers the
CS subevent handlers of each one on the shared bt_hci. LE Meta subevents
are dispatched with queue_foreach() over every registered handler, so each
CS Subevent Result is delivered to all of them, not only to the device the
event belongs to.

The Subevent Result and Subevent Result Continue handlers then passed their
own sm->rap on without checking which connection reported the event, unlike
every other handler in rap_hci.c, which resolves it with
find_mapping_by_handle() and returns when the connection is not its own.
The Connection_Handle was parsed into the event and never read again, in
rap_hci.c or in shared/rap.c.

With two CS connections up, one set of ranging data was therefore consumed
by both sessions and sent out over both peers' RAS characteristics. Resolve
the mapping and drop the subevent when the connection is not tracked.

handle_local_subevent_result() and parse_cs_local_initiator_data() also
took a config_id they never checked against the tracked one, so subevents
belonging to a second CS configuration on the same connection were
appended to the procedure of the first. Ignore a subevent whose config_id
does not match the tracker, once the tracker has one.

Assisted-by: Claude:claude-opus-4.8
---
 profiles/ranging/rap_hci.c | 16 ++++++++++++++--
 src/shared/rap.c           | 22 ++++++++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 66bc7b5eb..c472cedc9 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -1478,6 +1478,7 @@ static void rap_cs_subevt_result_evt(const void *data, uint8_t size,
 {
 	struct cs_state_machine *sm = (struct cs_state_machine *) user_data;
 	struct rap_ev_cs_subevent_result *rap_ev;
+	struct rap_conn_mapping *mapping;
 	struct iovec iov;
 	uint8_t cs_role;
 	uint8_t cs_rtt_type;
@@ -1563,7 +1564,12 @@ static void rap_cs_subevt_result_evt(const void *data, uint8_t size,
 			offsetof(struct rap_ev_cs_subevent_result, step_data));
 
 	DBG("CS subevent result processed: %zu bytes, ", send_len);
-	bt_rap_hci_cs_subevent_result_callback(send_len, rap_ev, sm->rap);
+	mapping = find_mapping_by_handle(sm, handle);
+	if (mapping && mapping->rap)
+		bt_rap_hci_cs_subevent_result_callback(send_len, rap_ev,
+							mapping->rap);
+	else
+		DBG("No RAP mapping for handle 0x%04X, ignoring", handle);
 	free(rap_ev);
 }
 
@@ -1572,6 +1578,7 @@ static void rap_cs_subevt_result_cont_evt(const void *data, uint8_t size,
 {
 	struct cs_state_machine *sm = (struct cs_state_machine *) user_data;
 	struct rap_ev_cs_subevent_result_cont *rap_ev;
+	struct rap_conn_mapping *mapping;
 	struct iovec iov;
 	uint8_t cs_role;
 	uint8_t cs_rtt_type;
@@ -1646,7 +1653,12 @@ static void rap_cs_subevt_result_cont_evt(const void *data, uint8_t size,
 							step_data));
 
 	DBG("CS subevent result cont processed: %zu bytes, ", send_len);
-	bt_rap_hci_cs_subevent_result_cont_callback(send_len, rap_ev, sm->rap);
+	mapping = find_mapping_by_handle(sm, handle);
+	if (mapping && mapping->rap)
+		bt_rap_hci_cs_subevent_result_cont_callback(send_len, rap_ev,
+							mapping->rap);
+	else
+		DBG("No RAP mapping for handle 0x%04X, ignoring", handle);
 	free(rap_ev);
 }
 
diff --git a/src/shared/rap.c b/src/shared/rap.c
index c0305a9e3..765ab11c2 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -2721,6 +2721,18 @@ static void handle_local_subevent_result(struct bt_rap *rap,
 
 	resptracker = rap->resptracker;
 
+	/* A connection can hold several CS configurations at once. Only the one
+	 * the responder tracker was set up for by CS Config Complete may feed
+	 * this procedure, otherwise subevents of a different configuration
+	 * would be appended to the same ranging data.
+	 */
+	if (resptracker->config_id != CS_INVALID_CONFIG_ID &&
+			resptracker->config_id != config_id) {
+		DBG(rap, "Ignoring subevent for config_id %u (tracking %u)",
+			config_id, resptracker->config_id);
+		return;
+	}
+
 	if (resptracker->current_proc) {
 		struct cs_procedure_data *cur = resptracker->current_proc;
 
@@ -2995,6 +3007,16 @@ static void parse_cs_local_initiator_data(struct bt_rap *rap,
 	struct cs_proc_state *state;
 	struct bcs_procedure_data *bcs;
 
+	/* Same as the responder side: only the tracked CS configuration may
+	 * contribute steps to this procedure.
+	 */
+	if (reqtracker->config_id != CS_INVALID_CONFIG_ID &&
+			reqtracker->config_id != config_id) {
+		DBG(rap, "Ignoring subevent for config_id %u (tracking %u)",
+			config_id, reqtracker->config_id);
+		return;
+	}
+
 	effective_counter = has_header_fields ? proc_counter
 					      : reqtracker->last_proc_counter;
 
-- 
2.43.0

