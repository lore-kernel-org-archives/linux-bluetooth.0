Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8384F1E4
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 03:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713409932; cv=none; b=htlO2oKiWY6HWRfwhFvBDZiuPwwIwzXUPp+PjYJfcUAklWAAtO/3Fn3boRvhm2Xwh4rssbf56mawby1juAxNIGPCeaJZXZ6o26gkGWW2esxBSMZC/2veUPIpYEzvpcrgSQaB/X4+nhmissMzS63WJJkOPMngTJIWUvBYO5TwPVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713409932; c=relaxed/simple;
	bh=a0Dws8bCHWQDjut/dq6Un5iD5BkUvh71mEh3bVz34dE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jOqIuT5Jg/TyaM2KXidXdoQqyGMbUyQe8snPG2NwVVwvnMzdYF8/UtQoO21zBhLdL7BRZzHgfkNnIe5XG2TgXu+E5rKW/hDJir4MpR3LYAguiMkAY6cvcIK+1I5ByAam9WxGWIgzcqw3wYLdeQXF8K6TYOGoRwAOFpVi046Bw84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PhbC5r0c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PhbC5r0c"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43I1dwC0031435;
	Thu, 18 Apr 2024 03:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=xGf06k19GpmCskoVfaxh
	sQXJwVrhXkDkROvHSn0eFw4=; b=PhbC5r0ccUQ35vhEFsEMGTjzT+UdPAXi0KSa
	yAmSzzi3JOuZe/A2CZQqkKlqWobMBuOqAyQQYueYmlSfq5qzIrWFzaJSfh3T8duO
	6tFTwGxRDG4Ux3CYunc1VlEBQ30ICqoDUe/zCH4UVV61kznEnkQkI3vURGqeKpbM
	XBjzs5iR04zJNwDgabTw/psIePWfSJn1T4pNfXwd425MOM1oAZrh2izNgHQ0f0zz
	dQaPiVVycTmnQUlgeE/L+LScEkYuuEnQcGI+IG/2VHHvs7vGrujfFOcGgPC6m6yo
	Ey+8g0TpHAVMIHlhs91uJRn6VX2H54PDTnGATFa7KwkziyrJpw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjqcurn2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 03:12:06 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43I3C5MA003846
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 03:12:05 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 20:12:03 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH v3 2/4] Bluetooth: qca: Fix nullptr dereference for non-serdev devices
Date: Thu, 18 Apr 2024 11:11:51 +0800
Message-ID: <1713409913-13042-3-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713409913-13042-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713358336-29619-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713409913-13042-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: mor-LxtjF-NPuHxkRs3fmmbmaWY8Z-IK
X-Proofpoint-ORIG-GUID: mor-LxtjF-NPuHxkRs3fmmbmaWY8Z-IK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_02,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180021

hu->serdev is nullptr and will cause nullptr dereference if qca_setup()
is called by non-serdev device, fixed by nullptr checking before access.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index fdaf83d817af..c04b97332bca 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1905,10 +1905,11 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		qcadev = serdev_device_get_drvdata(hu->serdev);
-		if (qcadev->bdaddr_property_broken)
-			set_bit(HCI_QUIRK_BDADDR_PROPERTY_BROKEN, &hdev->quirks);
-
+		if (hu->serdev) {
+			qcadev = serdev_device_get_drvdata(hu->serdev);
+			if (qcadev->bdaddr_property_broken)
+				set_bit(HCI_QUIRK_BDADDR_PROPERTY_BROKEN, &hdev->quirks);
+		}
 		hci_set_aosp_capable(hdev);
 
 		ret = qca_read_soc_version(hdev, &ver, soc_type);
-- 
2.7.4

