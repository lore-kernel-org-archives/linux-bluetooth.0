Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2871F449EB2;
	Thu, 15 Oct 2026 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792056160; cv=none; b=e+danrODgvwgzYEMGByXP68/FlUY2D7j2j/W67df7iS/cunTMIrdXU1DpXgd3eOzoUOLAP/ZC/XHl4ZgV1ZKFqjNBaxFsylqS5U8Xc/zAbf+33iZw+5cvgbcePXRM1oC8RdBjjYwfGAEGykZ3BbpWoXsDSt/uwLf/ZjIiJdfXiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792056160; c=relaxed/simple;
	bh=oucbtbcr4iEIb+cMBggN+RvFK40jXdjFHJQUWMgXYGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pd/YJUFA41fzPukTbSjR+/nrFeswMxETqjyiO/Mryn/LjK4Kx50pw4OJ/A9oOwgJFKWhQRP8YbWbDCPsJ9qbAAP0GMOy6XgzBDWAiWh0Hecj7kj45mOLQ6ymNfKtwqxtDbhyvLJiA+kJgT4PxxbWRJuu6vl0ZjL5bWyFIG1AQBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cKz+1RaP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cKz+1RaP"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F6GWJO644589;
	Thu, 15 Oct 2026 09:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=PrU8BcvrJbzacnUrQ1KVIFlTydi9uIP4FJ9
	xA+uRW6Q=; b=cKz+1RaPCs1AQQmJWwvJ+p1Ma2E4EIQzsCFOjQrAFLtqMBn4Cb9
	iFPVpvoHFZq9z5SPVb1wSSzdgC1Ls8BSZucbkJsTOyNhm1aZn9T//Idmf5wTTvaA
	KdC+UJsXSnLntW//w7c86xuSiTu/wvl0F/gbztiGofzDf0gKtiwo0kml0QvB9L1u
	R/k8wKJvt/SNRmfn8pACciR9IHBPL7NHYdzDPRyUrsiPT3hedUWFvpJcTVW7USrJ
	CvGLACJmjF18QWOpw0kvWizLro+HITIHEgW4nwTcXElrtR00v05daGhrfSaZn4NV
	d0X6H7bqAJg5+pPuY1J1PbuOvjboKFKdHsQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hajmya8jj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 09:22:34 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9MWSm1443452;
	Thu, 15 Oct 2026 09:22:32 GMT
Received: from shuaz-gv.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 69F9MWTd1443442
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 09:22:32 +0000 (GMT)
Received: by shuaz-gv.ap.qualcomm.com (Postfix, from userid 4467449)
	id 63D45679; Thu, 15 Oct 2026 17:22:31 +0800 (CST)
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, chejiang@qti.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Subject: [PATCH] Bluetooth: hci_qca: Reopen port after power on for QCA2066
Date: Thu, 15 Oct 2026 17:22:24 +0800
Message-Id: <20261015092224.262158-1-shuai.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: 1DwFKj0_eoE9VK5Vyg4P5zezUsbc_n7C
X-Proofpoint-ORIG-GUID: 1DwFKj0_eoE9VK5Vyg4P5zezUsbc_n7C
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNyBTYWx0ZWRfXxTrdM8SVYrCa
 SDofGwRodX4uy0x4amt7hyThPewV0KXIMj11YQPIwWw/LfAYhZTxctSctThkNw4BrFHaLt4XEbv
 dnPfeR+lzjFn1RAqhLRt+pggZ62UrR4=
X-Authority-Analysis: v=2.4 cv=TbQDJhQh c=1 sm=1 tr=0 ts=6ad09b5a cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=yBvomlNPn9_oKlKuI4sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNyBTYWx0ZWRfXwnwl9V4qJaLB
 NRf5dm3pC6aVTty6eVPOfYU66/nLWn27M9xO6xTM8j40xZDyJ4VYNMwZtB/FLFY91tbbvn1xTbb
 LxTh+kUf2J7D42a/dS+FaH318Ys0Pv2bbBSPAVcdr0RYukSIlv52zdOfhE3ycxT7Eiww0Q0xNre
 y3QEV4sRMvRgmaNw34BoXKygV3ktTGwn+9ijqq62jyt/inq7yJtsgDO6ZbLB9rTlQs+XK357FuF
 Fn1Vt4vp9pUyyEm4IVqgAg4GH4Ho8kY/VaWH3TAqxI/AR4Dk40Uus/MM4Hx0YHuoP1voEOrAp/s
 OjKqh5uLom2LJSckD2TB1R7VfZ8UaVSteJrnUD1xBIzmYC3ED5q1PzusUcZP9acTr9nJkUAFjFE
 lzzQh8PHzJ/Jkm9dWRJJPAVA3LNemOqZX58nm810Si3vGrZlZPnyGhpi1RKR0/c2jsE035slG/K
 EkoKn5nfLIALFVOvkBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150037

QCA2066 requires the serial port to be reopened after the controller
is powered on, otherwise the host and the device run into RTS/CTS
synchronization issues. Call the existing qca_port_reopen() helper
for QCA_QCA2066 in the default power-on path, leaving the behaviour
for other default-path controllers unchanged.

Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 7089e9b63..c24f4e6c9 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1873,6 +1873,12 @@ static int qca_power_on(struct hci_dev *hdev)
 			gpiod_set_value_cansleep(qcadev->bt_en, 1);
 			/* Controller needs time to bootup. */
 			msleep(150);
+
+			if (soc_type == QCA_QCA2066) {
+				ret = qca_port_reopen(hu);
+				if (ret)
+					break;
+			}
 		}
 	}
 
-- 
2.34.1

