Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354023D667F
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537939; cv=none; b=gRSLYGVaRa+PkyI3yska3EHVmOePkA8tkFWbdl2QUTCS46904MFdq5GaORflW0KocaSStfRuUPKXYQg5oZQiumhss0Ucf95I9XPjbyMpcrBnQX02PcqDFoqRSBPY8BNC5C3NHGnicMhog+XbGe1lC+mfcCrFi4DKoSUCfp8t4DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537939; c=relaxed/simple;
	bh=IuVb95NtlLIkXt1Jdyeef/4w3bf3kjk97/hoHWidxqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgQPELT6HijqprcmckeUxVvpS2/wy7MB3HL5V5k2G9qYiMEpxSxKM1LLhTDOcjdqobgN0lApKdgHhmcfc/oSi43fMYt0JokaxKd6yXYH1bV/gOsYQMWJYRhVlmhQi5c33PDJ66s6Ru4slQwCzd5UGZv2CIT4Pn6cdBdjMZ6PgAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q5UvCDqg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q5UvCDqg"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KFPj906806
	for <linux-bluetooth@vger.kernel.org>; Fri, 9 Oct 2026 09:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Uc5e3EkTJtE
	p2nDadnhmEe9QoB14aWJ92ZKbl58+ClI=; b=Q5UvCDqgqwe0pRKSbYc756O5HzJ
	xY8q5TQVVkoYTD4xyySDoiDtv8NBh8I6Dav1jBt8FhQcH73diAQIytnPmJVpKUkp
	6uaN4QPFtx/9MisxnWT+gVlf+QuG8X6rt8kUx2WyW0k4yaHAtP+MmSNQW1/ZRjI8
	5RrNaFJ994Ix3qfOnCIwEYsFHSkfF8NLxsKpVc49oXLoBx9pA3vR13vBf5bxTNgp
	x7VM6vodNdV5KtxRfuzhzKVwBGrVNis5SKnU/cj/NB15WazItnc4qS/agD4+JbAq
	rdSwhymVT8p996HEP7eXghEFnT2Rs7OqNKqDSSrCg/8eF5jfH1x2niA9I0g==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fmqu0fa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 09:25:36 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6999PYvY3497406;
	Fri, 9 Oct 2026 09:25:34 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6999PYFA3497392
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 09:25:34 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 735D249BDB; Fri,  9 Oct 2026 17:25:33 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH v2 02/14] shared/gatt-db: Pass the ATT opcode to the notify callback
Date: Fri,  9 Oct 2026 17:25:18 +0800
Message-ID: <20261009092532.3600749-3-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfX0/zecaum8ycG
 olPcI8UYy1yCma0M9/UIZK3C9mbXQxSW1rMHunLO18zIBF5Xq9bcjwDjG+XrdYcuHAdKogWAtXk
 OvRIjk18ASDseglMoy2Fb3qJ5jYdlx8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfX8mUnlSykSJJ2
 rL03FaKzMxO+d5yR/3GmZBnPqDw55VapDBdCPDm8NK/iCqmHwZ/eYrsWzsrCQkVyIq2kWzcU6i2
 WeFjJCcSnnKrAW8qUXoQMfFrxIQSDbyajfLIEXIPor4dTszhVX6f5PhqoBtVHavXPUoox233hkt
 uF1Os86GP5QJip09NTUbrqXuU+VVloAgIuHv28kcsRnnJi3tfwB9f3t7cOXhS/yQr/t35sK28xS
 9FF1z8UwoX8AhVk0MgV4eD+dnOrN38SmUrA4Z8UNbzsfyFtAvcr2uIvQMcqvZnLNURwi4JpZi8+
 Euor5EvhtbawZcf7FHG6ahUQCI/kyzSjZRveBsPAAXsjLn9tHip8dKKBufSYhALp56C8p/ZUKNC
 I7Wfk0cXEWHtWY29/mhz/jvILFuZj7tyxiI+dPb40kh9wYtJKxFfrMwdCaeGluHJjVzog7Egljw
 HpkrEeOl4cQbIRkNO8A==
X-Proofpoint-GUID: 2PAjjkwzTQPDqRyik79OiGnLkWbTxUCt
X-Proofpoint-ORIG-GUID: 2PAjjkwzTQPDqRyik79OiGnLkWbTxUCt
X-Authority-Analysis: v=2.4 cv=IqCL47/g c=1 sm=1 tr=0 ts=6ac8b311 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=GIKLfr4ZlUauLyFVOd4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090037

gatt_db_read_t and gatt_db_write_t both tell the callback which ATT
operation it is serving through an opcode argument. gatt_db_notify_t does
not, so a notify callback can only assume a notification.

Pass the opcode the same way, set to BT_ATT_OP_HANDLE_NFY, which is what
gatt_db_attribute_notify() has always meant. No caller behaviour changes
yet; it gives the callback somewhere to read the transport from once there
is more than one.

Assisted-by: Claude:claude-opus-4.8
---
 src/gatt-database.c  | 3 ++-
 src/shared/gatt-db.c | 3 ++-
 src/shared/gatt-db.h | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 18b7aa667..b8bcc0a04 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1474,7 +1474,8 @@ remove:
 static void gatt_notify_cb(struct gatt_db_attribute *attrib,
 					struct gatt_db_attribute *ccc,
 					const uint8_t *value, size_t len,
-					struct bt_att *att, void *user_data)
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
 {
 	struct btd_gatt_database *database = user_data;
 	struct notify notify;
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 751d4c3da..d168e355b 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -2468,7 +2468,8 @@ bool gatt_db_attribute_notify(struct gatt_db_attribute *attrib,
 	else
 		notify_user_data = ccc->user_data;
 
-	attrib->notify_func(attrib, ccc, value, len, att, notify_user_data);
+	attrib->notify_func(attrib, ccc, value, len, BT_ATT_OP_HANDLE_NFY, att,
+							notify_user_data);
 
 	return true;
 }
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index da0600c01..587a281b3 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -51,7 +51,8 @@ typedef void (*gatt_db_write_t) (struct gatt_db_attribute *attrib,
 typedef void (*gatt_db_notify_t) (struct gatt_db_attribute *attrib,
 					struct gatt_db_attribute *ccc,
 					const uint8_t *value, size_t len,
-					struct bt_att *att, void *user_data);
+					uint8_t opcode, struct bt_att *att,
+					void *user_data);
 
 struct gatt_db_attribute *
 gatt_db_service_add_characteristic(struct gatt_db_attribute *attrib,
-- 
2.43.0

