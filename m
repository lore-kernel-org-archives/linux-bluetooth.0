Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372041CDFBC
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Feb 2025 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738430962; cv=none; b=B/gALUVZDd6avhf864Vp4e/vRAxHBPX+EQ+rFBd8Beax7dtuQk7Num5iOuwCKAdalki1Mx9Sy0aOJTa9jIfA7le//jUhWUGG7u4IZWGupfzofyRZxUNkihPOVqUak/8N9k/aU70YUI+3+qkv5CWLNoSPhxqi8Is1Rt4AgjiLKgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738430962; c=relaxed/simple;
	bh=ycOIHYAGFDD1jOlWhLjzqCD5G1p8AhMZpp9cNcyiiKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Thez2PAkImGR5g8tCBd7EnQ04ZWWPMUMxmrsKrt7lGuikzGTEtULVGZq3+onQn9iD+V1bqghxe25TqM53+1uhvAYU1s8hYW2Ed9gAttEICaNuJ7S9veUGdn5dtrz/zTQZVHvSPp8TDjdzpIh8JkJ6NjgZGeN2xXrKKjHIfF0UJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VM8ce+he; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VM8ce+he"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30167f4c1e3so28055761fa.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Feb 2025 09:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738430957; x=1739035757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZZ4xyfo+uc3x26XGH79TmF64JJh5ei0Vih4JbnvUzI=;
        b=VM8ce+heo0GZZ6sIpk5iqRiWG5zn/5u2WX/qfCMfpTO3Y1LB5P1N5Saon75fKHhZMW
         /fsL03PcyeFUkFlpU7QOD9rYOLZ/UgKGaB6LeMpv7WitrNN9rLDFADQOxx//4Tu5gj62
         1N2iDhh8GaYoFip9h5Ya9Vya1ZnjcVJHPqeiX+6gyZdkzvADyubESUEKH4Hp4kaAi2wJ
         BY1cE+rLvjAFI55ZTOKpduuCO+lIuZUzSSuV7WgEiLXMT/uUrvdIoA9ukLT7rbX96NKt
         FjwrTS5v83/V/3ogxiQTY9IzcA1FkcVhr/vomnWX9dr4UClMH3Nhy4020ra81xCMq7RV
         Vj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738430957; x=1739035757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZZ4xyfo+uc3x26XGH79TmF64JJh5ei0Vih4JbnvUzI=;
        b=nZ3wPx955TklVFmMJYzjgVMtTCrfaccqDc4La99He50Sxj9Q3I1r0mZn/u0Q21XaBe
         Ev1k1T1chbjQnCcuyr+8vE7eo3trP6myr/01/O50so68q9VlCJaT2Ri/PgAdcHwTv6Nb
         fdo9fHaqZHPxDP/6zfCA3Neku5u1u16EG9xsx7kxidBU7DbdQL7PvEH3CHGk9WMBdUPT
         CYrNw5iVgAsaZSVnzZwwTQvgMm7Skz+SMfbXtUVftNjzWw3RafjCubIFFWhec/VLGvXk
         hW5k0m4QMEGeTLysbNOzMYIbt5fI0Z4PTLRkS1NRU1rNuEHwvjg70RC5F2ClNgXnobKQ
         qTyQ==
X-Gm-Message-State: AOJu0YyqqtIXCKW5B8X20MwLkp17ULBRCebOvk2TK3Mp9bij8p4HIt2R
	wNKKB71CdHNR8TENyV9rA0uHftVdYO96n0HVl1dmtJi1yIxGVOZ6xnSBxaHywqg=
X-Gm-Gg: ASbGncugM7SdOdHKcmjScPiOMBydPs47TA9DNNZvrmp52tiOgERt7KpfjFC0cG+LuIP
	lezVTBbZENH7MsgSCOs6lQH2vZ8o5BbRJEU21Xr/P9ljUERILiIERJ5q03iCP5U2PiU5iLg6Igc
	NbABNdWJrEvkwPQYH7UZeQux1UdmhJg9FC9jOOhV3cJp2f2IelWIUdocXsIhCV+cspD3r22Gyyj
	APB7isE+XqwUI4AF0XfeVIJz3EyIVoZB7dSyvGtKNkY/eWNnmeY9q4EREFw/PeFAQPVx9MGjQ/K
	9GIwC2XwrQG2SKQg4HQICy4=
X-Google-Smtp-Source: AGHT+IGsx8Aj/IUcm36x0Eks9GyNFCiz2stzVn5fA9ymhZlqpLodClQHlPacl7JkgrfQpXFxOBb4nA==
X-Received: by 2002:a2e:a10c:0:b0:2ff:d2e4:8dd9 with SMTP id 38308e7fff4ca-30796968ecamr63106101fa.32.1738430957139;
        Sat, 01 Feb 2025 09:29:17 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307a3099ec4sm8852161fa.48.2025.02.01.09.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 09:29:15 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 01 Feb 2025 19:29:09 +0200
Subject: [PATCH v2 3/6] Bluetooth: qca: add WCN3950 support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250201-rb1-bt-v2-3-fd44011749bb@linaro.org>
References: <20250201-rb1-bt-v2-0-fd44011749bb@linaro.org>
In-Reply-To: <20250201-rb1-bt-v2-0-fd44011749bb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6629;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ycOIHYAGFDD1jOlWhLjzqCD5G1p8AhMZpp9cNcyiiKE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnnlnlol6Zu9ssdVrSRXGZXwmN5ayg/ZytqP9rs
 OHOv6yxpUSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ55Z5QAKCRCLPIo+Aiko
 1SWVB/0WKcV34oFniOCnTOMcluilYRA/TWn5jIM2Yvatqx8Q3ramqzk5KIaTaSooquAAr7JKG+q
 HjIQkHhdv2LP1wfYcnVOqTf3G1ySPEYDS58IrBgkHwRy1my4PEOIj0iqbG2DWRB+3m55tKTIyob
 dm1ExC2vOojPWvdbr7zcDJvijiPoHZe3fHYgqp3vRdfUyMPiau9aQgihTAv2r1qgcS2RUkBUkVz
 WTvl7HudzWqNMle3ZGzr8nYsTdEz8ZxMtbKc1CvWXv4TW5FlVhtEmFd+wP1em6wUfqOvdbWjPW+
 caZCV29ViEZWJyoAmUPQTRtZOuhATtDMIYKMYL7hOxYgH56C
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

WCN3950 is another example of the WCN39xx BT/WiFI family of chips. It
requires different firmware files and has different current
requirements, so add it as a separate SoC type.

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

