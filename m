Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A100848F85E
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537941; cv=none; b=R68xuZLtLDSJnd/FhRjCvHI92tR07eICYkfaHXpAvkfNcgExsHYViC04R7UVueoX5QEDhX9mrmCzkteIr8BxGTsNFDN3RrJ3RtM35lvHi+RGq3E2DNeEJWR7Js4+6aiUAAUo8K/VM96drQov15LMRAkkRcBxCPr+vGNSxudFZPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537941; c=relaxed/simple;
	bh=pq/PC+IN6eSeTrSzT9UsptsD2Svk32IMd6JUs2vh4cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6/cLXqvBjlX1Z9TGdIYF4rTr5d3I65EfkeBqxBu4V/83rd7Bbe07q1bd7P9G/cK8DkTnnQ9QYK0XQgXnIB4Y1QD57EuqqZG/1pvnacblqRHagphhoRzs24l9ZFlwJsWSlos8mx2fz2DlRn1abstNEA0Ea56cA2ZbrSs/WctRyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hTYGIL6J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hTYGIL6J"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KISv1746833
	for <linux-bluetooth@vger.kernel.org>; Fri, 9 Oct 2026 09:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qL1V2M0b/qF
	3AvYUNJWtdUKUbi6hrBGDUK8HPitXqGQ=; b=hTYGIL6JcZISpF2P08kCcesmYpu
	mQNypqAw9YYJdLoENL9IiDihCxqiGU2gtUwFthvazcSEnMRXahqSyP46BzUjovNT
	s7rLhXUl5SydH2VyYBXhMPRVCUXmZLs/o/jy1mdcFKagEWJf4GTuIoix+1jvPPS7
	bMQCraY+ehmlw0lql3Bp5YaHf+rg2U2edbRz2k4wahWnFf9SgrA+/efjka3WzHYK
	by9bV698VxUFTC0vQuqR0uM5ZpIjPjr9ft7oYUYf7fqxJEOG89VZYbfutOhugTQg
	Yioyq89cFMSoUDtBfEPBuOsMJ/Fxh2OEODoGbVp8RsAvszLO/lx1SQQaT0Q==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ekvb6vr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 09:25:38 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6999PZ4O3497534;
	Fri, 9 Oct 2026 09:25:35 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6999PZjv3497438
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 09:25:35 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 8DB7349BE3; Fri,  9 Oct 2026 17:25:33 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH v2 10/14] shared/rap: Add requester ranging data subscription API
Date: Fri,  9 Oct 2026 17:25:26 +0800
Message-ID: <20261009092532.3600749-11-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 5bPRypVd-KsdKgZRH_IpYSpoKCX0xHPD
X-Authority-Analysis: v=2.4 cv=csYOAF4i c=1 sm=1 tr=0 ts=6ac8b312 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=H6PcJvQWHW-OtYxVAMYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfXyBWUJgW/lpdf
 qUzwVrk6KlZkloEPGzBiMBZCruYMIy+CVkxrbSvycuEw63JFgWo43MkxP7zwXqYiXn8bhyFbVJ5
 mm5dS+V46hm/UOw2REBjk88TppwVJbZNSbG9fhcg7Ym5rr3jp0c+M0VPNWkrb6rI9y5I5dKMz+A
 tZ0Ge3D1H06ronRm7e0hB82DTBiJ2zYbtL/mYNSIQ9Z9aaGpKGDV96bkiMR1Y3rksUNAN8eNE0u
 P3XCvG4bO6fkMQMnJFaL3ZjBR35qyzV/UPATYTx8OUnxofzGXBI/ayw194UJ8lLev8CmfvQDgcR
 BhbQjb6oWOhYFZxVYsAuaiytC/cQafGImZd4YKgKLHIat5K2ud3rSXomrBKeluzS9wvbTFKiG17
 gtIE3hCa1fN7Tdj5giknwulB4mNyy7HJh4eqpmhaiOwi95JljB77WzFHjtEyZChhUGRq6LVjt0m
 Q1FmQs3mwB84VJRdyHw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfXzaem3NtkKTBb
 fMInFjR3P7P9bzSuQ2QIi6wpgFJLUMCOKDZV52jBQEr77D2xd6Cp/TB2I89uuk/cQzSvf1VFvrt
 cVRcjxnULvDHXATYjXvdw4Qj8K2lodM=
X-Proofpoint-GUID: 5bPRypVd-KsdKgZRH_IpYSpoKCX0xHPD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090037

Give the RAS requester control over how Ranging Data is received from the
peer. bt_rap_set_ranging_data_mode() picks Real-time, On-demand or neither,
together with the CCC value to write on the peer, and
bt_rap_disable_realtime_ranging() drops a Real-time subscription again.
bt_rap_set_ondemand_ranging() selects the mode to use before GATT discovery
has completed.

Setting a mode first unsubscribes whatever is currently subscribed, so the
modes do not stack, and fails when the RAS Features read has not completed
or the peer does not advertise the mode being asked for.

The requested transport applies to the RAS Control Point, Ranging Data
Ready and Ranging Data Overwritten characteristics. On-demand Ranging Data
itself stays on notifications whatever is asked for: it carries the
segmented transfer, and gating each segment on a confirmation would slow a
large one down for no benefit on the receiving side. On-demand mode also
reads Ranging Data Ready once subscribed, to pick up a counter published
before the subscription existed.

Real-time reception is guarded by the deadlines RAP 4.4.1.1 sets for the
Requester: the CCCD is disabled again if no first segment arrives within
5 seconds, or if more than 1 second passes between continuation segments,
so a peer that stops sending does not leave the subscription open.

Assisted-by: Claude:claude-opus-4.8
---
 src/shared/rap.c | 275 +++++++++++++++++++++++++++++++++++++++--------
 src/shared/rap.h |  23 ++++
 2 files changed, 253 insertions(+), 45 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index 6c2196f73..35a7b0980 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -34,6 +34,7 @@
  */
 #define RAS_CP_RESPONSE_TIMEOUT (5 * 1000)
 #define RAS_SEGMENT_TIMEOUT (1 * 1000)
+#define RAS_REALTIME_FIRST_SEGMENT_TIMEOUT (5 * 1000)
 /* Delay between On-demand ranging-data notification segments, see
  * send_ondemand_segment_data_cb().
  */
@@ -471,6 +472,15 @@ struct bt_rap {
 	 * bt_rap_attach() to take effect.
 	 */
 	bool ondemand_mode;
+	uint16_t realtime_ccc_value;
+	uint16_t ondemand_ccc_value;
+	unsigned int realtime_notify_id;
+	unsigned int realtime_timeout_id;
+	unsigned int ondemand_notify_id;
+	unsigned int cp_notify_id;
+	unsigned int ready_notify_id;
+	unsigned int overwritten_notify_id;
+	uint32_t ras_features;
 
 	/* Responder role: this connection's on-demand ranging data cache.
 	 * Per-connection (not on the shared struct ras) so that concurrent
@@ -958,6 +968,15 @@ void bt_rap_detach(struct bt_rap *rap)
 	bt_gatt_client_idle_unregister(rap->client, rap->idle_id);
 	bt_gatt_client_unref(rap->client);
 	rap->client = NULL;
+	if (rap->realtime_timeout_id) {
+		timeout_remove(rap->realtime_timeout_id);
+		rap->realtime_timeout_id = 0;
+	}
+	rap->realtime_notify_id = 0;
+	rap->ondemand_notify_id = 0;
+	rap->cp_notify_id = 0;
+	rap->ready_notify_id = 0;
+	rap->overwritten_notify_id = 0;
 
 	bt_att_unregister_disconnect(rap->att, rap->disconn_id);
 	rap->att = NULL;
@@ -3427,6 +3446,7 @@ static void rap_notify_destroy(void *data)
 
 static unsigned int bt_rap_register_notify(struct bt_rap *rap,
 					uint16_t value_handle,
+					uint16_t ccc_value,
 					rap_notify_t func,
 					void *user_data)
 {
@@ -3439,7 +3459,13 @@ static unsigned int bt_rap_register_notify(struct bt_rap *rap,
 
 	DBG(rap, "register for notifications");
 
-	notify->id = bt_gatt_client_register_notify(rap->client,
+	if (ccc_value)
+		notify->id = bt_gatt_client_register_notify_with_ccc(
+					rap->client, value_handle, ccc_value,
+					ras_register, rap_notify, notify,
+					rap_notify_destroy);
+	else
+		notify->id = bt_gatt_client_register_notify(rap->client,
 					value_handle, ras_register,
 					rap_notify, notify,
 					rap_notify_destroy);
@@ -3454,6 +3480,85 @@ static unsigned int bt_rap_register_notify(struct bt_rap *rap,
 	return notify->id;
 }
 
+bool bt_rap_disable_realtime_ranging(struct bt_rap *rap)
+{
+	unsigned int notify_id;
+
+	if (!rap || !rap->client)
+		return false;
+
+	if (rap->realtime_timeout_id) {
+		timeout_remove(rap->realtime_timeout_id);
+		rap->realtime_timeout_id = 0;
+	}
+
+	if (!rap->realtime_notify_id)
+		return true;
+
+	notify_id = rap->realtime_notify_id;
+	rap->realtime_notify_id = 0;
+
+	return bt_gatt_client_unregister_notify(rap->client, notify_id);
+}
+
+static bool ras_realtime_timeout_cb(void *user_data)
+{
+	struct bt_rap *rap = user_data;
+
+	rap->realtime_timeout_id = 0;
+	DBG(rap, "Real-time Ranging Data segment timeout; disabling CCCD");
+	bt_rap_disable_realtime_ranging(rap);
+
+	return false;
+}
+
+static void ras_realtime_arm_timeout(struct bt_rap *rap, unsigned int timeout)
+{
+	if (rap->realtime_timeout_id)
+		timeout_remove(rap->realtime_timeout_id);
+
+	rap->realtime_timeout_id = timeout_add(timeout, ras_realtime_timeout_cb,
+						rap, NULL);
+}
+
+static void ras_realtime_cancel_timeout(struct bt_rap *rap)
+{
+	if (!rap->realtime_timeout_id)
+		return;
+
+	timeout_remove(rap->realtime_timeout_id);
+	rap->realtime_timeout_id = 0;
+}
+
+static bool bt_rap_unregister_notify(struct bt_rap *rap, unsigned int *id)
+{
+	unsigned int notify_id;
+
+	if (!*id)
+		return true;
+
+	notify_id = *id;
+	*id = 0;
+	return bt_gatt_client_unregister_notify(rap->client, notify_id);
+}
+
+static bool bt_rap_disable_ranging_data(struct bt_rap *rap)
+{
+	bool success = true;
+
+	if (!rap || !rap->client)
+		return false;
+
+	ras_realtime_cancel_timeout(rap);
+
+	success &= bt_rap_unregister_notify(rap, &rap->realtime_notify_id);
+	success &= bt_rap_unregister_notify(rap, &rap->ondemand_notify_id);
+	success &= bt_rap_unregister_notify(rap, &rap->cp_notify_id);
+	success &= bt_rap_unregister_notify(rap, &rap->ready_notify_id);
+	success &= bt_rap_unregister_notify(rap, &rap->overwritten_notify_id);
+	return success;
+}
+
 static void ras_ondemand_client_reset(struct ras *ras)
 {
 	if (!ras)
@@ -4190,12 +4295,22 @@ static void ras_segment_notify_cb(struct bt_rap *rap, uint16_t value_handle,
 {
 	const char *label = user_data ? user_data : "real-time";
 	struct ras *ras = rap_get_ras(rap);
+	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
+	struct segmentation_header seg_hdr;
+	bool realtime = !strcmp(label, "real-time");
 
 	DBG(rap, "Received %s notification: handle=0x%04x len=%u",
 	    label, value_handle, length);
 
 	ras_reassemble_segment_notify(rap, value, length);
 
+	if (realtime && parse_segmentation_header(&iov, &seg_hdr)) {
+		if (seg_hdr.last_segment)
+			ras_realtime_cancel_timeout(rap);
+		else
+			ras_realtime_arm_timeout(rap, RAS_SEGMENT_TIMEOUT);
+	}
+
 	if (ras && ras->client.pending_op == RAS_CP_PENDING_GET)
 		ras_cp_arm_segment_timeout(rap, ras);
 }
@@ -4340,7 +4455,9 @@ static void ras_cp_response_notify_cb(struct bt_rap *rap,
  */
 static void rap_subscribe_ondemand_chrc(struct bt_rap *rap,
 					struct gatt_db_attribute *chrc,
-					rap_notify_t func, const char *name)
+					uint16_t ccc_value, rap_notify_t func,
+					const char *name,
+					unsigned int *notify_id_out)
 {
 	uint16_t value_handle;
 	unsigned int notify_id;
@@ -4356,13 +4473,118 @@ static void rap_subscribe_ondemand_chrc(struct bt_rap *rap,
 		return;
 	}
 
-	notify_id = bt_rap_register_notify(rap, value_handle, func,
+	notify_id = bt_rap_register_notify(rap, value_handle, ccc_value, func,
 							(void *)name);
 	if (!notify_id)
 		DBG(rap, "Failed to register for %s notifications", name);
 	else
 		DBG(rap, "Registered for %s notifications: id=%u", name,
 							notify_id);
+
+	if (notify_id_out)
+		*notify_id_out = notify_id;
+}
+
+static void ras_data_ready_read_complete(struct bt_rap *rap, bool success,
+					uint8_t att_ecode, const uint8_t *value,
+					uint16_t length, void *user_data)
+{
+	if (!success) {
+		DBG(rap, "Unable to read Ranging Data Ready: error 0x%02x",
+			att_ecode);
+		return;
+	}
+
+	/* This read only synchronizes the characteristic as required by RAS.
+	 * A Ready notification, not its current value, starts a retrieval.
+	 */
+	DBG(rap, "Read Ranging Data Ready (%u bytes)", length);
+}
+
+static bool rap_subscribe_ranging_data(struct bt_rap *rap,
+			enum bt_rap_ranging_data_mode mode)
+{
+	struct ras *ras = rap_get_ras(rap);
+
+	if (!ras || !rap->client)
+		return false;
+
+	if (mode == BT_RAP_RANGING_DATA_REALTIME) {
+		uint16_t value_handle;
+
+		if (!(rap->ras_features & 0x01) || !ras->realtime_chrc ||
+			!gatt_db_attribute_get_char_data(ras->realtime_chrc,
+						NULL, &value_handle,
+						NULL, NULL, NULL))
+			return false;
+
+		rap->realtime_notify_id = bt_rap_register_notify(rap,
+				value_handle, rap->realtime_ccc_value,
+				ras_segment_notify_cb, "real-time");
+		if (rap->realtime_notify_id)
+			ras_realtime_arm_timeout(rap,
+					RAS_REALTIME_FIRST_SEGMENT_TIMEOUT);
+		return rap->realtime_notify_id != 0;
+	}
+
+	if (mode == BT_RAP_RANGING_DATA_ONDEMAND) {
+		uint16_t value_handle;
+
+		/* Data is segmented and can be large, so keep it on
+		 * notifications. The control and status characteristics use
+		 * the requested transport.
+		 */
+		rap_subscribe_ondemand_chrc(rap, ras->ondemand_chrc,
+			BT_RAP_RANGING_NOTIFY, ras_segment_notify_cb,
+			"on-demand", &rap->ondemand_notify_id);
+		rap_subscribe_ondemand_chrc(rap, ras->cp_chrc,
+			rap->ondemand_ccc_value, ras_cp_response_notify_cb,
+			"RAS Control Point", &rap->cp_notify_id);
+		rap_subscribe_ondemand_chrc(rap, ras->ready_chrc,
+			rap->ondemand_ccc_value, ras_data_ready_notify_cb,
+			"Ranging Data Ready", &rap->ready_notify_id);
+		rap_subscribe_ondemand_chrc(rap, ras->overwritten_chrc,
+			rap->ondemand_ccc_value,
+			ras_data_overwritten_notify_cb,
+			"Ranging Data Overwritten",
+			&rap->overwritten_notify_id);
+		if (ras->ready_chrc &&
+			gatt_db_attribute_get_char_data(ras->ready_chrc, NULL,
+						&value_handle, NULL, NULL,
+						NULL))
+			rap_read_value(rap, value_handle,
+					ras_data_ready_read_complete, NULL);
+		return rap->ondemand_notify_id || rap->cp_notify_id ||
+			rap->ready_notify_id || rap->overwritten_notify_id;
+	}
+
+	return true;
+}
+
+bool bt_rap_set_ranging_data_mode(struct bt_rap *rap,
+			enum bt_rap_ranging_data_mode mode,
+			enum bt_rap_ranging_transport transport)
+{
+	if (!rap || !rap->client || !rap->ras_features)
+		return false;
+
+	if (mode == BT_RAP_RANGING_DATA_REALTIME &&
+			transport != BT_RAP_RANGING_NOTIFY &&
+			transport != BT_RAP_RANGING_INDICATE)
+		return false;
+
+	if (mode == BT_RAP_RANGING_DATA_ONDEMAND &&
+			transport != BT_RAP_RANGING_NOTIFY &&
+			transport != BT_RAP_RANGING_INDICATE)
+		return false;
+
+	if (!bt_rap_disable_ranging_data(rap))
+		return false;
+
+	rap->realtime_ccc_value = transport;
+	rap->ondemand_ccc_value = transport;
+
+	return rap_subscribe_ranging_data(rap, mode);
 }
 
 static void read_ras_features(struct bt_rap *rap, bool success,
@@ -4410,6 +4632,7 @@ static void read_ras_features(struct bt_rap *rap, bool success,
 	abort_operation = (features & 0x04) != 0;
 	if (ras)
 		ras->client.abort_operation = abort_operation;
+	rap->ras_features = features;
 
 	DBG(rap, "RAS Features - Real-time: %s, Retrieve Lost: %s, Abort: %s",
 	    supports_realtime ? "Yes" : "No",
@@ -4423,48 +4646,10 @@ static void read_ras_features(struct bt_rap *rap, bool success,
 		return;
 	}
 
-	if (!rap->ondemand_mode) {
-		/* Register for real-time characteristic notifications */
-		if (supports_realtime && ras->realtime_chrc) {
-			uint16_t value_handle;
-
-			if (gatt_db_attribute_get_char_data(ras->realtime_chrc,
-						NULL, &value_handle,
-						NULL, NULL, NULL)) {
-				unsigned int notify_id;
-
-				notify_id = bt_rap_register_notify(rap,
-							value_handle,
-							ras_segment_notify_cb,
-							"real-time");
-				if (!notify_id)
-					DBG(rap, "Failed to register for "
-						"real-time notifications");
-				else
-					DBG(rap, "Registered for real-time "
-						"features: id=%u", notify_id);
-			}
-		}
-
-		return;
-	}
-
-	/* On-demand mode: subscribe to each on-demand characteristic
-	 * independently so a partially-capable peer doesn't block the
-	 * others.
-	 */
-	rap_subscribe_ondemand_chrc(rap, ras->ondemand_chrc,
-					ras_segment_notify_cb,
-					"on-demand");
-	rap_subscribe_ondemand_chrc(rap, ras->cp_chrc,
-					ras_cp_response_notify_cb,
-					"RAS Control Point");
-	rap_subscribe_ondemand_chrc(rap, ras->ready_chrc,
-					ras_data_ready_notify_cb,
-					"Ranging Data Ready");
-	rap_subscribe_ondemand_chrc(rap, ras->overwritten_chrc,
-					ras_data_overwritten_notify_cb,
-					"Ranging Data Overwritten");
+	if (!rap_subscribe_ranging_data(rap, rap->ondemand_mode ?
+				BT_RAP_RANGING_DATA_ONDEMAND :
+				BT_RAP_RANGING_DATA_REALTIME))
+		DBG(rap, "Failed to subscribe to requested Ranging Data mode");
 }
 
 static void foreach_rap_char(struct gatt_db_attribute *attr, void *user_data)
diff --git a/src/shared/rap.h b/src/shared/rap.h
index 9ab577710..af4fab057 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -303,3 +303,26 @@ void bt_rap_set_conn_interval(struct bt_rap *rap, uint16_t conn_interval);
  * GATT discovery to completion to take effect.
  */
 bool bt_rap_set_ondemand_ranging(struct bt_rap *rap, bool enable);
+
+enum bt_rap_ranging_data_mode {
+	BT_RAP_RANGING_DATA_DISABLED,
+	BT_RAP_RANGING_DATA_REALTIME,
+	BT_RAP_RANGING_DATA_ONDEMAND,
+};
+
+enum bt_rap_ranging_transport {
+	BT_RAP_RANGING_NOTIFY = 0x0001,
+	BT_RAP_RANGING_INDICATE = 0x0002,
+};
+
+/* Select the Requester's received Ranging Data subscription. This can only
+ * be called after remote RAS discovery and Features read complete.
+ */
+bool bt_rap_set_ranging_data_mode(struct bt_rap *rap,
+			enum bt_rap_ranging_data_mode mode,
+			enum bt_rap_ranging_transport transport);
+
+/* Initiator role: stop receiving Real-time Ranging Data. The GATT client
+ * disables the characteristic CCCD when this is its final subscription.
+ */
+bool bt_rap_disable_realtime_ranging(struct bt_rap *rap);
-- 
2.43.0

