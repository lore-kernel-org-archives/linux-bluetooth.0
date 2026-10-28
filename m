Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186329;
	b=xVFv+ubyNIXAfkYj/sbtx9rDj+fnevvXR4vR0amWuT2t4rlE1rHB2bBK7lS8UZkNRcA/
	 LoRL6MID6XlXcPa+ADeBiHYvizSRMAxqTcpFg5g8aQVp80awcU/eJsIEFKpnbxmTvztvV
	 qkj/+twEDNyIxfoY7wFtSgQ47aQNUjRwl0/f300WbLe97zfI1J9wo/vfn8vI7XaTmsyBp
	 YUak65KSLuj1Xb5ucO/Cor8kKwPkEaU+9mkNxQSe/ho+xNzPjTdYuUnhdPqYJOCa+iwg2
	 mEAxdXkUIAaST9J6TPLomV+tIvpdfA4ovIJEVh10Yp6hUvB93knK0vN8ePO0X3IM98g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186329;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=OqesCeyuvsscOD2VhSsoXL/Y+JLWXaWviIfe9VOpBKI=;
	b=xlxf0h6u1h0Gc2hMSuepwWEKFeYG3kj/8silvBxb3JrgYF3/qyVK05HqV8BmleT+PBaZ
	 +ARU/nDsiv6XkZD13J8Z1lSTFQtvSzA838DKGuH9G06eZYoKa3/NWgCkXZigSlIhKD9Ly
	 wp7TKHaz112ZSqJwwGwqoM3QwZpJEpWfpLYGz/wbEKjlK6k5omg6/KsgsOS5iaSIWyA/7
	 lAoYiB6K/c359QRRiqJoqeGEXghM+xHD3moUiy56PCSmJj+odgLs5YZUqMulPSG6FVfWh
	 krpFAkWaScGzpWnCdRBk7cYfcIZ8pcMOvdEm95lqXDUFp7GeQKOGVyrsEYLyjjrLDzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Ks4WG/bM";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F469606A31A;
	Wed, 28 Oct 2026 11:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F469606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ks4WG/bM
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8KB0t1642970;
	Wed, 28 Oct 2026 11:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=OqesCeyuvss
	cOD2VhSsoXL/Y+JLWXaWviIfe9VOpBKI=; b=Ks4WG/bMLs/AYcVBSI+VyvbVvn9
	w2TfJLQtOVS22AH4ofoGMZhW+QAjti2i0tyoLaoJCnbk8W4AnplzQQ9bbplO6Jx7
	NRYjh/JDx1VfAqVPyXEzlIfx83vItY33WBVF8c90T8ySvV0ItqdfRNIT2nY/hT8+
	Z3zJt96V6cOFK2cXWQfdarWsaaUA1sCrC3Ap/BKmkIiP9nzduawp9YK3e/mBBUKn
	UbzYp82lx5dR65EnU/wPbv1jb70cR4tLcDs0YLaISvvnXI383NyrjI4NPSZumcrF
	oFn+94cX/QNpoNeV5pZJpanAJBBno0aE2nqGdLHjC7qeW+GTW6EiDJ53EYQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjyjpuqjf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 11:18:43 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBFbPg3250129;
	Wed, 28 Oct 2026 11:18:42 GMT
Received: from shuaz-gv.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 69SBIfhM3253937
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 11:18:41 +0000 (GMT)
Received: by shuaz-gv.ap.qualcomm.com (Postfix, from userid 4467449)
	id B83A8640; Wed, 28 Oct 2026 19:18:40 +0800 (CST)
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, chejiang@qti.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Subject: [PATCH v3 1/2] Bluetooth: hci_qca: Reopen port after power on for QCA2066
Date: Wed, 28 Oct 2026 19:18:38 +0800
Message-Id: <20261028111839.2148515-2-shuai.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028111839.2148515-1-shuai.zhang@oss.qualcomm.com>
References: <20261028111839.2148515-1-shuai.zhang@oss.qualcomm.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0NCBTYWx0ZWRfX4pgICbjWH/ZX
 ED6ZBu0O8JKmpV8NlXrk0VVD3Nq3emPvCbR2Gi28Td0Op7UkQakMmqkOEHPZ2xN4vvTD9E0GCHH
 1FuPMbdpnPKY5ZTbm3CkAatLehGAn63DAAUvq7G350PvYbk4AySvYqZrTF+CBAEFru2ZDcu0zy4
 5sB9BnaEfuFtEarjc4I7vBjZSEttmSsITyePtcfTqpNGbJ2gKA3bSHK8iAjXG4E9dyYjqbcBN8Y
 Ymxoyq8rb0l3rt03mLYJQ0VMFUuhN/oFMDAB4/9w4D9qKOOqf4NujDvrtvp23IJt7Z2a2XN03KV
 lZObHeLlbR+eTsipU7G+6a1SoWqc//hjEjwQ9qHD8ur0d/fgmKAm1MOKV2qoYMd/DXQE58hthCd
 6Xx6O0PYwbHs6j1pWeFQ5d3EGp3wJXipw0hUjlt69Xnwi5OWHlSz8Tu5H8xj7GeoVm1y3IzIUo2
 xf2r2zAMCVPzCg5SshQ==
X-Proofpoint-ORIG-GUID: t-lcJ56SRBUB1T5sCgQ-nQzoQmhHw58b
X-Proofpoint-GUID: t-lcJ56SRBUB1T5sCgQ-nQzoQmhHw58b
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0NCBTYWx0ZWRfX2uRnTlO98xpZ
 YkVNlBYyklqHCQYmPERWJXSavLDyXbGpKDbTkEVywsMMcu4hX3YJTZsfq7NOkYr5tROf/IkhckW
 bz3vmuyiEksVk332LzTJHArk2sFte3Q=
X-Authority-Analysis: v=2.4 cv=JodkP84C c=1 sm=1 tr=0 ts=6ae1da14 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=y3j_BG3VSwJ5xvWuhoIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280044

QCA2066 needs the serial port reopened after the controller is powered
on, otherwise the host and the controller run into RTS/CTS
synchronization issues.

Reopen the port in qca_power_on() for QCA2066, once the controller has
been powered on.

Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 7089e9b63..ee3ccb59e 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1867,6 +1867,19 @@ static int qca_power_on(struct hci_dev *hdev)
 		ret = qca_regulator_init(hu);
 		break;
 
+	case QCA_QCA2066:
+		qcadev = serdev_device_get_drvdata(hu->serdev);
+		if (qcadev->bt_en) {
+			gpiod_set_value_cansleep(qcadev->bt_en, 0);
+			msleep(50);
+			gpiod_set_value_cansleep(qcadev->bt_en, 1);
+			/* Controller needs time to bootup. */
+			msleep(50);
+		}
+
+		ret = qca_port_reopen(hu);
+		break;
+
 	default:
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 		if (qcadev->bt_en) {
-- 
2.34.1

