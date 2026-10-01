Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F524AAC66
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860759; cv=none; b=V6TPqKYkyeAMUEN5bCfz06u3O7rs2/ATZ3JcCib3dgxe/E6clguvTqlAMJmcni7fW6coJ6KJ8KD6rylxlGphfnQJtoZ1LJu79Ay3tUjDX1Wdmz/Vtuqpd+piNT59k5BLWtBv88ZFPZrcImBKTKl3JLJv8NTm6JMIDBQy12SWcOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860759; c=relaxed/simple;
	bh=lbp1/5IrGOYDjSlL9bZNIsWHUX/+FKrczPto2dbcdSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVyFZs9gvT50qG70XJTLjXG9B++koqzlrlt5O7MD+Kgv3sxuWyDqiVbALIHrSb5Jsmib9g2gyUroqnc36um2v+qnpbarJM2FxQCIBl3XzH0/mZhnFmz6k6IL4eZ6hShgXOB9E2ZZ7ziONCwg/wIgzXD9U8UtfGGzsZC03p82Xd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JNCUOC1Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JNCUOC1Z"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691CxYku1062199
	for <linux-bluetooth@vger.kernel.org>; Thu, 1 Oct 2026 13:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+4EBmF9Vr3x
	hl0KtNh2UhIja7b8jdss+TevrMKE6Ymg=; b=JNCUOC1Zo4sJ6ZfdV9X/FSFw/7L
	12jrvo5a8wkGxR3950GipGhq3p0zaWeOHz1yxKV2JphyrvugCkiiXJkIS9HHwB4L
	ozIO5HAW+LUs9w6WlCAHuvuMBN4RAfY7nL+u85zUJm0uN5zc1A5fzuhqnehNeamz
	9f52eyzFb3VyfElfRU+wzgoSp9I0SrdVNfjyvMT/uwM10Qsjnk/NyZ8hIesAksa5
	KSyFwe9vDabWSet1H+ft0svakafpEB4LeBHveWaWWwft5PsiZix4OrgoFPFaf3dr
	/6aIYRsTNltqJmF6hbBiX7b2AH9J4n2cm8hEQ/nOyHhYVwa6zJHPhFGWp6Q==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h17mvv356-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 13:19:15 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 691DJEwR2496307;
	Thu, 1 Oct 2026 13:19:14 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 691DJD9x2496294
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 13:19:13 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id F1A5A41C78; Thu,  1 Oct 2026 21:19:12 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH 01/11] shared/gatt-client: Allow registering notify with explicit CCC value
Date: Thu,  1 Oct 2026 21:18:47 +0800
Message-ID: <20261001131900.707485-2-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 2YLu961AzOUOqRQu7a2RT7QogSH7ld6u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfXwl4GyLVKvqr/
 zrLbT8TSvos306DkfV3QKdATSBPlsxF2Jx+aCNnWGcRt7L5Kb2q5mY9gKfx67uuPgBu5IZkhhMZ
 Lp8Zn31cZH/MCn3BKGhbFhiiIfkYg9WwQbhJSRy0K9nlpejEK2hnrP2F3MEXFhN/bXn8rsrThIp
 CYbKoDpApuMBxDNe+bjqsPyXRzQ7OsyqRsyzVHSqifPiWVRbWQqoayaAKTfqGJV0JprbNsmId7+
 DNFYlgaNLgk1Uf/xrthvcyhK5At7eLHLRiXL+rC5tWiZSEphrXP4xp2XKtJ9D5vHzPo1hQC6krr
 Zu1nDMN7vFfv6sRu2ruHcVLdj7wPeCQa5pvos/BfTH6WFerlkXtklmc7BIuVDqgV7GZSh9otSxM
 nxvd9M/N+le4PKl38XhpxC0NWSlyG6TnHog35pPa0fsFsghJjwhxKDkiHXVsaKnm8BUUGXuWzDL
 DWFK4McT37W3O8uUbxw==
X-Proofpoint-GUID: 2YLu961AzOUOqRQu7a2RT7QogSH7ld6u
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfX/fuJHBO5c4hD
 NEn4zOWCQWFlcIYXJsnPmsA4mfkGLrf6yLxI7Y6km1Q7RGmn0oqqhmUk4oLU0qyKzezrMSm+0Pd
 EsYAS+LDliLPmC34FJpxXZzp9Zy7HoE=
X-Authority-Analysis: v=2.4 cv=KuvYSmWN c=1 sm=1 tr=0 ts=6abe5dd3 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=k-Iygp5wEp1O0Gt4uwcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010053

bt_gatt_client_register_notify() picks the CCC value to write based on
the characteristic properties, preferring notifications over indications
when both are supported. A client that specifically needs one of the two
- for example the Ranging Service, which distinguishes notification and
indication transports - has no way to request it.

Add bt_gatt_client_register_notify_with_ccc() which takes the desired
CCC value (0x0001 for notifications, 0x0002 for indications) and writes
it verbatim. register_notify() gains a ccc_value argument and rejects a
value the characteristic does not support. The existing entry point
keeps its behaviour by passing 0, which restores the property-based
selection.

Assisted-by: Claude:claude-opus-4.8
---
 src/shared/gatt-client.c | 41 +++++++++++++++++++++++++++++++++++-----
 src/shared/gatt-client.h |  7 +++++++
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 92ad7c39c..1cf361f50 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -232,6 +232,7 @@ struct notify_data {
 	uint8_t att_ecode;
 	int ref_count;
 	struct notify_chrc *chrc;
+	uint16_t ccc_value;
 	bt_gatt_client_register_callback_t callback;
 	bt_gatt_client_notify_callback_t notify;
 	void *user_data;
@@ -1670,10 +1671,9 @@ static bool notify_data_write_ccc(struct notify_data *notify_data, bool enable,
 	assert(notify_data->chrc->ccc_handle);
 
 	if (enable) {
-		/* Try to enable notifications or indications based on
-		 * whatever the characteristic supports.
-		 */
-		if (properties & BT_GATT_CHRC_PROP_NOTIFY)
+		if (notify_data->ccc_value)
+			value = cpu_to_le16(notify_data->ccc_value);
+		else if (properties & BT_GATT_CHRC_PROP_NOTIFY)
 			value = cpu_to_le16(0x0001);
 		else if (properties & BT_GATT_CHRC_PROP_INDICATE)
 			value = cpu_to_le16(0x0002);
@@ -1749,6 +1749,7 @@ static bool match_notify_chrc_value_handle(const void *a, const void *b)
 
 static unsigned int register_notify(struct bt_gatt_client *client,
 				uint16_t handle,
+				uint16_t ccc_value,
 				bt_gatt_client_register_callback_t callback,
 				bt_gatt_client_notify_callback_t notify,
 				void *user_data,
@@ -1778,10 +1779,20 @@ static unsigned int register_notify(struct bt_gatt_client *client,
 	if (chrc->notify_count == INT_MAX)
 		return 0;
 
+	if (ccc_value == 0x0001 && !(chrc->properties & BT_GATT_CHRC_PROP_NOTIFY))
+		return 0;
+
+	if (ccc_value == 0x0002 && !(chrc->properties & BT_GATT_CHRC_PROP_INDICATE))
+		return 0;
+
+	if (ccc_value != 0 && ccc_value != 0x0001 && ccc_value != 0x0002)
+		return 0;
+
 	notify_data = new0(struct notify_data, 1);
 	notify_data->client = client;
 	notify_data->ref_count = 1;
 	notify_data->chrc = chrc;
+	notify_data->ccc_value = ccc_value;
 	notify_data->callback = callback;
 	notify_data->notify = notify;
 	notify_data->user_data = user_data;
@@ -1871,6 +1882,7 @@ static bool register_service_changed(struct bt_gatt_client *client)
 	 */
 	client->svc_chngd_ind_id = register_notify(client,
 					gatt_db_attribute_get_handle(attr),
+					0x0002,
 					service_changed_register_cb,
 					service_changed_cb,
 					client, NULL);
@@ -3834,10 +3846,29 @@ unsigned int bt_gatt_client_register_notify(struct bt_gatt_client *client,
 	if (client->in_svc_chngd)
 		return 0;
 
-	return register_notify(client, chrc_value_handle, callback, notify,
+	return register_notify(client, chrc_value_handle, 0, callback, notify,
 							user_data, destroy);
 }
 
+unsigned int bt_gatt_client_register_notify_with_ccc(
+				struct bt_gatt_client *client,
+				uint16_t chrc_value_handle, uint16_t ccc_value,
+				bt_gatt_client_register_callback_t callback,
+				bt_gatt_client_notify_callback_t notify,
+				void *user_data,
+				bt_gatt_client_destroy_func_t destroy)
+{
+	if (!client || !client->db || !chrc_value_handle ||
+			(!callback && !notify) || !ccc_value)
+		return 0;
+
+	if (client->in_svc_chngd)
+		return 0;
+
+	return register_notify(client, chrc_value_handle, ccc_value, callback,
+						notify, user_data, destroy);
+}
+
 bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 							unsigned int id)
 {
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 63cf99500..1b19c885b 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -122,6 +122,13 @@ unsigned int bt_gatt_client_register_notify(struct bt_gatt_client *client,
 				bt_gatt_client_notify_callback_t notify,
 				void *user_data,
 				bt_gatt_client_destroy_func_t destroy);
+unsigned int bt_gatt_client_register_notify_with_ccc(
+				struct bt_gatt_client *client,
+				uint16_t chrc_value_handle, uint16_t ccc_value,
+				bt_gatt_client_register_callback_t callback,
+				bt_gatt_client_notify_callback_t notify,
+				void *user_data,
+				bt_gatt_client_destroy_func_t destroy);
 bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 							unsigned int id);
 
-- 
2.43.0

