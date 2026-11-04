Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785840;
	b=vmB8QyJiWbp9Szej03wOjtRQ6lAsiwS6/CzTUl/xumj+BcL50pVF7nqszIGLAn+D9ary
	 jU95PPNL54iwbuQRjlTNK/lONnFpgSlM/CleWvPC3SWuSGo85hG/K0bFnFwo+xzVUaOjX
	 jzrrjyNuXg6EsTET0vzXWd70Vn/4V4MWDxqti5ACokIhnsYQLaZok5+LfCuZNVXFDrttY
	 z4PkSUrnkhhNq4DzzUKtgFEUBp8ifmwP9OECR3kb0iDO/zncDZT87xJypgtrBZbxe42ah
	 4N7S94fjIZN+QWsLn9zq1S1WxbUlVa5EXzgTfxRPSTyI3o5soCIZkdHbz2VnN/Z1liA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785840;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=2WqyN61e0h3rhP7eUH1YLO5Fbcnfgh/28o3d/pTv+tQ=;
	b=a7yj7MRXQrtl63qpQrori6g+LNLC5VpFiWRtws+LRWI7LMBZIXAnkFM+x0RKam48PF0i
	 4L+V4CtvKUGqGzLfCW6hkYUgOhKyps+5vMLJH3sH4hwS0yjYORrFMpaAyQp9E+wem0lUd
	 sHl2qxFOOURDUd/Zl7VrkbTMfWz+r7PoxIgjOf/kS/efyPU711TLrQGv76dJF+QGsZJCZ
	 7ZyWpc+TEE1ejcSRCz31MXSzrIBQUExzO98sAPRO+rZBURzfe9J7emZV4/n7f2ZYxTsc/
	 SjE1fqGOte3FDIfpqsZrgXPHzrNjxhVzYlqizjmotsng1m376qL6yFGNM7V8fmVKDrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SUjNUPRf;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8954B606A326;
	Wed,  4 Nov 2026 09:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8954B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SUjNUPRf
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48Ktm3715369;
	Wed, 4 Nov 2026 09:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=2WqyN61e0h3rhP7eUH1YLO5Fbcnfgh/28o3
	d/pTv+tQ=; b=SUjNUPRfNVnf3ow9ISmJZKlfALSbGWRnAkL1WsqOO3TATzg6ays
	0XjRoiExo3D+sRZ6n/SwrmeyXUfq5y2gS3cDG6GkAXcOWXl4SuKXu94VRxcXvvtA
	ugdaVGXmhzsijgVQQ7h9NDoHxHYIAWxR6Yf2JwI38YUePP04AGsNyS1X5PsafMJg
	hG70F6OcSdLuyY2iogwwRNr4ibhCCmFk4/C4XlNfx7ULQj/jcTOzlKODrvg9mEQO
	lYpgjXXTsWqJdSU4/U5uFNDbV9HCBIOljC+O6MMV7+WFHDgn5cYX4izB48hKS0Qu
	9C/SIsRGwLauH9d92GQAbzGLEbBsHnFq6Tg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqn8y34a8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 09:50:34 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A49oW1W2779018;
	Wed, 4 Nov 2026 09:50:32 GMT
Received: from shuaz-gv.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6A49oVwR2779009
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 09:50:31 +0000 (GMT)
Received: by shuaz-gv.ap.qualcomm.com (Postfix, from userid 4467449)
	id C1AF4693; Wed,  4 Nov 2026 17:50:30 +0800 (CST)
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Subject: [PATCH] Bluetooth: hci_qca: WCN3988: Drop baudrate change vendor event
Date: Wed,  4 Nov 2026 17:50:26 +0800
Message-Id: <20261104095026.3414666-1-shuai.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: eigcZJOtxqXZztVLskJu6sJxQG0FYcNg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzOSBTYWx0ZWRfX1yrag7wsF1jT
 CXQtByrbG3ozc1adaszT3qvQH3S5LqMz0+kAPLQyRU0Byoxg0dMWHRUC51U4bAJeruUVp/joVUH
 guDcugYSJAi+03vhW0pvtpk/YoDXoN46r6+wG64ak93MQvDkASYsE081VHdiRvxBrlzNUOsZ1Xy
 Z6BJSpOVHFq2cjLVMJNAf/PjyvqrtxUSTpGFSPtcsFEz+1j0NY9ATKb19rgtOmRUCQ8vUrXVFXd
 eQhuKh8uvtFb27InfhDpEts2QjH7hTc2hp6F+qybZaMyy5ONOw32MOdR+U0emTBeeNgWvpCGfFT
 B0vxZ3OC1Lm8+lmSiv8HkYLh/9kH9wX1b3I4EtYgOlYIiULnAV9GBoIetq7+Rz9AEsx8azWBxfA
 Va5LrO0NP5KQNguldX7Tl2+srS/1QOGXfzoy40+JUQk/oKwaaivPwpsJJpuCubKya3Ci7c43qDi
 HYarp16GzpUeey+xPWg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzOSBTYWx0ZWRfX5dOFHKn0Ce6D
 XnC8H9KJ1JqKaWdu9F4y+DxbuSkfNBsx8Laln6314yipXG7/XnHkQ9M1CEOPWDjNbJbGtzlnlO8
 qomQXoVaLdYwv9nI/J1UPSSapyXGh5I=
X-Proofpoint-ORIG-GUID: eigcZJOtxqXZztVLskJu6sJxQG0FYcNg
X-Authority-Analysis: v=2.4 cv=NP5AaE6g c=1 sm=1 tr=0 ts=6aeaffea cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=QDeELHPiMCJVZ61WT1IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040039

Firmware download on the WCN3988 sometimes fails and is retried:

  Bluetooth: hci0: QCA TLV response size mismatch
  Bluetooth: hci0: QCA Failed to request file: qca/apbtfw11.tlv (-84)

The vendor event answering the baudrate change command can arrive late
and is then taken as the response of the last firmware segment, which
waits for any vendor event. Its length is 2 instead of the expected 3:

  < HCI Command: Vendor (0x3f|0x0000) plen 220    (last segment)
  > HCI Event: Vendor (0xff) plen 2
          92 01

Drop and wait for this event on the WCN3988.

Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 7089e9b63..4d502ee82 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1521,6 +1521,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		}
 
 		switch (soc_type) {
+		case QCA_WCN3988:
 		case QCA_WCN3990:
 			reinit_completion(&qca->drop_ev_comp);
 			set_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
@@ -1556,6 +1557,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		}
 
 		switch (soc_type) {
+		case QCA_WCN3988:
 		case QCA_WCN3990:
 			/* Wait for the controller to send the vendor event
 			 * for the baudrate change command.
-- 
2.34.1

