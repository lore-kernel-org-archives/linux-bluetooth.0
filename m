Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F714B44CC
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860762; cv=none; b=GWIK4dtYuEOSpnRgvy3l61fWwgjZ6yt3C7/TUatKQ7w3Q/qElWjlFkr3DRQFXXMfurRoDU7Hn1CqLHO3vHRP12arn9V0zOr7axYKfwhLLqaPjOY6Q0Z+AGh5qOZkFJHuRR8xM2nxbY/C3cohOZcGsXTXDNCjy/OnxtHCv+NECZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860762; c=relaxed/simple;
	bh=Ayli0CeoXSEiQNqCRKnp8AHSDT27ZAqObuFwXss4WGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8Lg5wn+SODPABwfRsom7peeOpuh5lvCl6l6PeUbRs4wQGeBAaWgOVNvqlpKxjn5FnF6stAFdc+oA1ACGCUSJTRpsHoBdGMG//a9quJByCocYA+AZ8sYlKorEWRQf3d1y5Skmd5d9bVNrczNZMKD5loPommvDm1DYvlb2zaSNf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Udy4DogJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Udy4DogJ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691CfxeQ1512010
	for <linux-bluetooth@vger.kernel.org>; Thu, 1 Oct 2026 13:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QOQtRu5Ci/j
	/0tu/LCSs5wPtJGaDM8QyIBMxJ2ZQnrg=; b=Udy4DogJ15P5UD0KyvipGNLCz6U
	hnq/Yw6iM1u/wEQMRz8669TLPJRhYMTCv6Hlu6l4cHdUtMY3qCvK4WI0f6UiztcI
	pf+ksdG9eNCi5vMM/JDa4mJ5sxAGJCEUZLfAsbe9BflE5LKEQtGjx1yM+6tBeB31
	ScojjiSRUCH+Ww1nX7f2d6NTIiEzXa+oesEEw4Tn33I3jdnXcGs3/kk9Z7exMXkb
	spnNUEw5TvvsNJgic9rPqaOJJMYFNQ+5GshuWX/Vfj4DSkj1vjVrN+xCSblp87xk
	BlVgzwAXoxFai2IXdjFSHee7Wf5tNfQWOsj06RXgLp+PT3V+RqQi2OJPHuA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h188suw1h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 13:19:16 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 691DJEn12496316;
	Thu, 1 Oct 2026 13:19:14 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 691DJDbC2496295
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 13:19:13 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 06D8549BBE; Thu,  1 Oct 2026 21:19:13 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH 03/11] shared/rap: Honor CCCD transport for RAS on-demand ranging data
Date: Thu,  1 Oct 2026 21:18:49 +0800
Message-ID: <20261001131900.707485-4-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfXzfJzikhaQL9d
 P3IeQQbKlIUHp/tGIpYc50f0C3yq+nw6YZVz52GaFCB9QkRbP4C2P7bHzNvEah4waiKErDcd6rD
 cIg91yzwPKWgYg+sOx7iKpZWogF+bFQ=
X-Authority-Analysis: v=2.4 cv=OozaWC/t c=1 sm=1 tr=0 ts=6abe5dd4 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=9mR2QVjV9MAvOuKvHQYA:9
X-Proofpoint-ORIG-GUID: hMEt_smzyKFLSfaDzesCsa7S8meFrMAZ
X-Proofpoint-GUID: hMEt_smzyKFLSfaDzesCsa7S8meFrMAZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfX4HbirZv0iExE
 9fxlUuAUA56+Fm3bskUHkqQV8Tm/rju2HJDHHA9g9S+xKGMTQACYufCYmFStfIdfgMya4r3v053
 eSl0DdzMrXKVavHgHK73e/voDfJ5JUcz8/Qosg8crWzmnbHkDIGFKROpI32PxNe7X3mZtgDPkcU
 jsi2HyLbipsxTDy9F9nv3LOmxOzSsnknHND/eX0QAfvbTsTFl+TW62QLTmwqG7Ciyn7PXsAlfm/
 vpPGNoNSHgSmUJId66MRQlUYEX0UDo979PoyC9xNc7AHcS0Eq35tv9cJ3ykji2NWT9+3HtH+71n
 t734OG/8hVRXEuZdby71pQiisSKr+r7eMRXtW8MoBdgLS69CfDOZ93U6+jejV2kQUaFrLPh66XJ
 Pzd9hDIUZeWID8LHAV53o5Pnnw/O/e6UCfpKbYqICXFyJ2UzjcFcv6KUoh4h9s17LRKu5MwjZzX
 e5NAmSP3ZHtLcbDkywQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010053

Complete the RAS responder handling of On-demand Ranging Data so the
transport used for each notified characteristic follows the peer's CCCD
subscription. The On-demand Ranging Data, RAS Control Point, Ranging
Data Ready and Ranging Data Overwritten characteristics are delivered
as notifications or indications according to how the client configured
their CCCDs. Ready and Overwritten gain a CCC write callback so their
subscribed transport is tracked, and a Ranging Counter each so a read
returns the value last notified.

When a client enables both transports (0x0003) the spec does not pick the
same one everywhere, so the two rules are kept in separate helpers:
Ranging Data Ready and Ranging Data Overwritten are indicated per RAS
3.4.2 and 3.5.2, while On-demand and Real-time Ranging Data are notified
per RAS 3.2.2 and 3.2.3.1. The RAS Control Point is indicate-only.

Ranging data is segmented across ATT PDUs, and it was queued a whole
transfer at a time. Notifications land on the att write queue, which
pick_next_send_op() drains ahead of the request queue and with no flow
control of its own, so doing that starves incoming ATT operations until the
last segment has been written: a Control Point write arriving mid-transfer
is only answered once the transfer ends.

Send one segment at a time instead. Indications go out with bt_att_send()
and the next segment is queued from the confirmation callback; notifications
have no confirmation to gate on, so the next one is queued from a short
timeout. Either way a single segment is outstanding, so an Abort Operation
stops the transfer rather than letting a queued one drain out.

The notification delay cannot be zero: a zero timeout yields the event loop
without waiting, so a Control Point write is only seen once it has already
arrived, and a short transfer can finish before an Abort crosses the air
interface. Against RAS/SR/SPE/BI-05-C, which writes an invalid Abort
Operation mid-transfer, 0 ms fails and 5 ms passes, so use that.

Assisted-by: Claude:claude-opus-4.8
---
 src/shared/rap.c | 386 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 336 insertions(+), 50 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index e55bbe088..a794de044 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -33,6 +33,11 @@
  * ras_ondemand_client permanently stuck waiting.
  */
 #define RAS_CP_RESPONSE_TIMEOUT (10 * 1000)
+#define RAS_SEGMENT_TIMEOUT (1 * 1000)
+/* Delay between On-demand ranging-data notification segments, see
+ * send_ondemand_segment_data_cb().
+ */
+#define RAS_SEGMENT_NFY_PACE_MS 5
 
 #define DBG(_rap, fmt, ...) \
 	rap_debug(_rap, "%s:%s() " fmt, __FILE__, __func__, ##__VA_ARGS__)
@@ -337,10 +342,12 @@ enum ras_cp_response_code {
  */
 struct ras_ondemand_cache {
 	bool     valid;
+	bool     sending;
 	uint16_t counter;
 	struct iovec data;
 	uint16_t send_index;
 	struct segmentation_header seg_hdr;
+	unsigned int send_id;
 };
 
 /* Initiator role: which RAS Control Point request the client is
@@ -378,10 +385,16 @@ struct ras {
 	struct gatt_db_attribute *ready_ccc;
 	struct gatt_db_attribute *overwritten_chrc;
 	struct gatt_db_attribute *overwritten_ccc;
+	uint16_t ready_counter;
+	uint16_t overwritten_counter;
 
 	/* CCC state tracking for mutual exclusivity */
 	uint16_t realtime_ccc_value;
 	uint16_t ondemand_ccc_value;
+	/* CCC state for Ready/Overwritten so notifications are sent with the
+	 * transport (notification vs indication) the client actually enabled. */
+	uint16_t ready_ccc_value;
+	uint16_t overwritten_ccc_value;
 
 	/* Initiator role: pending RAS Control Point request state */
 	struct ras_ondemand_client client;
@@ -396,6 +409,9 @@ static inline bool ras_is_ondemand_mode(const struct ras *ras)
  * defined alongside the other RAS Control Point client helpers.
  */
 static void ras_ondemand_client_reset(struct ras *ras);
+static void ras_ondemand_cache_clear(struct bt_rap *rap);
+static bool ras_cp_write_op(struct bt_rap *rap, struct ras *ras,
+				uint8_t opcode, uint16_t counter);
 
 struct bt_rap_db {
 	struct gatt_db *db;
@@ -942,8 +958,7 @@ void bt_rap_detach(struct bt_rap *rap)
 	 * connection so a reconnect (by this or another central) cannot
 	 * be served stale ranging data via Get_Ranging_Data.
 	 */
-	free(rap->cache.data.iov_base);
-	memset(&rap->cache, 0, sizeof(rap->cache));
+	ras_ondemand_cache_clear(rap);
 
 	if (rap->rrapdb && rap->rrapdb->ras) {
 		struct ras *ras = rap->rrapdb->ras;
@@ -1180,12 +1195,7 @@ static void ras_features_read_cb(struct gatt_db_attribute *attrib,
 				 void *user_data)
 {
 	struct ras *ras = user_data;
-	/*
-	 * Feature mask: bits 0-2 set:
-	 *  - Real-time ranging
-	 *  - Retrieve stored results
-	 *  - Abort operation
-	 */
+	/* Real-time ranging and Abort Operation are supported. */
 	uint8_t value[4] = { 0x01, 0x00, 0x00, 0x00 };
 
 	if (ras)
@@ -1203,9 +1213,7 @@ static void ras_ondemand_cache_clear(struct bt_rap *rap);
 
 /*
  * RAS Control Point handler, dispatches Get_Ranging_Data and
- * ACK_Ranging_Data. The remaining, optional
- * op codes (Retrieve_Lost_Ranging_Data_Segments, Abort_Operation,
- * Set_Filter) are not implemented.
+ * ACK_Ranging_Data. The remaining optional op codes are not implemented.
  */
 static void ras_control_point_write_cb(struct gatt_db_attribute *attrib,
 				       unsigned int id, uint16_t offset,
@@ -1236,6 +1244,13 @@ static void ras_control_point_write_cb(struct gatt_db_attribute *attrib,
 		return;
 	}
 
+	if (rap->cache.sending) {
+		ras_cp_send_response_code(rap, ras, RAS_CP_RSP_CODE_SERVER_BUSY);
+		goto done;
+	}
+
+	DBG(rap, "CP write: opcode=0x%02x len=%zu", value[0], len);
+
 	switch (value[0]) {
 	case RAS_CP_OP_GET_RANGING_DATA:
 		if (len != 3) {
@@ -1279,6 +1294,7 @@ static void ras_control_point_write_cb(struct gatt_db_attribute *attrib,
 		break;
 	}
 
+done:
 	gatt_db_attribute_write_result(attrib, id, 0);
 }
 
@@ -1289,13 +1305,12 @@ static void ras_data_ready_read_cb(struct gatt_db_attribute *attrib,
 				   void *user_data)
 {
 	struct ras *ras = user_data;
-	uint16_t counter = 0;
 	uint8_t value[2];
 
 	if (ras)
 		bt_rap_get_session(att, ras->rapdb->db);
 
-	put_le16(counter, value);
+	put_le16(ras ? ras->ready_counter : 0, value);
 	gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value));
 }
 
@@ -1306,11 +1321,12 @@ static void ras_data_overwritten_read_cb(struct gatt_db_attribute *attrib,
 					 void *user_data)
 {
 	struct ras *ras = user_data;
-	uint8_t value[2] = { 0x00, 0x00 };
+	uint8_t value[2];
 
 	if (ras)
 		bt_rap_get_session(att, ras->rapdb->db);
 
+	put_le16(ras ? ras->overwritten_counter : 0, value);
 	gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value));
 }
 
@@ -1380,6 +1396,75 @@ static void ras_ranging_data_ccc_write_cb(struct gatt_db_attribute *attrib,
 	gatt_db_attribute_write_result(attrib, id, 0);
 }
 
+/* Track the Ready / Overwritten CCC value so their notifications are sent with
+ * the transport the client subscribed to (notification vs indication). Both
+ * characteristics support NOTIFY and INDICATE; a headless RAS server must honor
+ * whichever the client enabled (e.g. RCO/BV-05-C uses Indication, BV-06-C uses
+ * Notification). */
+static void ras_ready_overwritten_ccc_write_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					const uint8_t *value, size_t len,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct ras *ras = user_data;
+	uint16_t ccc_value;
+
+	if (!ras) {
+		gatt_db_attribute_write_result(attrib, id,
+					BT_ATT_ERROR_UNLIKELY);
+		return;
+	}
+
+	if (offset) {
+		gatt_db_attribute_write_result(attrib, id,
+					BT_ATT_ERROR_INVALID_OFFSET);
+		return;
+	}
+
+	if (len != 2) {
+		gatt_db_attribute_write_result(attrib, id,
+			BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN);
+		return;
+	}
+
+	ccc_value = get_le16(value);
+
+	if (ccc_value != 0x0000 && ccc_value != 0x0001 &&
+	    ccc_value != 0x0002 && ccc_value != 0x0003) {
+		gatt_db_attribute_write_result(attrib, id,
+					BT_ERROR_WRITE_REQUEST_REJECTED);
+		return;
+	}
+
+	if (attrib == ras->ready_ccc)
+		ras->ready_ccc_value = ccc_value;
+	else if (attrib == ras->overwritten_ccc)
+		ras->overwritten_ccc_value = ccc_value;
+
+	gatt_db_attribute_write_result(attrib, id, 0);
+}
+
+/* Pick the notify transport for Ranging Data Ready / Ranging Data Overwritten
+ * from a tracked CCC value. RAS 3.4.2 and 3.5.2 require indications when both
+ * transports are enabled (0x0003), so notification is used only when it is the
+ * sole enabled transport. The On-demand and Real-time Ranging Data
+ * characteristics take the opposite rule and must not use this helper.
+ */
+static bool ras_ccc_use_indication(uint16_t ccc_value)
+{
+	return !(ccc_value & 0x0001) || (ccc_value & 0x0002);
+}
+
+/* Pick the notify transport for On-demand / Real-time Ranging Data. RAS 3.2.2
+ * and 3.2.3.1 require notifications when both transports are enabled (0x0003),
+ * so indication is used only when it is the sole enabled transport.
+ */
+static bool ras_data_ccc_use_indication(uint16_t ccc_value)
+{
+	return !(ccc_value & 0x0001);
+}
+
 /* Service registration - store attribute pointers */
 static struct ras *register_ras_service(struct gatt_db *db)
 {
@@ -1470,8 +1555,10 @@ static struct ras *register_ras_service(struct gatt_db *db)
 						  ras_data_ready_read_cb, NULL,
 						  ras);
 
-	ras->ready_ccc = gatt_db_service_add_ccc(ras->svc,
-					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+	ras->ready_ccc = gatt_db_service_add_ccc_custom(ras->svc,
+					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+					ras_ready_overwritten_ccc_write_cb,
+					ras);
 
 	/* RAS Data Overwritten */
 	bt_uuid16_create(&uuid, RAS_DATA_OVERWRITTEN_UUID);
@@ -1485,8 +1572,10 @@ static struct ras *register_ras_service(struct gatt_db *db)
 						  ras_data_overwritten_read_cb,
 						  NULL, ras);
 
-	ras->overwritten_ccc = gatt_db_service_add_ccc(ras->svc,
-					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+	ras->overwritten_ccc = gatt_db_service_add_ccc_custom(ras->svc,
+					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+					ras_ready_overwritten_ccc_write_cb,
+					ras);
 
 	/* Activate the service */
 	gatt_db_service_set_active(ras->svc, true);
@@ -1702,12 +1791,17 @@ static void ras_ondemand_cache_clear(struct bt_rap *rap)
 	if (!rap)
 		return;
 
+	if (rap->cache.send_id)
+		timeout_remove(rap->cache.send_id);
+
 	free(rap->cache.data.iov_base);
 	rap->cache.data.iov_base = NULL;
 	rap->cache.data.iov_len = 0;
 	rap->cache.valid = false;
 	rap->cache.counter = 0;
 	rap->cache.send_index = 0;
+	rap->cache.send_id = 0;
+	rap->cache.sending = false;
 }
 
 static void ras_ondemand_cache_store(struct bt_rap *rap,
@@ -1735,9 +1829,14 @@ static void ras_send_ranging_data_ready(struct bt_rap *rap, struct ras *ras,
 	if (!rap || !ras || !ras->ready_chrc)
 		return;
 
+	ras->ready_counter = counter;
 	put_le16(counter, value);
-	gatt_db_attribute_notify(ras->ready_chrc, value, sizeof(value),
-					bt_rap_get_att(rap));
+	if (ras_ccc_use_indication(ras->ready_ccc_value))
+		gatt_db_attribute_indicate(ras->ready_chrc, value,
+					sizeof(value), bt_rap_get_att(rap));
+	else
+		gatt_db_attribute_notify(ras->ready_chrc, value,
+					sizeof(value), bt_rap_get_att(rap));
 }
 
 static void ras_send_ranging_data_overwritten(struct bt_rap *rap,
@@ -1748,9 +1847,14 @@ static void ras_send_ranging_data_overwritten(struct bt_rap *rap,
 	if (!rap || !ras || !ras->overwritten_chrc)
 		return;
 
+	ras->overwritten_counter = counter;
 	put_le16(counter, value);
-	gatt_db_attribute_notify(ras->overwritten_chrc, value, sizeof(value),
-					bt_rap_get_att(rap));
+	if (ras_ccc_use_indication(ras->overwritten_ccc_value))
+		gatt_db_attribute_indicate(ras->overwritten_chrc, value,
+					sizeof(value), bt_rap_get_att(rap));
+	else
+		gatt_db_attribute_notify(ras->overwritten_chrc, value,
+					sizeof(value), bt_rap_get_att(rap));
 }
 
 static void ras_cp_send_response_code(struct bt_rap *rap, struct ras *ras,
@@ -1761,8 +1865,9 @@ static void ras_cp_send_response_code(struct bt_rap *rap, struct ras *ras,
 	if (!rap || !ras || !ras->cp_chrc)
 		return;
 
-	gatt_db_attribute_notify(ras->cp_chrc, value, sizeof(value),
-					bt_rap_get_att(rap));
+	DBG(rap, "CP send Response Code: rsp=0x%02x", response_code);
+	gatt_db_attribute_indicate(ras->cp_chrc, value, sizeof(value),
+						bt_rap_get_att(rap));
 }
 
 static void ras_cp_send_complete_ranging_data(struct bt_rap *rap,
@@ -1776,18 +1881,51 @@ static void ras_cp_send_complete_ranging_data(struct bt_rap *rap,
 	value[0] = RAS_CP_RSP_COMPLETE_RANGING_DATA;
 	put_le16(counter, value + 1);
 
-	gatt_db_attribute_notify(ras->cp_chrc, value, sizeof(value),
-					bt_rap_get_att(rap));
+	gatt_db_attribute_indicate(ras->cp_chrc, value, sizeof(value),
+						bt_rap_get_att(rap));
 }
 
-static void send_ondemand_segment_data(struct bt_rap *rap, struct ras *ras)
+static bool send_ondemand_segment_data_cb(void *user_data);
+
+/*
+ * Confirmation callback for an on-demand ranging-data Indication segment.
+ * Invoked (opcode == BT_ATT_OP_HANDLE_CONF) when the client confirms the
+ * segment. Only then do we send the next segment (confirm-driven flow control),
+ * so at most one indication is in-flight and an Abort (which clears
+ * cache.sending) stops the transfer immediately.
+ */
+static void ondemand_ind_conf_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
 {
+	struct bt_rap *rap = user_data;
+	struct ras *ras = rap && rap->lrapdb ? rap->lrapdb->ras : NULL;
+
+	if (!rap || !ras || !rap->cache.valid || !rap->cache.sending)
+		return;
+
+	/* All data sent and confirmed: finish with Complete Ranging Data. */
+	if (rap->cache.send_index >= rap->cache.data.iov_len) {
+		rap->cache.sending = false;
+		ras_cp_send_complete_ranging_data(rap, ras, rap->cache.counter);
+		return;
+	}
+
+	/* Otherwise send the next segment. */
+	send_ondemand_segment_data_cb(rap);
+}
+
+static bool send_ondemand_segment_data_cb(void *user_data)
+{
+	struct bt_rap *rap = user_data;
+	struct ras *ras = rap && rap->lrapdb ? rap->lrapdb->ras : NULL;
 	uint16_t value_max;
 	const uint16_t header_len = ras_segment_header_size;
 	uint16_t raw_payload_size;
 
-	if (!rap || !ras || !rap->cache.valid)
-		return;
+	if (!rap || !ras || !rap->cache.valid || !rap->cache.sending)
+		return false;
+
+	rap->cache.send_id = 0;
 
 	value_max = ras_att_value_payload_max(rap);
 
@@ -1801,17 +1939,13 @@ static void send_ondemand_segment_data(struct bt_rap *rap, struct ras *ras)
 		 */
 		ras_cp_send_response_code(rap, ras,
 					RAS_CP_RSP_CODE_SERVER_BUSY);
-		return;
+		rap->cache.sending = false;
+		return false;
 	}
 
 	raw_payload_size = (uint16_t)(value_max - header_len);
 
-	rap->cache.send_index = 0;
-	rap->cache.seg_hdr.first_segment = 1;
-	rap->cache.seg_hdr.last_segment = 0;
-	rap->cache.seg_hdr.rolling_segment_counter = 0;
-
-	while (true) {
+	{
 		size_t total_len = rap->cache.data.iov_len;
 		size_t index = rap->cache.send_index;
 		size_t unsent_data_size = total_len - index;
@@ -1833,7 +1967,8 @@ static void send_ondemand_segment_data(struct bt_rap *rap, struct ras *ras)
 			DBG(rap, "OOM (%u)", seg_len);
 			ras_cp_send_response_code(rap, ras,
 					RAS_CP_RSP_CODE_SERVER_BUSY);
-			return;
+			rap->cache.sending = false;
+			return false;
 		}
 
 		wr += (uint16_t)
@@ -1844,6 +1979,88 @@ static void send_ondemand_segment_data(struct bt_rap *rap, struct ras *ras)
 			copy_size);
 		wr += copy_size;
 
+		/*
+		 * On-demand transfer flow control by transport:
+		 *
+		 * - Indication: send one segment as an ATT Handle Value
+		 *   Indication via bt_att_send() and advance/schedule the NEXT
+		 *   segment only from its confirmation callback
+		 *   (ondemand_ind_conf_cb). This keeps at most one segment
+		 *   in-flight, so an Abort Operation that clears cache.sending
+		 *   actually stops the transfer instead of a large backlog
+		 *   draining out of the att indication queue.
+		 * - Notification: fire-and-forget, so there is no confirmation
+		 *   to gate on. Notifications go to the att write queue, which
+		 *   pick_next_send_op() drains ahead of the request queue and
+		 *   without flow control of its own, so queueing the whole
+		 *   transfer at once would starve incoming ATT operations until
+		 *   the last segment is written. Queue the next segment from
+		 *   the next event loop iteration instead, which keeps one
+		 *   segment outstanding.
+		 *
+		 * The delay has to be non-zero for a client to be able to
+		 * abort a transfer it no longer wants. A zero timeout yields
+		 * the event loop but does not wait, since poll() returns at
+		 * once when nothing is pending on the socket, so a Control
+		 * Point write is only seen here once it has already arrived,
+		 * and the transfer can be over by then.
+		 *
+		 * What the peer gets is the transfer time, segments times this
+		 * delay, and it has to cover a connection event for an Abort
+		 * Operation to reach us at all. A short transfer is therefore
+		 * the constraining case, not a long one, and the rate at which
+		 * the controller reports ranging data does not help: the
+		 * segments of one subevent still go out back to back.
+		 * RAS/SR/SPE/BI-05-C, which writes an invalid Abort Operation
+		 * mid-transfer and expects Invalid Parameter rather than
+		 * Complete Ranging Data, fails at 0 ms and passes at 5 ms.
+		 *
+		 * The delay also bounds a transfer, so keep it short: at a
+		 * 247 byte MTU a 13 KB procedure is 57 segments.
+		 */
+		if (ras_data_ccc_use_indication(ras->ondemand_ccc_value)) {
+			uint16_t vhandle =
+				gatt_db_attribute_get_handle(
+					gatt_db_attribute_get_value(
+						ras->ondemand_chrc));
+			uint8_t *pdu = malloc(2 + wr);
+			unsigned int id = 0;
+
+			if (pdu) {
+				put_le16(vhandle, pdu);
+				memcpy(pdu + 2, seg, wr);
+				id = bt_att_send(bt_rap_get_att(rap),
+						BT_ATT_OP_HANDLE_IND,
+						pdu, 2 + wr,
+						ondemand_ind_conf_cb,
+						rap, NULL);
+				free(pdu);
+			}
+
+			free(seg);
+
+			if (!id) {
+				DBG(rap, "Failed to send on-demand indication");
+				ras_cp_send_response_code(rap, ras,
+						RAS_CP_RSP_CODE_SERVER_BUSY);
+				rap->cache.sending = false;
+				return false;
+			}
+
+			/* Advance now; last-segment completion and scheduling
+			 * of the next segment happen in the confirmation cb.
+			 */
+			rap->cache.send_index += copy_size;
+			rap->cache.seg_hdr.first_segment = 0;
+			rap->cache.seg_hdr.rolling_segment_counter =
+				(uint8_t)((rap->cache.seg_hdr
+					.rolling_segment_counter + 1) & 0x3F);
+			return false;
+		}
+
+		/* Reached whenever the client enabled notifications, so
+		 * gatt_db_attribute_notify() picks the notification transport.
+		 */
 		ok = gatt_db_attribute_notify(ras->ondemand_chrc, seg, wr,
 						bt_rap_get_att(rap));
 
@@ -1853,7 +2070,8 @@ static void send_ondemand_segment_data(struct bt_rap *rap, struct ras *ras)
 			DBG(rap, "Failed to send on-demand RAS notification");
 			ras_cp_send_response_code(rap, ras,
 					RAS_CP_RSP_CODE_SERVER_BUSY);
-			return;
+			rap->cache.sending = false;
+			return false;
 		}
 
 		rap->cache.send_index += copy_size;
@@ -1863,11 +2081,36 @@ static void send_ondemand_segment_data(struct bt_rap *rap, struct ras *ras)
 				.rolling_segment_counter + 1) & 0x3F);
 
 		if (rap->cache.seg_hdr.last_segment) {
+			rap->cache.sending = false;
 			ras_cp_send_complete_ranging_data(rap, ras,
-							rap->cache.counter);
-			return;
+								rap->cache.counter);
+			return false;
 		}
 	}
+
+	rap->cache.send_id = timeout_add(RAS_SEGMENT_NFY_PACE_MS,
+						send_ondemand_segment_data_cb,
+						rap, NULL);
+	if (!rap->cache.send_id) {
+		ras_cp_send_response_code(rap, ras, RAS_CP_RSP_CODE_SERVER_BUSY);
+		rap->cache.sending = false;
+	}
+
+	return false;
+}
+
+static void send_ondemand_segment_data(struct bt_rap *rap, struct ras *ras)
+{
+	if (!rap || !ras || !rap->cache.valid || rap->cache.sending)
+		return;
+
+	rap->cache.sending = true;
+	rap->cache.send_index = 0;
+	rap->cache.seg_hdr.first_segment = 1;
+	rap->cache.seg_hdr.last_segment = 0;
+	rap->cache.seg_hdr.rolling_segment_counter = 0;
+
+	send_ondemand_segment_data_cb(rap);
 }
 
 static void send_ras_segment_data(struct bt_rap *rap,
@@ -1956,14 +2199,28 @@ static void send_ras_segment_data(struct bt_rap *rap,
 		wr += copy_size;
 
 		/* Try sending to real-time characteristic */
-		if (ras->realtime_chrc)
-			ok = gatt_db_attribute_notify(ras->realtime_chrc, seg,
-						wr, bt_rap_get_att(rap));
+		if (ras->realtime_chrc) {
+			if (ras_data_ccc_use_indication(ras->realtime_ccc_value))
+				ok = gatt_db_attribute_indicate(
+						ras->realtime_chrc, seg, wr,
+						bt_rap_get_att(rap));
+			else
+				ok = gatt_db_attribute_notify(
+						ras->realtime_chrc, seg, wr,
+						bt_rap_get_att(rap));
+		}
 
 		/* Try sending to on-demand characteristic */
-		if (ras->ondemand_chrc && ok)
-			ok = gatt_db_attribute_notify(ras->ondemand_chrc, seg,
-						wr, bt_rap_get_att(rap));
+		if (ras->ondemand_chrc && ok) {
+			if (ras_data_ccc_use_indication(ras->ondemand_ccc_value))
+				ok = gatt_db_attribute_indicate(
+						ras->ondemand_chrc, seg, wr,
+						bt_rap_get_att(rap));
+			else
+				ok = gatt_db_attribute_notify(
+						ras->ondemand_chrc, seg, wr,
+						bt_rap_get_att(rap));
+		}
 
 		free(seg);
 
@@ -3087,7 +3344,7 @@ static bool ras_cp_timeout_cb(void *user_data)
 
 	if (ras) {
 		DBG(rap, "RAS CP response timed out (pending_op=%d "
-		    "counter=%u) - resetting", ras->client.pending_op,
+		    "counter=%u)", ras->client.pending_op,
 		    ras->client.pending_counter);
 
 		/* The glib source is about to be destroyed on return; avoid
@@ -3113,11 +3370,24 @@ static void ras_cp_arm_timeout(struct bt_rap *rap, struct ras *ras)
 						ras_cp_timeout_cb, rap, NULL);
 }
 
+static void ras_cp_arm_segment_timeout(struct bt_rap *rap, struct ras *ras)
+{
+	if (!ras)
+		return;
+
+	if (ras->client.cp_timeout_id)
+		timeout_remove(ras->client.cp_timeout_id);
+
+	ras->client.cp_timeout_id = timeout_add(RAS_SEGMENT_TIMEOUT,
+						ras_cp_timeout_cb, rap, NULL);
+}
+
 static bool ras_cp_write_op(struct bt_rap *rap, struct ras *ras,
 				uint8_t opcode, uint16_t counter)
 {
 	uint8_t value[3];
 	uint16_t value_handle;
+	uint16_t length = 1;
 
 	if (!rap || !ras || !ras->cp_chrc || !rap->client)
 		return false;
@@ -3128,10 +3398,11 @@ static bool ras_cp_write_op(struct bt_rap *rap, struct ras *ras,
 
 	value[0] = opcode;
 	put_le16(counter, value + 1);
+	length = sizeof(value);
 
 	return bt_gatt_client_write_without_response(rap->client,
 					value_handle, false,
-					value, sizeof(value));
+					value, length);
 }
 
 static bool ras_cp_send_get_ranging_data(struct bt_rap *rap, struct ras *ras,
@@ -3776,11 +4047,15 @@ static void ras_segment_notify_cb(struct bt_rap *rap, uint16_t value_handle,
 				   void *user_data)
 {
 	const char *label = user_data ? user_data : "real-time";
+	struct ras *ras = rap_get_ras(rap);
 
 	DBG(rap, "Received %s notification: handle=0x%04x len=%u",
 	    label, value_handle, length);
 
 	ras_reassemble_segment_notify(rap, value, length);
+
+	if (ras && ras->client.pending_op == RAS_CP_PENDING_GET)
+		ras_cp_arm_segment_timeout(rap, ras);
 }
 
 /* Initiator role: reacts to a Ranging Data Ready notification/indication
@@ -3896,11 +4171,22 @@ static void ras_cp_response_notify_cb(struct bt_rap *rap,
 		DBG(rap, "RAS CP response code=0x%02x (pending_op=%d "
 		    "counter=%u)", code, ras->client.pending_op,
 		    ras->client.pending_counter);
-		ras_ondemand_client_reset(ras);
+		switch (code) {
+		case RAS_CP_RSP_CODE_SUCCESS:
+		case RAS_CP_RSP_CODE_OPCODE_NOT_SUPPORTED:
+		case RAS_CP_RSP_CODE_INVALID_PARAMETER:
+		case RAS_CP_RSP_CODE_PROCEDURE_NOT_COMPLETED:
+		case RAS_CP_RSP_CODE_SERVER_BUSY:
+		case RAS_CP_RSP_CODE_NO_RECORDS_FOUND:
+			ras_ondemand_client_reset(ras);
+			break;
+		default:
+			DBG(rap, "Ignoring RFU RAS CP response code 0x%02x", code);
+			break;
+		}
 		break;
 	default:
 		DBG(rap, "Unknown RAS CP response opcode 0x%02x", value[0]);
-		ras_ondemand_client_reset(ras);
 		break;
 	}
 }
-- 
2.43.0

