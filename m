Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462BE4A24
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 00:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713919627; cv=none; b=YQCBlkQVr5mMpaqs3Wtsg/IybmQpMv8TT1A+qQRht4QHmNb2jzcn564c819CYsEDFa38M/PKMkMnuhT9FzDgmgHUFBgTwRYzxAUtisWe/LAtYkPgJfipKjVYT1imMkx3xS+Cvyp8C+X8C0QygwpTRpE/Fj6B2JVZm6FA6lgN8Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713919627; c=relaxed/simple;
	bh=OHmeabr68wlF5BCEuLU+14CcOyNcs6LsoPKsEEbTNcU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iENDo0WZpJs5DGDHN0X6q6qGHQJAR7sEQk33Yt4uutb6bkJG+Jo97xy5wRnf6/mLgJSWWJeodCqTS8yE5z5JncnOenJhceltO+5GL2+vmjdj+yw7MzekjMRgJuMVcAeF8JqILbqaPSUJ4Ni87Ml7w7KRINZMQI6Ov6uoaD9CpfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CQrg74/Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CQrg74/Z"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NNSGPp011660;
	Wed, 24 Apr 2024 00:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=maZoiijPfERIdSrE+5eS
	q0GGZ36e+sGVhm/6HFRLOzo=; b=CQrg74/ZK4vpIfF9RNZ72tAbVGq7u0Mvzrj9
	JDELA7D8OQp/RKaZtJIRYBnnu/Sp/ZzrxppzGsZzA1bcx7qPjkX5m+lpWkUjSd6V
	Xuq9RV4QceyFEIJENKy48cPpt72sYqekz2ko1tP/qBZxRcVYke+f+8K7Hvsk/7Z9
	82TOn09X0LWHBA+McZ/ecXIIRze6e2+iAj/1ABV9vm2vCjnmqfAjHJO7h6p19yhS
	d5XI9RIO0Ct3DZFFB0upzF7kMQFXrVvzGD87NdSHwYKOGqyjGU1HJT2toGQ+mIm8
	PYf4ZVTcuFGQ1VmA/GnzG+YTnuF8117b0m4evZZev7K/qP9v5w==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp91rtsfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 00:46:59 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O0kwSs010557
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 00:46:58 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Apr 2024 17:46:52 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>,
        <bartosz.golaszewski@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <wt@penguintechs.org>, <regressions@lists.linux.dev>,
        <kernel@quicinc.com>
Subject: [PATCH v6 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
Date: Wed, 24 Apr 2024 08:46:41 +0800
Message-ID: <1713919602-5812-2-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713919602-5812-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713919602-5812-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: iVK-xhbuXRhSr5Vm_nAMdyGF4RNbU7_U
X-Proofpoint-ORIG-GUID: iVK-xhbuXRhSr5Vm_nAMdyGF4RNbU7_U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_19,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240001

Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
with gpiod_get_optional()") will cause below serious regression issue:

BT can't be enabled any more after below steps:
cold boot -> enable BT -> disable BT -> BT enable failure
if property enable-gpios is not configured within DT|ACPI for QCA6390.

The commit wrongly changes flag @power_ctrl_enabled set logic for this
case as shown by its below code applet and causes this serious issue.
qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
                                               GPIOD_OUT_LOW);
- if (IS_ERR_OR_NULL(qcadev->bt_en)) {
+ if (IS_ERR(qcadev->bt_en)) {
  	dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
	power_ctrl_enabled = false;
  }

Fixed by reverting the mentioned commit for QCA6390.

Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
Reported-by: Wren Turkal <wt@penguintechs.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Tested-by: Wren Turkal <wt@penguintechs.org>
---
Changes:
V3 -> V6: Correct code stype and title and commit message
V1 -> V3: Don't revert the whole wrong commit but focus on impacted device 

 drivers/bluetooth/hci_qca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 92fa20f5ac7d..4079254fb1c8 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2357,6 +2357,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		if (IS_ERR(qcadev->bt_en)) {
 			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
 			power_ctrl_enabled = false;
+		} else if (!qcadev->bt_en && qcadev->btsoc_type == QCA_QCA6390) {
+			power_ctrl_enabled = false;
 		}
 
 		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
-- 
2.7.4

