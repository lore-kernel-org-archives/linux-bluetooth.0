Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F52165FB6
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449215; cv=none; b=O6O1rd+dAB2LrAKHq+KiiUGq9d0WnTiUk9+ndXY5NilgthYGjHUgsyLXVU22u6O4ia7/eBH9WKAPCSkT0QnYjCXcKrHS0tBIBZ/zGT1yaehmRLbvnDso+q8TZ4vOE2hQrPgkOP8q6bBW2dnD7bt6mhNJ+kcWVYuBG020WD1LRQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449215; c=relaxed/simple;
	bh=8Q8sc0+Ydu2ZSfLsFfmLYkriplymhvWVdXVenLNzYZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebugkKi34ZykjTmhgUHpfB45QqzWBiYyXHs+qSD76hQO+5BqZ0Kz3RbfDhtYwWjUA2HLuFuBviMLgaorKnVaSsFyN2W60RGeTzunbB4ioz0OCibzw/o+ocvLp7hL9gG1p3sCNrP8813LQ0xPEPfuPSbJA2qduSbOIE3p05lvgE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HBMK6Y7x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HBMK6Y7x"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43I903BK026862;
	Thu, 18 Apr 2024 14:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=zReGGMbCnaN1NGCTaln/
	xDZRFZHSFHfw0FSB3qZvE0Q=; b=HBMK6Y7xPSca5Jg6C+DuNcJdkvOwbYfzk6id
	qUmVInTQ/W5KbHpCOs45J9SMvMegIsE5ljOmA4vzGl23IYZIiYJA95debgoa7Myt
	n0dGaY/eWuqKsXohNWNV/jXRWxNGOUWdTcAKSyUHsHEpIf2qAixNYg8k/gv22L6K
	8JFTEGPgDLUE5ve/QCMTEWcBFySZj9FBA2i0n7apcUABZwbgiloZPU6RBtCZ0/Lf
	Q+Ppz2XCIvSmON6jiHdJeZ2hi63zTPBBmezcLfKCC+AqXJZSEdYjUu7lcrcVtNnV
	AD+Srbeft9znf+ulJUT5avGRrOYQUb3DI0K5oVkradk8v+sp5Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xk0gm0mk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 14:06:42 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43IE6f6G014573
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 14:06:41 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 18 Apr 2024 07:06:39 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>,
        <wt@penguintechs.org>, <bartosz.golaszewski@linaro.org>,
        <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v1 1/2] Revert "Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()"
Date: Thu, 18 Apr 2024 22:06:31 +0800
Message-ID: <1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: r4Lq9BtCJIxDc7NuepdFD-gpWQmnQVhu
X-Proofpoint-GUID: r4Lq9BtCJIxDc7NuepdFD-gpWQmnQVhu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_12,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180100

This reverts commit 56d074d26c5828773b00b2185dd7e1d08273b8e8.

Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
with gpiod_get_optional()") will cause serious regression issue for
several QCA controllers such as QCA_WCN6750,QCA_WCN6855,QCA_ROME,
QCA_QCA6390 and QCA_QCA2066, the regression issue is that BT can't be
enabled any more once BT is disabled if BT reset pin is not configured
by DT or ACPI.

if BT reset pin is not configured, devm_gpiod_get_optional() will return
NULL, and we should NOT set quirk HCI_QUIRK_NON_PERSISTENT_SETUP, but the
reverted commit SET the quirk since NULL is not a error case, and cause
qca_setup() call failure triggered by the 2nd and later BT enable
operations since there are no available BT reset pin to clear BT firmware
downloaded by the 1st enable operation, fixed by reverting the commit.

Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
Reported-by: Wren Turkal <wt@penguintechs.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Tested-by: Wren Turkal <wt@penguintechs.org>
---
 drivers/bluetooth/hci_qca.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 92fa20f5ac7d..160175a23a49 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2323,7 +2323,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
-		if (IS_ERR(qcadev->bt_en) &&
+		if (IS_ERR_OR_NULL(qcadev->bt_en) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855)) {
 			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
@@ -2332,7 +2332,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
-		if (IS_ERR(qcadev->sw_ctrl) &&
+		if (IS_ERR_OR_NULL(qcadev->sw_ctrl) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855 ||
 		     data->soc_type == QCA_WCN7850))
@@ -2354,7 +2354,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	default:
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
-		if (IS_ERR(qcadev->bt_en)) {
+		if (IS_ERR_OR_NULL(qcadev->bt_en)) {
 			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
 			power_ctrl_enabled = false;
 		}
-- 
2.7.4

