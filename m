Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BE47FBDA
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 21:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713563369; cv=none; b=HO4D2Kx6jtlB3QeeXCG6/PTUfuLrLMS3M7EoirT+5g8zqnktIJHjNKxXYQ4ucqD2Pc8a0zyRWWTd5b+vGOQ3pAIA/ahmIf3kjEMxVjo7T/FzdYx6qFvUNW2y7mOQgHaeohIw3i/aV+P/oVToVIxP1I09Wn9oYryk6Cu4nj6OkLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713563369; c=relaxed/simple;
	bh=rH+hoiAXiCkAbgpbk6f3xoECq+Yo3AxyfrRZQBHnwcc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2AFi68rEBv4PFbw1q8XkpMk1gL3IgKp0JnHPCmG2UwVix9q60xQDuV58/fqn6d/rxVBIUgbqj5Yf1kxxjHi4afK8X4nkPalZxrvn9I8WJ1ZoEVj3gtHJNuCT3JPNP/u43IqT3I9l5DmpVitn12Pi+B5L29zNcs3l3HkKD7ixlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WiSpdnI3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WiSpdnI3"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JLNiam029875;
	Fri, 19 Apr 2024 21:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=xISrgYG8Ihq3FmODEIfr
	fFtbHSfaIGZh22WWLCosrzg=; b=WiSpdnI3UDCNXxZ9ek3yN+v5OFWZNVIkhDDF
	WOZtw/8HH+k1QqrHmD/yyvuZhQdBEvZYbGBczLza5rJEt1tsHfoE9coz/f+dwqsO
	Txwu0WUbdfeWTV93n9y9E0FPoWbqvPx6U1+WbJCFz/PBqiI5mGB4A7YkAI0vVO7F
	Wng0aP5De0ti+2J9qFr8B3O+RJrNe53ty4cCtSQIfciSCVYBXHhgLj++LuFDSnvT
	8+N5Ln+bKEcxBRM6aTroEp052w+ekR4lyzgSZGLTaO432gHG6iBAl5vXfEFNYHk4
	uZs++9Yp5DgHKYUbxSh5EQ2pvXf4RxBhgwC4itPQvGuyFFzVNg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xksuvrwxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 21:49:20 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43JLmx0n031354
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 21:48:59 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 19 Apr 2024 14:48:58 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>,
        <bartosz.golaszewski@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <wt@penguintechs.org>
Subject: [PATCH v2 2/2] Bluetooth: qca: Fix BT enable failure for QCA_QCA6390
Date: Sat, 20 Apr 2024 05:48:47 +0800
Message-ID: <1713563327-19694-3-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713563327-19694-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713563327-19694-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: Jg0BiRJfpf9hHcvbQH8yWnkvKNzsqozv
X-Proofpoint-ORIG-GUID: Jg0BiRJfpf9hHcvbQH8yWnkvKNzsqozv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_15,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404190170

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

