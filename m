Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F30E1422C3
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 08:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947733; cv=none; b=psR5EAyaxu/T16gIkYeti2k91vwS8aR1eSc3Yq08ir4HUybXfW7GseI2IPO1BSlsFod95hPYbDJA5/qZFBJfrfTiH4N3MvAtJjF0XZUSqM1nMWqHttseAR8ZEdBpso7a1/hQ+aQFFOC/DMeMXdhUc/badiJDVHU9gefj3OyGlfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947733; c=relaxed/simple;
	bh=w+nZM0SNckJ5URBgPtRzQrUvtDDut74UQ2nlhwet7To=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ErV7lkWRmRHRVBGyR6++VjJ6oha5SoECt1l92qqMFFl7HTqrf6AlV94YECljugG9q/wuCauezmOqoOkaFjZpgOyEe8ThzhQ/VdsG4bQQjJoOyDPatx88EgZy9KESuATXEXj810ERAZPqO8G1ueYCgwf4pD1shQ/gS6nagA5Zt/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hDI3570V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hDI3570V"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O8TFaT011364;
	Wed, 24 Apr 2024 08:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=vDFImD9L851v3eokbLJ+e59EKftJ969NRYvO1svYOIo=; b=hD
	I3570VcftHjjzq0p/YugEVHaaZpIS5YcFibYWerfpMgMGynQBvykkIH01BZgp++f
	KqFFylUBvUS4VK1fGqT/veszVEEpjOFBC/k3bNImLJ7JWdmV5AitRGoM8OEUFbS2
	Ohs1ulFyFNYMYnusMylk6LnhY+ofW6UdVCMrFjDZyovEoASQBfVhn4jN/PFP2jPb
	1i/2wm2kPjC0LZm9gH6U/0Szis9eQLOzxIaOGmYZVGw7Vo0AlyIWUOFhRUwzQ6kl
	121TK3lroiNx6bYTQ9Yn3HZZH5e/EHuca0p6yrNixZ4qn4j9BGV2Bp3Ec09VrmpQ
	+1mOjeT5QiHS48eve4fA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9gra7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 08:35:24 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O8ZMMJ029351
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 08:35:22 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 01:35:16 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>,
        <bartosz.golaszewski@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <wt@penguintechs.org>, <kernel@quicinc.com>
Subject: [PATCH v1] Bluetooth: qca: Correct property enable-gpios handling logic for WCN6750 and WCN6855
Date: Wed, 24 Apr 2024 16:35:12 +0800
Message-ID: <1713947712-4307-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hf3oUbC05QlDFsbrMn1PklslbAVWlhcs
X-Proofpoint-ORIG-GUID: hf3oUbC05QlDFsbrMn1PklslbAVWlhcs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_06,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240036

Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
with gpiod_get_optional()") has wrong logic for below case:

property enable-gpios is not configured for WCN6750 and WCN6855

Function devm_gpiod_get_optional(...,"enable",...) returns NULL for above
case, we normaly need to treat it as success case as the commit argued
but the property enable-gpios is marked as required by the binding spec
Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
so we can't treat it as success case any more since it is a required
property but not configured by user.

Fix by reverting the commit's impact for WCN6750 and WCN6855, error
prompt is also added for this case.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index b621a0a40ea4..5c6bafe008ed 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2328,10 +2328,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
-		if (IS_ERR(qcadev->bt_en) &&
+		if (IS_ERR_OR_NULL(qcadev->bt_en) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855)) {
-			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
+			if (IS_ERR(qcadev->bt_en))
+				dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
+			else
+				dev_err(&serdev->dev, "required BT_EN gpio is not configured\n");
 			power_ctrl_enabled = false;
 		}
 
-- 
2.7.4

