Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F943E5EE3;
	Tue,  9 Jun 2026 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991686; cv=none; b=ksPGWpQDfUkrz8M8Gr0w1HvRe3bNS3TWf8fVPFH7KMBqD9ZXsptqTUNO7byuc2CrS3aJSPng2WQUS/7mGsNmFt5h79Krd4b/j5ISLWUgnAIEat5VfOlsiWxQ7gdrwkk0zOqhEBA5bKYZ3wDMeOrCWgBRY3MiqgXsNy+w0IsB5T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991686; c=relaxed/simple;
	bh=ybvm4urhyGTL6NSM/gH0tiTXZ8kS7M+YaoVj3GzfOFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ECgefTX+5KWQIOdOUcXQC5vRgWovcpT2OnSfs2YJUmT1JKNDmcBSTtmAKZY+QxMlQPor7y487uQhGRUYgfIYcUTBR4FSh1j8kImofZmyrCjBwWfyWzls/m/rVdGMS0aRfrk4cCt3B5ZS6Bjl3PKu2pQW5Ly4igR3LsC7A5HSHqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iMM+4xuE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iMM+4xuE"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597rO281517656;
	Tue, 9 Jun 2026 07:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=En520fOlylSIcgowAH1IrOQcqJENUN0Ecls
	GJYCBhZE=; b=iMM+4xuEv3GO7mav43pdu9ANuMDKHvkzfCPQJAjuamXe/tj/LFM
	dyH6eK+GF/1hHosJiiUtk5QHxeVYM/qTaV/nUkc5bHfubYxR0Do2IFDS0k+NY576
	/zkQHhIsOinSN19MRtOKZACW/VUi7QdRNNtoYguY1R0fy5rWnRbcB7AbYs28hMqt
	/tZKK/w/rr85FtF1D/x/zwnGBIA6EfENvP6Y6Uk8HoeUjE0GCXq3/A7RNTWgeFxW
	/mAUYVawj/7vYpn+6TcVO5J0i3vvx6WdyB3mTcddqGGc5lwQrmJZQS+tUUeja2ux
	GKGtJuDDMwDJ4m8dTxtlJ+XVMJmIV13OWIA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epenr81p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 07:54:40 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 6597sbqB027894;
	Tue, 9 Jun 2026 07:54:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4emcmjcy6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 07:54:37 +0000 (GMT)
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6597sbT8027888;
	Tue, 9 Jun 2026 07:54:37 GMT
Received: from bt-iot-sh03-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6597sbXN027885
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 07:54:37 +0000 (GMT)
Received: by bt-iot-sh03-lnx.qualcomm.com (Postfix, from userid 2385805)
	id 79ECB42FF4; Tue,  9 Jun 2026 15:54:36 +0800 (CST)
From: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1] Bluetooth: qca: Add BT FW build version log
Date: Tue,  9 Jun 2026 15:54:17 +0800
Message-ID: <20260609075417.1160702-1-xiuzhuo.shang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: jTDfDDtkljO-xPEREgNBJoE5_k1d4THv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3NCBTYWx0ZWRfX6N73eLuFbvx/
 nreufegzpBRfVav08negf8jOnML3mnXfQbyRZso9DTczoQLLuLeoUfDPLYcUthqh2PG8q5uvmSC
 pHqJatSW0uV0GV0tDHytOh3SO+CmT9d2Fj2ZBBuB9A/LRynF1dI4q2meNFY9QcuVSCHoN67KRxV
 JchHcZyzrJbD48Kl/uYFGG8N1NeSVIwSB71mDyKOlr/TnEJ3koIGcDSTep15a4SyM+ri7C5faN9
 tSFOTVUoz41t2GPrPhmxOis5KPrL3qtTgBOsCjMNIsVDMnSE48/Mnh5FPz1KhUiD7g1sqfyWEOc
 eAc8g93CRDvn2SYio1q3LZjv6e3GdCB5VDcJ3y8pTss2bMOdImoqT6KjHvflFGlDaKkukCU7K7v
 HW+zvz9OuzQwXL8Ms6YvHy+TlG7I7cMMDYBIggvJ/3w8uT23ejgKodt976nlGCyVmjjIsyvxxX4
 6pmeJ9Vt6qWecLKnHvg==
X-Authority-Analysis: v=2.4 cv=NKPlPU6g c=1 sm=1 tr=0 ts=6a27c6c0 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=04T4pHoN_kJIhFNsTqkA:9
X-Proofpoint-ORIG-GUID: jTDfDDtkljO-xPEREgNBJoE5_k1d4THv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090074

Printf BT FW build version log after BT FW downloaded.

Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index dda76365726f..04ebe290bc78 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -143,6 +143,8 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
 
 	hci_set_fw_info(hdev, "%s", build_label);
 
+	bt_dev_info(hdev, "QCA FW build version: %s", build_label);
+
 	kfree(build_label);
 out:
 	kfree_skb(skb);
-- 
2.43.0

