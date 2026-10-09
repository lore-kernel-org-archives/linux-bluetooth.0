Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4223E43DEAB
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537941; cv=none; b=Dvu0bSbGB7gQGI1j88n+ks2PqQbKX0lcFeJUlJTIGE2aPyofpw3SdacSx84AW/Sqnalk+LP/OF9zHdhPmhuOHAYmLzpiGfUjiCmlq8csIKLu+bqHX3XLsRaQA9j+GN0RW4eX1xAbVZhcNrcfVUV06JhzpMY7Gp4f1g1rQTK01es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537941; c=relaxed/simple;
	bh=PPD66tLA+gZoC4ZGI9WpxugCZy+Io4m3WT7Hq31WjB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFAY/PnlTa4NRoJiHAXTVrZR/OVCk/Xn4nuIWOemVcPPGiEY2FlEn/HC/Y7j1NYUwEhPGd3Jkgb6FqiQL7+2qCsEqEeQ1WA6fZERl47IAtSRKq6rUxMYWbEgiYRSo843LjXBtyd8nSBM8Uf3DDiYxNnrp3jwsokSvtStRTudu4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R8xawm/P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R8xawm/P"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KIM5404357
	for <linux-bluetooth@vger.kernel.org>; Fri, 9 Oct 2026 09:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cF0VMP4WgZl
	IbRy7+KkUd9dVGiA6Z6IhFQQYqjhdWuY=; b=R8xawm/P2LhcCQ7I/wdE0EjsrfR
	ZXyidT21s7eyb/bsdVzvwS4HjVcaJXIjcnBRT6UAwL1QeIqdJnWtKk7fd+h4yw71
	2Xib+i/oIvdqriLbxBG+HpZFxUxkWYi6m5o39bH9j38EI4rycyKHkJYGwdhP9j9S
	yA8HQwLXUxAaUlSJ5X3ypTYjLxRaEFic/vKT/x7q6tULDjjnZMlkuW0Q70rBoJIU
	n6bJEnzgNn96rwEJpwp3GmNHzQvA/g0d5Mfo+Xk1mYJ13s/RopepKe711g7SwxuI
	IyJMYbfyqMXrvRn21EfpQDc6TTt636hp1eiLUXkswmwvXuZ4MQf69F9476g==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxk2wcw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 09:25:36 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6999PYeA3501187;
	Fri, 9 Oct 2026 09:25:34 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6999PYMi3501164
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 09:25:34 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 7003B415B9; Fri,  9 Oct 2026 17:25:33 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH v2 01/14] shared/gatt-client: Allow registering notify with explicit CCC value
Date: Fri,  9 Oct 2026 17:25:17 +0800
Message-ID: <20261009092532.3600749-2-cheng.jiang@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=fKesTpae c=1 sm=1 tr=0 ts=6ac8b310 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=k-Iygp5wEp1O0Gt4uwcA:9
X-Proofpoint-GUID: c7HQbQul8CbR-ipRc0f6MklLeFBACPf5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfXwLjK+fvtTuBk
 5jmoQPQl1ZUMmyo1FFGddmqjUpMU2V6lQSU00dlrLRlaf6rm6xnhtSVFxqpXG86YR+jDYmoLWr9
 pFnXWMe+JSSRwTgn1WNmOQbnSNawwSk=
X-Proofpoint-ORIG-GUID: c7HQbQul8CbR-ipRc0f6MklLeFBACPf5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfXz36CWseq+O9G
 Pa0crWI1U3YOqXYzSWM0t0+kXR0VDvungVwJ9+pbOZpq3RVo5pqeBYVSSVVZOsrvWpuRgSN9q4q
 /TtUrcnnDqpRyDc/zU9OnIwriu78wIZ2cfFawgjUeIbfnhocQWkVYY4eB4I6eyQSXP9ApxD5+Ea
 Wjs4An8/LKaDjv+D5Jh6SuqxyuLcZotPi0odhdSZCTWC0kKEOtZ9XiGg+eQPr3BvH+nT4Vk2AH8
 S8fucYHfozGwsPVGcKUAm57V29M6/ZGTy+MVLFk8TQ8nlPbYr0yHxSuij2waVyNy6ZQZhzJge9b
 bRp5fkys+fBLjl8NEqtVS/WifST4jNzQUCZNz2PMxtlw3cdnSRh9P8v4nTmz+C4Ql+Kz2RJpjv+
 iqFdMHABboBU7XiioCppc8K9HfiO7tRacvP+wIiRHrwTf/gCGljyRB3BVvhYqXYXIeN/HPQcSwX
 lRupKfidIwNUfoGJ9rA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090037

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
 src/shared/gatt-client.c | 43 +++++++++++++++++++++++++++++++++++-----
 src/shared/gatt-client.h |  7 +++++++
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 95f83fa3e..5c29587bb 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -242,6 +242,7 @@ struct notify_data {
 	uint8_t att_ecode;
 	int ref_count;
 	struct notify_chrc *chrc;
+	uint16_t ccc_value;
 	bt_gatt_client_register_callback_t callback;
 	bt_gatt_client_notify_callback_t notify;
 	void *user_data;
@@ -1680,10 +1681,9 @@ static bool notify_data_write_ccc(struct notify_data *notify_data, bool enable,
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
@@ -1759,6 +1759,7 @@ static bool match_notify_chrc_value_handle(const void *a, const void *b)
 
 static unsigned int register_notify(struct bt_gatt_client *client,
 				uint16_t handle,
+				uint16_t ccc_value,
 				bt_gatt_client_register_callback_t callback,
 				bt_gatt_client_notify_callback_t notify,
 				void *user_data,
@@ -1788,10 +1789,22 @@ static unsigned int register_notify(struct bt_gatt_client *client,
 	if (chrc->notify_count == INT_MAX)
 		return 0;
 
+	if (ccc_value == 0x0001 &&
+			!(chrc->properties & BT_GATT_CHRC_PROP_NOTIFY))
+		return 0;
+
+	if (ccc_value == 0x0002 &&
+			!(chrc->properties & BT_GATT_CHRC_PROP_INDICATE))
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
@@ -1881,6 +1894,7 @@ static bool register_service_changed(struct bt_gatt_client *client)
 	 */
 	client->svc_chngd_ind_id = register_notify(client,
 					gatt_db_attribute_get_handle(attr),
+					0x0002,
 					service_changed_register_cb,
 					service_changed_cb,
 					client, NULL);
@@ -3852,10 +3866,29 @@ unsigned int bt_gatt_client_register_notify(struct bt_gatt_client *client,
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
index ff90fd8ea..0c5d118c7 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -123,6 +123,13 @@ unsigned int bt_gatt_client_register_notify(struct bt_gatt_client *client,
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

