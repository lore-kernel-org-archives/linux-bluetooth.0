Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CED51E529
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Sep 2024 03:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726974303; cv=none; b=o44O+ore9mR4nSfTQnsrmKA9wOZCR+CgszkqBCV5gbr/8cJZ5K16gUcYlFGcXfRNZcfaizySyeo5ROr8X+TGCEZgAvxqpQkrtGjokuzuDbwehz/DwZgZ1Lq8HPC+01C0aC6p2s4PiqMMNh78EEjfNwDAiQTUjs9ZZ0DpaUn4V7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726974303; c=relaxed/simple;
	bh=cYQ2LHypgp9y1z21bOEDAHSsa3m68sIB/yChEfOITiA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ijbphFOgQxiknyHuOvYB4KubfG93Turgwray1ADa8OHOxWmt1UEqhySvs43xfxAdadbSeI63mg9irux2ScFmPegPEP7dToAe7bm+RJ/qgbGY2eYrjyMF2O1oOW10tE6hwta2IIIUtNGPn5iu0LKk9tHAQehMpGPkK9X1Z7CXf+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dGLQzbVQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dGLQzbVQ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48M2AVQG003569
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Sep 2024 03:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7Wg3EFntnKuYzJiaBunUdw
	wICcpmiNlEDkBAztH7W84=; b=dGLQzbVQ41y+EABuci0HmG7gHS0jRsaR9r2Kq1
	Z9B+ht4pn+HNsftzhTr41s2fEU64Dg09MmYHWnqs7ZHtkGydYCqP7bNSPP3O7IhR
	shWl+J1W6NAXld4xmGcH+6ZQRW7zNSyeZ3jaIA4tKTKjLVDtbmG+VzzkfI4jogdh
	Q+kTPaCk737kITG6nZWg6kgHRGVcMsnAkAl9V28o/JDTfCmbufyOOBKUkUfGyjkW
	10pE/0yrKk1Nzpi90pOApritmd8eZIAPoJJm3DPCd3cCh1R8NYkczwwVRIF3BV0y
	Ld4ZaClPHmszDe4zWffmZhGZJvAtEIpUX36E6GxjdLbpV9BQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41skgn21ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Sep 2024 03:04:53 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48M34qaW026874
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Sep 2024 03:04:52 GMT
Received: from chejiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 21 Sep 2024 20:04:51 -0700
From: Cheng Jiang <quic_chejiang@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_jiaymao@quicinc.com>
Subject: [PATCH v3] adapter: Cancel the service authorization when remote is disconnected
Date: Sun, 22 Sep 2024 11:04:17 +0800
Message-ID: <20240922030417.140005-1-quic_chejiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: roFncojxlSmQpkb1KKCCx08hzeQq-kG4
X-Proofpoint-GUID: roFncojxlSmQpkb1KKCCx08hzeQq-kG4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 impostorscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409220022

If the remote device drops the connection before DUT confirm the
service authorization, the DUT still must wait for service
authorization timeout before processing future request.

Cancel the service authorization request when connection is dropped.
---
 src/adapter.c | 44 ++++++++++++++++++++++++--------------------
 src/adapter.h |  2 ++
 src/device.c  |  3 +++
 3 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 6fbfcdf2e..2bb94cf16 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1420,8 +1420,6 @@ static void adapter_remove_device(struct btd_adapter *adapter,
 void btd_adapter_remove_device(struct btd_adapter *adapter,
 				struct btd_device *dev)
 {
-	GList *l;
-
 	adapter->connect_list = g_slist_remove(adapter->connect_list, dev);
 
 	adapter_remove_device(adapter, dev);
@@ -1435,22 +1433,7 @@ void btd_adapter_remove_device(struct btd_adapter *adapter,
 	if (adapter->connect_le == dev)
 		adapter->connect_le = NULL;
 
-	l = adapter->auths->head;
-	while (l != NULL) {
-		struct service_auth *auth = l->data;
-		GList *next = g_list_next(l);
-
-		if (auth->device != dev) {
-			l = next;
-			continue;
-		}
-
-		g_queue_delete_link(adapter->auths, l);
-		l = next;
-
-		service_auth_cancel(auth);
-	}
-
+	btd_adapter_cancel_service_auth(adapter, dev);
 	device_remove(dev, TRUE);
 }
 
@@ -7538,8 +7521,7 @@ static void adapter_remove_connection(struct btd_adapter *adapter,
 
 	device_remove_connection(device, bdaddr_type, &remove_device);
 
-	if (device_is_authenticating(device))
-		device_cancel_authentication(device, TRUE);
+	device_cancel_authentication(device, TRUE);
 
 	/* If another bearer is still connected */
 	if (btd_device_bearer_is_connected(device))
@@ -10905,3 +10887,25 @@ bool btd_adapter_has_exp_feature(struct btd_adapter *adapter, uint32_t feature)
 
 	return false;
 }
+
+void btd_adapter_cancel_service_auth(struct btd_adapter *adapter,
+			struct btd_device *device)
+{
+	GList *l;
+
+	l = adapter->auths->head;
+	while (l != NULL) {
+		struct service_auth *auth = l->data;
+		GList *next = g_list_next(l);
+
+		if (auth->device != device) {
+			l = next;
+			continue;
+		}
+
+		g_queue_delete_link(adapter->auths, l);
+		l = next;
+
+		service_auth_cancel(auth);
+	}
+}
diff --git a/src/adapter.h b/src/adapter.h
index e3695b21b..8dfbe762e 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -298,3 +298,5 @@ void btd_adapter_store_conn_param(struct btd_adapter *adapter,
 				const bdaddr_t *peer, uint8_t bdaddr_type,
 				uint16_t min_interval, uint16_t max_interval,
 				uint16_t latency, uint16_t timeout);
+void btd_adapter_cancel_service_auth(struct btd_adapter *adapter,
+				struct btd_device *device);
diff --git a/src/device.c b/src/device.c
index 8cba804ce..f8f61e643 100644
--- a/src/device.c
+++ b/src/device.c
@@ -7038,6 +7038,9 @@ void device_cancel_authentication(struct btd_device *device, gboolean aborted)
 	struct authentication_req *auth = device->authr;
 	char addr[18];
 
+	if (device->adapter)
+		btd_adapter_cancel_service_auth(device->adapter, device);
+
 	if (!auth)
 		return;
 
-- 
2.25.1

