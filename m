Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA4A4CE05
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771517; cv=none; b=u/tH0Zs8koGyrdIB4JsAedC4HHmPleShInWWEuAY02VDNvrBzOMeeHdP+tmDqjkZZ6pH382sjzNT/uueU2NttQ/gfcMGKfX9uTSSlWw3cCremvHXL6QZ6kOGwH5fAwscNylAeg5t6r7I0ZFWl0PSLklF1PLRs60HGrURT66dzyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771517; c=relaxed/simple;
	bh=row+0Rh0WU2qpEUBTf4GCR+Sq+0e8R1S6azPu09H0eQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ood1l+ZTBHZQkjFD/EV9RxM3/3zMEE5mYt5AL7GcZklAIV4W44AXO/OyGOKUTG3J+eydXSp0xrM22k5z/Rf8jYXnAWXCIrZuI26mVZY528xQulUV9rOMGQVd0YAdSSRSEqFkNBiPVaKYwfXZCWjyluHAhy4zCbIJAB2ujKhDMeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BWvCM4CX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BWvCM4CX"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M71HSE013383;
	Mon, 22 Apr 2024 07:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=H/sU5CMfVKuec8euFUqA
	Q94/0LHWKcjFDdxN6QKyxIE=; b=BWvCM4CX4FRwBvF+UQXTQ3fr61NTo+dYNJQv
	QUm814oMOfN638OCwAjhB7nWHWJCv1WY/Tr0daMKtg2ZSMeYbnxfi6iGfmzWJKVN
	wAMjKcEg5iuxNger5eVaGg/azoinKXfjWhDu25Kh/C9u6xSQK3SoCyawA594nkXa
	IXgZzwdmwfNZ2siXGjPGnv1PNCCsYGwzEzSTHsXNxopD1ziogOkSavkepx5ERIQ5
	owbxqTt0GvIeeIVS6pcIMQVxYfSfLQqGRe4j2O/VCukyeTI27ChJI82dG3u8X3Ti
	ZPwraSAd68Slj8XEbBPyZGRJTs2inOmaMiu+HKKY9AKX7AxJSw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm6vrbce5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 07:38:27 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43M7cRUY031873
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 07:38:27 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Apr 2024 00:38:24 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>,
        <bartosz.golaszewski@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <wt@penguintechs.org>, <regressions@lists.linux.dev>
Subject: [PATCH v5 1/2] Bluetooth: qca: Fix BT enable failure for QCA_QCA6390
Date: Mon, 22 Apr 2024 15:38:16 +0800
Message-ID: <1713771497-5733-2-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713771497-5733-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713650800-29741-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713771497-5733-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oR8J08AQ0eQiJh5yDvBO6Y0gDHT-P9c5
X-Proofpoint-ORIG-GUID: oR8J08AQ0eQiJh5yDvBO6Y0gDHT-P9c5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_04,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 clxscore=1015 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220034

Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
with gpiod_get_optional()") will cause below serious regression issue:

BT can't be enabled any more after below steps:
cold boot -> enable BT -> disable BT -> BT enable failure
if property enable-gpios is not configured within DT|ACPI for QCA_QCA6390.

The commit wrongly changes flag @power_ctrl_enabled set logic for this
case as shown by its below code applet and causes this serious issue.
qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
                                               GPIOD_OUT_LOW);
- if (IS_ERR_OR_NULL(qcadev->bt_en)) {
+ if (IS_ERR(qcadev->bt_en)) {
  	dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
	power_ctrl_enabled = false;
  }

Fixed by reverting the mentioned commit for QCA_QCA6390.

Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
Reported-by: Wren Turkal <wt@penguintechs.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Tested-by: Wren Turkal <wt@penguintechs.org>
---
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

