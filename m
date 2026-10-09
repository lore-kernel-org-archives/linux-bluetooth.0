Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BD249AA20
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537942; cv=none; b=ObAhv0HLL/SCpB41ow557rulpnsrANNtVoa6wvuw9r9pfADlD2k2ppgAWSVMB8dly0yDLl6iArAId7kC4XLf7XH+J/l4twFWL2K+xnLaVbsqnNWpOygJUxlRMQuxz1F5uO0SGFuC50IEhq3nePkV1vd70Xyai+aJjudKHbiABMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537942; c=relaxed/simple;
	bh=9TbT2HdEovFGBpVJHNSYk7e7yiDh/I2GWlAbdhmeMYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKwWcqFWjF8yjsuUu9vKmA6RIqQ3AYUf+aBXLt9V9i7ijtisFSJT7VxQw5WmyL0KxYKKMTlmT9LWeG8DZAlrxP1m+l5aAl5WQdAk89bIUlxx1A+LrMuFsMdERdhpDxCcxklmoIB/bMu68BWEaTCyjwi8LsI68n6dRH1e18/pjcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nou4Rjl9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nou4Rjl9"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KFPl906806
	for <linux-bluetooth@vger.kernel.org>; Fri, 9 Oct 2026 09:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ztnTxkP/L1d
	w07Jw4VrzF4gEdPyhwIzvmIv+Yi3Ove8=; b=Nou4Rjl9R+RcVkyzzYmlIVmeX5M
	BZ4Aphz1ZPKg5zfuCoxRGEN9quzg9s2c09jyRgWNfNX6TBMWuYfVahek3pHFdm8G
	cn6zwUVFVbAggXQnUj5Fhnsm7RH3Jb5ty0Veyun26RHwRDIc+mrf5TgJq+EKxR+e
	emIQ2jzSLI/rNJ1e2qhXrtT+PGH7lTbIFsY71eDoxeMJvBJJr0Z6+XbaccOr2K1h
	8iSxOZtRFog4c6bYGdEjaaaYcCxJYY011d660h8CpdPUxz6/Ve9HFRfig9cVP8co
	9okcHRKEeHnXykeiLTiL7Yri9N1M54dEekOBG3NoGb0JlDP5YE4mmoi4hZA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fmqu0fc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 09:25:37 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6999PYkh3497410
	for <linux-bluetooth@vger.kernel.org>; Fri, 9 Oct 2026 09:25:35 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6999PZlL3497441
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 09:25:35 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 80CE449BDF; Fri,  9 Oct 2026 17:25:33 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH v2 06/14] shared/rap: Add RAS Control Point Abort Operation
Date: Fri,  9 Oct 2026 17:25:22 +0800
Message-ID: <20261009092532.3600749-7-cheng.jiang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009092532.3600749-1-cheng.jiang@oss.qualcomm.com>
References: <20261009092532.3600749-1-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfX5YJjXKOP9N6f
 WCf7Z2RjawHXzV+A7FpGtt25xbUBNzdHu9PoCbCcjiTBT8Ze65Xfi4j8aLFbqZMu8hu4WK+ZAH+
 2ZJwNesb+1+yGHk3L07/LraJEXG/+IU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfX652it99gCx9+
 7KodRKL9sE0IshkkXVec5FHdD8J3NXLYgsJWADj++q+tmzj+fqFzVnozGn9Uz/EsTrOS7RMEe6r
 OPP4/CkzY+JsvhL5/zxahPfKDKKMX2ISqN8yu+qd7F5vaRBsW9gpleeBwmSDdS9HKgDUHb266qB
 Vn/V/ZOTgLawkMSproXS0OBUc6y4YyNj2IA9bXridqyeTIVaR/Y7brLfoSOe0tg+DxpYPpVDcUQ
 1B5vyNOrAeW3qCiLjv+FTY+a3BtIXcZq8QSuEyjdFDO7h9qmawRRPh0QBpa+cKM/wtOQzZYeZHc
 sMx7oWbu6RF9BaqSNV16H270QzsHZ+TUh7G8En8dA4x9K1IyE+U2cNrF/yx5VeM/C6ZbylEtNOm
 of9G4r/i7IApryJvdvIov2OPJPOFTm1eTnA8ktBo/o8m1nIo9tT/IHdyrnsfSak3aBBnXzQNcjR
 b7GT4THJutMcPaOo9Dw==
X-Proofpoint-GUID: nEZFfpzb-RadtsJSSN4GmdPTF4l23vLv
X-Proofpoint-ORIG-GUID: nEZFfpzb-RadtsJSSN4GmdPTF4l23vLv
X-Authority-Analysis: v=2.4 cv=IqCL47/g c=1 sm=1 tr=0 ts=6ac8b312 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=L6w_ywKUsAN4RoXpShEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090037

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

Assisted-by: Claude:claude-opus-4.8
---
 src/shared/rap.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index e0129773e..eddf9f0bf 100644
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
@@ -1197,7 +1198,7 @@ static void ras_features_read_cb(struct gatt_db_attribute *attrib,
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
 		ras_cp_send_response_code(rap, ras,
 					RAS_CP_RSP_CODE_SERVER_BUSY);
 		goto done;
@@ -1270,6 +1271,22 @@ static void ras_control_point_write_cb(struct gatt_db_attribute *attrib,
 
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
@@ -3379,6 +3396,10 @@ static bool ras_cp_timeout_cb(void *user_data)
 		 * on it.
 		 */
 		ras->client.cp_timeout_id = 0;
+		if (ras->client.pending_op == RAS_CP_PENDING_GET &&
+				ras->client.abort_operation)
+			ras_cp_write_op(rap, ras, RAS_CP_OP_ABORT_OPERATION,
+					ras->client.pending_counter);
 		ras_ondemand_client_reset(ras);
 	}
 
@@ -3424,8 +3445,10 @@ static bool ras_cp_write_op(struct bt_rap *rap, struct ras *ras,
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
@@ -4293,6 +4316,8 @@ static void read_ras_features(struct bt_rap *rap, bool success,
 	supports_realtime = (features & 0x01) != 0;
 	retrieve_lost = (features & 0x02) != 0;
 	abort_operation = (features & 0x04) != 0;
+	if (ras)
+		ras->client.abort_operation = abort_operation;
 
 	DBG(rap, "RAS Features - Real-time: %s, Retrieve Lost: %s, Abort: %s",
 	    supports_realtime ? "Yes" : "No",
-- 
2.43.0

