Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E2113D26E
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564231; cv=none; b=fFQIIYa5pBU8Zt1v93FAOy4ArTTOdzbMJMAmRUPJRjIGu88zAMWnDHDnaHETqmCndYnYk+VlDjO5xE58j9VxQJWgbDKE8H8b5oo/q74ceDxvHOB1Ai21j35H03HDY8WrvPD7zdQr8WxuDrgEDqJgcMG0yfYChkuFJ0AccHYcJck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564231; c=relaxed/simple;
	bh=rH+hoiAXiCkAbgpbk6f3xoECq+Yo3AxyfrRZQBHnwcc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2PFSs9ikFfk+S+8pD27a1ybBhTVd0F6GLroj+3jiEJ+xuFtoids5guHQrF+4Dy7j3Xj19K+MR9oqp3NaWwK29z6EMOy30RwCSPUyyZFXfNYoM0eIWm1dvSzYkytR6Bi16dU9dCcZEUKyrVZOTN13GM/snRhO5Q2JoAYFaz/WGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nfSKMcUa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nfSKMcUa"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JLTAt0026774;
	Fri, 19 Apr 2024 22:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=xISrgYG8Ihq3FmODEIfr
	fFtbHSfaIGZh22WWLCosrzg=; b=nfSKMcUaoQuJFWyAxmWR22gZrWhP8b2jEIZw
	osilQzxR6K4XoK9Z0lt2S7EWCHSrkPfx8Wr4qz/649U9lbpYMLAxc+FfhKuwN1et
	ef3E0fhiFiOeWHuT8wdVWnGe0/E7G4z6lSRBeqoHgB5cQl92OizcSxg/NVaF46oK
	GLz0A4dNJe21Rjp4UHdS1JMkEzHm8o95OckhIRvUYZOuw1cRP7yW7yYQVHHBlKlg
	oyjwVT0DRlCjbGsApP80ZDAhzKbbGr2dTlNReL6Mj4ZeF2Aoyogg6WaMvg/KzLSP
	j7nf37bwDHZissekHrTMic78RhI3lGLa2SAsRpdChDdIYrVf2g==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xk9s7awhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 22:03:42 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43JM3fTg008751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 22:03:41 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 19 Apr 2024 15:03:39 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>,
        <bartosz.golaszewski@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <wt@penguintechs.org>
Subject: [PATCH v3 1/2] Bluetooth: qca: Fix BT enable failure for QCA_QCA6390
Date: Sat, 20 Apr 2024 06:03:31 +0800
Message-ID: <1713564212-21725-2-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713564212-21725-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713564212-21725-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: Y25BaEwioLMnyveRMTagpciKRhbvcGde
X-Proofpoint-ORIG-GUID: Y25BaEwioLMnyveRMTagpciKRhbvcGde
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_15,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404190171

Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
with gpiod_get_optional()") will cause below serious regression issue:

BT can't be enabled any more after below steps:
cold boot -> enable BT -> disable BT -> BT enable failure
if BT reset pin is not configured within DT|ACPI for QCA_QCA6390.

The mentioned commit wrongly set quirk HCI_QUIRK_NON_PERSISTENT_SETUP
within qca_serdev_probe() for this case and cause this serious issue.

Fixed by reverting the mentioned commit for QCA_QCA6390.

Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
Reported-by: Wren Turkal <wt@penguintechs.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Tested-by: Wren Turkal <wt@penguintechs.org>
---
 drivers/bluetooth/hci_qca.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 92fa20f5ac7d..0934e74112a6 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2357,7 +2357,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		if (IS_ERR(qcadev->bt_en)) {
 			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
 			power_ctrl_enabled = false;
-		}
+		} else if (!qcadev->bt_en && qcadev->btsoc_type == QCA_QCA6390)
+			power_ctrl_enabled = false;
 
 		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
 		if (IS_ERR(qcadev->susclk)) {
-- 
2.7.4

