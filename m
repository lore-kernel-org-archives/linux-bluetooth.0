Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEA31E9063;
	Thu, 14 Nov 2024 06:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731565651; cv=none; b=pVOpY1duG1f6lavm1e9msN39aa9pZ3gdwCKeLGpzJ8QpnTcaS1mxqqamt/D3n+1/4vG3U7LfVPm5KEVjJAXbVmCPXqr1N8UFVO983Bu+zC84KhQQLLp0wgDPbcXYWN1gbWocYqfImyFYy7kPcEk2gyM2XG9C6JVhBAPSf/grj7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731565651; c=relaxed/simple;
	bh=titiC/Z2EXdelJ+pdZR6PcDy6zwBEVZQUNi6Cz7wvYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=ozGbs4s/gXWisxMNBVMSOkgcMUNCGjWoUO6I2KmP0hH19q54P3cJylCLqTbv07rJqcY779piWB79iRVQvLTddZCeL0tVejtCxeyY3DEbkdlU+1Cv4k82AGRfSVKr8a3RGpyKVc3646LLaN8na1JYznTNfYZ9HtEX2a2bZLNQnMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jUsLQQ4B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jUsLQQ4B"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE1LXhf010309;
	Thu, 14 Nov 2024 06:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5vKwAz41n/c9jfkKxKxOWK
	dCWwzQYv0safYDZHjtsSI=; b=jUsLQQ4BSdr6lgIYrSjL99/GBpO3t5MrbXxlsQ
	j63ZrFrRkiH2+Qe+Jp3K9nFaxsuo6+fhnfz+7lkMa5fYGGJ7sNIcymMi18hWGYeR
	Vs1b125Nl8hKcbPO9RuOWOgxtFpDxjUGPDdT+xSBieqE4A8z9zyM6vbkYriFH5ne
	LX7AQi93vg4bW5g1T5Tr640ruZWnLXu0hfUC8+Pp6mRBSlVy1mkAGVAVz82qaSsO
	3AIQB8H6GC1URSZhUaMGqrIJvHHP6oORL3vsxDL/eaEisv3UGqDb2/ysRycJnueO
	ulSZtBVK+VMJFODjStpiqaM1F1j2dZiD98c+b9Qinyd5kWmg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42w7ekgs1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 06:27:16 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AE6RFc4020750
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 06:27:15 GMT
Received: from hu-zijuhu-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 13 Nov 2024 22:27:15 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
Date: Wed, 13 Nov 2024 22:26:56 -0800
Subject: [PATCH] Bluetooth: qca: Support downloading board id specific NVM
 for WCN6855
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAC+YNWcC/x2MQQqAIBAAvyJ7Tmg1U/pKhISttRcLhQqivycdZ
 2DmgUKZqcAgHsh0cuE9VcBGQNjmtJLkpTKoVnWIqOWNuvgrpN4Z4yPf0uhgrI7ROuugZkemqv/
 lOL3vB7ilDDNiAAAA
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: Zijun Hu <zijun_hu@icloud.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bjorn Andersson <bjorande@quicinc.com>,
        "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
        Cheng Jiang
	<quic_chejiang@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Jens Glathe
	<jens.glathe@oldschoolsolutions.biz>,
        Steev Klimaszewski <steev@kali.org>,
        Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CCE5dTodrfEaBPzEotBJVoJjOHq6c-Vm
X-Proofpoint-GUID: CCE5dTodrfEaBPzEotBJVoJjOHq6c-Vm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140047

Download board id specific NVM instead of default for WCN6855 if board
id is available, and that is required by Lenovo ThinkPad X13s.

Cc: Bjorn Andersson <bjorande@quicinc.com>
Cc: Aiqun Yu (Maria) <quic_aiquny@quicinc.com>
Cc: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Cc: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/btqca.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index dfbbac92242a..4f8576cbbab9 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -717,6 +717,29 @@ static void qca_generate_hsp_nvm_name(char *fwname, size_t max_size,
 		snprintf(fwname, max_size, "qca/hpnv%02x%s.%x", rom_ver, variant, bid);
 }
 
+static void qca_get_hsp_nvm_name_generic(struct qca_fw_config *cfg,
+					 struct qca_btsoc_version ver,
+					 u8 rom_ver, u16 bid)
+{
+	const char *variant;
+
+	/* hsp gf chip */
+	if ((le32_to_cpu(ver.soc_id) & QCA_HSP_GF_SOC_MASK) == QCA_HSP_GF_SOC_ID)
+		variant = "g";
+	else
+		variant = "";
+
+	if (bid == 0x0)
+		snprintf(cfg->fwname, sizeof(cfg->fwname), "qca/hpnv%02x%s.bin",
+			 rom_ver, variant);
+	else if (bid & 0xff00)
+		snprintf(cfg->fwname, sizeof(cfg->fwname), "qca/hpnv%02x%s.b%x",
+			 rom_ver, variant, bid);
+	else
+		snprintf(cfg->fwname, sizeof(cfg->fwname), "qca/hpnv%02x%s.b%02x",
+			 rom_ver, variant, bid);
+}
+
 static inline void qca_get_nvm_name_generic(struct qca_fw_config *cfg,
 					    const char *stem, u8 rom_ver, u16 bid)
 {
@@ -810,8 +833,15 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	/* Give the controller some time to get ready to receive the NVM */
 	msleep(10);
 
-	if (soc_type == QCA_QCA2066 || soc_type == QCA_WCN7850)
+	switch (soc_type) {
+	case QCA_QCA2066:
+	case QCA_WCN6855:
+	case QCA_WCN7850:
 		qca_read_fw_board_id(hdev, &boardid);
+		break;
+	default:
+		break;
+	}
 
 	/* Download NVM configuration */
 	config.type = TLV_TYPE_NVM;
@@ -848,8 +878,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 				 "qca/msnv%02x.bin", rom_ver);
 			break;
 		case QCA_WCN6855:
-			snprintf(config.fwname, sizeof(config.fwname),
-				 "qca/hpnv%02x.bin", rom_ver);
+			qca_get_hsp_nvm_name_generic(&config, ver, rom_ver, boardid);
 			break;
 		case QCA_WCN7850:
 			qca_get_nvm_name_generic(&config, "hmt", rom_ver, boardid);

---
base-commit: e88b020190bf5bc3e7ce5bd8003fc39b23cc95fe
change-id: 20241113-x13s_wcn6855_fix-53c573ff7878

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>

