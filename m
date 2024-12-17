Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208691F755A;
	Tue, 17 Dec 2024 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445529; cv=none; b=Fs+PRxJjqND8JeNoaNA/5oeoyPJ5TgHj8QzOIdTTLaofkchDUUo2dQ951FopvPjZaTUWvRA5u1I04kbpY+Qz/w2XuO4SKlJVQDtm8GSER+bUJi9bMoIVOS7Cmvc68Hh06TSwch5NGERaoZFeXhTXqIf9V6hG5r7TLO4G+X74ekI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445529; c=relaxed/simple;
	bh=9d9aJHRIyaAmVrjs8r/RhS2SbuGHrNHxM3HgsX8hSO8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0QR7U2zIcSCA+r9hTKFtzytiRyv9ngVolV1KtVoPnulRGxe+5YYg4Avv5o8js6wd3syaKNyNaJ8IBK17Bejs8ayajP/cKBqiBdyUQ6raaaz9TaMXeXPGIxlPoyWKv5cJYLGmDOqPWozu/f9kNu06EFIr1nEVnZr5O1R7ouED5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dFC8HO8L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dFC8HO8L"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHAmBVG026306;
	Tue, 17 Dec 2024 14:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/9eCf6KYt3lZoGL/GM0Fv8UXN1Q287WPBPjpezo8Cs8=; b=dFC8HO8LmVn/xG7Q
	f3UnwHTGvimCnwe2WYqPKVPoSSMyJ8/kbiKWTy3xOYKOwI5XS5Pcv6ooMUjFACoB
	65/QUjg8N3Ko7oKQUG5LlxXDWrPmPiJLVgcLXviXyE1hMDM71unNVzOSqjKlJoRe
	TtPXOPrHD2wMZBHoKm7MsKbgDE+hu9StcZWeAyi21qZDMeN/0sn5DhcOYeVNARKc
	fXnma5jbwN8PB1tJmdwSHMPgXi5t8B8hSScoOOGIkrS+9laDBSHR75PtLsH66c1b
	1xRHkIgijOP4/f2rS/XyeA8NXiG1wL/1Aywa7FNxrO0WXbcezW8mcqfYhYxLt8TV
	SjTr2g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43k7v08j44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 14:25:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BHEPJO1011002
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 14:25:19 GMT
Received: from chejiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Dec 2024 06:25:16 -0800
From: Cheng Jiang <quic_chejiang@quicinc.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Balakrishna
 Godavarthi" <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
CC: <linux-bluetooth@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_chejiang@quicinc.com>,
        <quic_jiaymao@quicinc.com>, <quic_shuaz@quicinc.com>,
        <quic_zijuhu@quicinc.com>, <quic_mohamull@quicinc.com>
Subject: [PATCH v6 3/3] Bluetooth: qca: Expand firmware-name to load specific rampatch
Date: Tue, 17 Dec 2024 22:24:54 +0800
Message-ID: <20241217142454.614551-4-quic_chejiang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217142454.614551-1-quic_chejiang@quicinc.com>
References: <20241217142454.614551-1-quic_chejiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G1ntttg9qgvR1oHPDj35HAQFgxNDNxDy
X-Proofpoint-ORIG-GUID: G1ntttg9qgvR1oHPDj35HAQFgxNDNxDy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 bulkscore=0
 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170114

The firmware-name property has been expanded to specify the names of NVM
and rampatch firmware for certain chips, such as the QCA6698 Bluetooth
chip. Although it shares the same IP core as the WCN6855, the QCA6698
has different RF components and RAM sizes, necessitating new firmware
files. This change allows for the configuration of NVM and rampatch in
DT.

Possible configurations:
firmware-name = QCA6698/hpnv21.bin, QCA6698/hpbtfw21.tlv;
firmware-name = QCA6698/hpnv21, QCA6698/hpbtfw21.tlv;

Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
---
 drivers/bluetooth/btqca.c   | 82 +++++++++++++++++++------------------
 drivers/bluetooth/btqca.h   |  5 ++-
 drivers/bluetooth/hci_qca.c | 22 +++++++---
 3 files changed, 63 insertions(+), 46 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 5cb1fd1a0..a6b53d1f2 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -782,7 +782,7 @@ static void qca_get_nvm_name_by_board(char *fwname, size_t max_size,
 
 int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		   enum qca_btsoc_type soc_type, struct qca_btsoc_version ver,
-		   const char *firmware_name)
+		   const char *firmware_name, const char *rampatch_name)
 {
 	struct qca_fw_config config = {};
 	int err;
@@ -811,44 +811,48 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 
 	/* Download rampatch file */
 	config.type = TLV_TYPE_PATCH;
-	switch (soc_type) {
-	case QCA_WCN3990:
-	case QCA_WCN3991:
-	case QCA_WCN3998:
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/crbtfw%02x.tlv", rom_ver);
-		break;
-	case QCA_WCN3988:
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/apbtfw%02x.tlv", rom_ver);
-		break;
-	case QCA_QCA2066:
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/hpbtfw%02x.tlv", rom_ver);
-		break;
-	case QCA_QCA6390:
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/htbtfw%02x.tlv", rom_ver);
-		break;
-	case QCA_WCN6750:
-		/* Choose mbn file by default.If mbn file is not found
-		 * then choose tlv file
-		 */
-		config.type = ELF_TYPE_PATCH;
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/msbtfw%02x.mbn", rom_ver);
-		break;
-	case QCA_WCN6855:
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/hpbtfw%02x.tlv", rom_ver);
-		break;
-	case QCA_WCN7850:
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/hmtbtfw%02x.tlv", rom_ver);
-		break;
-	default:
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/rampatch_%08x.bin", soc_ver);
+	if (rampatch_name) {
+		snprintf(config.fwname, sizeof(config.fwname), "qca/%s", rampatch_name);
+	} else {
+		switch (soc_type) {
+		case QCA_WCN3990:
+		case QCA_WCN3991:
+		case QCA_WCN3998:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/crbtfw%02x.tlv", rom_ver);
+			break;
+		case QCA_WCN3988:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/apbtfw%02x.tlv", rom_ver);
+			break;
+		case QCA_QCA2066:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/hpbtfw%02x.tlv", rom_ver);
+			break;
+		case QCA_QCA6390:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/htbtfw%02x.tlv", rom_ver);
+			break;
+		case QCA_WCN6750:
+			/* Choose mbn file by default.If mbn file is not found
+			 * then choose tlv file
+			 */
+			config.type = ELF_TYPE_PATCH;
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/msbtfw%02x.mbn", rom_ver);
+			break;
+		case QCA_WCN6855:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/hpbtfw%02x.tlv", rom_ver);
+			break;
+		case QCA_WCN7850:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/hmtbtfw%02x.tlv", rom_ver);
+			break;
+		default:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/rampatch_%08x.bin", soc_ver);
+		}
 	}
 
 	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index bb5207d7a..9d28c8800 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -161,7 +161,7 @@ enum qca_btsoc_type {
 int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		   enum qca_btsoc_type soc_type, struct qca_btsoc_version ver,
-		   const char *firmware_name);
+		   const char *firmware_name, const char *rampatch_name);
 int qca_read_soc_version(struct hci_dev *hdev, struct qca_btsoc_version *ver,
 			 enum qca_btsoc_type);
 int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
@@ -176,7 +176,8 @@ static inline int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdad
 static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 				 enum qca_btsoc_type soc_type,
 				 struct qca_btsoc_version ver,
-				 const char *firmware_name)
+				 const char *firmware_name,
+				 const char *rampatch_name)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 37129e6cb..5d75087cc 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -228,7 +228,7 @@ struct qca_serdev {
 	u32 init_speed;
 	u32 oper_speed;
 	bool bdaddr_property_broken;
-	const char *firmware_name;
+	const char *firmware_name[2];
 };
 
 static int qca_regulator_enable(struct qca_serdev *qcadev);
@@ -258,7 +258,18 @@ static const char *qca_get_firmware_name(struct hci_uart *hu)
 	if (hu->serdev) {
 		struct qca_serdev *qsd = serdev_device_get_drvdata(hu->serdev);
 
-		return qsd->firmware_name;
+		return qsd->firmware_name[0];
+	} else {
+		return NULL;
+	}
+}
+
+static const char *qca_get_rampatch_name(struct hci_uart *hu)
+{
+	if (hu->serdev) {
+		struct qca_serdev *qsd = serdev_device_get_drvdata(hu->serdev);
+
+		return qsd->firmware_name[1];
 	} else {
 		return NULL;
 	}
@@ -1855,6 +1866,7 @@ static int qca_setup(struct hci_uart *hu)
 	unsigned int retries = 0;
 	enum qca_btsoc_type soc_type = qca_soc_type(hu);
 	const char *firmware_name = qca_get_firmware_name(hu);
+	const char *rampatch_name = qca_get_rampatch_name(hu);
 	int ret;
 	struct qca_btsoc_version ver;
 	struct qca_serdev *qcadev;
@@ -1963,7 +1975,7 @@ static int qca_setup(struct hci_uart *hu)
 
 	/* Setup patch / NVM configurations */
 	ret = qca_uart_setup(hdev, qca_baudrate, soc_type, ver,
-			firmware_name);
+			firmware_name, rampatch_name);
 	if (!ret) {
 		clear_bit(QCA_IBS_DISABLED, &qca->flags);
 		qca_debugfs_init(hdev);
@@ -2309,8 +2321,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	qcadev->serdev_hu.serdev = serdev;
 	data = device_get_match_data(&serdev->dev);
 	serdev_device_set_drvdata(serdev, qcadev);
-	device_property_read_string(&serdev->dev, "firmware-name",
-					 &qcadev->firmware_name);
+	device_property_read_string_array(&serdev->dev, "firmware-name",
+					 qcadev->firmware_name, ARRAY_SIZE(qcadev->firmware_name));
 	device_property_read_u32(&serdev->dev, "max-speed",
 				 &qcadev->oper_speed);
 	if (!qcadev->oper_speed)
-- 
2.34.1

