Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7862617F7
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340188; cv=none; b=hqvRqMLhakp0vqZ+PZczfi3ZSB+hqkW1VH6Q92b+cpFEQ9TLyfYLBm/chnKz9G9qurGlbq/q0skij8aTUkWoOyScIz2vP6bZy7FfpYNJQlaOPO6TkJCDJN3QmvocxuOESD0pI2SCh3MIb69bRYc4lw8CkD3mDI3tjAZ29e1jJ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340188; c=relaxed/simple;
	bh=Z/B/n4Mr69KRvMQejwVMwe5vhhTE/L1+SUp151nfCkw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZFkLHev6ItZDRyyrnHxCz+Z0e6EPPXBMWIkKUZVbr27l2lQjYMXanOIGvp8guHzAw7+jrM/NLi3sDWZwelTEZjOomXy0kAKfVQIj1rY1qYXLCWUuLKjj2R6iAKYGaidHioOmRZJnfWLHbR9ssZtunlrb6MYlDI1kRwV6xPu16ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hBPeSVv6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hBPeSVv6"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H4GUlb024492;
	Wed, 17 Apr 2024 07:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=6lJAwLYw5KTyAZp5Ox0Lj/3z5h1/l4Tfli2zRWKmm44=; b=hB
	PeSVv6dKZfGSr9OdahiLPljVPF4B1HLr63PFR/WMOFB5uj9YoIHYckhb4JsX81PS
	emCTOnUpSEgUfPODhUhzi704i7MDpfuMDey4WPLpUEOkT5XFXYSCQLCbYjdh09BZ
	Y4FWveiw7H8Acpi0TAlU1spe/cGTa5r26p+rUjT69Z23kMfyyqaT5NtF0TXi1QWF
	QcDTm7DoEMQgnM3SpJrVn3R+bNF8ZIOot/x4Dgw5KKl2xculLW2fM6Q2vv2xsdwc
	M/om4W5pEzTZPUxJ0YvQ4VHrRDeM4Fs67BtQ00f1rz+Q+Zhn+yLgTpkOepxdNciR
	MTe9u0R395OPQJYHEkZg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj78h8ea7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 07:49:42 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43H7nf4C015987
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 07:49:41 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 00:49:39 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH] Bluetooth: qca: Support downloading board id specific NVM for WCN7850
Date: Wed, 17 Apr 2024 15:49:34 +0800
Message-ID: <1713340174-1304-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: tER-S5fl4Msb4xYFNlUFNaSO0OsYs3dT
X-Proofpoint-ORIG-GUID: tER-S5fl4Msb4xYFNlUFNaSO0OsYs3dT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_06,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170053

Download board id specific NVM instead of default for WCN7850 if board id
is available.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/btqca.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 19cfc342fc7b..3ff1d3f99d7b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -629,6 +629,19 @@ static void qca_generate_hsp_nvm_name(char *fwname, size_t max_size,
 		snprintf(fwname, max_size, "qca/hpnv%02x%s.%x", rom_ver, variant, bid);
 }
 
+static inline void qca_get_nvm_name_generic(struct qca_fw_config *cfg,
+					    const char *stem, u8 rom_ver, u16 bid)
+{
+	if (bid == 0x0)
+		snprintf(cfg->fwname, sizeof(cfg->fwname), "qca/%snv%02x.bin", stem, rom_ver);
+	else if (bid & 0xff00)
+		snprintf(cfg->fwname, sizeof(cfg->fwname),
+			 "qca/%snv%02x.b%x", stem, rom_ver, bid);
+	else
+		snprintf(cfg->fwname, sizeof(cfg->fwname),
+			 "qca/%snv%02x.b%02x", stem, rom_ver, bid);
+}
+
 int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		   enum qca_btsoc_type soc_type, struct qca_btsoc_version ver,
 		   const char *firmware_name)
@@ -709,7 +722,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	/* Give the controller some time to get ready to receive the NVM */
 	msleep(10);
 
-	if (soc_type == QCA_QCA2066)
+	if (soc_type == QCA_QCA2066 || soc_type == QCA_WCN7850)
 		qca_read_fw_board_id(hdev, &boardid);
 
 	/* Download NVM configuration */
@@ -751,8 +764,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 				 "qca/hpnv%02x.bin", rom_ver);
 			break;
 		case QCA_WCN7850:
-			snprintf(config.fwname, sizeof(config.fwname),
-				 "qca/hmtnv%02x.bin", rom_ver);
+			qca_get_nvm_name_generic(&config, "hmt", rom_ver, boardid);
 			break;
 
 		default:
-- 
2.7.4

