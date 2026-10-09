Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497A73EE1C3
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537941; cv=none; b=m4FJBg2WI8KFZlPn3DEPmDDEfpMa9s/ztlxFOWo/GBvSFNRxY1xZPSRTgBteGLdXrahk/sktmFXyD5p+0IL3dWB3UDDNjDggQdM+Wc+ljDPva5bmLeEsMH433yffn8LDC0hf3KkdKz3RhIoh+8+UzwalgECj1dxzaDB5/JXHmY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537941; c=relaxed/simple;
	bh=cYXGdOdHTf7JWWBbXTmppAg7zOZ+aiwsu6gWvLy1NK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5bOP0YjKqHPHOfqk6CwGkdpksOiiHuo3EFUZr0J0i6UjA1x8Xn3RgvhwE3uTECusdF4cUWrRPswKIY7hPs5/FBwzx+NfX4qbD6GpuIy4iLLZBlAHGlDIhO8EkIl+qvT95LZ8UdJfYPUNqOQ65taLHOBpZNcznAl1o73dUlRHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R2qJVpda; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R2qJVpda"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KO1e1103157
	for <linux-bluetooth@vger.kernel.org>; Fri, 9 Oct 2026 09:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=W5Kw/kIZnPi
	Yc69f/7tvhmlGoWpEpjiho/FejDdNO+I=; b=R2qJVpda/a4Cs5nlxHfe2kCb55X
	P1/rS2scindOIr0hyV5CNSjOgFtyro3dAYT5B/wMreH557kqf1D6FXz/0qtibDAz
	O0OTXyQMaPNLXKdmhVgQYjnlEwcXj+df421O0AXyX1iVBdLDqDFnictSxKpOabiU
	JI06HOtGeZlW8Hz4qQIo5JR3fxPB9HBPkdD7L8KKuObA/9yxkXmmp0UeWjdcHOiA
	1uhDY5c4TZEvCIdEOMFNAItLpeBktfoeGnnTT4vsBWi6tTpST+x2kE4fQMeW1HJz
	fENB7bsfI0KUC7KcobU8w/SSPLYGo2iImgoeecbbm4sTwatv96Mg1XAoQtQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6b9km1e5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 09:25:37 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6999PYai3501183;
	Fri, 9 Oct 2026 09:25:34 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6999PYf43501163
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 09:25:34 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 7A4BD49BDD; Fri,  9 Oct 2026 17:25:33 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH v2 04/14] shared/gatt-db: Add gatt_db_attribute_indicate()
Date: Fri,  9 Oct 2026 17:25:20 +0800
Message-ID: <20261009092532.3600749-5-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 2n8O7lA2d28a_aA5HP00vbkkE8eRTm_V
X-Authority-Analysis: v=2.4 cv=U98Hnuru c=1 sm=1 tr=0 ts=6ac8b311 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=oCymsrMISqH1isRbsV4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfX5vwYHZUG28AG
 B8nPaJe/fzmKjXykaGwhqYQjFC5/bMUDqS3dar0jrrA57dlCnHNZ6/2y1jWSqxNGtYrwSzINgbW
 pyn0104SeldXM0w1WSfmka1wL/xAQEY=
X-Proofpoint-GUID: 2n8O7lA2d28a_aA5HP00vbkkE8eRTm_V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfX8rgdOag8uBpT
 ynhX2XBS9pWbhgDf90CmDdUIKmAiNxrVC5oRG9masN/13Sai0ig2YscnMrID9SYUSeqzhhRlT8o
 EWuLi08Zr0CBcdXJRncurtQTooqlU4qqU4jLKO09M4B8q+l+BVYkrDQ2G7H9qP5Lgz3NGxPa71C
 zCFy47zcL4gvex9Wo13BRZQlH99qQsECBHAR/2HPt93r4XOWLMyX/zbf6s86bNsqVkag+LtyGUd
 Bce4zLBMK2lcLljhQUMaeNYh21R7kV/3kY0LQIRAu8WBVcSlPlch/iH2BQexZY/VfFPzQK/y7xp
 o00u1b1rAUlmktWCYCnomp7MgnS0mSzY2KXDpBa+KCAzflx3Sw/RZFGp9UMJvuhf6BXJQUgeKay
 QkaKWetPSH4eYfQnE6ihff/QMxI/1jJ4b1IkLET3k+MsjrYHhKOiBc9EUCiV/uv4R0AtGOAeykh
 TXciPSOkB8r3N771K8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090037

gatt_db_attribute_notify() leaves the choice between a notification and an
indication to the CCC value the client wrote, preferring notifications
whenever the client enabled them. A server cannot therefore honour a
characteristic that has to be indicated: the Ranging Service requires
Ranging Data Ready and Ranging Data Overwritten to be indicated even when
the client subscribed to both transports (RAS 3.4.2, 3.5.2).

Add gatt_db_attribute_indicate() next to it. The two share a helper and
differ only in the opcode handed to the notify callback, so the CCC lookup
stays in one place, and a callback that does not care keeps working
unchanged.

gatt-database honours the request by skipping the notification branch and
sending an indication instead, provided the client enabled indications.

Assisted-by: Claude:claude-opus-4.8
---
 src/gatt-database.c  |  7 ++++++-
 src/shared/gatt-db.c | 20 +++++++++++++++++---
 src/shared/gatt-db.h | 12 ++++++++++++
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index b8bcc0a04..b511e13e3 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -168,6 +168,7 @@ struct notify {
 	uint16_t len;
 	bt_gatt_server_conf_func_t conf;
 	void *user_data;
+	bool indicate;
 };
 
 #define CLI_FEAT_SIZE 1
@@ -1446,7 +1447,7 @@ static void send_notification_to_device(void *data, void *user_data)
 	 * TODO: If the device is not connected but bonded, send the
 	 * notification/indication when it becomes connected.
 	 */
-	if (ccc->value & 0x0001) {
+	if (!notify->indicate && (ccc->value & 0x0001)) {
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
@@ -1487,6 +1491,7 @@ static void gatt_notify_cb(struct gatt_db_attribute *attrib,
 	notify.ccc_handle = gatt_db_attribute_get_handle(ccc);
 	notify.value = (void *) value;
 	notify.len = len;
+	notify.indicate = (opcode == BT_ATT_OP_HANDLE_IND);
 
 	if (attrib == database->svc_chngd)
 		notify.conf = service_changed_conf;
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index d168e355b..af26ca5c1 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -2440,9 +2440,9 @@ gatt_db_attribute_get_ccc(struct gatt_db_attribute *attrib)
 	return ccc;
 }
 
-bool gatt_db_attribute_notify(struct gatt_db_attribute *attrib,
+static bool attribute_notify(struct gatt_db_attribute *attrib,
 					const uint8_t *value, size_t len,
-					struct bt_att *att)
+					uint8_t opcode, struct bt_att *att)
 {
 	struct gatt_db_attribute *ccc;
 	struct gatt_db *db;
@@ -2468,12 +2468,26 @@ bool gatt_db_attribute_notify(struct gatt_db_attribute *attrib,
 	else
 		notify_user_data = ccc->user_data;
 
-	attrib->notify_func(attrib, ccc, value, len, BT_ATT_OP_HANDLE_NFY, att,
+	attrib->notify_func(attrib, ccc, value, len, opcode, att,
 							notify_user_data);
 
 	return true;
 }
 
+bool gatt_db_attribute_notify(struct gatt_db_attribute *attrib,
+					const uint8_t *value, size_t len,
+					struct bt_att *att)
+{
+	return attribute_notify(attrib, value, len, BT_ATT_OP_HANDLE_NFY, att);
+}
+
+bool gatt_db_attribute_indicate(struct gatt_db_attribute *attrib,
+					const uint8_t *value, size_t len,
+					struct bt_att *att)
+{
+	return attribute_notify(attrib, value, len, BT_ATT_OP_HANDLE_IND, att);
+}
+
 bool gatt_db_attribute_reset(struct gatt_db_attribute *attrib)
 {
 	if (!attrib)
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 587a281b3..5e7e7203f 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -301,6 +301,18 @@ bool gatt_db_attribute_notify(struct gatt_db_attribute *attrib,
 					const uint8_t *value, size_t len,
 					struct bt_att *att);
 
+/* Same as gatt_db_attribute_notify() but asks for an indication, so the
+ * notify callback is given BT_ATT_OP_HANDLE_IND instead of
+ * BT_ATT_OP_HANDLE_NFY. Some profiles mandate the indication transport for
+ * specific characteristics, for example the Ranging Service Ranging Data
+ * Ready and Ranging Data Overwritten ones, which gatt_db_attribute_notify()
+ * cannot express since it prefers notifications whenever the client enabled
+ * them.
+ */
+bool gatt_db_attribute_indicate(struct gatt_db_attribute *attrib,
+					const uint8_t *value, size_t len,
+					struct bt_att *att);
+
 bool gatt_db_attribute_reset(struct gatt_db_attribute *attrib);
 
 void *gatt_db_attribute_get_user_data(struct gatt_db_attribute *attrib);
-- 
2.43.0

