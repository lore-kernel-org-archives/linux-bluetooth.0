Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8E01DFE15;
	Tue,  7 Jan 2025 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736242034; cv=none; b=WK9kkpHcfXFXennO6305/+W4oaOVDBJ4TiBAM9bemXM11kC3xw+0iZpVh6PnOkWnr8AREqi9kMFncpbTW/R6KtRfKwWbCv04vcPgcbQm/Eva0ebPxZ/zQv83ouPTUm79ZEx9GmeBryMEYPzIVza9N2sqOcRNmaWuvlAVfI2cFB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736242034; c=relaxed/simple;
	bh=9d9aJHRIyaAmVrjs8r/RhS2SbuGHrNHxM3HgsX8hSO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sH1w8gTHaan0i7oPDA7C318ybE245tCH4FQqSprOxKGf+n2w2elYEdBWfrn4uYZFXFCz8Fx79d5ZVf+alF2wK1pnc2Y+Rc+Qtl5asgvBW26++B4ezIv1eZKAJ/tzyY+D60v297stZtRU+k+tf06HE7Hslmn1ZzoWgj3LfZXIzKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UdTjQD4T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UdTjQD4T"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50740Epa013765;
	Tue, 7 Jan 2025 09:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/9eCf6KYt3l
	ZoGL/GM0Fv8UXN1Q287WPBPjpezo8Cs8=; b=UdTjQD4Tcvc6MlEkHxnT/UPBVlE
	aKmxlGXb4yBGs7ztoVYVdcmW/3358/8BViqIJwzejiZR6RQtWkzfmC45depRx4Lf
	729Ta3Kqb+nEP+sTLygvEVyz5MzHsl7XDu2PchC8PbXFo3JurbgszlNtj2IUYa78
	93c4YcIYIfto8c/f/6D3YPWCffe5yynhGu8shJmqi/3n7YRye7aP1koN/s9HZgR9
	E9IVsc+VchYf49acS6iKKPhXPUdM0AurqAnzMzGfgmKEZkdq7QAx3EiVCcZvly/R
	v41rfQ6TOKBpyVqpTyM3WXHvDI1m7imcL9nj+iZah1qlCFqhVFIxmd3Tasg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 440vuu0paw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 09:27:01 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5079QshD015394;
	Tue, 7 Jan 2025 09:26:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 43xx2kj3un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 09:26:59 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5079QwC8015850;
	Tue, 7 Jan 2025 09:26:58 GMT
Received: from chejiang-gv.ap.qualcomm.com (chejiang-gv.qualcomm.com [10.233.43.239])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 5079QwmI015843
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 09:26:58 +0000
Received: by chejiang-gv.ap.qualcomm.com (Postfix, from userid 37913)
	id ACC86F57; Tue,  7 Jan 2025 17:26:57 +0800 (CST)
From: Cheng Jiang <quic_chejiang@quicinc.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chejiang@quicinc.com,
        quic_jiaymao@quicinc.com, quic_shuaz@quicinc.com,
        quic_zijuhu@quicinc.com, quic_mohamull@quicinc.com
Subject: [PATCH v6 RESEND 3/3] Bluetooth: qca: Expand firmware-name to load specific rampatch
Date: Tue,  7 Jan 2025 17:26:50 +0800
Message-Id: <20250107092650.498154-4-quic_chejiang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107092650.498154-1-quic_chejiang@quicinc.com>
References: <20250107092650.498154-1-quic_chejiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: qc8FCuGfQ7U4qFRQDPy67tI_Iz356bW1
X-Proofpoint-GUID: qc8FCuGfQ7U4qFRQDPy67tI_Iz356bW1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070079

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

