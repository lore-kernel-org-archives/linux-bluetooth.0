Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E500813E031
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713932835; cv=none; b=cbaedvexmPVQiXGKXbVHKRsbmDS9W47nJu/JK5LGUJos/wV3/y7YkxnxdEtkqAskZr0y3drO82SPDYsuyVpNb6Xgu8exXGNKjiViZKua5c/XbJywZf4BoBgFmDVJiP+LLsvJAqTejgzV9A0JCJDNxmGRGerd0pDp7cMBteyTens=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713932835; c=relaxed/simple;
	bh=xRsRrX1nq4aq5Vme9i57fCltAGFzXYukSByJbX5fceI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pa0fIvzsMOaNXmzrcS4Jom6CkEV5ogMRcmOcFhhJeeXXbk5O7dWbYUCLGVqWh7rgcrOJjhX4ExCRlGHOZds7slw4VgBAFcIhTHEBf8fB4vmJX5jlWpBIrjqO1ckV1YdBsNMtkWHA4gPTZpBG2/by+NBERzJXP9gC00gxaJxkOWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OeKuP+qC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OeKuP+qC"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O2bl3M001760;
	Wed, 24 Apr 2024 04:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=5VVYn4Qo0Qv9olEA4O3c
	tX+Ub6G/uPT4RdWCMqfx6Jg=; b=OeKuP+qCTouVfsC7p0LgDvmrpDS6AUS6tFWD
	I2WBDrtUVRY2I703OIwEcfkykmtiHNg3qy1NHROX/ez1XhQBLKZiQ/sB3ds5k9Zn
	MIiEdZN97dh6dvdvza0dZwE5isIE8Fl3ePGUG+qleDixEjQyO3yJ87LaJ2E0PztH
	i5bvhCeZRjgmn2tr7HFLIfiImilr/LINSnHY8jQdErvm1nVDvpz06YcSS863ZKDu
	LcFhYJVy2wzHUJnCk+kvsgqWxZQEvLjWeDpJJ2qQTUAQZMejeWuAcJDTKOOtWjmG
	+OWdNHKIF2OoNkU1oZV8N8R8kGJxsSFYZcIZH50OV01fyShB+Q==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xppn5gesq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 04:27:04 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O4R4Hb028655
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 04:27:04 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Apr 2024 21:26:56 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>,
        <bartosz.golaszewski@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <wt@penguintechs.org>, <regressions@lists.linux.dev>,
        <kernel@quicinc.com>, <gregkh@linuxfoundation.org>,
        <stable@vge.kernel.org>
Subject: [PATCH v7 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
Date: Wed, 24 Apr 2024 12:26:46 +0800
Message-ID: <1713932807-19619-2-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713932807-19619-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713932807-19619-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: mV96DoL7ukkNVZKCPG0oG-_tjF08Ir2r
X-Proofpoint-ORIG-GUID: mV96DoL7ukkNVZKCPG0oG-_tjF08Ir2r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_01,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240018

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
Cc: stable@vge.kernel.org
Reported-by: Wren Turkal <wt@penguintechs.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Tested-by: Wren Turkal <wt@penguintechs.org>
---
Changes:
V6 -> V7: Add stable tag
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

