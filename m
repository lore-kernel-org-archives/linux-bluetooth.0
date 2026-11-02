Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607569;
	b=zo/YJ6Jjkot4Dx8/j1m0tD4JAzGmpynVmUq5E4CmxlwrGhjiiDxoJenxPaD5g5BOl9Qh
	 lLrgR1bYs08PlfDrotAii7VB5UBsyE7HcvS7KRXi9CeeTWURg9ypzjOpqlgw/qKwJX/R6
	 rVV489kwqR9IiC38YJFIElpKiCJFV7RhWPOvUmBFIo/9M0N+NgiLYkYXcb5CDNOBYK7RG
	 4QGhCIKJOA1+Cxe8KmrDtoMeYSAyvHOygfTOFOUfIQf/EyuAj+7WdIcqetEogMHb+EHuG
	 yOLr0VnDKaMQ6Cd6qQIWfOimU5lIlO23WZVU8GLOM0UGPXu67z017gSQvw8ZLQYr4xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607569;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-QCInternal:X-QCInternal:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=wqY8e4lLnc8kk/v1XEiUJG/ll5xuGW3vDBQxp0IXIjs=;
	b=dQRT8l4YWhaz6x3q6szC1ase3nQSxnC3heqvPB3DMXMXSz4prrTsQ7DiESyYauwk7quZ
	 GlrF4vln5s4xi++8b4REb4MLi3N7qagysUSlE/kH6eWj5jdUj+L0RNPDU52MPy16VJKWR
	 8/oFjOcy590SYt7tZJ3QHEH4VInS3seWsrzieFFbtUKSFHYYM89EplEbkGQEAGe66mK6C
	 aohMkW68141xh7VcFaiYE9BWWdLXXsnUiE5j8cixRptM1cE0foR/y4jOI2BFy6VN/HPrA
	 B/6VXW/HOTRbyUmRjByazeaOosP/GdM/msUUywL04ga7xztDOZ8KhFDZlV06nGLEr6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Wx7vaUn8;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3759606A337
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 08:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3759606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Wx7vaUn8
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A23vMTE1676249
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wqY8e4lLnc8
	kk/v1XEiUJG/ll5xuGW3vDBQxp0IXIjs=; b=Wx7vaUn8zBLIMpOcUOJen1ud7PQ
	/Jg5EUsfav9VjLk6JbbdJ8nvyFR3R6U4gUmtL+ELRtkm2485BLNTkCKJOgTyDV6O
	ep3FOnBfIoGlBvS+JU32lXJshjt9F9VNr+Vo7WJ6WdGtnw4W9sOl0N7Y1sdKTzdU
	9XmGYCewwUhkhzRxd210jOLKFEt5NESxry8P+xvE2HJsjm86vmQHLCfZLJxquIte
	GnoE9RhbSEPy5+lsMkVsqNmcEouwVU2vduuEUZFxfhv+fctZFJMbF+NkXY3Sq7MO
	5q+9X1H0Xe3+RQYATbZP+wjXksoCZuKHPte8efZmkYWEQYhLbnvNzPHgUdA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8q7wv25-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 08:19:27 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A28JKLQ3331053
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:25 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 6A28JJg73331043;
	Mon, 02 Nov 2026 08:19:25 +0000 (GMT)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH BlueZ 12/15] profiles/ranging: Defer CS Security Enable until the link is encrypted
Date: Mon,  2 Nov 2026 16:19:09 +0800
Message-ID: <20261102081913.1623864-13-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: iabltZXRFy1MrYyvXZ3L3bewtTvcfkBa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfXwDOQEdLd9iNL
 11qJBlfpptwTp66scEkNppn5hrxy/JOkJ2ZWU0nClqMVp+ynDnqpGlj3TdinzHZViHhDA4+yZCX
 rgJGsvqmRO3qKodGJXMQ38aa8uWUgnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX6kh4eaUi0a/m
 Xm53urFECn3GJYPCcUdBwBaF0RSLNAQTBcuQHBDpq027z8T8pa/HtM7VCGfBL3NV3VlWXWyhv4n
 MpmMvOWDrTtib0oMrxOgzOUbEdrUgAtbpCOfbdM6My87dDA03HLf2QFK5qq9zG/IL9PQVDgQ65Q
 dbaA9WN3Bee0PK2n2h1OpQgNqUvbNS78dF7W5uDQ3mYSLF8HdfAF2CTzz8Yo5hDxCW/JZ34HKur
 CvptIje43wmW26vo1TG+DjGkMngETK6CQXCgfuOqTTiEPLqcwKZa88uOacYCEI1HOT0G0OU6s3I
 HZzYEGVHmAU3kv2JIFv5x0EKpEyT4QNk661RgHFM7Pb5T6Nlt8bc1s4Q4MD/fdLmvTt0Sd1QlP9
 BXbPsUE9uBqtwnsWSj0tUAQ7FsZ9y3MrUcHQe6u/EXjTStWyQ3hgu7w4oUmPbVOojktLh51dDlx
 octlAIzuFQIN1ffL+DA==
X-Proofpoint-GUID: iabltZXRFy1MrYyvXZ3L3bewtTvcfkBa
X-Authority-Analysis: v=2.4 cv=PucG/AM3 c=1 sm=1 tr=0 ts=6ae8478f cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=SUGFAPlK5396kY8RcVQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020032

LE CS Security Enable is only valid on an encrypted link (Core v6.2
Vol 4 Part E 7.8.133, which fails it with Insufficient Security
otherwise). On the Central, the Config Complete handler checked the ATT
security level once and put the state machine on hold if the link was
not yet encrypted, so a configuration completing before encryption
never got its Security Enable.

Defer the command instead and send it when the HCI Encryption Change
event reports the link as encrypted. Track the encryption in the
connection mapping, so the check no longer depends only on an ATT
instance being attached, and keep the ATT security level as a fallback
for a link that was encrypted before the state machine was attached.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/ranging/rap_hci.c | 78 +++++++++++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 13 deletions(-)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 8ce7f32f1..2e7f216aa 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -75,6 +75,8 @@ struct cs_state_machine {
 	bool procedure_active;
 	struct bt_rap_hci_cs_options cs_opt;  /* Per-instance CS options */
 	uint8_t role_enable;  /* Role value for HCI commands (1, 2, or 3) */
+	bool sec_enable_pending;  /* Security Enable deferred until encrypted */
+	unsigned int encrypt_evt_id;  /* Encryption Change registration */
 	/* Negotiated CS role for this config (CS_INITIATOR/CS_REFLECTOR), taken
 	 * from LE CS Config Complete. Unknown until that event arrives, which
 	 * is why it is kept apart from role_enable: the latter is the bitmask
@@ -99,6 +101,7 @@ struct rap_conn_mapping {
 	uint8_t bdaddr[6];
 	uint8_t bdaddr_type;
 	bool is_central;  /* true if local device is BLE Central on this link */
+	bool encrypted;  /* set from the HCI Encryption Change event */
 	struct bt_att *att;
 	struct bt_rap *rap;
 };
@@ -905,7 +908,8 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 	 * the ones for other links: acting on them would overwrite this
 	 * link's negotiated role and advance its state.
 	 */
-	if (!find_mapping_by_handle(sm, evt->handle)) {
+	mapping = find_mapping_by_handle(sm, evt->handle);
+	if (!mapping) {
 		DBG("Not for this link, ignoring");
 		return;
 	}
@@ -1013,26 +1017,62 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 	/* Success - proceed to Security enable complete */
 	cs_set_state(sm, CS_STATE_WAIT_SEC_CMPLT);
 
-	/* CS Security Enable may only be issued by the BLE Central */
-	mapping = find_mapping_by_handle(sm, evt->handle);
-	if (mapping && mapping->is_central) {
-		if (bt_att_get_security(mapping->att, NULL) <
-						BT_ATT_SECURITY_MEDIUM) {
-			error("CS Security Enable skipped: not encrypted");
-			cs_set_state(sm, CS_STATE_HOLD);
-			return;
-		}
-
+	/* CS Security Enable may only be issued by the BLE Central, and only on
+	 * an encrypted link. The LE role comes from the connection mapping
+	 * (set from the LE connection event), not from the CS role in rap_ev.
+	 * If the link is not encrypted yet, defer: the Encryption Change event
+	 * retries it (rap_encrypt_change_evt).
+	 */
+	if (!mapping->is_central) {
+		/* Peripheral link: the Central's Link Layer starts CS Security
+		 * Start (Core v6.2 Vol 6 Part B 5.1.23). The local controller
+		 * reports completion with LE CS Security Enable Complete when
+		 * it responds to the peer's request (Vol 4 Part E 7.7.65.41),
+		 * and that event continues the procedure. Do not stop here.
+		 */
+		DBG("Peripheral link: waiting for peer CS Security Start");
+		sm->sec_enable_pending = false;
+	} else if (mapping->encrypted ||
+			(mapping->att && bt_att_get_security(mapping->att,
+					NULL) >= BT_ATT_SECURITY_MEDIUM)) {
 		DBG("Central,encrypted: Sending CS Security Enable command");
 		rap_send_hci_cs_security_enable_command(sm, evt->handle);
 	} else {
-		DBG("Peripheral: Waiting for security enable event...");
+		DBG("Central, not yet encrypted: deferring CS Security Enable");
+		sm->sec_enable_pending = true;
 	}
 
 	/* Send callback to RAP Profile */
 	bt_rap_hci_cs_config_complete_callback(size, &rap_ev, sm->rap);
 }
 
+static void rap_encrypt_change_evt(const void *data, uint8_t size,
+					void *user_data)
+{
+	struct cs_state_machine *sm = user_data;
+	const struct bt_hci_evt_encrypt_change *evt = data;
+	struct rap_conn_mapping *mapping;
+	uint16_t handle;
+
+	if (!sm || size < sizeof(*evt) || evt->status != 0)
+		return;
+
+	handle = le16_to_cpu(evt->handle);
+	mapping = find_mapping_by_handle(sm, handle);
+	if (!mapping)
+		return;
+
+	mapping->encrypted = (evt->encr_mode != 0x00);
+
+	if (!sm->sec_enable_pending || !mapping->is_central ||
+						!mapping->encrypted)
+		return;
+
+	DBG("Encrypted: sending deferred CS Security Enable");
+	sm->sec_enable_pending = false;
+	rap_send_hci_cs_security_enable_command(sm, handle);
+}
+
 static void rap_cs_sec_enable_cmplt_evt(const void *data, uint8_t size,
 					 void *user_data)
 {
@@ -1802,6 +1842,14 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 		queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
 	}
 
+	/* Encryption Change is a plain HCI event; it lets a deferred CS
+	 * Security Enable be sent once the link is encrypted.
+	 */
+	sm->encrypt_evt_id = bt_hci_register(hci, BT_HCI_EVT_ENCRYPT_CHANGE,
+					rap_encrypt_change_evt, sm, NULL);
+	if (!sm->encrypt_evt_id)
+		error("Failed to register Encryption Change handler");
+
 	DBG("HCI state machine attached (role=%u, ant=0x%02x, power=%d)",
 		sm->role_enable, sm->cs_opt.cs_sync_ant_sel,
 		sm->cs_opt.max_tx_power);
@@ -1940,6 +1988,7 @@ void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle)
 	remove_conn_mapping(sm, handle);
 	sm->procedure_active = false;
 	sm->cs_role_known = false;
+	sm->sec_enable_pending = false;
 	sm->current_state = CS_STATE_UNSPECIFIED;
 }
 
@@ -1988,9 +2037,12 @@ void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm)
 	/* Cleanup the per-instance state machine */
 	if (sm) {
 		/* Unregister HCI events */
-		if (sm->hci)
+		if (sm->hci) {
 			queue_foreach(sm->event_ids, unregister_event_id,
 								sm->hci);
+			if (sm->encrypt_evt_id)
+				bt_hci_unregister(sm->hci, sm->encrypt_evt_id);
+		}
 
 		if (sm->measurement_timeout_id) {
 			timeout_remove(sm->measurement_timeout_id);
-- 
2.43.0

