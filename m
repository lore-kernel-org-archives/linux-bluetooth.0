Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3D11CACF7
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Feb 2025 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738430959; cv=none; b=cM++6qr8UE48/dQ54yQR6m8mUw10+jf+GPPcllt+iVjoTSUE6TgDMS4xoSeq0fsCkfoePDiNFCSzdeY42JvLnNsfcUNsdL9/cqQYS+A47nIbEDl/nnI6IPjG8wUpNVBTgy7kkkVYC8krkCjJWJse9Izn2J3m9Rf4N6UUJTzQAxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738430959; c=relaxed/simple;
	bh=XL7ng8U88IdS02LpqkHkwAED27Q7ZWUI6j1I8zn2UOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p3ke4usg75HCAqoZHwe7GPXunjyIkQHUqFebQ8J8Vssuu9yh1925f3mk/FaoViEy3RCdaFbGeIynuXq6V/m8mylxviD4odPtXPbKl58GhArZBqm7vJh2gqklN38+A+xlXUMGfl5lhDt1MbAXy5VPfxjQtEwtxas0lfiws/NkKJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KfHwvFmB; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KfHwvFmB"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30615661f98so32636581fa.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Feb 2025 09:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738430955; x=1739035755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0uDfHhxafnqOPaFWheOWVq1hqVSH+SO7a7CETbeXIaY=;
        b=KfHwvFmBZyLa2PSSusFUe30jY6VCcqpEH06RwFDkfRoCLpv0VUvd2s2/DuUq9KEYjh
         8YzE4kmn5e3I5uAzjdoOSt2pttJp3K6TeHq77vQYwjbqR28ujLGBgtIzEDD4JmWszZYc
         bq3iAREoPL1aitzvK1ZMOciiY8DZKTHWKBK1Zxcu2gaLimhG2VXltOdK14yggJtqZxA9
         fx8Ivtoy/L7Ct7CY9VopzPehhRGRGzdb2orqvtYAxOOo6S6fii4gUqZ2KroeeeuoX80I
         EJ4f3P6ZhtxJe9efoZEzcxhuV1x4Vmi+qwQavvqTm162yvWTuiPYlYEiPGbxlQBAYoV8
         36yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738430955; x=1739035755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uDfHhxafnqOPaFWheOWVq1hqVSH+SO7a7CETbeXIaY=;
        b=VsPadgwgeR3j7kDfeByLdecCA2tPAaUeOlyIWNR63Q8FypXiqkwu54ChvP8TcWuoU2
         PHoEevIE6vMgPyXw+T4cUINIU52djiqNxTYl0twjfoNIb+VKPb3LgzeduA8xOqm1I+jP
         k5lUUAMVMdNUL/fJqQo/nhM5GtWBbLl5lWSfkRBb+d0QXBG/Yg1hzimnSHLCusBVKgnn
         WL8AbpGDVxaS67zRq/MrdT0MhnoRrwp0aXBK2romhfqdI5zIjxNjohrtmSCxj02d6IvC
         DupwsuPA4V5PDlJNfHEI961wcfOGpAJt/6IdiP4CHE5kkCpLVJzs9AmSNT5HspU7ON2/
         7YDA==
X-Gm-Message-State: AOJu0YyA/kUh1RbYtuHoRy4qGG9iV11OcICGroVq7oL/tdlyC7aoBngZ
	ssHT92h+8x3v6gUxtkshYn6ONhrH2piSp85WNG4yOAPndF9UyRSTCD+JJHyewAM=
X-Gm-Gg: ASbGncv2OYgNDTx9Fj4Gegs6d1ppNZ68wvRJ3hgfuS0mkqpoUClVjX8iY1ndUJgV7tg
	58IPcdzQ/QcCk2P6C6G9pBibqVVgMTs25K6XqmOZ55FGKUI1gGdEvGRZXMdqitDzBgmTHE+Vbka
	tOzxiN6rhOamd6MMjv17sIR8pEjBvncA+Gv5uyTl9+LNVsftG31va4nj+bpVt4wqTt4IJD6lNSj
	YXx1SOniQLxw2uBXGdSzqs8x+sRrDqQLoeyJAWoM1L8g96jgMPLK35L1JCYC6ve9yA8dSgN/kEH
	lQC7xS+/1ObreebDdfsKO4o=
X-Google-Smtp-Source: AGHT+IE8Hr0IX1pCMwiAV7uh2gFAGtFlcOaMwnAab/6lNNmleqqSsFzR5DBmNYTKJ5CEK4pnv3A0/w==
X-Received: by 2002:a2e:a883:0:b0:307:95de:e3ed with SMTP id 38308e7fff4ca-3079695147bmr48071951fa.29.1738430955520;
        Sat, 01 Feb 2025 09:29:15 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307a3099ec4sm8852161fa.48.2025.02.01.09.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 09:29:14 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 01 Feb 2025 19:29:08 +0200
Subject: [PATCH v2 2/6] Bluetooth: qca: simplify WCN399x NVM loading
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250201-rb1-bt-v2-2-fd44011749bb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=XL7ng8U88IdS02LpqkHkwAED27Q7ZWUI6j1I8zn2UOs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnnlnlKDKbhsJaGXbR4PVQjNYuqdjhhv6ocj8q7
 i/6BfARIcOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ55Z5QAKCRCLPIo+Aiko
 1fYtB/41pLaxBJKwD+/915Gb2NS7XQyQthMPAb770YCfU+7esQ1bltInu1iz1OdsV1kglAk5BCj
 W6KEuaGZWEm2z0Gv/zn5v0tsRF00jBbs/Ve6Mw8tXVpq26884M8wuDbwOirVy6ZGprjRIKlkAQv
 wWAOtdyA81ML/lJqiv9Uub3AVIK6AyquLi3LZiq+eCd1wHObd6BNBaR77gBdpm7aAKgt03bliZp
 1AvX/WghLA+7XA8cl7LVmUeRZXOI57r1fUZ6Hm4aVAM6GPjVUy6+R7kKSqqo9TdmezMOYbXkLvG
 ahiheDRCGEiY/6KPled/jtQXFsx4W7U2n7bZvLMTP8FLjZKC
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

