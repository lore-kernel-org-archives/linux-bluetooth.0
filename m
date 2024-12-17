Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7371F706D;
	Tue, 17 Dec 2024 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445524; cv=none; b=gdO6Pj+WYMfpyqFNmZzRyln5nyuagMYADDnJN2PFdIkRyYppvAOfGlHAMGIFwt25ky1HjSYP09/r36pKlAe1mrbkBT0afD/+dI9oCtqCZjWFLVVWGckaGjDYyTETrRqXSWiqKedUEbqjp4G28m9pzJengEkmSse/VMig1CVWRUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445524; c=relaxed/simple;
	bh=sRUkl4dsyLDy1DfHFjxbKwUMtTUSaf4ljapZ+O2OwRo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kymCZNYOc81eTad7Vz7fiUbGOZ/YK0W15HECRMY/5pRt3tqIIjxbqOdGBgXPSYdPr4PsuY1UdfopjRRMurX6ZsaTwrpS/D43Wkre3igHGvc5eeqgPQqGNRM+1gdRChLfQsS6I8iIx04YS45RsOxVOnp70n7LtqDSU/OwtiERk10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dmzfzvLV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dmzfzvLV"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHAo6nF032385;
	Tue, 17 Dec 2024 14:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z3nPDwiZHUCnyEB8YdaYOGOQbONzUodgbr1y0AuKpWs=; b=dmzfzvLVPENqFCgK
	XHl8qYiDPunQPRIELGldqS21dU3+AfBROBm7gs+2de1/WCHnNxc+Pjq9h8EeMtYm
	kbp2vNEydCbOHBICiainyg297M20k7ftx85y/CDd5ChIR1mMRpMmGMXhjk2ssVm0
	1ArMabF2z8eNZkBhPIh1I4L56vgrRvgEWeK0iDqh+lezt7kcAICgFnj1ri1BlcfB
	IsJX300Hw7bJzUcdu0IYfqaWuymiCi1T9ExGsM+5bboCz6ZQVWH8M/3QNlKj+uzs
	wewSqagFfgfPwiDwdwYmXvkMGEIBhp65Ix2M3qtoDa9wdDmnQePRIRGxVh4spPM6
	iwv8Tw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43k7w50hjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 14:25:17 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BHEPFl3018207
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 14:25:16 GMT
Received: from chejiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Dec 2024 06:25:12 -0800
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
Subject: [PATCH v6 2/3] Bluetooth: qca: Update firmware-name to support board specific nvm
Date: Tue, 17 Dec 2024 22:24:53 +0800
Message-ID: <20241217142454.614551-3-quic_chejiang@quicinc.com>
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
X-Proofpoint-GUID: NTzaoxlGKUnNt2BAhjwr-DVtyb5Dvhn9
X-Proofpoint-ORIG-GUID: NTzaoxlGKUnNt2BAhjwr-DVtyb5Dvhn9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170114

Different connectivity boards may be attached to the same platform. For
example, QCA6698-based boards can support either a two-antenna or
three-antenna solution, both of which work on the sa8775p-ride platform.
Due to differences in connectivity boards and variations in RF
performance from different foundries, different NVM configurations are
used based on the board ID.

Therefore, in the firmware-name property, if the NVM file has an
extension, the NVM file will be used. Otherwise, the system will first
try the .bNN (board ID) file, and if that fails, it will fall back to
the .bin file.

Possible configurations:
firmware-name = "QCA6698/hpnv21";
firmware-name = "QCA6698/hpnv21.bin";

Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
---
 drivers/bluetooth/btqca.c | 113 ++++++++++++++++++++++++++++----------
 1 file changed, 85 insertions(+), 28 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index dfbbac922..5cb1fd1a0 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -272,6 +272,39 @@ int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(qca_send_pre_shutdown_cmd);
 
+static bool qca_filename_has_extension(const char *filename)
+{
+	const char *suffix = strrchr(filename, '.');
+
+	/* File extensions require a dot, but not as the first or last character */
+	if (!suffix || suffix == filename || *(suffix + 1) == '\0')
+		return 0;
+
+	/* Avoid matching directories with names that look like files with extensions */
+	return !strchr(suffix, '/');
+}
+
+static bool qca_get_alt_nvm_file(char *filename, size_t max_size)
+{
+	char fwname[64];
+	const char *suffix;
+
+	/* nvm file name has an extension, replace with .bin */
+	if (qca_filename_has_extension(filename)) {
+		suffix = strrchr(filename, '.');
+		strscpy(fwname, filename, suffix - filename + 1);
+		snprintf(fwname + (suffix - filename),
+		       sizeof(fwname) - (suffix - filename), ".bin");
+		/* If nvm file is already the default one, return false to skip the retry. */
+		if (strcmp(fwname, filename) == 0)
+			return false;
+
+		snprintf(filename, max_size, "%s", fwname);
+		return true;
+	}
+	return false;
+}
+
 static int qca_tlv_check_data(struct hci_dev *hdev,
 			       struct qca_fw_config *config,
 			       u8 *fw_data, size_t fw_size,
@@ -564,6 +597,19 @@ static int qca_download_firmware(struct hci_dev *hdev,
 					   config->fwname, ret);
 				return ret;
 			}
+		}
+		/* If the board-specific file is missing, try loading the default
+		 * one, unless that was attempted already.
+		 */
+		else if (config->type == TLV_TYPE_NVM &&
+			 qca_get_alt_nvm_file(config->fwname, sizeof(config->fwname))) {
+			bt_dev_info(hdev, "QCA Downloading %s", config->fwname);
+			ret = request_firmware(&fw, config->fwname, &hdev->dev);
+			if (ret) {
+				bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
+					   config->fwname, ret);
+				return ret;
+			}
 		} else {
 			bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
 				   config->fwname, ret);
@@ -700,34 +746,38 @@ static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *co
 	return 0;
 }
 
-static void qca_generate_hsp_nvm_name(char *fwname, size_t max_size,
+static void qca_get_nvm_name_by_board(char *fwname, size_t max_size,
+		const char *stem, enum qca_btsoc_type soc_type,
 		struct qca_btsoc_version ver, u8 rom_ver, u16 bid)
 {
 	const char *variant;
+	const char *prefix;
 
-	/* hsp gf chip */
-	if ((le32_to_cpu(ver.soc_id) & QCA_HSP_GF_SOC_MASK) == QCA_HSP_GF_SOC_ID)
-		variant = "g";
-	else
-		variant = "";
+	/* Set the default value to variant and prefix */
+	variant = "";
+	prefix = "b";
 
-	if (bid == 0x0)
-		snprintf(fwname, max_size, "qca/hpnv%02x%s.bin", rom_ver, variant);
-	else
-		snprintf(fwname, max_size, "qca/hpnv%02x%s.%x", rom_ver, variant, bid);
-}
+	if (soc_type == QCA_QCA2066)
+		prefix = "";
 
-static inline void qca_get_nvm_name_generic(struct qca_fw_config *cfg,
-					    const char *stem, u8 rom_ver, u16 bid)
-{
-	if (bid == 0x0)
-		snprintf(cfg->fwname, sizeof(cfg->fwname), "qca/%snv%02x.bin", stem, rom_ver);
-	else if (bid & 0xff00)
-		snprintf(cfg->fwname, sizeof(cfg->fwname),
-			 "qca/%snv%02x.b%x", stem, rom_ver, bid);
-	else
-		snprintf(cfg->fwname, sizeof(cfg->fwname),
-			 "qca/%snv%02x.b%02x", stem, rom_ver, bid);
+	if (soc_type == QCA_WCN6855 || soc_type == QCA_QCA2066) {
+		/* If the chip is manufactured by GlobalFoundries */
+		if ((le32_to_cpu(ver.soc_id) & QCA_HSP_GF_SOC_MASK) == QCA_HSP_GF_SOC_ID)
+			variant = "g";
+	}
+
+	if (rom_ver != 0) {
+		if (bid == 0x0 || bid == 0xffff)
+			snprintf(fwname, max_size, "qca/%s%02x%s.bin", stem, rom_ver, variant);
+		else
+			snprintf(fwname, max_size, "qca/%s%02x%s.%s%02x", stem, rom_ver,
+						variant, prefix, bid);
+	} else {
+		if (bid == 0x0 || bid == 0xffff)
+			snprintf(fwname, max_size, "qca/%s%s.bin", stem, variant);
+		else
+			snprintf(fwname, max_size, "qca/%s%s.%s%02x", stem, variant, prefix, bid);
+	}
 }
 
 int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
@@ -816,8 +866,14 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	/* Download NVM configuration */
 	config.type = TLV_TYPE_NVM;
 	if (firmware_name) {
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/%s", firmware_name);
+		/* The firmware name has an extension, use it directly */
+		if (qca_filename_has_extension(firmware_name)) {
+			snprintf(config.fwname, sizeof(config.fwname), "qca/%s", firmware_name);
+		} else {
+			qca_read_fw_board_id(hdev, &boardid);
+			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
+				 firmware_name, soc_type, ver, 0, boardid);
+		}
 	} else {
 		switch (soc_type) {
 		case QCA_WCN3990:
@@ -836,8 +892,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 				 "qca/apnv%02x.bin", rom_ver);
 			break;
 		case QCA_QCA2066:
-			qca_generate_hsp_nvm_name(config.fwname,
-				sizeof(config.fwname), ver, rom_ver, boardid);
+			qca_get_nvm_name_by_board(config.fwname,
+				sizeof(config.fwname), "hpnv", soc_type, ver,
+				rom_ver, boardid);
 			break;
 		case QCA_QCA6390:
 			snprintf(config.fwname, sizeof(config.fwname),
@@ -852,9 +909,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 				 "qca/hpnv%02x.bin", rom_ver);
 			break;
 		case QCA_WCN7850:
-			qca_get_nvm_name_generic(&config, "hmt", rom_ver, boardid);
+			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
+				 "hmtnv", soc_type, ver, rom_ver, boardid);
 			break;
-
 		default:
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/nvm_%08x.bin", soc_ver);
-- 
2.34.1

