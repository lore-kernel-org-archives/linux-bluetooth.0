Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CFD12C489
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 07:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656195; cv=none; b=b6wqkEW56eGU1NX9LUrcZlWu/GT9gh6tmkXQtf8khF284nvHK0N8JpyiE7oZ81EYUT3fV1YSskwCkvtk23lop2iLwPZoXQ/vVElA3jDKmSaM9tbAfapBrzSnqZdraauBG9I90gkKQ+HUBxZd0dDnV8qHpP6O6I/BU1O33vZwGUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656195; c=relaxed/simple;
	bh=YKaUwu15KIooAWm8RiFwucP3tAbRtY2o9pasGIzqXzQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TL7g7Tn+ZIMKXm4TseMEwDO7ByU2kZdTN+253RqawkiJh+HBa8r9/9y/4KkYcARHTHoAObWyLxg9MHTmcJhLiU4P20Z+Lf2i+URSAgsp7GFfOg36c+v7loTK/dk+ir5BaSYpFYBj8yjH5MtZ7ikaJ5svwwg07uXoiRNuQVB4zm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Nub0w9O8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Nub0w9O8"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q0ONah005711
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 07:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RZap1Sn5CYeWz4PdtqZmMf
	uNuffD46AbqgzIfM/IShU=; b=Nub0w9O8bDkwb5ulsLnCeGVbFsPg9fMN/sMqka
	PpzkZDYcjhhxnfNwNK0jOVwuP1zGli3AtxTsN26+ekAfb+GgyORrrbqTNGwT1+ZV
	LwxwsuX3cXDi2/7NwsRTf1dihMuKFIm1TpjiU6oN0t7Pdq5NqvzOrxgp9rUODYoI
	6p/+JJyvh5pG+j9JLlaVrsWXVDbohCJZJi7Yi+NhuVacQL0yh8B5WfMRvz9mFb9R
	QiTLOplekhY87nAvVzehJsZ5byfjW6xe5eFGdVwrTbJOufwQttoGXwJ3m5NKIW22
	Jx7Wl84TUTmvkNY31E9ukZZ6widOEDaaITm/CT/0AniqBuoA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 417976trdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 07:09:51 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47Q79oe3014245
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 07:09:50 GMT
Received: from chejiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 26 Aug 2024 00:09:49 -0700
From: Cheng Jiang <quic_chejiang@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v1] adapter: Cancel the service authorization when remote is disconnected
Date: Mon, 26 Aug 2024 15:09:27 +0800
Message-ID: <20240826070927.557290-1-quic_chejiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XXnzZL-zMAv8_1ejh91L6euhHwXAMSOp
X-Proofpoint-GUID: XXnzZL-zMAv8_1ejh91L6euhHwXAMSOp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_04,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408260056

If the remote device drops the connection before DUT confirm the
service authorization, the DUT still must wait for service
authorization timeout before processing future request.

Cancel the service authorization request when connection is dropped.
---
 src/adapter.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 245de4456..cd4cff8e7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8502,6 +8502,23 @@ static void disconnect_notify(struct btd_device *dev, uint8_t reason)
 	}
 }
 
+static void adapter_cancel_service_auth(struct btd_adapter *adapter, struct btd_device *device)
+{
+	struct service_auth *auth;
+	GSList *l;
+	auth = NULL;
+	for (l = adapter->auths->head; l != NULL; l = l->next) {
+		auth = l->data;
+		if (auth->device == device)
+			break;
+	}
+	if (auth != NULL) {
+		DBG("Cancel pending auth: %s", auth->uuid);
+		g_queue_remove(auth->adapter->auths, auth);
+		service_auth_cancel(auth);
+	}
+}
+
 static void dev_disconnected(struct btd_adapter *adapter,
 					const struct mgmt_addr_info *addr,
 					uint8_t reason)
@@ -8516,6 +8533,7 @@ static void dev_disconnected(struct btd_adapter *adapter,
 	device = btd_adapter_find_device(adapter, &addr->bdaddr, addr->type);
 	if (device) {
 		adapter_remove_connection(adapter, device, addr->type);
+		adapter_cancel_service_auth(adapter, device);
 		disconnect_notify(device, reason);
 	}
 
-- 
2.25.1

