Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2F317A2EF
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466510; cv=none; b=WQlehfBLfjJ2q+WPqtHV8HXWRqP2daJd8VkXI3LzG0w8/d8o8iPovaS/Rk/ntJ2r+ocGM1jYuYOdpOx9/e9AGisZT5X6mefXh+9nMw+MhS29yqyGPFwLpG5E/3tYO08WKqmVu6gCvuOGX1JUup7JQM9CYdwdoN5pqa02FLbOoUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466510; c=relaxed/simple;
	bh=Is6jgqGlnVbEu9KMHJ6jRXrIhdh2rdpl8OvmCKnAy/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aJ3PzDx/cEPg7fS+E5OrXuIyh96Q+1yQccUmZ+aCCAYRLTwt6CbuSPvxYELe6S+cv7ZOQT6Ggujrq1fvl74IAxioTM7CITFHEqM63zhaKcQKEc+MPaICHPRR3qqhAzlVBFnVtfMiHIVQbELOFZ/JU2l3ZFH2rGgNBaCl6VqFYi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q7tGno+c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q7tGno+c"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55935BR7020195
	for <linux-bluetooth@vger.kernel.org>; Mon, 9 Jun 2025 10:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ZGPz6Mgb1Cgl1GuHklcbylQWtyfEHk3fSU/
	0+8/ElgA=; b=Q7tGno+c/RdqJFo8xs19KlZRFaXUJvNUSg264r5lYfln4xd3gLG
	0X3B1uO6Z6JcIBGfevi2k4hUkQOzgsTmyE15ADRpZv4n/hnsGzJ986/nKBvtO4F0
	w/Nm3kDJb2KM8q+2qxyZrja7zeKjOv9G6Why0Kr7j0m2yM+KwVi5j+G6HmGrCbOj
	KCFKvFlbmTwEyoWqa8zJet/iC6eWkUzUn7KCgou6TQjCB6AsgkvHE5AH0t2dbvbB
	1PgJWP9AIVJKyqswF+vHyD5/vDuIcwDInADH52inZk3xqAbBF6JAGMHmUKQZAQjX
	mLAix0Jku8KJ8WXWoXN1mIUIo27wApnIkkA==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 475qcts690-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jun 2025 10:55:07 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 559At4GK013081
	for <linux-bluetooth@vger.kernel.org>; Mon, 9 Jun 2025 10:55:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 474egksaeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jun 2025 10:55:04 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 559At4g8013078
	for <linux-bluetooth@vger.kernel.org>; Mon, 9 Jun 2025 10:55:04 GMT
Received: from bt-iot-sh01-lnx.qualcomm.com ([10.253.136.182])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 559At4bl013071
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jun 2025 10:55:04 +0000
Received: by bt-iot-sh01-lnx.qualcomm.com (Postfix, from userid 4467449)
	id 6EDE5529; Mon,  9 Jun 2025 18:55:03 +0800 (CST)
From: Shuai Zhang <quic_shuaz@quicinc.com>
To: linux-bluetooth@vger.kernel.org
Cc: quic_bt@quicinc.com, Shuai Zhang <quic_shuaz@quicinc.com>
Subject: [PATCH v1] driver: bluetooth: hci_qca:fix unable to load the BT driver
Date: Mon,  9 Jun 2025 18:55:00 +0800
Message-Id: <20250609105500.4083963-1-quic_shuaz@quicinc.com>
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
X-Proofpoint-GUID: 57OVhq3FHjspoWStye489msF_vGBX7bk
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=6846bd8b cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=yfn8_VlG4_yacJM8_nIA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MyBTYWx0ZWRfX57UeJgdEUXUS
 /kK26A2MVMJ6y75E7jrJT7jcWCqpLkNEzK0ErXOqkNLql6JHpl+QdUDW66kfwdMUecgpVlcKVEv
 ZhXwo6V0qYSW7qp8TfM5OFhCNs2s2Xc+UlneEyUGq87tWT+NjEYr+6Jk6+qQcZvHRjQ/DaVKOMr
 x2mBB2yXxSHL3Xmim2ZKg23vf18+URaerXmF5LsMis3ux6tq0T/mg84jzOOjGZF2k51eA4q65zq
 pSQeJIEjRLC6QGtGybrVadpC86R9NeCJBz/8RbY04fbr7LFRyGx9VcFVfzmAa7s7LMdK/APf+Bd
 GIkFQzqm0It8PXvq5uap8IO1MsoLVXC57slNnkk+s+tLH/Kh+Zsp7QF1Utz6oaytyiCpfJxOH+p
 aLH+QQTEXiefdSFdHz87SsTNOV44Yhn4vV8lM4WI1Vma2vgVBT1Kf55ysNEmd4n8eA1O3f/7
X-Proofpoint-ORIG-GUID: 57OVhq3FHjspoWStye489msF_vGBX7bk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=902 mlxscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506090083

Some modules have BT_EN enabled via a hardware pull-up,
meaning it is not defined in the DTS and is not controlled
through the power sequence. In such cases, fall through
to follow the legacy flow.

Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index a2dc39c00..976ec88a0 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2392,10 +2392,17 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			 */
 			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
 								   "bluetooth");
-			if (IS_ERR(qcadev->bt_power->pwrseq))
-				return PTR_ERR(qcadev->bt_power->pwrseq);
 
-			break;
+			/*
+			 * Some modules have BT_EN enabled via a hardware pull-up,
+			 * meaning it is not defined in the DTS and is not controlled
+			 * through the power sequence. In such cases, fall through
+			 * to follow the legacy flow.
+			 */
+			if (IS_ERR(qcadev->bt_power->pwrseq))
+				qcadev->bt_power->pwrseq = NULL;
+			else
+				break;
 		}
 		fallthrough;
 	case QCA_WCN3950:
-- 
2.34.1

