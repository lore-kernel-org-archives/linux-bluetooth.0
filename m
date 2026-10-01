Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBEE3C2796
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860762; cv=none; b=sL60V0F0C2FQk6y+9JQsv+hDlAtSC7m6bSQ8r/166Eyu9ZOHgoh3tqnq08rjosUx0fVMsNYlnoX0+jx2cnwqPR3zQdMfewOEEEyFzv6vNk29j9DYtTBDVChc8cWsP7/kb0hVLEZdp2uvSab4o6bMYijC3aEgHfbo1x7sBmoEi+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860762; c=relaxed/simple;
	bh=IgV4JqKGNgrmFOKdqMPnUvwpruXpqQ47oXAuL+tfLzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmpHPbTwWJoe5BzjyjThsa7MoEBJtRRWRgrcAOsaHXBflxDNURfIvgrvsTyYQ1K2GZ9U4Za2eHktr5nQkYumUmCiPVu5vApmS6/+M23U3VF3iXunT6ajqTU+OdwmHuwIAPqXOEN+CsZ4NYMDePT7OSDpyh7FbqeXen4tErLm0yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J5Lbr5qq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J5Lbr5qq"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691CiJaW962458
	for <linux-bluetooth@vger.kernel.org>; Thu, 1 Oct 2026 13:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=B0N6GyEaOKy
	YXGM6uX+RlsG0ytzBRZQYIMKN5yC6AfE=; b=J5Lbr5qq3HXYdyPhL90cJKQj2jr
	cn+lYKtEQ9KxsbPuT1KfrK3gn1gz6HnoBWGNY6W00tYVeiIQ83ooxzWVvzN39rgS
	lm19xGoPGy0a4E5HO8qeH0okQRJmCzbIcNgZuT8957FnVef0H580ZTCSaEpD85Fu
	CmD6/fkCwhMqQf+Esj3uN9E0aCEqNORT8iYvyevwh2gVrVD5lqcoQ7+mG3/GiXrl
	ZiN4qf2MMyJC7LPAEYns9x41ijdX7ELkzrCrge8UuKhRa+5oldcptCysldqcqYDK
	z4O+EbWOJufjrNE/RiNIUum25t9slzkR1wvixarmiUIb8B81y+vumHsVRUA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h16wcvchg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 13:19:17 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 691DJFuG2496351;
	Thu, 1 Oct 2026 13:19:15 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 691DJEfK2496337
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 13:19:15 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 15A1149BC8; Thu,  1 Oct 2026 21:19:13 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH 07/11] shared/rap: Add requester ranging data subscription API
Date: Thu,  1 Oct 2026 21:18:53 +0800
Message-ID: <20261001131900.707485-8-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfX58Hq2cfhUbKE
 qltKE8kyeo+GcABuDbC5fiTUgb69xFGxnS3i5PVeZKqviZTqVaDFKiC9ap9Jh0Ps+JiNXcwh3R7
 2TUlF6w1mOoHgfe2UcbRY4sAEw1FH5SmJAdU0g/063fKDYmP+uI3f4qz5fuclh4RjA7zimtdFOz
 /h8YKgmhWH41fZPWWdNsnEFLue6iz8yTR7CJHDsEmtIfCb18Jpd5aUaIChkXJmP970Xhx91bK6H
 KweMsFZvqVp0N+Qg/KMfWt5wKAlFj+HGbIqirBTz2X+3t/ENU74OL/mhmWJmx1IAN3zia8ORRak
 afUe0L5Wm78jaTkwuSrWy8Y7/QGTR0qcnDAmXH5T1evs3l2djoULJ26l2UM4XVlljCNcq6UQ+EP
 /PmXGiX5+1DLty/FHvPopHTkwO+YpfIfi+67fow8Y5mdgX6Ymu+NE727Q2uPUmx2pwCdPFUkFKy
 sYk1Mavt7x7tBn90epQ==
X-Proofpoint-GUID: bis_66j4wLH4xOtjMdyEFkGAn2l3ihph
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfX9tQSMf9nNUDr
 EXh1WKDJBMnSY1UHihcJCW47YYp2SBRvUjCeZyMoHpt3rY9Xh7pKZs5wlRJv05Q5SArP/g6h2xl
 QruiMZQWf76uiMhsr4pWe3Quv+Bc6ko=
X-Authority-Analysis: v=2.4 cv=S51MU4sP c=1 sm=1 tr=0 ts=6abe5dd5 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=H6PcJvQWHW-OtYxVAMYA:9
X-Proofpoint-ORIG-GUID: bis_66j4wLH4xOtjMdyEFkGAn2l3ihph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010053

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
 src/shared/rap.c | 270 ++++++++++++++++++++++++++++++++++++++---------
 src/shared/rap.h |  21 ++++
 2 files changed, 244 insertions(+), 47 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index b1108ad68..c0305a9e3 100644
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
@@ -470,6 +471,15 @@ struct bt_rap {
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
@@ -957,6 +967,15 @@ void bt_rap_detach(struct bt_rap *rap)
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
@@ -3397,6 +3416,7 @@ static void rap_notify_destroy(void *data)
 
 static unsigned int bt_rap_register_notify(struct bt_rap *rap,
 					uint16_t value_handle,
+					uint16_t ccc_value,
 					rap_notify_t func,
 					void *user_data)
 {
@@ -3409,9 +3429,13 @@ static unsigned int bt_rap_register_notify(struct bt_rap *rap,
 
 	DBG(rap, "register for notifications");
 
-	notify->id = bt_gatt_client_register_notify(rap->client,
-					value_handle, ras_register,
-					rap_notify, notify,
+	if (ccc_value)
+		notify->id = bt_gatt_client_register_notify_with_ccc(rap->client,
+					value_handle, ccc_value, ras_register,
+					rap_notify, notify, rap_notify_destroy);
+	else
+		notify->id = bt_gatt_client_register_notify(rap->client,
+					value_handle, ras_register, rap_notify, notify,
 					rap_notify_destroy);
 	if (!notify->id) {
 		DBG(rap, "Unable to register for notifications");
@@ -3424,6 +3448,85 @@ static unsigned int bt_rap_register_notify(struct bt_rap *rap,
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
@@ -4160,12 +4263,22 @@ static void ras_segment_notify_cb(struct bt_rap *rap, uint16_t value_handle,
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
@@ -4309,7 +4422,8 @@ static void ras_cp_response_notify_cb(struct bt_rap *rap,
  */
 static void rap_subscribe_ondemand_chrc(struct bt_rap *rap,
 					struct gatt_db_attribute *chrc,
-					rap_notify_t func, const char *name)
+					uint16_t ccc_value, rap_notify_t func, const char *name,
+					unsigned int *notify_id_out)
 {
 	uint16_t value_handle;
 	unsigned int notify_id;
@@ -4325,13 +4439,112 @@ static void rap_subscribe_ondemand_chrc(struct bt_rap *rap,
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
+	 * A Ready notification, not its current value, starts a retrieval. */
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
+			!gatt_db_attribute_get_char_data(ras->realtime_chrc, NULL,
+							&value_handle, NULL, NULL, NULL))
+			return false;
+
+		rap->realtime_notify_id = bt_rap_register_notify(rap, value_handle,
+				rap->realtime_ccc_value, ras_segment_notify_cb,
+				"real-time");
+		if (rap->realtime_notify_id)
+			ras_realtime_arm_timeout(rap,
+					RAS_REALTIME_FIRST_SEGMENT_TIMEOUT);
+		return rap->realtime_notify_id != 0;
+	}
+
+	if (mode == BT_RAP_RANGING_DATA_ONDEMAND) {
+		uint16_t value_handle;
+
+		/* Data is segmented and can be large; keep it notification-based.
+		 * The control/status characteristics use the requested transport. */
+		rap_subscribe_ondemand_chrc(rap, ras->ondemand_chrc,
+			BT_RAP_RANGING_NOTIFY,
+			ras_segment_notify_cb, "on-demand", &rap->ondemand_notify_id);
+		rap_subscribe_ondemand_chrc(rap, ras->cp_chrc,
+			rap->ondemand_ccc_value,
+			ras_cp_response_notify_cb, "RAS Control Point", &rap->cp_notify_id);
+		rap_subscribe_ondemand_chrc(rap, ras->ready_chrc,
+			rap->ondemand_ccc_value,
+			ras_data_ready_notify_cb, "Ranging Data Ready", &rap->ready_notify_id);
+		rap_subscribe_ondemand_chrc(rap, ras->overwritten_chrc,
+			rap->ondemand_ccc_value,
+			ras_data_overwritten_notify_cb, "Ranging Data Overwritten",
+			&rap->overwritten_notify_id);
+		if (ras->ready_chrc &&
+			gatt_db_attribute_get_char_data(ras->ready_chrc, NULL,
+						&value_handle, NULL, NULL, NULL))
+			rap_read_value(rap, value_handle, ras_data_ready_read_complete,
+					NULL);
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
@@ -4379,6 +4592,7 @@ static void read_ras_features(struct bt_rap *rap, bool success,
 	abort_operation = (features & 0x04) != 0;
 	if (ras)
 		ras->client.abort_operation = abort_operation;
+	rap->ras_features = features;
 
 	DBG(rap, "RAS Features - Real-time: %s, Retrieve Lost: %s, Abort: %s",
 	    supports_realtime ? "Yes" : "No",
@@ -4392,48 +4606,10 @@ static void read_ras_features(struct bt_rap *rap, bool success,
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
index 9ab577710..9a721df95 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -303,3 +303,24 @@ void bt_rap_set_conn_interval(struct bt_rap *rap, uint16_t conn_interval);
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
+/* Select the Requester's received Ranging Data subscription. This can only be
+ * called after remote RAS discovery and Features read complete. */
+bool bt_rap_set_ranging_data_mode(struct bt_rap *rap,
+			enum bt_rap_ranging_data_mode mode,
+			enum bt_rap_ranging_transport transport);
+
+/* Initiator role: stop receiving Real-time Ranging Data. The GATT client
+ * disables the characteristic CCCD when this is its final subscription. */
+bool bt_rap_disable_realtime_ranging(struct bt_rap *rap);
-- 
2.43.0

