Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB3D23EAB3;
	Thu, 19 Mar 2026 03:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889855; cv=none; b=YIskIQ7mKbqcDz8A2AKm3/Nbxo7B/dL2wZD8Qp4FADSRbsHmsdo+C9Ap6xmmXhWPwNp1QH5CtvHWSl4vbG4IvXeFlymgVoKh9jRqA6dReVfdJgIT46ZM8woGdrhIhUwmS8fMwG8YWYE6VRzvFuYVXDbVt83/fY/GYLNOycZwCoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889855; c=relaxed/simple;
	bh=jCC5wk0iMnAN3uCmwGNFer20NRw+dQyOXw7HdKK+/C8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pc9IAR2EfP/zBGauWXLppzapocNMqLHUM57FtHQjZoFreLyQ3PW7BNxQM0ZnMO6mLcJbQi358Ric9olEa1qy+NR28ZLmpy83SVZWqtonlXnMuLefC/+aF7ke5vDw2KCfbTiwX4CDZpACDrYfnZ+Y8vi+eRv5RbUzoWSuUg+E6Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZCJzxVR8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZCJzxVR8"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J0THiU3770351;
	Thu, 19 Mar 2026 03:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=S/V+2yG4X7zX/UI/C1LDwBaZa3SliwkxIdX
	SH/sO+8A=; b=ZCJzxVR8Xg0l6aKlSmkKJi/Lw0gKrh6vyXLOSZTE1RMIqwP5qJv
	Gi0m/ZpJ1mTSwt3reVAO1P985Gw9kKfNpNWot6OdWuNyK0sh0Q8VnoGBTrNusHlI
	trHX4SbGy4HqaeEQ8vYQ7VlrGpURXPeIgObjiGiJjyY3bDEAdYn6HJ1xpnS9MduO
	xmcM8RatsAa9R800ofqUohAmMUO9MRk2GVC9QoZk7RaeFQvfBro139lVdd1qp7Ap
	aVC6+NbZ79QHbhxF+JkOfEKReg+e3e27XCS/mBEI9BPHfzvTVFLEboY5Kyw39FIr
	GgvlWMK/om9Daog5nffnz7xxxryEL5+RJoA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyqcdv0rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 03:10:49 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 62J3AkBf028591;
	Thu, 19 Mar 2026 03:10:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4cw0rmne1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 03:10:46 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62J3Ak0j028584;
	Thu, 19 Mar 2026 03:10:46 GMT
Received: from shuaz-gv.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 62J3AkEV028580
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 03:10:46 +0000
Received: by shuaz-gv.ap.qualcomm.com (Postfix, from userid 4467449)
	id 488635DA; Thu, 19 Mar 2026 11:10:45 +0800 (CST)
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com
Subject: [PATCH v1] Bluetooth: hci_qca: disable power control for WCN7850 when bt_en is not defined
Date: Thu, 19 Mar 2026 11:10:40 +0800
Message-Id: <20260319031040.4096297-1-shuai.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDAyMiBTYWx0ZWRfXyEopFB4Ba7XC
 voJCKgxQAFAKMessuCQ+sVFz+V9imXvpcLlPaVghoortzay1ouik1xuNDnhhvpR+cN6joM2TjGr
 kMaxTbHx0kP2S5at+/zm5AAWiEDb5K7YZTZu3C8iMjniMJIaiVqhwSWiWvaXPbL9r3mCOFI506P
 9wDzmL0ObfDW2V2gzDMvuNmwIEYTSXfu3Fb7z1hhB3PMXgjBOsIILqLo6rLkOTgpbx49BmmadJ7
 XEDz9r5xRiRPNDQsICHEKKNdQKAy7Tq4JarDlZXOBnkjhPXkaVWH3gLOxNMH5HKhkHxYj8VR4rE
 5MMQCGDoqMFEw0qSfPiohvvNxnB8a+htwQk9WVefoBUDSx9q9ppDP/Ymhgj67g4EBGUmBgbbg7p
 p627tyQ/WwH3qimblaCrDl/pV8PJjaj5zHBe/05aRcEw7ik2jrtTANUCeIDZaI88StjAeCbQPOr
 1u/BO2QOiC1MgJgKQCg==
X-Proofpoint-ORIG-GUID: Gw0ekxETiTJciP6vOztOhdzWMtQzMKiL
X-Authority-Analysis: v=2.4 cv=H87WAuYi c=1 sm=1 tr=0 ts=69bb6939 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=CGWSjVmAmlQGx693OYsA:9
X-Proofpoint-GUID: Gw0ekxETiTJciP6vOztOhdzWMtQzMKiL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_02,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190022

For platforms where the bt_en GPIO is not defined, software-based power
control should be disabled when power is managed by hardware.

Add QCA_WCN7850 to the existing condition so that power_ctrl_enabled is
cleared when bt_en is absent, aligning its behavior with WCN6750 and
WCN6855.

Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index c17a462aef55..4512ff7cd0c0 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2484,7 +2484,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		if (!qcadev->bt_en &&
 		    (data->soc_type == QCA_WCN6750 ||
-		     data->soc_type == QCA_WCN6855))
+		     data->soc_type == QCA_WCN6855 ||
+		     data->soc_type == QCA_WCN7850))
 			power_ctrl_enabled = false;
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
-- 
2.34.1

