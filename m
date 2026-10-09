Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E9449B1EA
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537941; cv=none; b=eF5Bo4wItGvsxZncn/lJTqTXZdKw4aOMDJP0t6cftmQOWmG4+kGo+xvjIUGY7xsnY0OCh+GyxHP4bbde4MAGD0XetQrFpeAecw7eknEp+7cee4T8/N7H2I+xj2t+3V6urHXT78jwUlTKG8pqZau9SRCgFUYih+xv6/YoCVvyTNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537941; c=relaxed/simple;
	bh=/6+h1S+AiJb57UL+8aA5BDIfW1AmAofNyNMuUa9jdDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nde5GAAOG2zBapfKShATgXr7w8OaewpWZ4HqjUwD0oq7wnmkj6+b20kA3/a6tYQvtKqtBg7bYf907oQrtuhhaIJe9XMBkr6KiXJFAHiOOKBQx1NbGkUXT8DqNqtktx9LKOqh4si5Fo7XJyeac8X37t0AIH4nusqg28t8Te3FddU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DvCWwdrz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DvCWwdrz"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KMZs1223196
	for <linux-bluetooth@vger.kernel.org>; Fri, 9 Oct 2026 09:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=0jRu9nve5Gc
	QX5pvX3C9JtusfTT2v8g3ks3fw1rd1ko=; b=DvCWwdrzqq+0uc3LzKk7BrZK+oa
	4SqtoYlAa1I2yfmKLpqrQN1I2klTIuAPJJEQ/sR57d4xkHiJMoCghDEV8epuOfjJ
	8N95tfQKev/SASudCMT0L8Z5a2OJCTSKVi3g9JKa8dBMYcyvqPZR4nqq1noKabYW
	kQ3bnIKBFRO8ImJhVH4vGWncGYHwRRx5D+S21fJ9vHm7R1dJVtVHoHzMpyftFmPm
	miMq3yVyH/yTo2MUF3X6IoU8jLj2FdJi+X2tsWjV0NDQFM1SoOwWIRi/7cTRKZOt
	YjuXGeHUYfmufITFtYHhz2SJHOfm+JZwXbHnJ6hzbbKkFjjn+9/50uN7oDQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxkatse-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 09:25:38 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6999PZw73497558
	for <linux-bluetooth@vger.kernel.org>; Fri, 9 Oct 2026 09:25:36 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6999PZAA3497440
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 09:25:35 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 8A4BE49BE2; Fri,  9 Oct 2026 17:25:33 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH v2 09/14] shared/rap: Add real-time ranging data delivery on the responder
Date: Fri,  9 Oct 2026 17:25:25 +0800
Message-ID: <20261009092532.3600749-10-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-GUID: -x-lX9_ef_2A8d4TjqJAGU85SsD5RkH-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfX6XaaJA3qoo6L
 Ps+6e+Frldp39oCSQ2rjUjOHnISpBSoN6WyfVh/vLb5urdktb1T2uSUTI4fqW6Q5djwg7zuOUWR
 u70EefXnJ/PVeQUUTFn0z29bPthOTL4=
X-Authority-Analysis: v=2.4 cv=Cs0q4X4D c=1 sm=1 tr=0 ts=6ac8b312 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=5AFDY0mFNLBIbWA39TYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfX071WuZtr8LDl
 0r99VTrFUWJKaBdLsnmk8hyEzJjPmGaHSDAAfGanA0bZdPHiq+9g1xT6O9pU8/XW3h4c47YqtXm
 HTfGOTCCbpDgLryz/gLO1bCtKe/3gqWG1LllOcrACWtuUy4HecKrKdZUQAT943WLwNTIrlD11dw
 U5Zui0Iokmiu59zfqaOzY9O/NgwOND4XN3ChxjpZr2dnoCKT4g6ufNs7MxSpJIZ/7IE5d+6DQIk
 CGzIGIt0ih/j4IYE7pVnirC79E+V/eAIsdjG+tjz/mTp3N/HvyWkrNWSYpLWjzZj47DnUvjNQAE
 A9LLsiBpl80ldeh9qa/2sVB8fYDexnFSaFVef4uon8uoRuNqMkGBEDL+7TW4F8RUPDn0LLhpYR7
 n0ZN0NUTQNmi62/HHutIUpesAesnP2mzt8ZLSnwwRffg2Uv33LxEZtBojNLSxUa0ZR7Mio7mOea
 LusUONQINkQE9PGMymw==
X-Proofpoint-ORIG-GUID: -x-lX9_ef_2A8d4TjqJAGU85SsD5RkH-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090037

Implement the RAS responder side of Real-time Ranging Data. Completed
ranging-data segments are queued in a per-connection FIFO and delivered
on the Real-time Ranging Data characteristic, honoring the transport
selected by the client's CCCD: notifications are paced with a fixed
inter-segment interval, while indications are driven by ATT confirmations
so the next segment is only sent once the previous one is acknowledged.

The pending real-time segment queue is cleared when a new CS procedure
starts, so stale segments from an aborted or superseded procedure are
never delivered to the peer.

Assisted-by: Claude:claude-opus-4.8
---
 src/shared/rap.c | 186 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 139 insertions(+), 47 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index 7d4fa266c..6c2196f73 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -420,6 +420,22 @@ struct bt_rap_db {
 	struct ras *ras;
 };
 
+struct ras_realtime_segment {
+	uint8_t *value;
+	uint16_t len;
+};
+
+static void ras_realtime_segment_free(void *data)
+{
+	struct ras_realtime_segment *segment = data;
+
+	if (!segment)
+		return;
+
+	free(segment->value);
+	free(segment);
+}
+
 struct bt_rap {
 	int ref_count;
 	struct bt_rap_db *lrapdb;
@@ -461,6 +477,11 @@ struct bt_rap {
 	 * centrals cannot evict or receive each other's cached data.
 	 */
 	struct ras_ondemand_cache cache;
+
+	/* Serialized real-time segments await transport-paced delivery. */
+	struct queue *realtime_segments;
+	unsigned int realtime_send_id;
+	bool realtime_indicating;
 };
 
 static struct queue *rap_db;
@@ -1020,6 +1041,9 @@ static void rap_free(void *data)
 	rap_db_free(rap->rrapdb);
 
 	free(rap->cache.data.iov_base);
+	if (rap->realtime_send_id)
+		timeout_remove(rap->realtime_send_id);
+	queue_destroy(rap->realtime_segments, ras_realtime_segment_free);
 
 	if (rap->resptracker) {
 		free(rap->resptracker->segment_data.iov_base);
@@ -2133,10 +2157,96 @@ static void send_ondemand_segment_data(struct bt_rap *rap, struct ras *ras)
 	send_ondemand_segment_data_cb(rap);
 }
 
+static bool send_realtime_segment_cb(void *user_data);
+
+static void ras_realtime_segments_clear(struct bt_rap *rap)
+{
+	if (!rap)
+		return;
+
+	if (rap->realtime_send_id) {
+		timeout_remove(rap->realtime_send_id);
+		rap->realtime_send_id = 0;
+	}
+
+	queue_destroy(rap->realtime_segments, ras_realtime_segment_free);
+	rap->realtime_segments = queue_new();
+}
+
+static void realtime_ind_conf_cb(uint8_t opcode, const void *pdu,
+				uint16_t length, void *user_data)
+{
+	struct bt_rap *rap = user_data;
+
+	if (!rap)
+		return;
+
+	rap->realtime_indicating = false;
+	send_realtime_segment_cb(rap);
+}
+
+static bool send_realtime_segment_cb(void *user_data)
+{
+	struct bt_rap *rap = user_data;
+	struct ras *ras = rap && rap->lrapdb ? rap->lrapdb->ras : NULL;
+	struct ras_realtime_segment *segment;
+
+	if (!rap || !ras || !rap->realtime_segments)
+		return false;
+
+	rap->realtime_send_id = 0;
+	if (rap->realtime_indicating || queue_isempty(rap->realtime_segments))
+		return false;
+
+	segment = queue_pop_head(rap->realtime_segments);
+	if (!segment)
+		return false;
+
+	if (ras_data_ccc_use_indication(ras->realtime_ccc_value)) {
+		uint16_t vhandle = gatt_db_attribute_get_handle(
+					gatt_db_attribute_get_value(
+						ras->realtime_chrc));
+		uint8_t *pdu = malloc(2 + segment->len);
+		unsigned int id = 0;
+
+		if (pdu) {
+			put_le16(vhandle, pdu);
+			memcpy(pdu + 2, segment->value, segment->len);
+			id = bt_att_send(bt_rap_get_att(rap),
+					BT_ATT_OP_HANDLE_IND, pdu,
+					2 + segment->len,
+					realtime_ind_conf_cb, rap, NULL);
+			free(pdu);
+		}
+
+		ras_realtime_segment_free(segment);
+		if (!id) {
+			DBG(rap, "Failed to send real-time indication");
+			return false;
+		}
+
+		rap->realtime_indicating = true;
+		return false;
+	}
+
+	/* Reached whenever the client enabled notifications, so
+	 * gatt_db_attribute_notify() picks the notification transport.
+	 */
+	if (!gatt_db_attribute_notify(ras->realtime_chrc, segment->value,
+					segment->len, bt_rap_get_att(rap)))
+		DBG(rap, "Failed to send real-time notification");
+	ras_realtime_segment_free(segment);
+
+	if (!queue_isempty(rap->realtime_segments))
+		rap->realtime_send_id = timeout_add(RAS_SEGMENT_NFY_PACE_MS,
+					send_realtime_segment_cb, rap, NULL);
+
+	return false;
+}
+
 static void send_ras_segment_data(struct bt_rap *rap,
 				struct cs_procedure_data *proc)
 {
-	struct ras *ras;
 	uint16_t value_max;
 	const uint16_t header_len = ras_segment_header_size;
 	uint16_t raw_payload_size;
@@ -2147,7 +2257,6 @@ static void send_ras_segment_data(struct bt_rap *rap,
 	if (!rap->lrapdb || !rap->lrapdb->ras)
 		return;
 
-	ras = rap->lrapdb->ras;
 	value_max = ras_att_value_payload_max(rap);
 
 	if (value_max == 0) {
@@ -2171,7 +2280,6 @@ static void send_ras_segment_data(struct bt_rap *rap,
 		uint16_t seg_len;
 		uint8_t *seg;
 		uint16_t wr = 0;
-		bool ok = true;
 
 		if (index > total_len)
 			index = total_len;
@@ -2181,25 +2289,16 @@ static void send_ras_segment_data(struct bt_rap *rap,
 		if (unsent_data_size == 0)
 			return;
 
-		/* Set last_segment if procedure complete or fits in segment */
-		if ((proc->local_status != CS_PROC_PARTIAL_RESULTS &&
-				unsent_data_size <= raw_payload_size) ||
-			(proc->contains_complete_subevent_ &&
-				unsent_data_size <= raw_payload_size)) {
+		/* Only the final completed procedure segment terminates
+		 * the stream.
+		 */
+		if (proc->local_status != CS_PROC_PARTIAL_RESULTS &&
+				unsent_data_size <= raw_payload_size) {
 			proc->segmentation_header_.last_segment = 1;
 		} else {
 			proc->segmentation_header_.last_segment = 0;
 		}
 
-		/* Wait for more data if needed and not last segment */
-		if (unsent_data_size < raw_payload_size &&
-				proc->segmentation_header_.last_segment == 0) {
-			DBG(rap, "waiting for more data (unsent=%zu < "
-				"payload=%u)", unsent_data_size,
-				raw_payload_size);
-			return;
-		}
-
 		copy_size = (uint16_t)((unsent_data_size < raw_payload_size) ?
 				unsent_data_size : raw_payload_size);
 		seg_len = (uint16_t)(header_len + copy_size);
@@ -2218,39 +2317,26 @@ static void send_ras_segment_data(struct bt_rap *rap,
 			copy_size);
 		wr += copy_size;
 
-		/* Try sending to real-time characteristic */
-		if (ras->realtime_chrc) {
-			if (ras_data_ccc_use_indication(
-						ras->realtime_ccc_value))
-				ok = gatt_db_attribute_indicate(
-						ras->realtime_chrc, seg, wr,
-						bt_rap_get_att(rap));
-			else
-				ok = gatt_db_attribute_notify(
-						ras->realtime_chrc, seg, wr,
-						bt_rap_get_att(rap));
-		}
-
-		/* Try sending to on-demand characteristic */
-		if (ras->ondemand_chrc && ok) {
-			if (ras_data_ccc_use_indication(
-						ras->ondemand_ccc_value))
-				ok = gatt_db_attribute_indicate(
-						ras->ondemand_chrc, seg, wr,
-						bt_rap_get_att(rap));
-			else
-				ok = gatt_db_attribute_notify(
-						ras->ondemand_chrc, seg, wr,
-						bt_rap_get_att(rap));
-		}
+		{
+			struct ras_realtime_segment *segment = new0(
+						struct ras_realtime_segment, 1);
 
-		free(seg);
+			if (!segment || !queue_push_tail(rap->realtime_segments,
+							segment)) {
+				free(segment);
+				free(seg);
+				DBG(rap, "Failed to queue real-time "
+							"RAS segment");
+				return;
+			}
 
-		if (!ok) {
-			DBG(rap, "Failed to send RAS notification");
-			return;
+			segment->value = seg;
+			segment->len = wr;
 		}
 
+		if (!rap->realtime_send_id && !rap->realtime_indicating)
+			send_realtime_segment_cb(rap);
+
 		/* Advance read cursor and update segmentation state */
 		proc->ras_raw_data_index_ += copy_size;
 		proc->segmentation_header_.first_segment = 0;
@@ -2638,7 +2724,12 @@ static void handle_local_subevent_result(struct bt_rap *rap,
 		struct cs_procedure_data *cur = resptracker->current_proc;
 
 		if (has_header_fields && cur->counter != proc_counter) {
-			/* Safety: a new procedure; destroy the previous one */
+			/* A new real-time procedure supersedes queued
+			 * old ranging data.
+			 */
+			if (!ras_is_ondemand_mode(rap->lrapdb->ras))
+				ras_realtime_segments_clear(rap);
+
 			resptracker_reset_current_proc(resptracker);
 		}
 	}
@@ -3247,6 +3338,7 @@ struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb)
 	rap->pending = queue_new();
 	rap->ready_cbs = queue_new();
 	rap->notify = queue_new();
+	rap->realtime_segments = queue_new();
 
 	if (!rdb)
 		goto done;
-- 
2.43.0

