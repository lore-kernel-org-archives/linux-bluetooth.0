Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B895E2D238F
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860759; cv=none; b=NpVsc8oKFhBSmgVfQneXX92mlbREOaeG6bdk3IVcnouNrcpPmvXw7/9x+iJY6k473D8ErQxhiVhnCmue7d14xLWx6nV1eiQ4ItX9sdwa3827pbZhwZvS2BeC2Cw6N63mKHM0C5nxFGBwYoys1nPEGSiJvD55c9ieohH+RQvKwsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860759; c=relaxed/simple;
	bh=s9NG+vwJ3Z2RzA+kP/T+PdLndFlYJ+vdShbDw5dnmeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYXmaQQ46o4w+08sIMbuStHIQpGhRM8hcIvzFS3UkOjq7XC8ATO1393MSw+9A0QHlzf32x7Ce9irIVyDqMddc+SrRvSr5jdm4yTp3y68BsP13Ull+b5vujyJNTtUSNxKns3WuXn+8xMFtlLpaiJ1kanI+6+cY6hqA7iw7SHLKL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RLqgZzAb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RLqgZzAb"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691CiDwn1289076
	for <linux-bluetooth@vger.kernel.org>; Thu, 1 Oct 2026 13:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lwffcUk6qQ2
	DG0X+xQPuSek4ZkL2OL/AUfhiEJXi+3g=; b=RLqgZzAbI4J4+hUMgdJQ81e1+ZD
	kJMoVvhzbaEwTZ9JGPO0W0JRZclCTGMqh6rcrJ6PQZjAt/vNCYImLC8+ObLpl+zg
	oPnMsZGSs8xM2oge3GjNNGpl2c2DWEn/vpvshKvZ4/LEoQnj5lDadaG5ELOd58MX
	rtmPmCzgZbFkqqH14FF+sbbJEaRvzVR7tmdjDeYLxd7NPSDs8k6jU5gAguXougql
	lzaV5drq7SCu0JKvjHV9gbERmyFzpnCSqxPZuM5G7QZfs65+uxTrQZo2NMd50+fZ
	bDqikk3sSeOwjzVgT81h6opCZpBBpwhr4pkVwGLI9XpOl67X6PtH8WQLWBg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h17pjc5c8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 13:19:15 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 691DJEkX2501458;
	Thu, 1 Oct 2026 13:19:14 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 691DJDww2501444
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 13:19:13 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 0214649BAE; Thu,  1 Oct 2026 21:19:13 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH 02/11] shared/gatt-db: Add gatt_db_attribute_indicate()
Date: Thu,  1 Oct 2026 21:18:48 +0800
Message-ID: <20261001131900.707485-3-cheng.jiang@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=eqpKXYpX c=1 sm=1 tr=0 ts=6abe5dd3 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=x0fDcO7K-zMjWE45GsUA:9
X-Proofpoint-GUID: WJzr3PejoRchiNJ9ERUNQdmuOCpwgn8_
X-Proofpoint-ORIG-GUID: WJzr3PejoRchiNJ9ERUNQdmuOCpwgn8_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfXxj7payk0CvPS
 98Hyo8D0lOj4XKzwrZsiFEXUv+boBhOvxEWsL0XtQ2vnYnTe7hmGXCTs0B5PMgw/UdMs+dfotBh
 pG595TyasXWBCT28NbR0GZTvq5lhnQM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfXyPLMSnNtDsVU
 bCKz12Zd/UMvKo34j3ecSwZ6frSv6WPh/8wmHDhj3lkvMuK1qOr2J2Hs9+04vQhmzDa75U7DGUm
 +ZyTYLkrJ65Y6Ae5Sr8bXgeYnZTyQuF5lqHd73JL19A31pM7zC37rsewJGub/t0NJVzcln9CiEJ
 n84BCZ4hSDYl+j7Yx1OvgZZ9FylUkSX6vzmjoXlARYAhzi+9jbLiYv2M6X9eH8SdaH6Ui4EbiIf
 9hJ+eT37paMiKEQt6/r3Tt5niJMhQE/dhq4GV792RcyCNnn0jw4q4cbMxro7olB3T+muJSmGYaK
 +iGV+QFd6/94mlzO4f0SHjVIXnRv5MrO3duOCHm/qnW16T4aGxuCAIUT2SImpDSMj1AH6a7EOYi
 e5JCpQy2unJ4uj75kRWwIFhrLJUYhkvJzYezy5YekKIJfi2qweYuCimOkzGdpaPLs2BKwo34F7i
 DWDL4fX/Q/aQlxGBobg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010053

The notify callback leaves the choice between a notification and an
indication entirely to the CCC value written by the client, preferring
notifications whenever the client enabled them. Some services need the
indication transport for a given characteristic regardless: the Ranging
Service must indicate Ranging Data Ready and Ranging Data Overwritten
even when the client subscribed to both transports (RAS 3.4.2, 3.5.2).

Add gatt_db_attribute_indicate() alongside gatt_db_attribute_notify() and
let the callback query which of the two it was invoked from through
gatt_db_attribute_indicate_only(). Both entry points share a helper, so
the CCC lookup stays in one place, and neither gatt_db_notify_t nor the
existing gatt_db_attribute_notify() callers change.

gatt-database honors the request by skipping the notification branch and
sending an indication instead, provided the client enabled indications.

Assisted-by: Claude:claude-opus-4.8
---
 src/gatt-database.c  |  7 ++++++-
 src/shared/gatt-db.c | 35 +++++++++++++++++++++++++++++++++--
 src/shared/gatt-db.h | 17 +++++++++++++++++
 unit/test-rap.c      | 13 +++++++++----
 4 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 18b7aa667..800f76032 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -168,6 +168,7 @@ struct notify {
 	uint16_t len;
 	bt_gatt_server_conf_func_t conf;
 	void *user_data;
+	bool indicate_only;
 };
 
 #define CLI_FEAT_SIZE 1
@@ -1446,7 +1447,7 @@ static void send_notification_to_device(void *data, void *user_data)
 	 * TODO: If the device is not connected but bonded, send the
 	 * notification/indication when it becomes connected.
 	 */
-	if (ccc->value & 0x0001) {
+	if (!notify->indicate_only && (ccc->value & 0x0001)) {
 		DBG("GATT server sending notification");
 		bt_gatt_server_send_notification(server,
 					notify->handle, notify->value,
@@ -1455,6 +1456,9 @@ static void send_notification_to_device(void *data, void *user_data)
 		return;
 	}
 
+	if (!(ccc->value & 0x0002))
+		return;
+
 	DBG("GATT server sending indication");
 	bt_gatt_server_send_indication(server, notify->handle, notify->value,
 						notify->len, notify->conf,
@@ -1486,6 +1490,7 @@ static void gatt_notify_cb(struct gatt_db_attribute *attrib,
 	notify.ccc_handle = gatt_db_attribute_get_handle(ccc);
 	notify.value = (void *) value;
 	notify.len = len;
+	notify.indicate_only = gatt_db_attribute_indicate_only(attrib);
 
 	if (attrib == database->svc_chngd)
 		notify.conf = service_changed_conf;
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 751d4c3da..1f6e9ae14 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -123,6 +123,11 @@ struct gatt_db_attribute {
 
 	unsigned int next_notify_id;
 	struct queue *notify_list;
+
+	/* Set only while notify_func is being called on behalf of
+	 * gatt_db_attribute_indicate().
+	 */
+	bool indicate_only;
 };
 
 struct gatt_db_service {
@@ -2440,9 +2445,9 @@ gatt_db_attribute_get_ccc(struct gatt_db_attribute *attrib)
 	return ccc;
 }
 
-bool gatt_db_attribute_notify(struct gatt_db_attribute *attrib,
+static bool attribute_notify(struct gatt_db_attribute *attrib,
 					const uint8_t *value, size_t len,
-					struct bt_att *att)
+					struct bt_att *att, bool indicate_only)
 {
 	struct gatt_db_attribute *ccc;
 	struct gatt_db *db;
@@ -2468,11 +2473,37 @@ bool gatt_db_attribute_notify(struct gatt_db_attribute *attrib,
 	else
 		notify_user_data = ccc->user_data;
 
+	attrib->indicate_only = indicate_only;
+
 	attrib->notify_func(attrib, ccc, value, len, att, notify_user_data);
 
+	attrib->indicate_only = false;
+
 	return true;
 }
 
+bool gatt_db_attribute_notify(struct gatt_db_attribute *attrib,
+					const uint8_t *value, size_t len,
+					struct bt_att *att)
+{
+	return attribute_notify(attrib, value, len, att, false);
+}
+
+bool gatt_db_attribute_indicate(struct gatt_db_attribute *attrib,
+					const uint8_t *value, size_t len,
+					struct bt_att *att)
+{
+	return attribute_notify(attrib, value, len, att, true);
+}
+
+bool gatt_db_attribute_indicate_only(const struct gatt_db_attribute *attrib)
+{
+	if (!attrib)
+		return false;
+
+	return attrib->indicate_only;
+}
+
 bool gatt_db_attribute_reset(struct gatt_db_attribute *attrib)
 {
 	if (!attrib)
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index da0600c01..63d7f3464 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -300,6 +300,23 @@ bool gatt_db_attribute_notify(struct gatt_db_attribute *attrib,
 					const uint8_t *value, size_t len,
 					struct bt_att *att);
 
+/* Same as gatt_db_attribute_notify() but requests an indication even when the
+ * client has also enabled notifications. Some profiles mandate the indication
+ * transport for specific characteristics (e.g. the RAS Ranging Data Ready and
+ * Ranging Data Overwritten characteristics), which gatt_db_attribute_notify()
+ * cannot express since it prefers notifications whenever the client enabled
+ * them.
+ */
+bool gatt_db_attribute_indicate(struct gatt_db_attribute *attrib,
+					const uint8_t *value, size_t len,
+					struct bt_att *att);
+
+/* Valid only while a gatt_db_notify_t callback is running: tells whether it was
+ * triggered by gatt_db_attribute_indicate() rather than
+ * gatt_db_attribute_notify().
+ */
+bool gatt_db_attribute_indicate_only(const struct gatt_db_attribute *attrib);
+
 bool gatt_db_attribute_reset(struct gatt_db_attribute *attrib);
 
 void *gatt_db_attribute_get_user_data(struct gatt_db_attribute *attrib);
diff --git a/unit/test-rap.c b/unit/test-rap.c
index d7da2ff45..5c6033a4e 100644
--- a/unit/test-rap.c
+++ b/unit/test-rap.c
@@ -167,10 +167,15 @@ static void gatt_notify_cb(struct gatt_db_attribute *attrib,
 
 	printf("%s: notify.value:%d notify->len:%d\n", __func__,
 		(int)*(notify.value), notify.len);
-	if (!bt_gatt_server_send_notification(data->server,
-			notify.handle, notify.value,
-			notify.len, false))
-		printf("%s: Failed to send notification\n", __func__);
+	if (gatt_db_attribute_indicate_only(attrib)) {
+		if (!bt_gatt_server_send_indication(data->server, notify.handle,
+				notify.value, notify.len, NULL, NULL, NULL) &&
+				tester_use_debug())
+			tester_debug("Failed to send indication");
+	} else if (!bt_gatt_server_send_notification(data->server,
+			notify.handle, notify.value, notify.len, false) &&
+			tester_use_debug())
+		tester_debug("Failed to send notification");
 }
 
 static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
-- 
2.43.0

