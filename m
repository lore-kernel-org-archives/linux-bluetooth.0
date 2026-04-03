Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876C738A71E
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775224525; cv=none; b=RAVGfpWiW8rT05FHrNnoeDvtalhrsSRqcQsVaA8g/D8HD5PoXcnpw7flkVFyaMgWSg2untAhHR+qbFU343ud9/vk0pKQxVygN5/jfIfwEX2vXnss4HGyiF5mIHnRTvKkUkUitPHdGflstIo4WOFk11zCkHxszTiEImdQhQENxKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775224525; c=relaxed/simple;
	bh=0tNxjU9iZ5aS9yMEJ2ytUcRE8/Wq0mJ0XVTDTTRdWIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mgXZA8jFq5DCT9vcO1jA/6WVwrrqgKn2NYyaCpjd5Ja1OlOqJM7gAuRamAoyV3nxAEXf/+U4DK3WADzKOtPNOYMMkTr5lp9F8tzQKhbdLt4mWx7tW6elGy56fMfaPyD0b2qm3ucxSxtPobF4EJoUqnZIeSmK+6ID6/R2TC/OESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=KrQYnLGJ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="KrQYnLGJ"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b941762394aso251675566b.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2026 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1775224520; x=1775829320; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUIw5PfzjSbRelAWl0scbWA1aw6NDc9ZPR21LqC1P6U=;
        b=KrQYnLGJl8pxYlKkbPv9GaBQcgH7Y7ofkMb1Pw3P+0GjxqB5fvtUWPGvcZwiAFnCs0
         DuLXU+rRbGOsMHYMSnNB6rrP5f3ztFFAl3iLLx6oSj8/1O9h8eGTIEdHl0B5C4W/Uhm3
         6I27KiVMYAjLJMGvJhYYXHdbw75LlDzYO/zeMbFylWp/9lCJm7owH97i7ZqzFfEPwIPH
         gBa4Z0c30OoUTPGg0ZP0kd5pvVulkGg+lEF26Tfu0ZrPyoCrr9iSCS9oh4DYN01eC77H
         hxDPbYoH0BI0fWsdLzyxKvvugvkw61/i90HJFzPa/Xj527crC33BOwt1A+slwaxsLiE/
         COVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775224520; x=1775829320;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JUIw5PfzjSbRelAWl0scbWA1aw6NDc9ZPR21LqC1P6U=;
        b=LfXsxcOtYcsG93YLisUINNnZuooTXu9dSIbfDmMFuBAZUzwSylEZzv5noulBgoNu0a
         bW3meDEV8p39pkBEEaUkGGKDWp97RaapDbSzfCwko50VvEerVX3qnqKj3CX2hCF03Km7
         p/g4go8CvnmwbCWwOgA8+u78jM11I33rDpFK56vUPrBjU3em9i0GXNOLHGiYlHgDcVTU
         ybQHZe3yXu+tC2CaF6x0AzGQuche5LjamK/LSm+Ztn2yQGCt9A666f08YI1L9RDbp4wJ
         xGN29sbHggvwHqBhwhgg9knUPadyhjDOtqiUHRlStUf395h+V19STRRENWLiXW4GjpF+
         Ro7A==
X-Forwarded-Encrypted: i=1; AJvYcCW5vORgOprnbOWM4PPQT886kNRkVTjLFDOAk2Gt1ZO48ICjacYfirjs0MvbjYAuhRemzjL/E8RtrUM8DLxZ/9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrZ7UMI7x3FpHMvhr/LjgGlN9kTfjDl/7vagvCiRefRxb+g1dn
	oozpBjPca8NhuDYGgtSJt2k05w/w6gLu/AuERAOchBKQJvVN4oI03cpUkPDsAbz1q68=
X-Gm-Gg: AeBDieuyIGzkRf345VQbBNKyDjTgUL4eGqox3eWqTsMy72PKZOkBkUSg66BvmDMAUp2
	PoL3D219BKIK/pdGLjDU/P58P/WsiTB6HRNebmb+CxZ+FBCoynWPLs5n66XdxkdyhAf5CdwSHtF
	izGY0ACbSdsjxXHq6mx87IEE/CCJn0zsby2yOyX8aQUXBcK3ta0t5Vw04DLxh2JhocCTxc3vlox
	TvFp8A6yvq8O0XxFDFKpAHhxMaw+/MagYaRQCxkBMNMHYuwjkWaKsNuokiA/BNPJMPMHDefPf9H
	TrgynUO+2UnaI7GQOyS+jCMHYgKAXH3NIhHjXewjOf7Ukb7QjSETb49/ebJPx5bi1oJQw2MPmHl
	2YkMn7Ra+6qBOUkLBVAIWqFAQTq+ySEdAU4ryzr0bhyGW+OrtT1KrlJiBfC5acOv+KXVZ3y2PN7
	h/DXSFh/Gyh67Jo3OxKFMbv25hftZF0XJoKoQfLMt+ivqa+y5LyW2WL8gw8Rs0DtjjXFk6M4UZL
	YKiq+XpezcWAV65S/tGOnrAewOq4EsQDKhOwA==
X-Received: by 2002:a17:907:9711:b0:b96:e593:fd1e with SMTP id a640c23a62f3a-b9c66e5e2cemr156799566b.0.1775224520390;
        Fri, 03 Apr 2026 06:55:20 -0700 (PDT)
Received: from otso.local (2001-1c00-3b89-c600-71a4-084f-6409-1447.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b89:c600:71a4:84f:6409:1447])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c972e28sm198057266b.1.2026.04.03.06.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:55:20 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 03 Apr 2026 15:52:50 +0200
Subject: [PATCH v2 4/7] arm64: dts: qcom: milos: Split up uart11 pinctrl
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-milos-fp6-bt-wifi-v2-4-393322b27c5f@fairphone.com>
References: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
In-Reply-To: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alexander Koskovich <AKoskovich@pm.me>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Jeff Johnson <jjohnson@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775224512; l=1487;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=0tNxjU9iZ5aS9yMEJ2ytUcRE8/Wq0mJ0XVTDTTRdWIM=;
 b=/YToNUqYXJRAKqxJIRr0r/cZTobsLFymsg/TVbH46bVWMTHSJdm7XRvdUpgk256TWrcMjxZzR
 nOrivC7LfVFCc3S9aQe2Xi11CK1Ror8u934bOVKDYcB1HNT8BXOHYGt
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

In order to set the pinctrl for the individual CTS, RTS, TX and RX pins,
split up the pinctrl configuration into 4 nodes so that boards can set
some properties separately.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/milos.dtsi | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/milos.dtsi b/arch/arm64/boot/dts/qcom/milos.dtsi
index 4a64a98a434b..71292dfd6e08 100644
--- a/arch/arm64/boot/dts/qcom/milos.dtsi
+++ b/arch/arm64/boot/dts/qcom/milos.dtsi
@@ -2099,19 +2099,27 @@ qup_i2c7_data_clk: qup-i2c7-data-clk-state {
 			};
 
 			qup_uart11_cts_rts: qup-uart11-cts-rts-state {
-				/* CTS, RTS */
-				pins = "gpio48", "gpio49";
-				function = "qup1_se4";
-				drive-strength = <2>;
-				bias-pull-down;
+				qup_uart11_cts: cts-pins {
+					pins = "gpio48";
+					function = "qup1_se4";
+				};
+
+				qup_uart11_rts: rts-pins {
+					pins = "gpio49";
+					function = "qup1_se4";
+				};
 			};
 
 			qup_uart11_default: qup-uart11-default-state {
-				/* TX, RX */
-				pins = "gpio50", "gpio51";
-				function = "qup1_se4";
-				drive-strength = <2>;
-				bias-pull-up;
+				qup_uart11_tx: tx-pins {
+					pins = "gpio50";
+					function = "qup1_se4";
+				};
+
+				qup_uart11_rx: rx-pins {
+					pins = "gpio51";
+					function = "qup1_se4";
+				};
 			};
 
 			sdc2_default: sdc2-default-state {

-- 
2.53.0

