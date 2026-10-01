Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C854B4888
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860761; cv=none; b=R8g0CzabNZhhv8++JzMbViPWMdkX8B3LDMiFz5K7X9U2RePDc98QuWW0gAZMQdNhq0d5S6YQRsNLDAFoBWXqGZi0WggkIOzyS0cg1HScLVIcyXCQAzqImb9cwFr8mqINlJoha5uhlSYiz87/kcOke5zfvG0tonrNmmrp+eFY574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860761; c=relaxed/simple;
	bh=ThLNnH3DhzltTXDqxM4Dx5FuKU35PVgriuFFenvJFHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgcjl1cOPdWaHTLWR4GyM55l0t3msGWm6pmQ9VapBeUqQWMvU2YEYhYYN4pEOYkrfTgzxY+i1SITX//avew+ZpF46/mm2ltEy9rfYLNSiDOMZq2Z2Tdyd2Mxh0QgPBaWfC3mk1IQNUYsphaTVgqUPUAHiRDV/VETX0Xl6Ct8GMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f7z8juXG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f7z8juXG"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DERIQ1220140
	for <linux-bluetooth@vger.kernel.org>; Thu, 1 Oct 2026 13:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=4L57J8ZQNYc
	MPSDfbIRxG3IkLWkWWOysmQ4d31U5yVE=; b=f7z8juXG3lsyygjcnGjbCiGKmCK
	iA1iXPwnozDeIv9fsWFGaZlhXvhA59EgS+z8eH8AkuNF7m7SwKLIMrWZGgHXTKZb
	WDIcM3zbKYFAfcxqDKmdEJci31oJdLV08eYcbdO4/S3XNHfVypt6kEcaoz/6gcSB
	wWY+quS+mIVUQrztWe+sQLmH9JBSJwT30G/kPNrt2fAqHxtwbybTaxDP4CIYocoV
	5y50oa6hHBkO7O1hecTtFiy/OwOwQfg5CPlS90MhbajljRu1VW9KPyeoMK6NFVrG
	uNaNHNf4n43RizPWDavc8bUiU7dK7IaUemrQ7uPHFuQhkWmtH9Xs189d/XA==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1bh5b58t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 13:19:16 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 691DJFFi2501493;
	Thu, 1 Oct 2026 13:19:15 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 691DJEjc2501472
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 13:19:15 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 11E2849BC7; Thu,  1 Oct 2026 21:19:13 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH 06/11] shared/rap: Add real-time ranging data delivery on the responder
Date: Thu,  1 Oct 2026 21:18:52 +0800
Message-ID: <20261001131900.707485-7-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfX04yQojW2SXgx
 lBgkfNQQVtXIKLrdOJ0rcbuwJkG4hOKKuKZ0LH0V5KOgwn0rhkJufwTwYFDJ/fOlSoMCzTH/GCn
 eKh6lOwakMCobPYQQhqoTCpYgI+b/6i+Nv6dbnWK4P2iY+mUl8itLn2WVi6OUyWqWvBk6Kt79rs
 1oHqNqIFwCDkr+4VAl4FGs8ErThCnI01V+fQRAul+HCiriuDfhVzyyB7MdWBXATfq3AxK6lx0HU
 TFk+NpM3UfgskMV9JnyN8hhvF3EJdGfeo4pZV20wft2pPwac4dRd2kGNsRoSqgki7sYnMu7AXe7
 Wge5NWw4NHyH7OF++2XO/CsCbQDdTMXHX5ki5VhPTVNeouYTnprAStCCWI8g4na2HITFwB8BPrt
 CU0EZYiQ+0vleD9l6/TGf9h0avNZL82Ekugx9JvyzSI3CWlhF44hHflXqCiLemHL3jU3+T/DxU3
 ACTPSNRZp8kJYYjOrxQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfXwvTX5pkYh79/
 PeuUrduDOMcT7ZHUHhM1pN4G7WuYpQjFZdI80csUTwr9zhr2b60LKaQR4O5AIG+rx1L80Vy8lGL
 dS9o182VyYJdLYmxcuCFLCHtyQVqWhc=
X-Proofpoint-ORIG-GUID: cS0nSNc76ZI2JTgEQjVRXkl2oW70-RoZ
X-Proofpoint-GUID: cS0nSNc76ZI2JTgEQjVRXkl2oW70-RoZ
X-Authority-Analysis: v=2.4 cv=NrJE4MdJ c=1 sm=1 tr=0 ts=6abe5dd5 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=5AFDY0mFNLBIbWA39TYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010053

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
 src/shared/rap.c | 175 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 132 insertions(+), 43 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index 7c9a439a5..b1108ad68 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -419,6 +419,22 @@ struct bt_rap_db {
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
@@ -460,6 +476,11 @@ struct bt_rap {
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
@@ -1019,6 +1040,9 @@ static void rap_free(void *data)
 	rap_db_free(rap->rrapdb);
 
 	free(rap->cache.data.iov_base);
+	if (rap->realtime_send_id)
+		timeout_remove(rap->realtime_send_id);
+	queue_destroy(rap->realtime_segments, ras_realtime_segment_free);
 
 	if (rap->resptracker) {
 		free(rap->resptracker->segment_data.iov_base);
@@ -2130,6 +2154,91 @@ static void send_ondemand_segment_data(struct bt_rap *rap, struct ras *ras)
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
+				gatt_db_attribute_get_value(ras->realtime_chrc));
+		uint8_t *pdu = malloc(2 + segment->len);
+		unsigned int id = 0;
+
+		if (pdu) {
+			put_le16(vhandle, pdu);
+			memcpy(pdu + 2, segment->value, segment->len);
+			id = bt_att_send(bt_rap_get_att(rap), BT_ATT_OP_HANDLE_IND,
+					pdu, 2 + segment->len, realtime_ind_conf_cb,
+					rap, NULL);
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
@@ -2168,7 +2277,6 @@ static void send_ras_segment_data(struct bt_rap *rap,
 		uint16_t seg_len;
 		uint8_t *seg;
 		uint16_t wr = 0;
-		bool ok = true;
 
 		if (index > total_len)
 			index = total_len;
@@ -2178,25 +2286,14 @@ static void send_ras_segment_data(struct bt_rap *rap,
 		if (unsent_data_size == 0)
 			return;
 
-		/* Set last_segment if procedure complete or fits in segment */
-		if ((proc->local_status != CS_PROC_PARTIAL_RESULTS &&
-				unsent_data_size <= raw_payload_size) ||
-			(proc->contains_complete_subevent_ &&
-				unsent_data_size <= raw_payload_size)) {
+		/* Only the final completed procedure segment terminates the stream. */
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
@@ -2215,37 +2312,25 @@ static void send_ras_segment_data(struct bt_rap *rap,
 			copy_size);
 		wr += copy_size;
 
-		/* Try sending to real-time characteristic */
-		if (ras->realtime_chrc) {
-			if (ras_data_ccc_use_indication(ras->realtime_ccc_value))
-				ok = gatt_db_attribute_indicate(
-						ras->realtime_chrc, seg, wr,
-						bt_rap_get_att(rap));
-			else
-				ok = gatt_db_attribute_notify(
-						ras->realtime_chrc, seg, wr,
-						bt_rap_get_att(rap));
-		}
+		{
+			struct ras_realtime_segment *segment = new0(
+						struct ras_realtime_segment, 1);
 
-		/* Try sending to on-demand characteristic */
-		if (ras->ondemand_chrc && ok) {
-			if (ras_data_ccc_use_indication(ras->ondemand_ccc_value))
-				ok = gatt_db_attribute_indicate(
-						ras->ondemand_chrc, seg, wr,
-						bt_rap_get_att(rap));
-			else
-				ok = gatt_db_attribute_notify(
-						ras->ondemand_chrc, seg, wr,
-						bt_rap_get_att(rap));
-		}
-
-		free(seg);
+			if (!segment || !queue_push_tail(rap->realtime_segments,
+							segment)) {
+				free(segment);
+				free(seg);
+				DBG(rap, "Failed to queue real-time RAS segment");
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
@@ -2621,7 +2706,10 @@ static void handle_local_subevent_result(struct bt_rap *rap,
 		struct cs_procedure_data *cur = resptracker->current_proc;
 
 		if (has_header_fields && cur->counter != proc_counter) {
-			/* Safety: a new procedure; destroy the previous one */
+			/* A new real-time procedure supersedes queued old ranging data. */
+			if (!ras_is_ondemand_mode(rap->lrapdb->ras))
+				ras_realtime_segments_clear(rap);
+
 			resptracker_reset_current_proc(resptracker);
 		}
 	}
@@ -3220,6 +3308,7 @@ struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb)
 	rap->pending = queue_new();
 	rap->ready_cbs = queue_new();
 	rap->notify = queue_new();
+	rap->realtime_segments = queue_new();
 
 	if (!rdb)
 		goto done;
-- 
2.43.0

