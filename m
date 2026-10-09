Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4854348F83D
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537938; cv=none; b=RKaOC5rXyfD17P2Z4X3N4A9L6MS93xDWX6ghNfLxRxjiwndMzuJeyIOSQLIZZdOKhIpute6x6AamcuhTVvJC9lzRuJ+P16Ki/sYgpkscv896lb6d293BgEl98rE7Kig2kzR0v5JTBYBO9iocYLqr7MHkDZr0UWtDMR5pHRXOuqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537938; c=relaxed/simple;
	bh=/4vpbnjAyvxFOOUU4pizcE+1FX1nwAs3Obv4RG+H+Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8xHMsldZ0smCYJy4QAoaiZ6m6kmAuMtr7Mhtg0z14NNp2jnPdcEDmhMn7xAWOH/l1mAO3uw3dAl9gD71eTVzMmWGLFJBEtYN64zGgCwtAAP7skI6vjGpLNMZRZxgVnE4G/K44HasUZ+ZmYA/9DB/8cKmiIlmKanvgXeAitpZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EIVgdBnc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EIVgdBnc"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KK6I2369593
	for <linux-bluetooth@vger.kernel.org>; Fri, 9 Oct 2026 09:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=mv6792mMsIQ
	VksBvznclg2IyWRGufkkmoWXzM4cMI3A=; b=EIVgdBnc8yVZJbYdEfiEpNiZEeI
	1SkmylxkQQuixGq7dAjP0g+aoBv6zR+PRmJfumHQUFPORY/0a6h8kMooZetW+tqD
	7/NWdAXYHHFSwZGzKCT72EIFCnGgTsO5EWP+XXuskAi66IlBdvNwRNBZ0ZZXWgBC
	7GTXQiYSR3IWSpoYgnbW/MZ2FGzpRU5PNzCJohdfdt3l8ph1F6zOnMLfkj2pWg24
	e0PeoX26ro4nd1DmLVWve/RnACQVUJuS9I9E4S384aH5DiDsvfSXeco2VWfIzUIM
	sk13gC/1AbSICn+ENt3HXcQ8F62OM+3gHb7TeSVOt6ZamSwPytWf4ntbROQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxwaw0a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 09:25:36 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6999PYp63501184;
	Fri, 9 Oct 2026 09:25:34 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6999PYm03501162
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 09:25:34 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 7716B49BDC; Fri,  9 Oct 2026 17:25:33 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH v2 03/14] unit: Take the ATT opcode in the notify callbacks
Date: Fri,  9 Oct 2026 17:25:19 +0800
Message-ID: <20261009092532.3600749-4-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfX+ylkHu1pMgKJ
 PEwAb5WtZ6bWCVJzdPQH9t62/FNJgEBmKifnYoZoh8UphZC6vOCX2BEAWMU7dYy9O+Ozryuxkc9
 j8srzHSSUEv+jznXxubOdQT8gFsHItGNmlJ1fBpgS3w/PCMRN5Xt4BA5RbqGm5C34sRdXwz64PA
 ZSIOH2Svqe6RXLEHsGkHzdJSRhEHIhTuk3gXpPyPXMghvimXzZ0h5aU2DTGnNWeooz4nYAFu8dK
 aaWaJqOmW/2DaRtMGMUWT8iPmY9bKyswp3dgL8CzLUZK2L4ImmzO9t18tFJ0iFMO73/pu/bYj2h
 3ysD7PzAVCKWLYcTQO2NkJPkiVpxfPjXbAMWo2DckiO8c6jU/2JsMFa8hpiECjeDQ5aP8acR/C5
 5Va1tvg964LQ/pTloscVEZUADtx24EAzo5P4n2M359+tP+ykxNstJLvwqL8xn/qQNxXYB39jAdp
 buXAGIK0ZzQd9yiWxJA==
X-Proofpoint-GUID: hjVq6TszqCGTlECE222srnbXxGUzRIfL
X-Authority-Analysis: v=2.4 cv=cMB1IVeN c=1 sm=1 tr=0 ts=6ac8b310 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=WHHaNWctOLo9qeihjv4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfX6ZC0utvqBpMz
 lKexCTeP5MUTKP1qdN49Y4hu7GNJQ3k+9ZHtGOjNT3ND8Z7w1jX/ps+pPQkIvCp7VxKMoqiM5mt
 7ErumUUEzFEgIyr540g3KGPREgfjL0o=
X-Proofpoint-ORIG-GUID: hjVq6TszqCGTlECE222srnbXxGUzRIfL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090037

gatt_db_notify_t now passes the opcode of the operation it is serving.
Update the test callbacks to match; none of them needs to look at it.

Assisted-by: Claude:claude-opus-4.8
---
 unit/test-bap.c  | 3 ++-
 unit/test-bass.c | 3 ++-
 unit/test-mcp.c  | 3 ++-
 unit/test-micp.c | 3 ++-
 unit/test-rap.c  | 3 ++-
 unit/test-vcp.c  | 3 ++-
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 4e89ba6af..d16fbd96c 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -637,7 +637,8 @@ static struct ccc_state *get_ccc_state(struct test_data *data,
 static void gatt_notify_cb(struct gatt_db_attribute *attrib,
 					struct gatt_db_attribute *ccc,
 					const uint8_t *value, size_t len,
-					struct bt_att *att, void *user_data)
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
 {
 	struct test_data *data = user_data;
 	uint16_t handle = gatt_db_attribute_get_handle(attrib);
diff --git a/unit/test-bass.c b/unit/test-bass.c
index 0cdee043e..302501249 100644
--- a/unit/test-bass.c
+++ b/unit/test-bass.c
@@ -625,7 +625,8 @@ done:
 static void gatt_notify_cb(struct gatt_db_attribute *attrib,
 				struct gatt_db_attribute *ccc,
 				const uint8_t *value, size_t len,
-				struct bt_att *att, void *user_data)
+				uint8_t opcode, struct bt_att *att,
+				void *user_data)
 {
 	struct test_data *data = user_data;
 	struct ccc_state *ccc_state;
diff --git a/unit/test-mcp.c b/unit/test-mcp.c
index 21997915d..7ecb0d353 100644
--- a/unit/test-mcp.c
+++ b/unit/test-mcp.c
@@ -371,7 +371,8 @@ static struct ccc_state *get_ccc_state(struct test_data *data,
 static void gatt_notify_cb(struct gatt_db_attribute *attrib,
 					struct gatt_db_attribute *ccc,
 					const uint8_t *value, size_t len,
-					struct bt_att *att, void *user_data)
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
 {
 	struct test_data *data = user_data;
 	uint16_t handle = gatt_db_attribute_get_handle(attrib);
diff --git a/unit/test-micp.c b/unit/test-micp.c
index ff17300d5..1723ffa66 100644
--- a/unit/test-micp.c
+++ b/unit/test-micp.c
@@ -222,7 +222,8 @@ static struct ccc_state *get_ccc_state(struct test_data_mics *data,
 static void gatt_notify_cb(struct gatt_db_attribute *attrib,
 					struct gatt_db_attribute *ccc,
 					const uint8_t *value, size_t len,
-					struct bt_att *att, void *user_data)
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
 {
 	struct test_data_mics *data = user_data;
 	struct notify notify;
diff --git a/unit/test-rap.c b/unit/test-rap.c
index d7da2ff45..8e2759654 100644
--- a/unit/test-rap.c
+++ b/unit/test-rap.c
@@ -153,7 +153,8 @@ static struct ccc_state *get_ccc_state(struct test_data_ras *data,
 static void gatt_notify_cb(struct gatt_db_attribute *attrib,
 					struct gatt_db_attribute *ccc,
 					const uint8_t *value, size_t len,
-					struct bt_att *att, void *user_data)
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
 {
 	struct test_data_ras *data = user_data;
 	struct notify notify;
diff --git a/unit/test-vcp.c b/unit/test-vcp.c
index 4a60842e5..4ec4da428 100644
--- a/unit/test-vcp.c
+++ b/unit/test-vcp.c
@@ -127,7 +127,8 @@ static struct ccc_state *get_ccc_state(struct test_data *data,
 static void gatt_notify_cb(struct gatt_db_attribute *attrib,
 					struct gatt_db_attribute *ccc,
 					const uint8_t *value, size_t len,
-					struct bt_att *att, void *user_data)
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
 {
 	struct test_data *data = user_data;
 	uint16_t handle = gatt_db_attribute_get_handle(attrib);
-- 
2.43.0

