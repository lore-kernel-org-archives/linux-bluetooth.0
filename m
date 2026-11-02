Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607566;
	b=JpRLylprJX5fmnilja9PAZYGqdY9EMBBavCK6rb4ZxWp7j0VBBAYIVh5l8TCFtxKR0+U
	 fSC/xRzYN1W+VWSPLNJrpvXQQmg/d/GZJOv6SjLg/7sPosxGCL2TGGwE6XzxBnZ4OD51P
	 dvAMiF2QzEv3Hk5hm4tk3xayuq736eRIVn9FjcIR+zTN2DzS7/suhrNzOgbYzkGP+RJhP
	 UeiQPHHLBQxzxPp0BZ/z5DVFVzk45oOzQAdsUxbBptgwQoeznzgbEvCbZRX7aXEONRar+
	 iI7YA8Ifljk815W+k73IGYRNy1eBLg2KXof5kMGvKgSAB/eMKV9ruNwVwGzJAmoIFjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607566;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=xCsJmIdnOHUeWnjcDmdIFDrnRy8gq0JIH0CkfW1kBqg=;
	b=slDT6ThRy3wbO8yhs17uqxmoT5a49wK2nb8dh8FLCeJOv+GwNkGXJ9U+iy5yF+VHybRD
	 lhPVTVMbVgam95CN3ycLHlsEQ3hbB7D7VQtnJucVMG7stK4O4t+lzInpm66amZimgsh2o
	 uJm80G+Dacglo3BzxUvzbJk0p/lCBC0rYv7t8fe7urflpGiQAOAH0oTiSecutr0aE8ZOl
	 Il0UZLfzR5BHlUhoK3F35WHPCsm9jOCHY81vWZrBOJDNqLOZIddTWQeS0WUjr9h6cVa7w
	 xZ7oJBuRsu6QJ+WVCUsPhtze9is3CssEqMDPeRG7tiOYKuOnlK64rrmxoA1U9ZOyPfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M32wB4pt;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31154606A338
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 08:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31154606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M32wB4pt
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A27nNaw3220287
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xCsJmIdnOHUeWnjcDmdIFDrnRy8gq0JIH0CkfW1kBqg=; b=M32wB4ptIE5XzdI+
	N/VEOkneXLJga5MdLQZW67DzDFYuP9la46eaRgpaJI6fk5r1vVhImEOv4oCOKnTV
	Ay7+JjE3/PPez9z4SyuS/oiy0bdOOVqshLoawqRA6PjuCQfeoFlT0xXN3OGE6FV4
	MVbRS7OysjaS/LO9gIP4bI2E9bTjHBKcf5MTIvNDJymH5cyn0ICPkPhJ5RhcFvu4
	rLD5OygA5ZoBDf7NaP/8NxzF+K2c+xZvyry/NxOEl73waOSzcj5rkTzPTQzpCrJm
	tRApcLxnpm0W/RCqYrDLWYYN7XHMRfsVcWz+mjL3vkBBSDyv0jzM3+JjasEZNS/F
	HB7h4Q==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hppfe83wv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 08:19:25 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A28JNj63331183;
	Mon, 2 Nov 2026 08:19:23 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 6A28JJg33331043;
	Mon, 02 Nov 2026 08:19:23 +0000 (GMT)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH BlueZ 08/15] profiles/ranging: Let StartMeasurement() pick the Initiator for Both
Date: Mon,  2 Nov 2026 16:19:05 +0800
Message-ID: <20261102081913.1623864-9-cheng.jiang@oss.qualcomm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=SeZi5fRu c=1 sm=1 tr=0 ts=6ae8478d cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=71qAId39zc2m8ACVpswA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX3byyHevCCjf1
 ycn19tf2DoKF0Tjabpy2uKDHYescHsRawJSMOAZMZ1EOX1oM9LMLUkg+p9X0uqhGMnvB70buMkP
 /+wXENQzePdmdHj5d+tOVslEmT6nxukawnYWR0ZyRXOPxC478zEMM+Y/w1chplcph/4R10oELU2
 kHe1vV/wHcbUd2sYMCyWb1fnJNynJIewI/GyPfHEk5RA90XVLf3pZioIo27nHIU8Tz+wICuppkd
 YtpT3r2LhENh+VAXD3RFq2ulKGW2lawZFMPtsYOTMFvO9g1Qr1vuKFLhnP+/IL16T+GY4HV4o/L
 Bs1ribzeKZJb10AYKmszmfLbTNs1DD9eooqHWPbKEtxQZK1OK9cgiqHUiSITU2gs6Z521jxEMes
 SAIMQppk579SIkJvdTG6Jy/ZGIqTZpqcdZkyVH+18kiFcsKDpU5QCZDkjlLQYrCfwa97aEBIUi7
 iSz8MDl/+I0UYVQtEWw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX6/UqwWvxacmg
 6nnH9CAA82nwv/NrqpPZ/+XRZXKBz+D1Xe/AfLUP7t3+seQD2JpKOpBDoeczURKtnzhV/qJHLJG
 Rpmqfl4UWfgjIL3JhbY8SX3vAsA8lao=
X-Proofpoint-ORIG-GUID: wSmaoeqPQoRaqvurPQYJXo31enXcQIRt
X-Proofpoint-GUID: wSmaoeqPQoRaqvurPQYJXo31enXcQIRt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020032

Role_Enable is a bitmask of the CS roles the Host permits, and the CS
roles are independent of the GAP roles. When Role_Enable permitted both
roles, the setup code let the GAP role decide, so a Peripheral that
called StartMeasurement() still waited as Reflector and took the
Initiator role only when Role_Enable permitted nothing else.

The setup phase only runs from StartMeasurement(), so the local Host is
always the one asking to measure: take the Initiator role whenever
Role_Enable permits it.

Both sides may now ask for a configuration at the same time. The
collision rules let the Central's request complete and reject the
Peripheral's with LL Procedure Collision (Core v6.2 Vol 6 Part B 5.1.25
and 5.3). Ignore that rejection instead of removing the config ID, which
could remove the configuration the Central has just created.

The Config Complete role check compared Role_Enable with the two
removed helpers. Check the reported role against the Role_Enable bits
instead, which accepts the same roles for every valid Role_Enable.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/ranging/rap_hci.c | 59 +++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 23 deletions(-)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 0eea018cc..f23e89cfe 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -348,17 +348,30 @@ static enum cs_state cs_get_current_state(struct cs_state_machine *sm)
 	return sm ? sm->current_state : CS_STATE_UNSPECIFIED;
 }
 
-static bool is_initiator_role(const struct cs_state_machine *sm)
+/* Role_Enable is a bitmask of the CS roles the Host permits for this link
+ * (Core v6.2 Vol 4 Part E 7.8.134), not a selector for one of them.
+ */
+#define CS_ROLE_ENABLE_INITIATOR	0x01
+#define CS_ROLE_ENABLE_REFLECTOR	0x02
+
+/* Whether Role_Enable permits the CS role (CS_INITIATOR or CS_REFLECTOR)
+ * that LE CS Config Complete reports for the local Controller.
+ */
+static bool cs_role_permitted(const struct cs_state_machine *sm, uint8_t role)
 {
-	return sm->role_enable == 0x01;
+	if (role == CS_INITIATOR)
+		return sm->role_enable & CS_ROLE_ENABLE_INITIATOR;
+
+	return sm->role_enable & CS_ROLE_ENABLE_REFLECTOR;
 }
 
-/* For role_enable=0x03 (Both), Central acts as Initiator and Peripheral as
- * Reflector — the link layer topology determines the CS role assignment.
+/* The setup phase only runs from StartMeasurement(), that is when the local
+ * Host asked to measure this peer, so take the Initiator role whenever
+ * Role_Enable permits it. The CS roles are independent of the GAP roles.
  */
-static bool is_both_role(const struct cs_state_machine *sm)
+static bool cs_local_is_initiator(const struct cs_state_machine *sm)
 {
-	return sm->role_enable == 0x03;
+	return sm->role_enable & CS_ROLE_ENABLE_INITIATOR;
 }
 
 /* Helper function to send read remote capabilities for all connections */
@@ -503,7 +516,6 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 {
 	const struct bt_hci_rsp_le_cs_set_def_settings *rp;
 	struct cs_state_machine *sm = user_data;
-	struct rap_conn_mapping *m;
 
 	if (!sm || !data || size < sizeof(*rp))
 		return;
@@ -521,22 +533,13 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 	if (rp->status == 0) {
 		cs_set_state(sm, CS_STATE_WAIT_CONFIG_CMPLT);
 
-		/* Send CS Create Config if we are (or will act as) Initiator.
-		 * For role_enable=Both, Central acts as Initiator.
+		/* Only the Initiator creates the config; the Reflector waits
+		 * for its own CS Config Complete.
 		 */
-		if (is_initiator_role(sm)) {
+		if (cs_local_is_initiator(sm))
 			rap_send_hci_cs_create_config_command(sm, rp->handle);
-		} else if (is_both_role(sm)) {
-			m = find_mapping_by_handle(sm, rp->handle);
-
-			if (m && m->is_central)
-				rap_send_hci_cs_create_config_command(sm,
-								rp->handle);
-			else
-				DBG("Both role: Wait for CS Config Cmpl");
-		} else {
+		else
 			DBG("Reflector role: Waiting for CS Config Completed");
-		}
 	} else {
 		/* Error - transition to hold */
 		error("CS Set default setting failed with status 0x%02X",
@@ -889,6 +892,18 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 
 	DBG("status=0x%02X, handle=0x%04X", evt->status, evt->handle);
 
+	/* Both sides asked for a configuration at the same time. The Central
+	 * rejects the Peripheral's request with LL Procedure Collision (0x23)
+	 * and completes its own, which the Peripheral handles instead (Core
+	 * v6.2 Vol 6 Part B 5.3). That configuration arrives in an event of
+	 * its own, so there is nothing to undo here: removing the config ID
+	 * could remove the one the Central has just created.
+	 */
+	if (evt->status == 0x23) {
+		DBG("Config collided with the peer's, using the peer's");
+		return;
+	}
+
 	/* Check status */
 	if (evt->status != 0) {
 		if (evt->action != 0x00) {
@@ -934,9 +949,7 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 	 * (CS_INITIATOR=0x00, CS_REFLECTOR=0x01)
 	 * which is different from the role_enable value sent in HCI command
 	 */
-	if ((is_initiator_role(sm) && rap_ev.role != CS_INITIATOR) ||
-	    (!is_initiator_role(sm) && !is_both_role(sm) &&
-	     rap_ev.role != CS_REFLECTOR)) {
+	if (!cs_role_permitted(sm, rap_ev.role)) {
 		error("CS Config role 0x%02X doesn't match role enable 0x%02X",
 			rap_ev.role, sm->role_enable);
 		cs_set_state(sm, CS_STATE_HOLD);
-- 
2.43.0

