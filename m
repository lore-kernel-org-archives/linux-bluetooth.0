Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F1939CED6;
	Fri, 23 Jan 2026 05:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769147585; cv=none; b=NZyI/Z33jdK0F4ooLv6B0O8U1/R2tjbAu/sU+k1wSRMroZjDsjnXbEZZeu9zakrF/IftrWwyvZRkU+d3z8Ga2OYo2mc7QdStF5Sfi4AgRGdHDKusDW0CbUcs3pbv0eQB0de9FORMaOYZfTjGFdpx0/zEaWK8/XLMWBhbYz23dgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769147585; c=relaxed/simple;
	bh=fJw+UAbcFeLr8GvMwZs7ehSXWVEZZg3BiMexaU+FlNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NN9EqoOsq9G9JmXIeS5GOqs9+/g/sc57P5ahdwwsb0AMMrfsTd95/VjtaCpZm5VdrYGy6MIs+hgL23prgZnZN5XPOyks9mJB5mO3bTUeaP/cSdXXq/uFVtlG0IuxTBCvjkzeOXfJMzZY6Jk7VTq4d18ZRhoe20QidwDWu4qC/0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QXb6InXi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QXb6InXi"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N56CCm3656479;
	Fri, 23 Jan 2026 05:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6z9VwOA/MOV
	0ELPu0mfZ7L3ZcZ3VrIUt8DVo2KxzSb0=; b=QXb6InXik03cqTcXVNH0ukJ5Qb7
	7GAwbK2LoePOgRrOzqQd0JNDh8xOKJEOIbVKDVN7R0P4p9MfuxmdFK3TCfkkQDD8
	FSv/lP33dOAphHKjK12Z57baW1nhrkpNebf1kKfjXtHitMDF0UTcLy6CKOrlY7kk
	v7/1afamA+ikst6n5VzPUPLTe8+XPX400biysx9tsvSo030ItaOHyCJX0Lez61B+
	MvbuM2m+aQNDzgpb81kZbbyHviXFKA7J2ynG4JnHTOVxfTXrt7OgEbiQRz4qYjx0
	UJaVnbR/K5hA/AsrYG0XHYxodhHS1Sf1TQexcRcNqo0TSu/Ml1dKxl6/UOw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bv2hw85e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 05:52:50 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60N5qmkY004304;
	Fri, 23 Jan 2026 05:52:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4br3gn8ryy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 05:52:48 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60N5qmoD004296;
	Fri, 23 Jan 2026 05:52:48 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 60N5qlDt004293
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 05:52:48 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4766378)
	id C15BA237CD; Fri, 23 Jan 2026 13:52:46 +0800 (CST)
From: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuai.zhang@oss.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com,
        wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com,
        Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Subject: [PATCH v1 2/2] Bluetooth: hci_qca: Enable HFP hardware offload for QCA2066 and WCN6855
Date: Fri, 23 Jan 2026 13:52:43 +0800
Message-Id: <20260123055243.2634107-3-mengshi.wu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123055243.2634107-1-mengshi.wu@oss.qualcomm.com>
References: <20260123055243.2634107-1-mengshi.wu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rmmruj87Hy0EDqGOvY-uk9Eyvd6XsBA5
X-Proofpoint-ORIG-GUID: rmmruj87Hy0EDqGOvY-uk9Eyvd6XsBA5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA0MiBTYWx0ZWRfX9m2S6aa3lKYl
 PtSEf63Ge17cXsQRTl7DudfCyEwKrKyS/3E9nYxDGcnD022oOW1bJMs47GVwy9P+WHuXxRMJffR
 14FJT2cQQlHGL4japLcuLSlXz0gqzWvSVM7v6y2ZEI6cDNz9y2Mbf8buQx9tw1Q9+7F5dGuaNa2
 9LFNJImA7kyKVqUFWi3Z+458uUccs/hr6YM26VEOZJs11x/wKk7+OCpU331ZbM3qggwS98Vq8w6
 82WPQvnLd1mae3/96YvEUm085JtNw2BI6DImCruf9bmMVQWTr/kAZt3h0cVzf9aoIvG/2RcDAmf
 +oFWBK2Shc4V/b+9zZBpCGvzDe/w5xMVfcenqjrfSvPFKnVaGw8TjiNK7iwTNVSplmoXqU/8hak
 RK+AU7d0kJiJJlcyjnD6KpUj15lDb86Lt1KGhIbvlmwUxVq+4deLeaYw3tSRTxbsm2cpVw6TDDf
 niwLF326bZzqQXbRl2g==
X-Authority-Analysis: v=2.4 cv=A4Rh/qWG c=1 sm=1 tr=0 ts=69730cb3 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=lTINfPR8oJ7KkP3lkikA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230042

Add QCA_CAP_HFP_HW_OFFLOAD capability flag to QCA2066 and WCN6855
device data structures to enable Hands-Free Profile (HFP) hardware
offload support on these Qualcomm Bluetooth chipsets.

Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 4e1e113f4..212a92bbf 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2118,7 +2118,8 @@ static const struct qca_device_data qca_soc_data_wcn3998 __maybe_unused = {
 static const struct qca_device_data qca_soc_data_qca2066 __maybe_unused = {
 	.soc_type = QCA_QCA2066,
 	.num_vregs = 0,
-	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
+	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES |
+			QCA_CAP_HFP_HW_OFFLOAD,
 };
 
 static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
@@ -2154,7 +2155,8 @@ static const struct qca_device_data qca_soc_data_wcn6855 __maybe_unused = {
 		{ "vddrfa1p2", 257000 },
 	},
 	.num_vregs = 6,
-	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
+	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES |
+			QCA_CAP_HFP_HW_OFFLOAD,
 };
 
 static const struct qca_device_data qca_soc_data_wcn7850 __maybe_unused = {
-- 
2.34.1

