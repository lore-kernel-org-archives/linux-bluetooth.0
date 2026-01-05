Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C206C313E00
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767609518; cv=none; b=rKp0mpVy7zaTLQsW/bydiFxQrN+BRPjdEMgI6UREfMPdyDo2cQnyL9CoG8yebSMuauCRcqq+/3fXr+LOnOHEMTMM7wg/HUbGw9975YEpci1VdTrtz/G/v5VKfGs1O+EIcBwoAP3iy1WdfU1BqZhSln9YE91hR51RyX2Sm4hBNIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767609518; c=relaxed/simple;
	bh=7H9mDkQEbzLvMaY+/SjpMdrv+M5g87IjZwqI1gXnvNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nc+mJRrDAm4IN0HAZciNxKYpNx2YaK2aCYAIqpFpQ45o8onbEwTbSS1l3fxcppD23pn41N+UcymlQWXE2rk5rZ6Sxci0fVf7kYFHM8mZmWLGBn2Es5AkPtDu8ulqoJT4iTHJXdCNfqnYUgCkJNQIzbEpi7iKUUYauyyqAm/orJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=onKY69mC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="onKY69mC"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6059mek53541662;
	Mon, 5 Jan 2026 10:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+sGWAUI4zzB
	OhqHgPmMFUXELijLMn0znb91YHVzq9FE=; b=onKY69mCxqU88YFR1YJQco7Pe6X
	Z8PG7ELRUpoLPm3MiExo1QpJXxdkHr8KIJip9SWGVGLnLlo+2S3uw2w9Ba+y3Grg
	NYAS7a6VBFWvL488lBd0OJx12ykhiJqaSAmr8EgNf4eRG5TC9zZu8evf05CEL6Vc
	MRIfzHtLHrC9tjfRE5OVf64ORqeQc3fYlztliFZCEMwIA0Iu3xPqdlt1oOIf/nH4
	e3y2+MDqnp7ALRT6ngoXmyK9/vqC30cbUUQUtppC9/AFuUub9UfwssEpRjWcuqaz
	oeFRqULARq3XaWo0B7et5EBObhtBGARwGuqZnX8iH0SZ7VrMzsdMqrTPhRg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bg57sh6w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 10:38:35 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 605AcXgc014325;
	Mon, 5 Jan 2026 10:38:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4bev6kry80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 10:38:33 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 605AcXoM014320;
	Mon, 5 Jan 2026 10:38:33 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 605AcWd7014318
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 10:38:33 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4766378)
	id C87FB237A3; Mon,  5 Jan 2026 18:38:31 +0800 (CST)
From: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com,
        wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com,
        Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Subject: [PATCH v2 1/1] gatt-client:Implement error handling for DB_OUT_OF_SYNC in GATT caching.
Date: Mon,  5 Jan 2026 18:38:28 +0800
Message-Id: <20260105103828.105346-2-mengshi.wu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260105103828.105346-1-mengshi.wu@oss.qualcomm.com>
References: <20260105103828.105346-1-mengshi.wu@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=UJ/Q3Sfy c=1 sm=1 tr=0 ts=695b94ab cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=u6sptBXblWUB-6zrb-gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA5MyBTYWx0ZWRfX8DxH48kc6G8f
 Wvc59vdj/NCBc8MRpsFgi1Agea82YWpkAX3e+8apFVQnzOFjgjzXH/IZJiuekFYyANvWywQ5Yn4
 LnTwlxn4/Bgg++je2zlwbnKrKXXwrIuPzEHclSoBgc8uZ/VlEst1XADoC0bbOedCD3Gy4BCncAZ
 zoXjdyXgdzDnNEU61hm/gW7V1Nt4Vgjcd5/rq2L5+B/dwpbt+cT0GuPdrboJeYduEnRaT9F2+7Y
 +ktWNB3v9Sp17M/qDvjiKVP++YTBBmMdpeNgOw0uYqu07hcVpEE9T+VbCbfgcaa0weMbnLR3jtX
 QSOJXcY2oIje2msKCapap0pUNyXa3OSXAclli74OAJLrBvthryP6sKx3skdfsTAQ91AMsjAbXAN
 m4E7ZmthDHW9svEXpy2gQ4bK/vJM006UMTnD1tvR7LSI8o3I/foPJzeDbgltS+/gDqUMK48tU0b
 f2HeVIYa/2T4XZud1Zg==
X-Proofpoint-ORIG-GUID: 53GYAVWn9r0BYZ9gFP-_68jQMFgP6MdC
X-Proofpoint-GUID: 53GYAVWn9r0BYZ9gFP-_68jQMFgP6MdC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601050093

Implement automatic recovery when ATT_ECODE_DB_OUT_OF_SYNC error is
received from the remote device. The recovery mechanism:

- Detects DB_OUT_OF_SYNC errors during GATT operations
- Extracts affected handles from the original request PDU
- Checks if Service Changed indications overlap with those handles
- Verifies database consistency using Database Hash characteristic
- Automatically retries the original request if DB is consistent
- Automatically retries the original request if handle is not affected

This may prevent some application-level failures when the GATT database
changes on the remote device.

Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
---
 src/shared/gatt-client.c  | 376 +++++++++++++++++++++++++++++++++++++-
 src/shared/gatt-helpers.c |  16 ++
 src/shared/gatt-helpers.h |   3 +
 3 files changed, 392 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index f8ebab3fa..22b6c5d1d 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -41,6 +41,9 @@
 	gatt_log(_client, "[%p] %s:%s() " _format, _client, __FILE__, \
 		__func__, ## arg)
 
+#define DB_OUT_OF_SYNC_HOLD_ON true
+#define DB_OUT_OF_SYNC_GO_ON false
+
 struct ready_cb {
 	bt_gatt_client_callback_t callback;
 	bt_gatt_client_destroy_func_t destroy;
@@ -114,6 +117,9 @@ struct bt_gatt_client {
 
 	struct bt_gatt_request *discovery_req;
 	unsigned int mtu_req_id;
+
+	/* Pending DB out of sync handling */
+	struct db_out_of_sync_data *pending_db_sync;
 };
 
 struct request {
@@ -126,8 +132,31 @@ struct request {
 	unsigned int att_id;
 	void *data;
 	void (*destroy)(void *);
+
+	/* For DB_OUT_OF_SYNC recovery capability */
+	uint8_t *sent_pdu;
+	uint16_t sent_pdu_len;
+	uint8_t sent_opcode;
+};
+
+struct db_out_of_sync_data {
+	struct bt_gatt_client *client;
+	struct request *original_req;
+	uint8_t opcode;
+	uint8_t *pdu;
+	uint16_t pdu_len;
+	bt_att_response_func_t att_callback;
+	uint16_t *handles;
+	uint8_t num_handles;
+	bool handle_overlaps;
+	bool svc_changed_arrived;
+	/* Store original error PDU */
+	struct bt_att_pdu_error_rsp error_pdu;
 };
 
+static void db_out_of_sync_data_free(struct db_out_of_sync_data *data);
+static void call_original_callback_with_error(struct db_out_of_sync_data *data);
+
 static struct request *request_ref(struct request *req)
 {
 	__sync_fetch_and_add(&req->ref_count, 1);
@@ -210,6 +239,7 @@ static void request_unref(void *data)
 			notify_client_idle(client);
 	}
 
+	free(req->sent_pdu);
 	free(req);
 }
 
@@ -1968,11 +1998,272 @@ fail:
 		"Failed to initiate service discovery after Service Changed");
 }
 
+static void db_out_of_sync_recover(struct bt_gatt_client *client)
+{
+	struct db_out_of_sync_data *pending = client->pending_db_sync;
+	unsigned int new_att_id = 0;
+
+	assert(pending);
+
+	new_att_id = bt_att_send(client->att, pending->opcode, pending->pdu,
+				 pending->pdu_len, pending->att_callback,
+				 request_ref(pending->original_req),
+				 request_unref);
+	if (new_att_id)
+		pending->original_req->att_id = new_att_id;
+	else
+		call_original_callback_with_error(pending);
+	client->pending_db_sync = NULL;
+	db_out_of_sync_data_free(pending);
+}
+
+static void db_hash_check_read_cb(bool success, uint8_t att_ecode,
+				  struct bt_gatt_result *result,
+				  void *user_data)
+{
+	struct bt_gatt_client *client = user_data;
+	struct db_out_of_sync_data *pending = client->pending_db_sync;
+	const uint8_t *local_hash = NULL, *remote_hash;
+	struct gatt_db_attribute *hash_attr = NULL;
+	struct service_changed_op *op;
+	struct bt_gatt_iter iter;
+	bt_uuid_t uuid;
+	uint16_t handle, len;
+
+	assert(pending);
+
+	if (pending->svc_changed_arrived) {
+		if (!pending->handle_overlaps) {
+			/* No overlap - resend original request */
+			DBG(client, "Service changed range doesn't overlap");
+			db_out_of_sync_recover(client);
+		}
+
+		return;
+	}
+
+	/* If read failed, fall back to full re-discovery */
+	if (!success)
+		goto trigger_rediscovery;
+
+	if (!result || !bt_gatt_iter_init(&iter, result))
+		goto trigger_rediscovery;
+
+	if (!bt_gatt_iter_next_read_by_type(&iter, &handle,
+					&len, &remote_hash))
+		goto trigger_rediscovery;
+
+	if (len != 16)
+		goto trigger_rediscovery;
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_DB_HASH);
+	gatt_db_find_by_type(client->db, 0x0001, 0xffff, &uuid,
+			     get_first_attribute, &hash_attr);
+
+	if (hash_attr) {
+		gatt_db_attribute_read(hash_attr, 0, BT_ATT_OP_READ_REQ, NULL,
+				       db_hash_read_value_cb, &local_hash);
+	}
+
+	/* If hashes match, no need to trigger re-discovery */
+	if (local_hash && !memcmp(local_hash, remote_hash, 16)) {
+		db_out_of_sync_recover(client);
+		return;
+	}
+
+	DBG(client, "DB Hash mismatch: triggering re-discovery");
+
+trigger_rediscovery:
+	call_original_callback_with_error(pending);
+	client->pending_db_sync = NULL;
+	db_out_of_sync_data_free(pending);
+
+	process_service_changed(client, 0x0001, 0xffff);
+}
+
+static void db_out_of_sync_data_free(struct db_out_of_sync_data *data)
+{
+	if (!data)
+		return;
+
+	if (data->original_req)
+		request_unref(data->original_req);
+
+	free(data->pdu);
+	free(data->handles);
+	free(data);
+}
+
+static bool check_handle_overlap(uint16_t *handles, uint8_t num_handles,
+				 uint16_t start, uint16_t end)
+{
+	uint8_t i;
+
+	if (!handles)
+		return true;
+
+	for (i = 0; i < num_handles; i++) {
+		if (handles[i] >= start && handles[i] <= end)
+			return true;
+	}
+
+	return false;
+}
+
+static uint8_t extract_handles_from_pdu(uint8_t opcode, const uint8_t *pdu,
+					uint16_t pdu_len, uint16_t **handles)
+{
+	uint8_t num_handles = 0;
+	uint16_t *handle_array;
+	uint16_t i;
+
+	switch (opcode) {
+	case BT_ATT_OP_READ_REQ:
+	case BT_ATT_OP_READ_BLOB_REQ:
+	case BT_ATT_OP_WRITE_REQ:
+	case BT_ATT_OP_WRITE_CMD:
+	case BT_ATT_OP_PREP_WRITE_REQ:
+		/* Single handle at offset 0 */
+		num_handles = 1;
+		handle_array = malloc(sizeof(uint16_t));
+		if (handle_array)
+			handle_array[0] = get_le16(pdu);
+		break;
+
+	case BT_ATT_OP_READ_MULT_REQ:
+	case BT_ATT_OP_READ_MULT_VL_REQ:
+		/* Multiple handles, 2 bytes each */
+		num_handles = pdu_len / 2;
+		handle_array = malloc(num_handles * sizeof(uint16_t));
+		if (handle_array) {
+			for (i = 0; i < num_handles; i++)
+				handle_array[i] = get_le16(pdu + (i * 2));
+		}
+		break;
+
+	default:
+		return 0;
+	}
+
+	if (!handle_array)
+		return 0;
+
+	*handles = handle_array;
+	return num_handles;
+}
+
+static void call_original_callback_with_error(struct db_out_of_sync_data *data)
+{
+	struct request *req = data->original_req;
+
+	if (!req || !data->att_callback)
+		return;
+
+	data->att_callback(BT_ATT_OP_ERROR_RSP, &(data->error_pdu),
+			   sizeof(struct bt_att_pdu_error_rsp), req);
+}
+
+static bool process_db_out_of_sync(struct bt_gatt_client *client,
+				   uint8_t att_ecode, const void *error_pdu,
+				   struct request *req,
+				   bt_att_response_func_t callback)
+{
+	struct db_out_of_sync_data *pending;
+	struct service_changed_op *op;
+	struct bt_gatt_request *gatt_req_op = client->discovery_req;
+	const struct bt_att_pdu_error_rsp *epdu = error_pdu;
+	bt_uuid_t uuid;
+	unsigned int new_att_id = 0;
+
+	if (att_ecode != BT_ATT_ERROR_DB_OUT_OF_SYNC)
+		return DB_OUT_OF_SYNC_GO_ON;
+
+	/* Check if we already have a pending operation */
+	if (client->pending_db_sync)
+		return DB_OUT_OF_SYNC_GO_ON;
+
+	/* Only handle if we have the necessary request info */
+	if (!req || !req->sent_pdu || !callback)
+		goto trigger_rediscovery;
+
+	/* Create pending structure */
+	pending = new0(struct db_out_of_sync_data, 1);
+	if (!pending)
+		goto trigger_rediscovery;
+
+	pending->client = client;
+	pending->original_req = request_ref(req);
+	pending->att_callback = callback;
+	pending->opcode = req->sent_opcode;
+	pending->pdu_len = req->sent_pdu_len;
+
+	/* Copy PDU */
+	pending->pdu = malloc(pending->pdu_len);
+	if (!pending->pdu) {
+		db_out_of_sync_data_free(pending);
+		goto trigger_rediscovery;
+	}
+	memcpy(pending->pdu, req->sent_pdu, pending->pdu_len);
+
+	/* Store original error PDU */
+	memcpy(&(pending->error_pdu), error_pdu,
+	       sizeof(struct bt_att_pdu_error_rsp));
+
+	/* Extract handles from PDU */
+	pending->num_handles =
+		extract_handles_from_pdu(pending->opcode, pending->pdu,
+					 pending->pdu_len, &pending->handles);
+	if (!pending->num_handles) {
+		db_out_of_sync_data_free(pending);
+		goto trigger_rediscovery;
+	}
+
+	/* Store pending operation */
+	client->pending_db_sync = pending;
+
+	/* Initiate hash read */
+	bt_uuid16_create(&uuid, GATT_CHARAC_DB_HASH);
+
+	if (bt_gatt_read_by_type(client->att, 0x0001, 0xffff, &uuid,
+				 db_hash_check_read_cb, client, NULL)) {
+		return DB_OUT_OF_SYNC_HOLD_ON;
+	}
+
+	client->pending_db_sync = NULL;
+	db_out_of_sync_data_free(pending);
+
+trigger_rediscovery:
+
+	if (client->in_svc_chngd) {
+		if (client->discovery_req && req && req->sent_pdu && callback &&
+		    (epdu->handle != 0) && gatt_req_op &&
+		    (bt_gatt_request_get_start_handle(gatt_req_op) >
+			     epdu->handle ||
+		     bt_gatt_request_get_end_handle(gatt_req_op) <
+			     epdu->handle)) {
+			new_att_id = bt_att_send(client->att, req->sent_opcode,
+						 req->sent_pdu,
+						 req->sent_pdu_len, callback,
+						 request_ref(req),
+						 request_unref);
+			if (new_att_id) {
+				req->att_id = new_att_id;
+				return DB_OUT_OF_SYNC_HOLD_ON;
+			}
+		}
+		return DB_OUT_OF_SYNC_GO_ON;
+	}
+
+	process_service_changed(client, 0x0001, 0xffff);
+	return DB_OUT_OF_SYNC_GO_ON;
+}
+
 static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
 					uint16_t length, void *user_data)
 {
 	struct bt_gatt_client *client = user_data;
 	struct service_changed_op *op;
+	struct db_out_of_sync_data *pending;
 	uint16_t start, end;
 
 	if (length != 4)
@@ -1990,6 +2281,14 @@ static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
 	DBG(client, "Service Changed received - start: 0x%04x end: 0x%04x",
 			start, end);
 
+	/* Check if there's a pending DB out of sync operation */
+	pending = client->pending_db_sync;
+	if (pending) {
+		pending->svc_changed_arrived = true;
+		pending->handle_overlaps = check_handle_overlap(pending->handles,
+					pending->num_handles, start, end);
+	}
+
 	if (!client->in_svc_chngd) {
 		process_service_changed(client, start, end);
 		return;
@@ -2332,6 +2631,10 @@ static void att_disconnect_cb(int err, void *user_data)
 
 	client->disc_id = 0;
 
+	/* Cleanup pending DB out of sync operation */
+	db_out_of_sync_data_free(client->pending_db_sync);
+	client->pending_db_sync = NULL;
+
 	bt_att_unref(client->att);
 	client->att = NULL;
 
@@ -2712,10 +3015,15 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu, uint16_t length,
 			(!pdu && length)) {
 		success = false;
 
-		if (opcode == BT_ATT_OP_ERROR_RSP)
+		if (opcode == BT_ATT_OP_ERROR_RSP) {
 			att_ecode = process_error(pdu, length);
-		else
+			if (process_db_out_of_sync(req->client, att_ecode,
+						   pdu, req,
+						   read_multiple_cb))
+				return;
+		} else {
 			att_ecode = 0;
+		}
 
 		pdu = NULL;
 		length = 0;
@@ -2799,6 +3107,13 @@ unsigned int bt_gatt_client_read_multiple(struct bt_gatt_client *client,
 		BT_GATT_CHRC_CLI_FEAT_EATT ? BT_ATT_OP_READ_MULT_VL_REQ :
 		BT_ATT_OP_READ_MULT_REQ;
 
+	/* Store PDU for potential resend on DB_OUT_OF_SYNC */
+	req->sent_opcode = opcode;
+	req->sent_pdu_len = num_handles * 2;
+	req->sent_pdu = malloc(req->sent_pdu_len);
+	if (req->sent_pdu)
+		memcpy(req->sent_pdu, pdu, req->sent_pdu_len);
+
 	req->att_id = bt_att_send(client->att, opcode, pdu, num_handles * 2,
 							read_multiple_cb, req,
 							request_unref);
@@ -2867,6 +3182,10 @@ static void read_long_cb(uint8_t opcode, const void *pdu,
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		success = false;
 		att_ecode = process_error(pdu, length);
+		if (process_db_out_of_sync(req->client, att_ecode,
+					   pdu, req,
+					   read_long_cb))
+			return;
 		goto done;
 	}
 
@@ -2975,6 +3294,13 @@ unsigned int bt_gatt_client_read_long_value(struct bt_gatt_client *client,
 		att_op = BT_ATT_OP_READ_REQ;
 	}
 
+	/* Store PDU for potential resend on DB_OUT_OF_SYNC */
+	req->sent_opcode = att_op;
+	req->sent_pdu_len = pdu_len;
+	req->sent_pdu = malloc(req->sent_pdu_len);
+	if (req->sent_pdu)
+		memcpy(req->sent_pdu, pdu, req->sent_pdu_len);
+
 	req->att_id = bt_att_send(client->att, att_op, pdu, pdu_len,
 					read_long_cb, req, request_unref);
 
@@ -3053,6 +3379,9 @@ static void write_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		success = false;
 		att_ecode = process_error(pdu, length);
+		if (process_db_out_of_sync(req->client, att_ecode,
+					   pdu, req, write_cb))
+			return;
 		goto done;
 	}
 
@@ -3096,6 +3425,13 @@ unsigned int bt_gatt_client_write_value(struct bt_gatt_client *client,
 	put_le16(value_handle, pdu);
 	memcpy(pdu + 2, value, length);
 
+	/* Store PDU for potential resend on DB_OUT_OF_SYNC */
+	req->sent_opcode = BT_ATT_OP_WRITE_REQ;
+	req->sent_pdu_len = 2 + length;
+	req->sent_pdu = malloc(req->sent_pdu_len);
+	if (req->sent_pdu)
+		memcpy(req->sent_pdu, pdu, req->sent_pdu_len);
+
 	req->att_id = bt_att_send(client->att, BT_ATT_OP_WRITE_REQ,
 							pdu, 2 + length,
 							write_cb, req,
@@ -3216,6 +3552,10 @@ static void execute_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		success = false;
 		att_ecode = process_error(pdu, length);
+		if (process_db_out_of_sync(req->client, att_ecode,
+					   pdu, req,
+					   execute_write_cb))
+			return;
 	} else if (opcode != BT_ATT_OP_EXEC_WRITE_RSP || pdu || length)
 		success = false;
 
@@ -3281,6 +3621,10 @@ static void prepare_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		success = false;
 		att_ecode = process_error(pdu, length);
+		if (process_db_out_of_sync(req->client, att_ecode,
+					   pdu, req,
+					   prepare_write_cb))
+			return;
 		goto done;
 	}
 
@@ -3401,11 +3745,15 @@ unsigned int bt_gatt_client_write_long_value(struct bt_gatt_client *client,
 	put_le16(offset, pdu + 2);
 	memcpy(pdu + 4, op->value, op->cur_length);
 
+	/* Store PDU for potential resend on DB_OUT_OF_SYNC */
+	req->sent_opcode = BT_ATT_OP_PREP_WRITE_REQ;
+	req->sent_pdu_len = op->cur_length + 4;
+	req->sent_pdu = pdu;
+
 	req->att_id = bt_att_send(client->att, BT_ATT_OP_PREP_WRITE_REQ,
 							pdu, op->cur_length + 4,
 							prepare_write_cb, req,
 							request_unref);
-	free(pdu);
 
 	if (!req->att_id) {
 		op->destroy = NULL;
@@ -3450,6 +3798,10 @@ static void prep_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
 		success = false;
 		reliable_error = false;
 		att_ecode = process_error(pdu, length);
+		if (process_db_out_of_sync(req->client, att_ecode,
+					   pdu, req,
+					   prep_write_cb))
+			return;
 		goto done;
 	}
 
@@ -3566,6 +3918,13 @@ unsigned int bt_gatt_client_prepare_write(struct bt_gatt_client *client,
 	memcpy(op->pdu, pdu, length);
 	op->pdu_len = length;
 
+	/* Store PDU for potential resend on DB_OUT_OF_SYNC */
+	req->sent_opcode = BT_ATT_OP_PREP_WRITE_REQ;
+	req->sent_pdu_len = length;
+	req->sent_pdu = malloc(req->sent_pdu_len);
+	if (req->sent_pdu)
+		memcpy(req->sent_pdu, pdu, req->sent_pdu_len);
+
 	/*
 	 * Now we are ready to send command
 	 * Note that request_unref will be done on write execute
@@ -3600,6 +3959,10 @@ static void exec_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		success = false;
 		att_ecode = process_error(pdu, length);
+		if (process_db_out_of_sync(req->client, att_ecode,
+					   pdu, req,
+					   exec_write_cb))
+			return;
 		goto done;
 	}
 
@@ -3659,6 +4022,13 @@ unsigned int bt_gatt_client_write_execute(struct bt_gatt_client *client,
 	req->data = op;
 	req->destroy = destroy_write_op;
 
+	/* Store PDU for potential resend on DB_OUT_OF_SYNC */
+	req->sent_opcode = BT_ATT_OP_EXEC_WRITE_REQ;
+	req->sent_pdu_len = sizeof(pdu);
+	req->sent_pdu = malloc(req->sent_pdu_len);
+	if (req->sent_pdu)
+		memcpy(req->sent_pdu, &pdu, req->sent_pdu_len);
+
 	req->att_id = bt_att_send(client->att, BT_ATT_OP_EXEC_WRITE_REQ, &pdu,
 						sizeof(pdu), exec_write_cb,
 						req, request_unref);
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index c1cbbdc91..e3a6548c4 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -790,6 +790,22 @@ done:
 	discovery_op_complete(op, success, att_ecode);
 }
 
+uint16_t bt_gatt_request_get_start_handle(struct bt_gatt_request *request)
+{
+	if (!request)
+		return 0;
+
+	return request->start_handle;
+}
+
+uint16_t bt_gatt_request_get_end_handle(struct bt_gatt_request *request)
+{
+	if (!request)
+		return 0;
+
+	return request->end_handle;
+}
+
 static struct bt_gatt_request *discover_services(struct bt_att *att,
 					bt_uuid_t *uuid,
 					uint16_t start, uint16_t end,
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index 7623862e9..7a51ec619 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -101,3 +101,6 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
 					bt_gatt_request_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
+
+uint16_t bt_gatt_request_get_end_handle(struct bt_gatt_request *request);
+uint16_t bt_gatt_request_get_start_handle(struct bt_gatt_request *request);
-- 
2.34.1

