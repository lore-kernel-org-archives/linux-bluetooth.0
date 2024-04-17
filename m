Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B234413C8EE
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 11:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354838; cv=none; b=mL2NA6TNsrvaIUkmWAD8DyaPJFpQcJS9+GQcPvt+MHNNEi1U0a6HZLqQXDNIgl+mukcH0yjeDNcsKjJh0P280jTQEeyZYEbP/vSflXjpE6No3mcxifX9WQP6tdgn86shVB6JjTd39hh9MWM+DfR5a4Sc3T9OhU++bw4DuRgn/BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354838; c=relaxed/simple;
	bh=SPqJ+tar85EqK2sJ1QsHWYtqwY3hUw7NY0vsbCGUKcw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FN4MeiHYbJfsktmtstKl45NjRjzDe7fcfppmuDFokijduxgiagdTRd1Pln1/2Fsh5oC3psoFqLD2tsJfY0fXPiMLYHW511xubJXh1+P1d2Is5u/CP8voWvBG8upF9aCq+2GX5226px92NfwHGEU9MsFP8aDnXQTatdoZqF9W8Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RUTvEbu4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RUTvEbu4"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HApgfJ028047;
	Wed, 17 Apr 2024 11:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=ywSHOwKG3LVaRo0T0OyRiuYdAjK3J4ynsIKMbDTP0q4=; b=RU
	TvEbu4TQT9ZUB7Ktfm9rlMNqHG2b792qOmpawaycTNdrj+YAkNkRgqdaM70ZZBhC
	kq2iBGuA0v1idCwKt34Y1FyKaF6DVrZmgtwG8IJ4QB5cXgOs4lkAl3vGJ0ZdXiea
	rp5vGdALH3Vt4cYTxM1i3gEPsAc1shJJOz39YZlNtYVibGXeES9nRNNRdOy3h+GR
	i4639BOze3/RZD2eUatOi5ughkOD5DjdgRMpErcXXZHP2CAqpo4F0Gg0FxpdYZW+
	Jt54vn9OlICjIiehQ2bqkAZO2x371QEB9Ba9YHv1G8Ibg57Zx5y/r7SShA696fHi
	sfg3Y6IsU+aFDJK/7YRQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjd0x84bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 11:53:50 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HBrnqD007996
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 11:53:49 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 04:53:47 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <bartosz.golaszewski@linaro.org>,
        <wt@penguintechs.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH] Revert "Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()"
Date: Wed, 17 Apr 2024 19:53:43 +0800
Message-ID: <1713354823-17826-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: CqdzUMynhIcWNgL60zL2pbUcXB3BOlQF
X-Proofpoint-ORIG-GUID: CqdzUMynhIcWNgL60zL2pbUcXB3BOlQF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_08,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 clxscore=1011 suspectscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170081

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

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
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

