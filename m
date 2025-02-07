Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FE21B4235
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Feb 2025 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738960890; cv=none; b=du7NdqjQI5NSksErwgmtgEhl4Mr4k091oWlJNQyqOpq5lexIGi+U+mpNHSrGwCEOXCC+qhIVN+IdhBAKwIjw87gRgSwGAP6VRBlh0bdT2sjUxTvdJcRW2hgzfc6B9jm2+AcNZgQGLOSgxRMNdg6zUmLCyAvEpDYq0LZbexx/uog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738960890; c=relaxed/simple;
	bh=XL7ng8U88IdS02LpqkHkwAED27Q7ZWUI6j1I8zn2UOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GV8E4jgDXSLm1AJ6iPk9ly8G41U+YvNFDO3GFNNRwJja9i0o5SmAQD8ewxVCuuzLVfEGWZunqqU5MvSNz2piT8td/0Qfr09GU/rFHZlHuZ2ofzJIRbTrSQvlAa7rfDp2s8MQPNqJpscf2ALEM16hK5lyY9b3DBqbD1kaA9ggNTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d4XS0pQS; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d4XS0pQS"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-308a559bdf7so10018421fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Feb 2025 12:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738960886; x=1739565686; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0uDfHhxafnqOPaFWheOWVq1hqVSH+SO7a7CETbeXIaY=;
        b=d4XS0pQSQOVbWw+0OUFGpQe5k7aWUuvwgIqxk+3dclpyH9J3KD6bTfNuaG3xBE3a2y
         JUHP/7esVvfygbaQPZxAOusPcoieHOCnDArnnar6ucfknzaRbCTsKdopv7y1Xj595wHz
         vYARRZ7VBIxkvWEiQgWmrPMUhS6AaWVSC2AP9E7dW24rFst+9SCy7EhPtJ/+xEjDcMoO
         l0eY0MprFGVAhsAzxOJ4+N4c1qvy7liEmscNMfbVNn6arIUS9Swe6zwQpOGgXIJoaVr7
         vc8q4TgmhYgCRi4mZVxssjgEZr5Eux2SoW6VqYVod0jPdPwWLTito0FW4XXrHdNx3vte
         KBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738960886; x=1739565686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uDfHhxafnqOPaFWheOWVq1hqVSH+SO7a7CETbeXIaY=;
        b=fKgl6Rkr77YbXWBM1n/jrW7yMTbqQluDJhYP56220S3QBT+eNDy2/x25GI79QG1c+3
         StAyaffVLrXawACPB+0Z116Z8sV3RKy+7aUYWIryevAXhX8CwTMLf9EyxifwbYG0T0f6
         5dMRPYuRodNLW+RrKHiswITtbjaH06/IY7I/OpaisoiCjjcHvWP/FOonzZh2pVVplJAd
         iy4kGxvyrUTq0g3w+dQSmUiDrSuHwQ3xUkUuVYGg9obdl0LVO6qC2v4I4+D+bdbwOiUS
         gE80mauHBeqTOHOUjuIkQpFdEPHwZrTnoWM+vallPR+mQWzg/OZZCHGZZtT5wxt+eiEs
         vXag==
X-Gm-Message-State: AOJu0Yy1OygjJU+CtHu/QHEuaL0Nm2m9g4Pd1mlvDHsOq9VG0ZjpFvdM
	dUekn3VCXNzkAaq2vWAQVe2/s3uzD0QIig215xa27/GEcEuRGK6cvsw2yE14jPDiu6aZ65RyfPm
	Xy7I=
X-Gm-Gg: ASbGncv/5L4/shcH7hXlI/fIQp/7YyWJ6UNY05ycUAF4RmzvZ37av4ZQq9vm+qnVXgj
	/JEhRsghSrIzK0Ck2rVoae13U/6Gvvsom0lylWr8j3zNKEGOSgJTF4HfYHMfhAGeG8aR6JpxjMp
	CS977Qmj3W0cx5VCNgp6FtKF2lAK26NE238bs3qZSm00Wu+aDbkZepGyoUcFoTy0fCrwsxfYXO0
	MlmOerm9jNkyG7XkMNQ+jl3272wyIhulfoc3DCeZHpw4tG0Vcb3oAFHI8t/8gBd/D9uOzKVkYlj
	/efdI8uMR39nO0wlR7rKQlw=
X-Google-Smtp-Source: AGHT+IGtmlenPKj9LmASZRzoEdDvspUQmr0gkUf8MuzFWT3Zd9xILG1u2wmFj5LYB1kI0k75o0Hs3A==
X-Received: by 2002:a2e:7d1a:0:b0:306:1302:8c7a with SMTP id 38308e7fff4ca-307e5a8de31mr12160461fa.36.1738960885956;
        Fri, 07 Feb 2025 12:41:25 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de178628sm5343811fa.10.2025.02.07.12.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:41:24 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 07 Feb 2025 22:41:16 +0200
Subject: [PATCH v4 2/6] Bluetooth: qca: simplify WCN399x NVM loading
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-rb1-bt-v4-2-d810fc8c94a9@linaro.org>
References: <20250207-rb1-bt-v4-0-d810fc8c94a9@linaro.org>
In-Reply-To: <20250207-rb1-bt-v4-0-d810fc8c94a9@linaro.org>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnpm/u5muoe3WwA41QWOGX33TQrFVTMesUiPrQ/
 9pnIvcxGl6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ6Zv7gAKCRCLPIo+Aiko
 1dwNCACV+YYSREIUcBJrFra5aFyY76q3gLdPuk6s/5St8iZfxf3G5YLyCuDF4Ft4t4x/KlxZr9o
 rx85D9wg1EtUZTtqSYUkty900t2wUt5/jqsZ29LWTuvEPjHNYXx5Fxw+b2/PwC2gPNhLjWsM+LA
 XtlyLGXBH0eGlfSx/vKycONM06vPY4qImK5bt6x8qFMmvXLqQ3y7++Lt0H4rE79TrSvdY1XuYsd
 aMJzzVzQMf6NVzPTiycEqafs2mv6KlO2bUvWny0wfRctl0B4G3cxE5HeJJ45105BTKbWJrocosj
 KoILNJI8aj+AvbzAyIqQnvmiK/AKfFShcGr8DpavtFuV7gha
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

