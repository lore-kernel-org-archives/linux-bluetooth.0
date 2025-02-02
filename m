Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809771D88BE
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Feb 2025 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738498572; cv=none; b=BWznWNHQW77GTbNSZSlyjuRBnGkSowJ6gF474RKQXMy4dO4a1rgnuMggogS2Eo4szQ0YAr4vObvB5xYJsuoixlcGWBNioOTBXSb+1xbM09fhXT4QFZUlyVQ3x2X53TXCzowTMl4Qe3RYUJMq0NvddGdMhO5Pk2t76HA43Gm3YTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738498572; c=relaxed/simple;
	bh=XL7ng8U88IdS02LpqkHkwAED27Q7ZWUI6j1I8zn2UOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fel95y+6ajewCIGepu7Ln3yHkIUCfawJ27issrxK9SWlov8uPT+iSXnNvzHvlUc/LHE0NSQ+dAYUp1uwvIiTQPYI/hV31GTG7589pTNvwJj5JJShkAWDppx5C8zdOZ5ZRHeND6ihV0TZMPlcaWAtRj+8DOprHtd/fIT4mZJ7X68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yi4uvw1h; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yi4uvw1h"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53e3a227b82so3089731e87.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Feb 2025 04:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738498568; x=1739103368; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0uDfHhxafnqOPaFWheOWVq1hqVSH+SO7a7CETbeXIaY=;
        b=yi4uvw1hfcswZ2VQxp3nDkBa55RPmjGgBYmwe+CA+jXBHXVVMdlbB/zKmnI8qd5Yqf
         gJuglgJbb9RGXJmeutypPMJ2/DhI89YmWj3cm25dA0UdudeLUEU+LMz/6xUCTRNOynqs
         9MAAW7LrziYzckbGCdFONcpTDNLb2GjjQcfyJKsfRud3CuUS1dM10DuJKFgSz7X48Eiw
         JW9n10g57JucPHyBQQFugKeuGv8kGAW2falBzNMprDEFSO/OWSC/VpiSk+WQllJIHuKx
         7ro3YmL3hYuFnAYr1ZdzfxcJ9Iyy+5y2V3+AdhGZ9/daqpBdW5Ll/h2DN1aDlrneqSzt
         /MHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738498568; x=1739103368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uDfHhxafnqOPaFWheOWVq1hqVSH+SO7a7CETbeXIaY=;
        b=dUWtQc09TwCh7J9ZwwF8CvIr+duZPXIGECM0GS0X+enAJYsXsonsLTs2oDXVOSQSI8
         XGXlaz5NjrOCmHBd4o37OnVb14+RTcmdCVuh9tqcCXad8EZFvMMUh97wR++UEYaPCYYy
         RmPzz/SyQHFq8ufmYGr6kwhXFKIuJpxBYHoykmx1wTr8dE1Q3zt4p8UHTyAXG2L63eDw
         LHi21CKzngBAVS5LTPEJ0XE5F42nzUMpvalw+m9fim6gT6ljlGWV9sXkEgq4Mt1HuPNG
         6QD+W1+3UwpTFsl156j3xckQR631M9ckBI2XpOQVG3Nz/Tx6/JUMQbeZiL4oEfecNR/r
         TpwA==
X-Gm-Message-State: AOJu0YwMWkOfo0xqdKdlO8GblfLMcjFIurLRRj3gG8bI7n5Qei8UYV4g
	tn9+zseZi89MMtNjivjE1gpUf6uD+94Nsm21uF6xo/Nr9kD31zNDk60J3YFb4tHGenovmoHhyNQ
	B+68E4OJt
X-Gm-Gg: ASbGncuCASWesinheIcMrCSliyy7h5Gdj5LUDIza9hpczAvyAEUPOTl5OMDGlOnWpRM
	beA/imbBd3wbfTN8qKW6P5zqf/XPiYFA7bnZrZhDkBboVAWl/3zjIj6QZE4HKPF+RGAS96Z+e4c
	3fv1N/PEQaMHsr74kMUQ+I6pIcJZ72+TL3FNkQQ+52R0yStloeiBpYAIiiBrA/uvQTy1lsBTm/e
	y3wA1XqDnK/W37cQg89YlwDVrSR08FAAm8ln/jTn70xESDhSOdVFLxpt8/XKjQQRnPBkygI7Rx9
	rocBH8Qj0aM5XCsVMLe8k7A=
X-Google-Smtp-Source: AGHT+IGkAqb29ObwLsStliQ3X+p82fx7N71ujUtJWUx9Mh0vkbbBSuYVWVgq/RcqBea9q4sf1SX4og==
X-Received: by 2002:a05:6512:2344:b0:540:20eb:80c5 with SMTP id 2adb3069b0e04-543e4c2565fmr6341236e87.37.1738498568556;
        Sun, 02 Feb 2025 04:16:08 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebeb0a4esm950663e87.114.2025.02.02.04.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 04:16:07 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 02 Feb 2025 14:15:58 +0200
Subject: [PATCH v3 2/6] Bluetooth: qca: simplify WCN399x NVM loading
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250202-rb1-bt-v3-2-6797a4467ced@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=XL7ng8U88IdS02LpqkHkwAED27Q7ZWUI6j1I8zn2UOs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnn2IBLOuD4AebbL9VEvX8M3u7zFk8VAl9gGNdQ
 alwF5QoryyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ59iAQAKCRCLPIo+Aiko
 1c7XB/9loxRdO1eIDrFUhixVzmgXgsB59i1s7L7w88DJXzg+vTbZ7lC5QDBnyZP6T+XNLr3SZ/0
 qA+mMVM1Gu36R1ereCfMUgQCm3kfd+KCkYq1lQCjew5UxQC19mSU6UXmRQ+9QaY3iK63cgaf1ua
 PahJOxwqmNyGBi8BilFp6nLftFFiLLQzGorraEs2Lum8LOd18X1sPV6fv66Fhbp2xuFa5WsHZbd
 wJujrE8PgFeOnjtxYLt8crEUMwl0y1/b2ULnMKZ8rmfpwW/scXcH8HJ0PnTZFRNp6vEWmKYQHk7
 0RBh2sM7fMqwb3wWlJVJ5f0EgRDT6DLHmaiCgGZi74ajIrv4
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The WCN399x code has two separate cases for loading the NVM data. In
preparation to adding support for WCN3950, which also requires similar
quirk, split the "variant" to be specified explicitly and merge two
snprintfs into a single one.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/bluetooth/btqca.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index cdf09d9a9ad27c080f27c5fe8d61d76085e1fd2c..7d6b02fe2040ff16d9d62de683571e1e1900fe85 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -785,6 +785,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		   const char *firmware_name, const char *rampatch_name)
 {
 	struct qca_fw_config config = {};
+	const char *variant = "";
 	int err;
 	u8 rom_ver = 0;
 	u32 soc_ver;
@@ -883,13 +884,11 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		case QCA_WCN3990:
 		case QCA_WCN3991:
 		case QCA_WCN3998:
-			if (le32_to_cpu(ver.soc_id) == QCA_WCN3991_SOC_ID) {
-				snprintf(config.fwname, sizeof(config.fwname),
-					 "qca/crnv%02xu.bin", rom_ver);
-			} else {
-				snprintf(config.fwname, sizeof(config.fwname),
-					 "qca/crnv%02x.bin", rom_ver);
-			}
+			if (le32_to_cpu(ver.soc_id) == QCA_WCN3991_SOC_ID)
+				variant = "u";
+
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/crnv%02x%s.bin", rom_ver, variant);
 			break;
 		case QCA_WCN3988:
 			snprintf(config.fwname, sizeof(config.fwname),

-- 
2.39.5

