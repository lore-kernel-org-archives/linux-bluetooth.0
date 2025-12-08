Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AD6EEB3
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765189166; cv=none; b=WqGRA1iutsbMYNiiCXw7CNvRBOJFuDyeDJEdv8dFn9K7hO8KwHmIy6qOow38YN8Lt2ZpdVG/bgPHp8mAJvC6IEifaA7Q+WZ+QoYtyJyosXbZsksjJMsm/ayDWn5L9aweFVVICyrFZHbRXxTqPHWwpdLjN7yt6o3Bq8Tj2QfucK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765189166; c=relaxed/simple;
	bh=UhTjvi6cUUVn0m+eqXaBIkvm43tilX+40LryI+1Gtbc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SsUbegmodSm43W3reiQWO4B7GGY1s/Q9cYR66NsSbO72YW4DDT9dMkdSufjdHqJBIclVmj+8MgTNmVBB2lbOyvovQFjgOSghQ3hRSKIuR5jctOZQSacVnrytQRtFzOzWM+I/7bXs9YBgbZi5aP8KoSEcd2Hqq3+CqgF42BRLfgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dTFY6/F7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dTFY6/F7"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B842uLA109801
	for <linux-bluetooth@vger.kernel.org>; Mon, 8 Dec 2025 10:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jIQgvBUtKy4ZYRQhbCgaRqf24PgfAiKpyUs
	QmbTELw8=; b=dTFY6/F7bPywCWJhrClf7bcDeSEHDGyIZLzGSJ7SUlpTIM/y9Dn
	FPaeaTEJ4G08HLiK+EF5uF3h6rFunc93XeWOXNzzMeKf2vmmxru+xcCWsRM5dNDK
	uCeTFE4oGW2WBUAR+n8DhMx4yzYxJZL3Ofjwh0UfvEDRiohHk6bPWufRYHjEBNL5
	pDvSK2govN4YfiZVHN+10/aPeQdzB1f03RerLyIIGcDZ3AhI7BPAlQn+MOBG9A7B
	MYbZgkzs7aTBZjapxh/kmXEC1/wrekkIvIIJPvi+lPWs/e4AfvgH9K09GAwLMzDx
	PGGVFoKo70xTp7G8xaBnWFmaffeRaZ0aVRg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4awqabh2a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 08 Dec 2025 10:19:22 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8AJKs5018689
	for <linux-bluetooth@vger.kernel.org>; Mon, 8 Dec 2025 10:19:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4avdjkrvxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 08 Dec 2025 10:19:20 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5B8AJKHY018686
	for <linux-bluetooth@vger.kernel.org>; Mon, 8 Dec 2025 10:19:20 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 5B8AJJhi018684
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 10:19:20 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4766378)
	id D0C4D22AB6; Mon,  8 Dec 2025 18:19:18 +0800 (CST)
From: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: shuai.zhang@oss.qualcomm.com, cheng.jiang@oss.qualcomm.com,
        chezhou@qti.qualcomm.com, wei.deng@oss.qualcomm.com,
        Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Subject: [PATCH v1] gatt-client:Implement error handling for DB_OUT_OF_SYNC in GATT caching.
Date: Mon,  8 Dec 2025 18:19:15 +0800
Message-Id: <20251208101915.247459-1-mengshi.wu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _XkB4uDamUGngL8dLvqBYQM5hXHJeZli
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDA4NiBTYWx0ZWRfX7ths3WjeBmd6
 wCmTCim/9A1bsrRBMf/HWjTBNjjCb6pmFLHJn73ieWnizhLlO0gt8d+ldRxPJuQNIaFRLmUWNje
 af/d3gIxxLnhdciZvFpBKB/jSgm0YysIgYJd4ogenHjZ6ynB0qWYhqIzp+k0qWKPxlQ64kVI0tB
 EijTiW8BqHYuVbe2PHXtwRr7YTulD7cDEvXzVsv1eW/A0ai8NCAwsDYtaeiDX+mHc6VR4s7ocgo
 VE3usRPqxJUSyVDv9F6fVRrfIALu/oN6T4xlT04iZhDqrnoQ8tb4xMV2dgauMh88Dw86CvhOeZ2
 IxLuAEx4R/D2jnrWguROPIjD0BLdd/9qNRq9sNyzZcR4CEGJFjy2YVa/386RRMBu+5wnxT6oYj4
 pk+v5VuruxMOLkEBGhceIW60e6Hh/g==
X-Proofpoint-GUID: _XkB4uDamUGngL8dLvqBYQM5hXHJeZli
X-Authority-Analysis: v=2.4 cv=f7lFxeyM c=1 sm=1 tr=0 ts=6936a62b cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=odfTz2BWyqRTdTo19ewA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512080086

Add automatic DB re-discovery on receiving BT_ATT_ERROR_DB_OUT_OF_SYNC
error code from ATT operations. This ensures the local GATT database
stays synchronized with the remote device by triggering a full service
discovery (handles 0x0001-0xffff) when the database becomes out of sync.

The process_db_out_of_sync() function is now called in all ATT error
response handlers (read_multiple, read_long, write, execute_write,
prepare_write, and prep_write callbacks) to handle this error condition
consistently.

Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
---
 src/shared/gatt-client.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index f6d5dc4b7..087d4e228 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1965,6 +1965,29 @@ fail:
 		"Failed to initiate service discovery after Service Changed");
 }
 
+static void process_db_out_of_sync(struct bt_gatt_client *client,
+				   uint8_t att_ecode)
+{
+	struct service_changed_op *op;
+
+	if (att_ecode != BT_ATT_ERROR_DB_OUT_OF_SYNC)
+		return;
+
+	DBG(client, "Database Out of Sync - triggering full re-discovery");
+
+	if (!client->in_svc_chngd) {
+		process_service_changed(client, 0x0001, 0xffff);
+		return;
+	}
+
+	op = new0(struct service_changed_op, 1);
+
+	op->start_handle = 0x0001;
+	op->end_handle = 0xffff;
+
+	queue_push_tail(client->svc_chngd_queue, op);
+}
+
 static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
 					uint16_t length, void *user_data)
 {
@@ -2709,10 +2732,12 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu, uint16_t length,
 			(!pdu && length)) {
 		success = false;
 
-		if (opcode == BT_ATT_OP_ERROR_RSP)
+		if (opcode == BT_ATT_OP_ERROR_RSP) {
 			att_ecode = process_error(pdu, length);
-		else
+			process_db_out_of_sync(req->client, att_ecode);
+		} else {
 			att_ecode = 0;
+		}
 
 		pdu = NULL;
 		length = 0;
@@ -2864,6 +2889,7 @@ static void read_long_cb(uint8_t opcode, const void *pdu,
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		success = false;
 		att_ecode = process_error(pdu, length);
+		process_db_out_of_sync(req->client, att_ecode);
 		goto done;
 	}
 
@@ -3050,6 +3076,7 @@ static void write_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		success = false;
 		att_ecode = process_error(pdu, length);
+		process_db_out_of_sync(req->client, att_ecode);
 		goto done;
 	}
 
@@ -3213,6 +3240,7 @@ static void execute_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		success = false;
 		att_ecode = process_error(pdu, length);
+		process_db_out_of_sync(req->client, att_ecode);
 	} else if (opcode != BT_ATT_OP_EXEC_WRITE_RSP || pdu || length)
 		success = false;
 
@@ -3278,6 +3306,7 @@ static void prepare_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		success = false;
 		att_ecode = process_error(pdu, length);
+		process_db_out_of_sync(req->client, att_ecode);
 		goto done;
 	}
 
@@ -3447,6 +3476,7 @@ static void prep_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
 		success = false;
 		reliable_error = false;
 		att_ecode = process_error(pdu, length);
+		process_db_out_of_sync(req->client, att_ecode);
 		goto done;
 	}
 
@@ -3597,6 +3627,7 @@ static void exec_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		success = false;
 		att_ecode = process_error(pdu, length);
+		process_db_out_of_sync(req->client, att_ecode);
 		goto done;
 	}
 
-- 
2.34.1

