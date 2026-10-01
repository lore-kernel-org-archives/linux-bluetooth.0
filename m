Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB0F355F46
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860764; cv=none; b=lfBG71esLMxIcuf8Xba9vPaBNRRDbVqvBLikdpqycbZ7mSmiAJeyJIH5m8uXAnvfOL8OVh4VtmQKWSc9yT0VYWXUOV/WHl0RDO58YSrQ8mWyaNNew589lg++IGNeJ/5NL1BVb9HP9xTnSnocRLCTBB8yLFXvrLzcXwCEE4Uv89U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860764; c=relaxed/simple;
	bh=gXJMOjizRcZqeWChMfk0tDQx5pvaHpLxGgF9/4i0qFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CcUbbhUsKge3CuQhzd5C273SHGBJC/SabvhRWB6BZ6d1gyhXKF4XrCsRYKJAYk2ARaDohy9ZQaAWFTRhC1U90DpmTvcCviv/wjZPQw7gJ3If4XdhH08+Enr4OjpdzAd5lVrjj4eS58PZJsz65PjdJ7gVfckutyCPet88vt7G0Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RpibEa7y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RpibEa7y"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691Cl7i31661068
	for <linux-bluetooth@vger.kernel.org>; Thu, 1 Oct 2026 13:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hL/lVfJ4uPA
	jTT0xUfMvrHxv4R5YiQEj2L0KV1AxJgU=; b=RpibEa7yHIz7AQ192gnqWTF9Xud
	Yku92kOn4hU6XjAILXoZgQtA/zfYsYOBSS2j1YBLEWCOCxJ9guSXo3W89s4yx20c
	GUDJpcuOZCgLc5BmPFzP/hljHqKLSkRxYO+80C0vDx/VMNzv0M4s8uOWBo8d04Hw
	uee8YwTSK9F7U+p2qBkldFRifmm4JopCPQejCkNDAWSbjHbnZVDn/VOFaCI+g4vm
	GS7HLRimCtSvYGbB+/zWFSaAzygd7FIjnoPItXsccaPxKfuXwouZsRmGN+VBISmn
	TL0c/Tp93P9ACprpp7rRFK/YRbGSOLg0STMHJ9QVOmP7Q5izO1f05aiRJwg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h167pmq6k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 13:19:16 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 691DJE6w2496306;
	Thu, 1 Oct 2026 13:19:14 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 691DJDNh2496296
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 13:19:13 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 0AD2F49BBF; Thu,  1 Oct 2026 21:19:13 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH 04/11] shared/rap: Add RAS Control Point Abort Operation
Date: Thu,  1 Oct 2026 21:18:50 +0800
Message-ID: <20261001131900.707485-5-cheng.jiang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001131900.707485-1-cheng.jiang@oss.qualcomm.com>
References: <20261001131900.707485-1-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 5VKjgjkNNq7HP5RyEWbmp4amf01HX5t6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfXwYndAZCH0b4v
 oMF820U6V2/KLgOe8MtjADIFe2YjTxxKZE4JJRp58Xb8qcTE/2N4QqWtDZtm/6J93tLsU5bnGvj
 wkhbagAIXhlNcs1Hg8u2j3oKaL6xO94=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfX0slLr5hUR9kr
 l/TnkFmHguTLz/8TFysJcEctqnz4Uo5LMsw52VGuUrKqoJuv20ZhGsJXXG2M1LC7ew1R9L1Ot5p
 Df5nj8JbGCqj/va4C3WorP2Nz9+e7s0/++0MYMfNS4RzhQApWtcA+pswWrEctY/VeNDesWlHTwo
 2VK0aRknoBDqY7sqfeS4if93qs63sV2ISjXSe/WeOLY96S4ilOwK/HFgsiYCcPO/BA+8r5iTemk
 b3NzSRuXoF7Z+6GYPZtljADDDmYBqbUX7J69jNrPb0W4TMR/Z08wrXP6kHi0HivFQ3U9gxSN7UK
 a4j/Boz8grgVLXfj+4zdNrdc4XeEs/TIxFeMXw7BzctBIlM0NjVB9PxvZ7FBVG0zw4+Ln+vkZiU
 5J7pSVTZaEGW/YQtDdLHQOzwWpr4yAsHkNYIEaqT9SlsUftu/6Kh5oGUk8TOBtGL32hYLHT7rQL
 1WsVjXuhKeeWDKY3ofg==
X-Proofpoint-GUID: 5VKjgjkNNq7HP5RyEWbmp4amf01HX5t6
X-Authority-Analysis: v=2.4 cv=WpC+otfv c=1 sm=1 tr=0 ts=6abe5dd4 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=_XESNBVFqNUE2y36yhsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010053

Implement the Abort_Operation procedure (Op Code 0x03) so a client can
cancel an On-demand Ranging Data transfer that is already in progress,
and advertise it through bit 2 of the RAS Features characteristic.

Abort clears the sending state and removes the pending segment timer.
Since the transfer keeps at most one segment outstanding, dropping that
timer stops the transfer instead of letting a queued backlog drain out.
The Control Point busy check lets Abort through while every other Op Code
is answered with Server Busy, so an abort is accepted mid-transfer.

On the requester side, an Abort is written when a Get_Ranging_Data
request times out and the peer advertises Abort support, so the responder
does not keep sending data for a request the requester gave up on.

The unit test Features value changes to 0x05 accordingly.

Assisted-by: Claude:claude-opus-4.8
---
 src/shared/rap.c | 35 ++++++++++++++++++++++++++++++-----
 unit/test-rap.c  |  6 +++---
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index a794de044..b45bfc9e6 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -312,8 +312,8 @@ struct cstracker {
 enum ras_cp_opcode {
 	RAS_CP_OP_GET_RANGING_DATA = 0x00,
 	RAS_CP_OP_ACK_RANGING_DATA = 0x01,
+	RAS_CP_OP_ABORT_OPERATION = 0x03,
 	/* 0x02 Retrieve_Lost_Ranging_Data_Segments,
-	 * 0x03 Abort_Operation,
 	 * 0x04 Set_Filter - optional, not implemented
 	 */
 };
@@ -366,6 +366,7 @@ struct ras_ondemand_client {
 	 * peer never sends a Control Point response.
 	 */
 	unsigned int        cp_timeout_id;
+	bool                abort_operation;
 };
 
 /* Ranging Service context */
@@ -1196,7 +1197,7 @@ static void ras_features_read_cb(struct gatt_db_attribute *attrib,
 {
 	struct ras *ras = user_data;
 	/* Real-time ranging and Abort Operation are supported. */
-	uint8_t value[4] = { 0x01, 0x00, 0x00, 0x00 };
+	uint8_t value[4] = { 0x05, 0x00, 0x00, 0x00 };
 
 	if (ras)
 		bt_rap_get_session(att, ras->rapdb->db);
@@ -1244,7 +1245,7 @@ static void ras_control_point_write_cb(struct gatt_db_attribute *attrib,
 		return;
 	}
 
-	if (rap->cache.sending) {
+	if (rap->cache.sending && value[0] != RAS_CP_OP_ABORT_OPERATION) {
 		ras_cp_send_response_code(rap, ras, RAS_CP_RSP_CODE_SERVER_BUSY);
 		goto done;
 	}
@@ -1269,6 +1270,22 @@ static void ras_control_point_write_cb(struct gatt_db_attribute *attrib,
 
 		send_ondemand_segment_data(rap, ras);
 		break;
+	case RAS_CP_OP_ABORT_OPERATION:
+		if (len != 1) {
+			ras_cp_send_response_code(rap, ras,
+					RAS_CP_RSP_CODE_INVALID_PARAMETER);
+			break;
+		}
+
+		if (rap->cache.sending) {
+			if (rap->cache.send_id)
+				timeout_remove(rap->cache.send_id);
+			rap->cache.send_id = 0;
+			rap->cache.sending = false;
+		}
+
+		ras_cp_send_response_code(rap, ras, RAS_CP_RSP_CODE_SUCCESS);
+		break;
 	case RAS_CP_OP_ACK_RANGING_DATA:
 		if (len != 3) {
 			ras_cp_send_response_code(rap, ras,
@@ -3352,6 +3369,10 @@ static bool ras_cp_timeout_cb(void *user_data)
 		 * on it.
 		 */
 		ras->client.cp_timeout_id = 0;
+		if (ras->client.pending_op == RAS_CP_PENDING_GET &&
+				ras->client.abort_operation)
+			ras_cp_write_op(rap, ras, RAS_CP_OP_ABORT_OPERATION,
+					ras->client.pending_counter);
 		ras_ondemand_client_reset(ras);
 	}
 
@@ -3397,8 +3418,10 @@ static bool ras_cp_write_op(struct bt_rap *rap, struct ras *ras,
 		return false;
 
 	value[0] = opcode;
-	put_le16(counter, value + 1);
-	length = sizeof(value);
+	if (opcode != RAS_CP_OP_ABORT_OPERATION) {
+		put_le16(counter, value + 1);
+		length = sizeof(value);
+	}
 
 	return bt_gatt_client_write_without_response(rap->client,
 					value_handle, false,
@@ -4265,6 +4288,8 @@ static void read_ras_features(struct bt_rap *rap, bool success,
 	supports_realtime = (features & 0x01) != 0;
 	retrieve_lost = (features & 0x02) != 0;
 	abort_operation = (features & 0x04) != 0;
+	if (ras)
+		ras->client.abort_operation = abort_operation;
 
 	DBG(rap, "RAS Features - Real-time: %s, Retrieve Lost: %s, Abort: %s",
 	    supports_realtime ? "Yes" : "No",
diff --git a/unit/test-rap.c b/unit/test-rap.c
index 5c6033a4e..349d06840 100644
--- a/unit/test-rap.c
+++ b/unit/test-rap.c
@@ -802,11 +802,11 @@ const struct test_config_rap cfg_cggit_discovery = {
  *       Handle: 0x0003 (RAS Features value handle)
  *
  *  ATT: Read Response (0x0b) len 5
- *       Value: 0x01 0x00 0x00 0x00
+ *       Value: 0x05 0x00 0x00 0x00
  *       Feature bits:
  *         Bit 0: Real-time ranging (1 = supported)
  *         Bit 1: Retrieve stored results (0 = not supported)
- *         Bit 2: Abort operation (0 = not supported)
+ *         Bit 2: Abort operation (1 = supported)
  *
  *  Note: The RAS Features characteristic is registered with
  *  BT_ATT_PERM_READ | BT_ATT_PERM_READ_ENCRYPT. Since the test sets
@@ -817,7 +817,7 @@ const struct test_config_rap cfg_cggit_discovery = {
 
 #define ATT_READ_RAS_FEATURES \
 	IOV_DATA(0x0a, 0x03, 0x00), \
-	IOV_DATA(0x0b, 0x01, 0x00, 0x00, 0x00)
+	IOV_DATA(0x0b, 0x05, 0x00, 0x00, 0x00)
 
 #define RAS_SR_RCO_BV_01_C \
 	ATT_EXCHANGE_MTU, \
-- 
2.43.0

