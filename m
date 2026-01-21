Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D537392B98
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768984695; cv=none; b=mxhAFaKNLFh/NF8TqKuT2sGH41lkR+P7gOVhsz2qXYzL/TSv/qmO2L/3PurUmwPv903Wf9kco8mQnczwn4fasDd/qFg+QYFp2RRsXUXnuNrwb3mKPq90pIqcGb7t81QXC2px0jhqqzjLX9bIUPKunDTPdkXW06WKNl+b6mNOQPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768984695; c=relaxed/simple;
	bh=wIcAOZk/w3uco+OmN5lRHdaj6Ggobe59hFF2/PCqlXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AV27joYXnWH4ama/LwmQgpaeZaHLtM3wf77yDq4Gbs4mzo2z2QVg/LnDrXz/hnWD+j23neL94p4dUtHa3x/rW/AjSJukWAjbxayHCc6nBzmBdUaViDeWBYIEbsdSaoU7/3Sxu4y5rlXdGjymmSO86tCPFdqxLAHTg7x4c+JsLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CO3ZIIW9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CO3ZIIW9"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L2d0Np314751;
	Wed, 21 Jan 2026 08:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=72sQOT5mmGy
	5oaDuBxDooe70NS62/HJPzD9X6+nWgIk=; b=CO3ZIIW9fpuVdeCvsrnG3TaC6hO
	gjz24TEVrhZk0WZrIVMlLlMlGHrT0H0OFOIKYkUTaqFhR8bOpQonFAcaQi67T/WR
	dhW5LquW0nRtCV/t1PKgDaghKpAd67A5bvl7GfB1GRrjkMP/BErVT9v7eUUcjCRu
	oHyZP5BuAtu5rsTvF9kgZgf5pSDF//0TwMbMOE3opn4PCEpXycZyQi5q3MZKXOIF
	/uIMRdsN/JpXpozseqvrZjwGxJbbwZUDTogHkcDK7x18Zk1J9zOtaTCRtYNzScu5
	ZQp/7u/sM6ftHoow6djFXVf145lfp6jJWPg3AQpsEIDNotcVU30YhOUwMQQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btdw2axhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 08:38:11 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60L8c8xI029095;
	Wed, 21 Jan 2026 08:38:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4br3gms2s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 08:38:08 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60L8c8fX029090;
	Wed, 21 Jan 2026 08:38:08 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 60L8c8Fc029089
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 08:38:08 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4766378)
	id AA0A823791; Wed, 21 Jan 2026 16:38:07 +0800 (CST)
From: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com,
        wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com,
        Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Subject: [PATCH v3 2/2] gatt-client: Add DB_OUT_OF_SYNC error handling with retry mechanism
Date: Wed, 21 Jan 2026 16:38:04 +0800
Message-Id: <20260121083804.4010106-3-mengshi.wu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121083804.4010106-1-mengshi.wu@oss.qualcomm.com>
References: <20260121083804.4010106-1-mengshi.wu@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 9Xnv0WmxPPaB292c68Rtzy0bMDNXDzrq
X-Proofpoint-GUID: 9Xnv0WmxPPaB292c68Rtzy0bMDNXDzrq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA3MSBTYWx0ZWRfX5We1vl1n627v
 9RtZs18QeHdpvXd5hz5t3+aFABPu5zvx19mlwtqjJDUTYjZl741iiyW+b6loOLoIVJdG6klxolu
 8bDYxu3CarL1dFJg4zZkeRboZS7BxjG2kaeG5hkhwdP2l/rpuD10GuwwST+9hFH0aTtbKPnXcPy
 qn9RPh0ml5PyEetsPJj7IyDrfufvf59WLwDKDK9f+bUot5eKpB5aj3qGN+XyeWV6aA3eLxb11Ux
 L5sVHDIodLBOsROCVm3LboeJYMLkWEj01oykYP3M7gYfuN2uWfIdz5wf5MmrTeyIzbqTZxU3LJe
 zPVEgOB5B/znRV/x45Lp0An4QvD/TbNe2sQU6Y8VlGuQWa2itF5qth97QoONFO1/hUF4sFnBOmX
 9MYaw/X4icpWY+rZwuNBqS3giXyy3TRJHQv9Wd8tTNl+0s3De91bIXpnXBeCcd6WOVgSlabntCb
 wW8fiSSrGDXXEuvg+Vw==
X-Authority-Analysis: v=2.4 cv=RqzI7SmK c=1 sm=1 tr=0 ts=69709073 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=FP3Vu47zevXFEFS8Y5kA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210071

Implement automatic retry logic for GATT operations that fail with
DB_OUT_OF_SYNC error. When this error occurs, the client now:

- Reads and compares the remote Database Hash with the local cache
- Retries the failed operation if hashes match (database is in sync)
- Triggers service discovery if hashes differ or hash read fails
- Handles Service Changed indications during retry by checking if
  the error handle falls within the affected range

Add retry callback infrastructure in gatt-helpers to support deferred
retry decisions, allowing async verification before retrying requests.

Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
---
 src/shared/gatt-client.c  | 168 ++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-helpers.c |  16 ++++
 src/shared/gatt-helpers.h |   3 +
 3 files changed, 187 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index f8ebab3fa..bc8138e16 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -114,6 +114,10 @@ struct bt_gatt_client {
 
 	struct bt_gatt_request *discovery_req;
 	unsigned int mtu_req_id;
+
+	/* Pending retry operation for DB out of sync handling */
+	unsigned int pending_retry_att_id;
+	uint16_t pending_error_handle;
 };
 
 struct request {
@@ -2342,6 +2346,167 @@ static void att_disconnect_cb(int err, void *user_data)
 		notify_client_ready(client, false, 0);
 }
 
+static bool is_handle_out_of_range(uint16_t handle, struct bt_gatt_client *client)
+{
+	bool handle_out_of_range = false;
+	uint16_t start_handle, end_handle;
+
+	if (handle) {
+		start_handle = bt_gatt_req_get_start_handle(
+				client->discovery_req);
+		end_handle = bt_gatt_req_get_end_handle(
+				client->discovery_req);
+
+		if (start_handle != 0 && end_handle != 0 &&
+			(handle < start_handle || handle > end_handle))
+			handle_out_of_range = true;
+	}
+
+	return handle_out_of_range;
+}
+
+static void db_hash_check_cb(bool success, uint8_t att_ecode,
+			      struct bt_gatt_result *result,
+			      void *user_data)
+{
+	struct bt_gatt_client *client = user_data;
+	struct gatt_db_attribute *hash_attr = NULL;
+	const uint8_t *local_hash = NULL;
+	const uint8_t *remote_hash;
+	uint16_t length, handle;
+	struct bt_gatt_iter iter;
+	bt_uuid_t uuid;
+	unsigned int att_id = client->pending_retry_att_id;
+	uint16_t pending_error_handle = client->pending_error_handle;
+	bool handle_out_of_range;
+
+	client->pending_retry_att_id = 0;
+	client->pending_error_handle = 0;
+
+	/* If a Service Changed indication is received at this stage, the
+	 * pending request may be retried once we have verified that the
+	 * affected attribute handle is not within the range impacted by
+	 * the service change.
+	 */
+	if (client->in_svc_chngd) {
+		handle_out_of_range =
+			is_handle_out_of_range(pending_error_handle, client);
+
+		if (handle_out_of_range) {
+			DBG(client, "Error handle not effected, approving retry");
+			bt_att_retry_request(client->att, att_id);
+		} else {
+			DBG(client, "Error handle is in range of svc chngd");
+			bt_att_cancel_retry(client->att, att_id);
+		}
+		return;
+	}
+
+	if (!att_id) {
+		DBG(client, "No pending retry operation");
+		return;
+	}
+
+	if (!success) {
+		DBG(client,
+		"Failed to read remote DB Hash, triggering full discovery");
+		goto trigger_discovery;
+	}
+
+	/* Extract hash value from result */
+	if (!result || !bt_gatt_iter_init(&iter, result))
+		goto trigger_discovery;
+
+	if (!bt_gatt_iter_next_read_by_type(&iter, &handle, &length,
+					     &remote_hash))
+		goto trigger_discovery;
+
+	if (length != 16) {
+		DBG(client, "Invalid DB Hash length: %u", length);
+		goto trigger_discovery;
+	}
+
+	/* Get local hash from database */
+	bt_uuid16_create(&uuid, GATT_CHARAC_DB_HASH);
+	gatt_db_find_by_type(client->db, 0x0001, 0xffff, &uuid,
+			     get_first_attribute, &hash_attr);
+
+	if (hash_attr) {
+		gatt_db_attribute_read(hash_attr, 0, BT_ATT_OP_READ_REQ, NULL,
+				       db_hash_read_value_cb, &local_hash);
+	}
+
+	/* Compare hashes */
+	if (local_hash && !memcmp(local_hash, remote_hash, 16)) {
+		/* Hashes match - safe to retry */
+		DBG(client, "DB Hash matches, approving retry");
+		bt_att_retry_request(client->att, att_id);
+		return;
+	}
+
+	/* Hashes differ - need service discovery */
+	DBG(client, "DB Hash differs, canceling retry and triggering discovery");
+
+trigger_discovery:
+	bt_att_cancel_retry(client->att, att_id);
+
+	if (!client->in_svc_chngd)
+		process_service_changed(client, 0x0001, 0xffff);
+}
+
+static int gatt_client_retry_cb(uint8_t opcode, uint8_t error_code,
+				 const void *pdu, uint16_t length,
+				 unsigned int att_id, void *user_data)
+{
+	struct bt_gatt_client *client = user_data;
+	bt_uuid_t uuid;
+	uint16_t error_handle = 0;
+	const struct bt_att_pdu_error_rsp *error_pdu;
+	bool handle_out_of_range = false;
+
+	assert(client);
+
+	/* Only handle DB_OUT_OF_SYNC errors */
+	if (error_code != BT_ATT_ERROR_DB_OUT_OF_SYNC)
+		return BT_ATT_RETRY_NO;
+
+	if (pdu && length >= sizeof(struct bt_att_pdu_error_rsp)) {
+		error_pdu = (void *)pdu;
+		error_handle = get_le16(&error_pdu->handle);
+		client->pending_error_handle = error_handle;
+	}
+
+	/* If a Service Changed indication is received at this stage, the
+	 * pending request may be retried once we have verified that the
+	 * affected attribute handle is not within the range impacted by
+	 * the service change.
+	 */
+	if (client->in_svc_chngd) {
+		handle_out_of_range =
+			is_handle_out_of_range(error_handle, client);
+
+		if (handle_out_of_range)
+			return BT_ATT_RETRY_YES;
+		else
+			return BT_ATT_RETRY_NO;
+	}
+
+	/* Store the att_id for later use */
+	client->pending_retry_att_id = att_id;
+
+	/* Read remote DB Hash to compare */
+	bt_uuid16_create(&uuid, GATT_CHARAC_DB_HASH);
+	if (!bt_gatt_read_by_type(client->att, 0x0001, 0xffff, &uuid,
+				   db_hash_check_cb, client, NULL)) {
+		DBG(client, "Failed to read DB Hash, canceling retry");
+		client->pending_retry_att_id = 0;
+		client->pending_error_handle = 0;
+		return BT_ATT_RETRY_NO;
+	}
+
+	return BT_ATT_RETRY_PENDING;
+}
+
 static struct bt_gatt_client *gatt_client_new(struct gatt_db *db,
 							struct bt_att *att,
 							uint8_t features)
@@ -2382,6 +2547,9 @@ static struct bt_gatt_client *gatt_client_new(struct gatt_db *db,
 	client->db = gatt_db_ref(db);
 	client->features = features;
 
+	/* Register retry callback for DB out of sync handling */
+	bt_att_set_retry_cb(att, gatt_client_retry_cb, client, NULL);
+
 	return client;
 
 fail:
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index c1cbbdc91..8dee34a9e 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -790,6 +790,22 @@ done:
 	discovery_op_complete(op, success, att_ecode);
 }
 
+uint16_t bt_gatt_req_get_start_handle(struct bt_gatt_request *req)
+{
+	if (!req)
+		return 0;
+
+	return req->start_handle;
+}
+
+uint16_t bt_gatt_req_get_end_handle(struct bt_gatt_request *req)
+{
+	if (!req)
+		return 0;
+
+	return req->end_handle;
+}
+
 static struct bt_gatt_request *discover_services(struct bt_att *att,
 					bt_uuid_t *uuid,
 					uint16_t start, uint16_t end,
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index 7623862e9..2bf5aad46 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -101,3 +101,6 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
 					bt_gatt_request_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
+
+uint16_t bt_gatt_req_get_end_handle(struct bt_gatt_request *req);
+uint16_t bt_gatt_req_get_start_handle(struct bt_gatt_request *req);
-- 
2.34.1

