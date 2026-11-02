Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607569;
	b=a/bzXQ1E6aECEe5gQr/yFZ834oQIZMz4+S5aC11TDqWRl9px1ixp67pOfWT2/R8VEhvz
	 xoF3nWLeyS+hdC0/XVviM9U37I1+gmY+O338NXrxcg2IayAJVaaXVaX/pKlkxsGUssdUR
	 Xt6GYQE0A2xK7T9AakXbRlArZLBF1UZLJbw1ibvDNR2HCft8DUS4SwNovgu7vcnAE4/aO
	 Li7+MI6Ek7ThSVa6QoiIK6OR/J+NfFaze23wDm/WdcSNzZi3YI+w0JzEtyJsej3fjNgcb
	 nHgbftmFiRNh6ZRlqdsf3Dq/EOkuPpfC3TcsOweFuMmvTGqNp7Chfs+TDqExqsNjN9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607569;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-QCInternal:X-QCInternal:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pJQpsfzLbuk06O9gkiqs8k3oc+dQV81r+jSHKgq7h6A=;
	b=NkdJrpYyGRnLaB74m1OiRDWHqJosiBrAU1feS41DRDQHRX6K6HGbebO4+0oUa5YLV8x7
	 TjyDvR5U/x3rFWbFxQYsngP6BT2tcVnch/vNAXPHWzBlFc5N8AADjG6iXHIXjPXwt0NcU
	 xuwOuAIico+8Mkhyj7zvX04E8WIPT7vAy0pBRegPifDoCgL+BSioV/sA5MYT/5ylio+wP
	 AZwX3nt5Y/y0HQRRXQHWzMmWAfgQg5IXCC4t3rWOskxeIdxfXtBzTGFy8/YYzB575peMG
	 koBCvoKb5SKJXmik+vkDDWWECTkuiLlpd+1yAKVp0o/2cjF5Gao8ayGCxOToMIDo2sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="jZP6yU0/";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B571E606A33C
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 08:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B571E606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jZP6yU0/
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A25VssX3924175
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pJQpsfzLbuk
	06O9gkiqs8k3oc+dQV81r+jSHKgq7h6A=; b=jZP6yU0/w1DWEhHfqLLGj0pW3px
	PT+9vuC4suIi9vQBWMyFXDjceQXw0RiMeduPjl8aRBFXzu21FmjNNgVliQS4QUV/
	5TVIgh1HazaAZae1vAcK80xSxWxMP2Bzku0wX62kJ8wI32OMQgbvbDZE04AEi4dP
	fJ08uXlCQFosrGUMHXkVzSR1bgfxxPfG0Xd/0ja+f2iwIXlZiPixGhbXFz2OdiXx
	+/Q31esKfHWlQaSL/iQf+zqspRngbJCG49dC3pXD446YrYVsqg4n1yEWG919iyXz
	t3XlJLzSk4R5juTVc3x6GTdf1krlHQdBhEs3xovEwMgilyRbBtmNINNKb1Q==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpmf1rjyk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 08:19:27 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A28JLF43331094
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:26 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 6A28JJg93331043;
	Mon, 02 Nov 2026 08:19:26 +0000 (GMT)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH BlueZ 14/15] profiles/ranging: Do not start a procedure after StopMeasurement()
Date: Mon,  2 Nov 2026 16:19:11 +0800
Message-ID: <20261102081913.1623864-15-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: e1JEkil8XijYSuNpldCTafffKXrkQ0wn
X-Authority-Analysis: v=2.4 cv=bNaDs/+Z c=1 sm=1 tr=0 ts=6ae84790 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=--amN2WtOwgMHww60s8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX2qCvZPpBa7yQ
 7iGwuZpONDPko/F0y0VZzUi0GGnSb1kS6XnbT5ONKIsZ6MbXZ7tjpsOMDSi7AUeUG3KSOGqkoh4
 bI6zcZzzgQBnWmjJu0gR3J0m4XacUfEd4mH/7Lx9uNnTiRmVQrveUmA1M0FIjOjLVY9TovCNRbO
 2tJETMmGcNjjdczdrarsIeefN4RmOVFa4bSedJ/A8tObDDpCq7fYci5wsj/F6zReJ0ar/wTe1a2
 0w8eb2XNISoFfhaISGyNKDKl+KGYNXq2DknxdCs+ovne2Nfe5e2FTidhhYmVu5MEypMpFxAXt0x
 7dRBRgYvkfaW3wttn2BkaRbrLkhX8Zjpj5Ojii56R/Aia+vkRBmRAfPvzdcAiC+9GUzjETY71G6
 93UITskQ25rr6SnzjCXHvrv7vFLvtXVbx1kUd5chZ0Ys0JQg9urRjCgbnKwcCJNt8o2oIu1VWI4
 0X+Nahc2tDXCuS0ac7Q==
X-Proofpoint-GUID: e1JEkil8XijYSuNpldCTafffKXrkQ0wn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX9vB193dTLMcJ
 sCkyEtsRmuTAldaLsE/V6clWFZzZ8GDZupE99WNLSIqnKHJc252foqj9v0Fq4bIXS1JuUXtg+DX
 62JNr6Rdf5+wulyGJUTqkn4DP6HF4L8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020032

StopMeasurement() during the setup phase, or the measurement duration
expiring there, found no procedure to disable and returned without
touching the setup. The pending Set Default Settings response, Config
Complete and Security Enable Complete still arrived, and the Initiator
went on to create a configuration and enable a procedure that nobody
was waiting for any more.

Remember that a stop was requested until the next StartMeasurement(),
and while it is set do not send Create Config, and do not send Set
Procedure Parameters and Procedure Enable as the Initiator.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/ranging/rap_hci.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 4a1a2ad5e..04ea0d7a4 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -73,6 +73,7 @@ struct cs_state_machine {
 	unsigned int measurement_timeout_id;
 	bool initiator;
 	bool procedure_active;
+	bool stop_requested;  /* StopMeasurement() since StartMeasurement() */
 	struct bt_rap_hci_cs_options cs_opt;  /* Per-instance CS options */
 	uint8_t role_enable;  /* Role value for HCI commands (1, 2, or 3) */
 	bool sec_enable_pending;  /* Security Enable deferred until encrypted */
@@ -568,7 +569,9 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 		/* Only the Initiator creates the config; the Reflector waits
 		 * for its own CS Config Complete.
 		 */
-		if (cs_local_is_initiator(sm))
+		if (sm->stop_requested)
+			DBG("Measurement stopped during setup, no config");
+		else if (cs_local_is_initiator(sm))
 			rap_send_hci_cs_create_config_command(sm, rp->handle);
 		else
 			DBG("Reflector role: Waiting for CS Config Completed");
@@ -1252,6 +1255,15 @@ static void rap_cs_sec_enable_cmplt_evt(const void *data, uint8_t size,
 
 		/* Check if role is initiator */
 		if (sm->cs_role_known && sm->cs_role == CS_INITIATOR) {
+			/* StopMeasurement() during the setup phase had no
+			 * procedure to disable, so do not enable one now.
+			 */
+			if (sm->stop_requested) {
+				DBG("Measurement stopped during setup");
+				cs_set_state(sm, CS_STATE_STOPPED);
+				return;
+			}
+
 			DBG("Initiator role: Sending CS Set Procedure Params");
 			if (!rap_send_hci_cs_set_procedure_parameters(
 							sm, handle)) {
@@ -2010,6 +2022,7 @@ bool bt_rap_start_measurement(void *hci_sm, uint16_t conn_handle,
 	}
 
 	sm->active_conn_handle = conn_handle;
+	sm->stop_requested = false;
 
 	if (sm->measurement_timeout_id) {
 		timeout_remove(sm->measurement_timeout_id);
@@ -2033,6 +2046,11 @@ bool bt_rap_stop_measurement(void *hci_sm)
 	if (!sm || !sm->hci)
 		return false;
 
+	/* The setup phase may still be running, with nothing to disable yet:
+	 * keep it from creating a config or enabling a procedure.
+	 */
+	sm->stop_requested = true;
+
 	if (sm->measurement_timeout_id) {
 		timeout_remove(sm->measurement_timeout_id);
 		sm->measurement_timeout_id = 0;
@@ -2114,6 +2132,7 @@ void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle)
 	sm->cs_role_known = false;
 	sm->sec_enable_pending = false;
 	sm->remote_caps_known = false;
+	sm->stop_requested = false;
 	sm->current_state = CS_STATE_UNSPECIFIED;
 }
 
-- 
2.43.0

