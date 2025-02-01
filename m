Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF39114F108
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Feb 2025 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738401511; cv=none; b=OW4VUeqjcUKY3wf9kKiKIZ2dS6XEggz9kCX+4jL31V4do76quw2HFVRHyObEdWW6DLFVRYV6QHrhkQrrBlcSid5ASPhxH2expP4sJprmEpTMQEvF9nBodHg1oRQfawb+zkdBPfsYQmr2zW84/rSxUmvZFwM13hI4QNt+FvKubxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738401511; c=relaxed/simple;
	bh=JHBVtVHMkSJ6nIaRKycINz9lZG2/fh0enAbh7ip1B+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nGB7XBPmZg9+qXEDzLYzWCZnli+/Igu6EoMevii5RC13zdHJF6E755BFikH4u+5iF4nydYJcO7/tem7cXu8CqYBVtmvhSs11B5N1sPqo9r/SIJjnc4eYK9sn6InyRVItqBpr/qqrU2M+2Do/+q1/QDQ83MwMa4AutimGTuzYtaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Oh3SUEs6; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oh3SUEs6"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53ff1f7caaeso2764516e87.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Feb 2025 01:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738401507; x=1739006307; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ay7LZgt0wPUvvJsOjnpqFHGqHQqwfsSCz5W1wjgPoaY=;
        b=Oh3SUEs66kEFi5EcrOROk3Fyx7k2/o1etfFirV/XlTYr7XxfL2zh7anjBN1l17WBTp
         Lmh8p/8XRVPUOOry4KTS5j0DbTK73I02ImYCERIxc/BoKb4Q1odIqofywNEPiz9aj/QX
         pYX/78Lskk1ePvvmq/r+TTA9s3CsRHOGgK3TZJOIp8k1L+G3Ucx/UJlBZam1EVilbYmO
         qo6b+Me4GKhVwYzJLTVOa1jUwD50lN9AldihNQcknDg7EHO6Wv9t7UWT39hDcHE40s3N
         lJHGYN9VeXpI4bpZciY2s+e22LgQ5BgqYMqKrBwDUKZaI3ipatXFGDeRA9to83wEmN8s
         2dTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738401507; x=1739006307;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ay7LZgt0wPUvvJsOjnpqFHGqHQqwfsSCz5W1wjgPoaY=;
        b=CnrnT7pt2QiqaFn0j3/xBJak7iWZk1ZpjVM7KzdXMvIfdsJyQtYbqmN6BkMvEXHp4W
         038c8ckaMSuocOAIV1rTMkP/EMK+B6P6gR9ZE+i+GjJBMxoH1X5QVdDUdBJCXe0GQ3Ya
         T1W5le68cPHaXSTFMaptePP0CPbkfP72jp7DH+wUGE4NZQOd0oPL9njvH7ljDvkOh+BP
         B8/yHgdoBTyhmGxN8jZs7awfEaK6fBmXgMuxFbuH4OfqnXAjZ9Emnv2doeJ7tOn434OI
         f9W0b7gv9KBMZvoJPRLdXYOVmox3hrGpmpytlZ+D/jMhbeBirTSURCAtvehuGzGMoSWA
         eIRA==
X-Gm-Message-State: AOJu0YzI9Tki5oWFh5lPXTCy7Rzz2uKRLrQyU63idzaLNcbJ2y+MJueH
	/ADVVJ12G8ARV2wOeetworTzlVtanuVTyFEHaqZgDEXGzMewYf3L0HZ1HgEb8PM=
X-Gm-Gg: ASbGnctx4Qz4aJKN7SICN/5/OKUOwJEyuwMqaniyi+newMYJprBDwhIJh433XcFB5Zu
	iAiI2TCxgKaednp2f/VfWdw/C0v613hfuKcWFv/mbx5Gv8eopz4gXq1z+eXvTpFdmmFPW4ERoVh
	IQOT5NAN5IchVC/yGkWtJtKlyzPsXRLVOVhBhMKkK8AjhEuqZlTeYBbeiA0Vqt66ZOmdQlEisH6
	sIvVrxMHv+dZ0x0C8V1cXiGblUKd1f20gGjUmDj2IBBKRzUPRGWtFrs+mnCVPnRGNrJMgAYH++F
	9el6b3Gm8/kaEh7VqOuVz04=
X-Google-Smtp-Source: AGHT+IFkJxOGVqXAOjXLLsl9uwJy8xobyzU4KMYN10bp0kjV1CIg4vw8ZJbsBnUxGl8PJNf19B7UJQ==
X-Received: by 2002:a05:6512:3f1f:b0:543:f1db:d1d8 with SMTP id 2adb3069b0e04-543f1dbd214mr1679499e87.11.1738401506949;
        Sat, 01 Feb 2025 01:18:26 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebe0ff47sm711234e87.93.2025.02.01.01.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 01:18:25 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 01 Feb 2025 11:18:13 +0200
Subject: [PATCH 2/4] Bluetooth: qca: add WCN3950 support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250201-rb1-bt-v1-2-ae896c4923d8@linaro.org>
References: <20250201-rb1-bt-v1-0-ae896c4923d8@linaro.org>
In-Reply-To: <20250201-rb1-bt-v1-0-ae896c4923d8@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6227;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=JHBVtVHMkSJ6nIaRKycINz9lZG2/fh0enAbh7ip1B+E=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnnebbfXMcGG7r7nfSFMIHWVHTcM3WC2Lqz92/O
 hAOQZU60amJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ53m2wAKCRCLPIo+Aiko
 1aQzB/91Ydm79pJoeY19onpUPcHHgL1bo5G0a9EmSEnLUTahFmvjijmuHXvWCqWDlmhmZ4VwYGU
 3rQKWiGVwVK0hE/O8a9utiX+qMfbhidpVdOTTHcUarkYVTbczNSSQAhOLlrcbzY76UGtOBomhcX
 TVyf8U31M4RV11hhMhGqKufnMaxAgOB2utgxZ712TnwYUxF7WnibIUaeR7g+yo58otBy/SHPVTI
 JSfHz1aQnvS351UJZ23eQ2WdE0dVOcmwqonCSWw1nkmNiWsjfYL+25HQbyPKDRX2BwLNWTNkJkM
 a42st0p0lg5sd7fqxnC8shx9V8mRSPWmr085HcJ9R9HJeSp4
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

WCN3950 is another example of the WCN39xx BT/WiFI family of chips. It
requires different firmware files and has different current
requirements, so add it as a separate SoC type.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/bluetooth/btqca.c   |  9 +++++++++
 drivers/bluetooth/btqca.h   |  1 +
 drivers/bluetooth/hci_qca.c | 25 +++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index cdf09d9a9ad27c080f27c5fe8d61d76085e1fd2c..4d259d8447774ac7adfcc44d7cfb5bf41774289c 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -821,6 +821,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/crbtfw%02x.tlv", rom_ver);
 			break;
+		case QCA_WCN3950:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/cmbtfw%02x.tlv", rom_ver);
+			break;
 		case QCA_WCN3988:
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/apbtfw%02x.tlv", rom_ver);
@@ -891,6 +895,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 					 "qca/crnv%02x.bin", rom_ver);
 			}
 			break;
+		case QCA_WCN3950:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/cmnv%02x.bin", rom_ver);
+			break;
 		case QCA_WCN3988:
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/apnv%02x.bin", rom_ver);
@@ -948,6 +956,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	 * VsMsftOpCode.
 	 */
 	switch (soc_type) {
+	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 9d28c88002257bae31249457b98a5df1df26efe4..10ba8ebfe80fa43827e5c05f9ad643ecb2cea872 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -145,6 +145,7 @@ enum qca_btsoc_type {
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

