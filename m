Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607567;
	b=rpTNqSIgEH4U5Vh50/ThI56FumXMs0bm3oL6lh2TR/4Zzel7k1dC102E9U0m42ymYqFP
	 4D9h8gjcBpLIUmLMIRPR7CwmiL6B3WqZiD4whoeEqxXaD15/f6RnuohNv9xV6eBC0dmPJ
	 tW75Pk3elii80U5H7M+P6OPhtvEzxlakPoujT9xh2EptBI4acJS/Cuw1IpfC6fvxcFlfS
	 zogqzCt1fDQWWWvBSDgaLuBjmeZik6q7xnxybvRJW3emK8PoHBSkMUZS4B7R6tKHkioBj
	 UyiOVU0tYKsjMQJeI+GDM8amhVsp59xRGs8vLl4kJ0XAnezVoA2Z/Zn6dq8GLVcp0RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607567;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-QCInternal:X-QCInternal:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ag8LYmBeEHG/OQCSSIAlL9n8t1Xl1ONpPaDoB+SqM7I=;
	b=tzMv/3dkCrXDCZvtNqZQPZGav9FfgR6rcIobco5X65dJbSxjyv5NUeLChMkV8iBlaZb3
	 p+HJThulvNNX7WWOpl9KlRl10stZNrInCo+fhS3uh2K2xuqnOI2LiDiK0Hf/yL8MYPody
	 WexwMG4nDDXNdNeL1ADnn+euTwrtEVgfSPCrqw+6E7UXCIS0/A8CScCu908oaBE7H6PVo
	 fficPorh8ayUbGdonycoUTYYNFox/rWH9UD6tMDAmn0adzG0fXv9MPQcQTYrfwEBAFd8q
	 vn5S4gd9+Or0zbDqlt/seGrO9kMnZKAAJ3YzqmXV8o+XbkXmoPSiOUpGffJtilp6WDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lbvQsOJM;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F51606A337
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 08:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73F51606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lbvQsOJM
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A25VsiF3924178
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ag8LYmBeEHG
	/OQCSSIAlL9n8t1Xl1ONpPaDoB+SqM7I=; b=lbvQsOJMWuZ/U4meY6WLx9j2iWK
	wFEp475VWoeBT6FYpjJ93WwQPQk5Y9UccNO7JtOhqzhaM+Gt0QZoLsdNIwWsL9S1
	6/ZH8Tt500NI74w2coI2RAz4k4XG5Y+CKfqGYjNbENgSTUh83UYID4BgQMjdj27G
	RJp5nKihFGCQoV0ZkgrI/yE+LXc4eU4MigEkBplbvi8XB7y1MXIM7Ezwh0Xb9+iB
	K3lorGWpUzrCA+Ztmm2tWdMo7nNc2qdGtl9qNlWQ0ZXWTY6LVqh4kMjgFCiQvLH8
	4iiCRy+S05zisdJ5uj+kFBw0dtnyeHgAukTmm0XAClzcuvNbtso7hKJXKqQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpmf1rjyd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 08:19:26 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A28JKm53331060
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:24 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 6A28JJg53331043;
	Mon, 02 Nov 2026 08:19:24 +0000 (GMT)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH BlueZ 10/15] profiles/ranging: Act on a CS configuration created by the peer
Date: Mon,  2 Nov 2026 16:19:07 +0800
Message-ID: <20261102081913.1623864-11-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: EE3HRTzStrjcHZJETNQcgHq9qm4xJ_Ms
X-Authority-Analysis: v=2.4 cv=bNaDs/+Z c=1 sm=1 tr=0 ts=6ae8478e cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=MzT2TaW_STTz_qO-:21 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=uc-NRWdrDaRFPdozmDoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX6Qy06IxeFUK8
 vLGb83/Y3Gowdx+AvnJ4g3wxPL9jcAHMgQ/gvPXRFPh5/h0kHSe2Y235V+Dq39JK3JSjAQhEMhi
 EoCweTxN6wUExjrNjU+cn1vhsRD861WXLeYP5Ie++Iy5ZPmgE106s+Cchz580fT3b6jMc4nSjOS
 HPsaW0PTwaQUT2G5FLmT8i6ZWHzbCh+LiK0EyExgZQAKyE8JTLNbBQceHMjGtqIbYBksoXDAUk4
 vYVGzWk1/K6IMW9dkIKuOaNrG58tctkQu5S9c8f9oiu7Nscrg6iY1QiDG2hy+hew1/gEc4QXhlF
 0B2Hntj3Z0RwnGnjIRpP+Kf6DV9GEdj8p8gDYNyK5qKAVmWfUXCEfvno1KQLsoFdUXVMEpM/4gl
 KkiTmFUA6XeTapa+koB1TSqKtGC4PG5YowPvvYEdnTO6V9y3IjQO8EvGGZIfP6lfgsRsrBu/Tn9
 a33jszdR/v7DqQSPyiQ==
X-Proofpoint-GUID: EE3HRTzStrjcHZJETNQcgHq9qm4xJ_Ms
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX5IJ9QPkPS7zb
 MI9l0XwOpgObCkFtFZCaTD4doZxs1OqiIRCktB6bGCRZ+E2lfEP34fg7osFup3MwuiB5OFuKhRK
 bSTd2oA2f+WdBx59JW5OeU4S4OBj8dQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020032

LE CS Config Complete is also generated when the local Controller has
responded to a configuration request from the remote one (Core v6.2
Vol 4 Part E 7.7.65.42). The handler required CS_STATE_WAIT_CONFIG_CMPLT
before parsing the event, which is only reached between the Set Default
Settings response and Config Complete of a StartMeasurement(). A remote
Initiator does not wait for that: it can create the configuration as
soon as the link is up, before the local setup phase has run, or again
after an earlier procedure. The event was then dropped along with the
role it carries, Security Enable Complete and Procedure Enable Complete
failed their own state checks, and no ranging data was produced.

Parse Config Complete in any state. Every state machine on the adapter
receives the CS events of all links, which the state check used to
hide, so ignore Config Complete and Security Enable Complete events
whose handle is not mapped to this state machine, so that they cannot
overwrite this link's role or advance its state.

A successful removal (action 0x00) leaves the remaining parameters
undefined, yet it went on to the role check and, if the undefined role
happened to be permitted, to Security Enable. Ignore it whatever the
state.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/ranging/rap_hci.c | 42 +++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index ef01e60c5..39b167ba8 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -882,13 +882,6 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 
 	DBG("size=0x%02X", size);
 
-	/* State Check */
-	if (cs_get_current_state(sm) != CS_STATE_WAIT_CONFIG_CMPLT) {
-		DBG("Event received in Wrong State!! ");
-		DBG("Expected : CS_STATE_WAIT_CONFIG_CMPLT");
-		return;
-	}
-
 	/* Pull the entire structure at once */
 	evt = util_iov_pull_mem(&iov, sizeof(*evt));
 	if (!evt) {
@@ -898,6 +891,35 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 
 	DBG("status=0x%02X, handle=0x%04X", evt->status, evt->handle);
 
+	/* Every state machine on this adapter sees every CS event, so ignore
+	 * the ones for other links: acting on them would overwrite this
+	 * link's negotiated role and advance its state.
+	 */
+	if (!find_mapping_by_handle(sm, evt->handle)) {
+		DBG("Not for this link, ignoring");
+		return;
+	}
+
+	/* Action 0x00 reports that the configuration was removed, and leaves
+	 * the remaining parameters undefined (Core v6.2 Vol 4 Part E
+	 * 7.7.65.42), so there is no role or configuration to act on.
+	 */
+	if (evt->status == 0 && evt->action == 0x00) {
+		DBG("Config %u removed", evt->config_id);
+		return;
+	}
+
+	/* This event is also generated when the local Controller responded to a
+	 * configuration request from the remote one, which is how a Reflector
+	 * learns a procedure is being set up for it. The peer can do that
+	 * before the setup phase has run here, or after an earlier procedure,
+	 * so do not require WAIT_CONFIG_CMPLT, which only the local setup
+	 * phase reaches.
+	 */
+	if (cs_get_current_state(sm) != CS_STATE_WAIT_CONFIG_CMPLT)
+		DBG("Config created by the peer while in %s",
+			state_names[cs_get_current_state(sm)]);
+
 	/* Both sides asked for a configuration at the same time. The Central
 	 * rejects the Peripheral's request with LL Procedure Collision (0x23)
 	 * and completes its own, which the Peripheral handles instead (Core
@@ -1044,6 +1066,12 @@ static void rap_cs_sec_enable_cmplt_evt(const void *data, uint8_t size,
 	DBG("status=0x%02X, handle=0x%04X",
 		rap_ev.status, handle);
 
+	/* Shared HCI channel: drop events belonging to another link. */
+	if (!find_mapping_by_handle(sm, handle)) {
+		DBG("Not for this link, ignoring");
+		return;
+	}
+
 	if (rap_ev.status == 0) {
 		/* Success - proceed to configuration */
 		cs_set_state(sm, CS_STATE_WAIT_PROC_CMPLT);
-- 
2.43.0

