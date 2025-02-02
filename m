Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9861D8E16
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Feb 2025 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738498574; cv=none; b=JhxudIRJ7jHI6NNEnV3dY264lVwOn6WQyICrKe/ZET67C1e6Xl/2yHP/OQG3AMJGmSbRkKJ8MF65OaklrY7eR1nMyhZsIRKmaNgZd0aE7FCWj9ZvfAaTUOSU5W5TfB4g2ZF46VEA87qnuOcfvTaVGiAw6ZX80hbM8+0Wy8y0SVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738498574; c=relaxed/simple;
	bh=14MmxgXH6MGoKQlSv53fBwYT+gb2hGBEOWXu2liSlgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rE3efmhfyzX/a5WMz1CntRQi67eJv+VMg1S9tCLDR8U0HoBcyS8/bSTbjd9HnnYcqOjkoAsHCQGM4Ntw2caEQNVPZb3la6spgZigMQz9/95u3yuZIhU1Ya6bBy5ybD9cN9ZrvuhuBUZLVWO/FnrTqebAMlExMW+/DqH1+4wSGf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jdZNMxdj; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdZNMxdj"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5426fcb3c69so3102767e87.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Feb 2025 04:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738498570; x=1739103370; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/wgQA4ZO4Ux39DmgobxmQyBbaP59b/Ddx14+zk9ePA=;
        b=jdZNMxdjvLm+PitNsN2jOkjSoDVNrrWHABWcTsD9dhwQdzIvOeitEZ63NE58pmEoSG
         +3fQR6HiITjqxBG4Q59R2Oy3mE+R6He37XT+DCtSgi0t7chDdh9fUoUl7v4EOtJFLR0J
         6y7Y0irEkmfA9P6nTkyQDBRogCRPAWtBPGffQ/RvkPxL7AImPDc2nOXn6tEzhuV+q1n5
         brrm9hl0E6/y4lfrOy7d/yAahrNlsKunbiG5eB6gm7o/lT6UXalBO45tVg7DW69/0dPh
         hIFlSqxHtgCtUugAaPkHjplP/qcVqQBgV5Bao1rT16u2Pn0BWLdBlGvCZOOqBaDSio+9
         RJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738498570; x=1739103370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/wgQA4ZO4Ux39DmgobxmQyBbaP59b/Ddx14+zk9ePA=;
        b=XFyTS0qOM97126Gq9eq3/moZIKI6o0vSXbCbSI4fBWJjrfNxU31ep9Kzo64d8dn3e1
         92VYEhqpBF9aPIwaCT51f+puJImFZplZ4eL5WJtHgnXj1aqhRn7iWc0mEdFoq1KAuyvg
         mZ/dD87GCKFdFCJynW2YRE5kWKnEiMJgmCEjT2QJHJy7G4G/mfI8Hzt1II8CuO1I+H1W
         g7f3Buf1PFsJt7uqFBUmjvN92gT8z7ZFR7m8bgQCgDMGzbwbNRYP4IDRznvbRD1WmYXc
         qvNoomOaG081wfFLTbKedaw4qrtPs2PpjJ3697kgVeda/ogNFdb1dnj7ILhGcOiIlsnA
         YewQ==
X-Gm-Message-State: AOJu0Yxypx7/d8xIftDdMbHGAcz6IKelepdInNEZii/0vpy4Q9QLKOYF
	3aLmwfziSAFQ08lkBBqgKOny2SuG2Ewo/BFqnlWl9SipavHy4IB1cpGwUUmmoZ4=
X-Gm-Gg: ASbGncsjB+74w0/cPxjX1fJGaAWWQFvQ/ZvLtmXoKyf8b1nIYwulMpswNMCBO8O8xgL
	duVrFCRT3H/cfe5S4m5Vh6b9YJ2aWVMvS40SSLO+s/sJ52SDBZovgZS0/sOwJA2N08nFPH5K4jZ
	DSQmes8CwutDtu/DwyWJ8aMN2VHA0xsC5vnZmdBNe+XEW3jkGzXJ0lnNd56mg2joaN2ptkLu/VA
	PLKAmLhI4h1UrD+doRp7XPob42R749fQquTqPmjjxAdBOe52UtSE2la4X977YouQXN6ApkofQq6
	/BzvAXZIkc5bKES6hoa5vNk=
X-Google-Smtp-Source: AGHT+IFqExPesZgM/f1koff9qNfw4RB1gc5X7W1anqS7RYf47NPcsjIJhgvIkuCOh4rNke6QDcNaxQ==
X-Received: by 2002:a05:6512:b19:b0:541:1c48:8bf6 with SMTP id 2adb3069b0e04-543e4c3e14emr4839516e87.53.1738498570131;
        Sun, 02 Feb 2025 04:16:10 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebeb0a4esm950663e87.114.2025.02.02.04.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 04:16:09 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 02 Feb 2025 14:15:59 +0200
Subject: [PATCH v3 3/6] Bluetooth: qca: add WCN3950 support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250202-rb1-bt-v3-3-6797a4467ced@linaro.org>
References: <20250202-rb1-bt-v3-0-6797a4467ced@linaro.org>
In-Reply-To: <20250202-rb1-bt-v3-0-6797a4467ced@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6951;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=14MmxgXH6MGoKQlSv53fBwYT+gb2hGBEOWXu2liSlgE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnn2IBFb6rjwAzc/LtLub0IJQ3E97KS5ZYvnmo4
 9FUaTGf/UWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ59iAQAKCRCLPIo+Aiko
 1aWCB/9LhPHfYPcr9XC63kgQbDl8QKR4uhWY7biEsE/9+bT2eJE23+LbjoxZcHsTFpajYAOwpMg
 /sKB4Bz3qaFGlDXFGX//zpw/uqNouyTifuiNvBH+FE2L84UUBDTIcNhKo90vlDVx8hrSNjuLVMZ
 e8YVi2sBbG4yWQv3x+EW4EUspGJ18OC2TsL2Ha+4NbH5yz46FwwmNhzUTYesF6tRhhDiegPx/yU
 rlWYPPYNaGBo+/MTNAFwGsLhSx9o/Id74SSbhW0rEcywyEpXuCjewUADbTcjD5q6h3Llt2Uon0q
 o/Frj0W9DiDFumryeyofkgaeBivfmVR7MWiZbhLCs05d7MHt
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

WCN3950 is another example of the WCN39xx BT/WiFI family of chips. It
requires different firmware files and has different current
requirements, so add it as a separate SoC type.

The firmware for these chips has been recently added to the
linux-firmware repository and will be a part of the upcoming release:
- qca/cmbtfw12.tlv
- qca/cmbtfw13.tlv
- qca/cmnv12.bin
- qca/cmnv13.bin

Two additional NVM files are pending to be merged into linux-firmware:
- qca/cmnv13s.bin
- qca/cmnv13t.bin

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/bluetooth/btqca.c   | 14 ++++++++++++++
 drivers/bluetooth/btqca.h   |  4 ++++
 drivers/bluetooth/hci_qca.c | 25 +++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 7d6b02fe2040ff16d9d62de683571e1e1900fe85..3d6778b95e0058beda3f0500b21caaef8e797d32 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -816,6 +816,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		snprintf(config.fwname, sizeof(config.fwname), "qca/%s", rampatch_name);
 	} else {
 		switch (soc_type) {
+		case QCA_WCN3950:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/cmbtfw%02x.tlv", rom_ver);
+			break;
 		case QCA_WCN3990:
 		case QCA_WCN3991:
 		case QCA_WCN3998:
@@ -881,6 +885,15 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		}
 	} else {
 		switch (soc_type) {
+		case QCA_WCN3950:
+			if (le32_to_cpu(ver.soc_id) == QCA_WCN3950_SOC_ID_T)
+				variant = "t";
+			else if (le32_to_cpu(ver.soc_id) == QCA_WCN3950_SOC_ID_S)
+				variant = "u";
+
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/cmnv%02x%s.bin", rom_ver, variant);
+			break;
 		case QCA_WCN3990:
 		case QCA_WCN3991:
 		case QCA_WCN3998:
@@ -947,6 +960,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	 * VsMsftOpCode.
 	 */
 	switch (soc_type) {
+	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 9d28c88002257bae31249457b98a5df1df26efe4..8f3c1b1c77b3de8e7c86578aa3af17aefe99dab3 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -41,6 +41,9 @@
 
 #define QCA_WCN3991_SOC_ID		0x40014320
 
+#define QCA_WCN3950_SOC_ID_T		0x40074130
+#define QCA_WCN3950_SOC_ID_S		0x40075130
+
 /* QCA chipset version can be decided by patch and SoC
  * version, combination with upper 2 bytes from SoC
  * and lower 2 bytes from patch will be used.
@@ -145,6 +148,7 @@ enum qca_btsoc_type {
 	QCA_INVALID = -1,
 	QCA_AR3002,
 	QCA_ROME,
+	QCA_WCN3950,
 	QCA_WCN3988,
 	QCA_WCN3990,
 	QCA_WCN3998,
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 0ac2168f1dc4f8ae2f7a3b2912e7f5b5b8115cac..b39889ce0e8ff9d97f72eb8e70cb9c6825984c82 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -623,6 +623,7 @@ static int qca_open(struct hci_uart *hu)
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 
 		switch (qcadev->btsoc_type) {
+		case QCA_WCN3950:
 		case QCA_WCN3988:
 		case QCA_WCN3990:
 		case QCA_WCN3991:
@@ -1366,6 +1367,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 
 	/* Give the controller time to process the request */
 	switch (qca_soc_type(hu)) {
+	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
@@ -1452,6 +1454,7 @@ static unsigned int qca_get_speed(struct hci_uart *hu,
 static int qca_check_speeds(struct hci_uart *hu)
 {
 	switch (qca_soc_type(hu)) {
+	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
@@ -1494,6 +1497,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		 * changing the baudrate of chip and host.
 		 */
 		switch (soc_type) {
+		case QCA_WCN3950:
 		case QCA_WCN3988:
 		case QCA_WCN3990:
 		case QCA_WCN3991:
@@ -1528,6 +1532,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 
 error:
 		switch (soc_type) {
+		case QCA_WCN3950:
 		case QCA_WCN3988:
 		case QCA_WCN3990:
 		case QCA_WCN3991:
@@ -1746,6 +1751,7 @@ static int qca_regulator_init(struct hci_uart *hu)
 	}
 
 	switch (soc_type) {
+	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
@@ -1776,6 +1782,7 @@ static int qca_regulator_init(struct hci_uart *hu)
 	qca_set_speed(hu, QCA_INIT_SPEED);
 
 	switch (soc_type) {
+	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
@@ -1807,6 +1814,7 @@ static int qca_power_on(struct hci_dev *hdev)
 		return 0;
 
 	switch (soc_type) {
+	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
@@ -1891,6 +1899,7 @@ static int qca_setup(struct hci_uart *hu)
 		soc_name = "qca2066";
 		break;
 
+	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
@@ -1925,6 +1934,7 @@ static int qca_setup(struct hci_uart *hu)
 	clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
 
 	switch (soc_type) {
+	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
@@ -1958,6 +1968,7 @@ static int qca_setup(struct hci_uart *hu)
 	}
 
 	switch (soc_type) {
+	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
@@ -2046,6 +2057,17 @@ static const struct hci_uart_proto qca_proto = {
 	.dequeue	= qca_dequeue,
 };
 
+static const struct qca_device_data qca_soc_data_wcn3950 __maybe_unused = {
+	.soc_type = QCA_WCN3950,
+	.vregs = (struct qca_vreg []) {
+		{ "vddio", 15000  },
+		{ "vddxo", 60000  },
+		{ "vddrf", 155000 },
+		{ "vddch0", 585000 },
+	},
+	.num_vregs = 4,
+};
+
 static const struct qca_device_data qca_soc_data_wcn3988 __maybe_unused = {
 	.soc_type = QCA_WCN3988,
 	.vregs = (struct qca_vreg []) {
@@ -2338,6 +2360,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		qcadev->btsoc_type = QCA_ROME;
 
 	switch (qcadev->btsoc_type) {
+	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
@@ -2374,6 +2397,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			break;
 		}
 		fallthrough;
+	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
@@ -2683,6 +2707,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
 	{ .compatible = "qcom,qca6174-bt" },
 	{ .compatible = "qcom,qca6390-bt", .data = &qca_soc_data_qca6390},
 	{ .compatible = "qcom,qca9377-bt" },
+	{ .compatible = "qcom,wcn3950-bt", .data = &qca_soc_data_wcn3950},
 	{ .compatible = "qcom,wcn3988-bt", .data = &qca_soc_data_wcn3988},
 	{ .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data_wcn3990},
 	{ .compatible = "qcom,wcn3991-bt", .data = &qca_soc_data_wcn3991},

-- 
2.39.5

