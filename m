Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CFA15B120
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961793; cv=none; b=YGUPzBRTAcp9jRtzUXvUQ+NCmmksEMeiyd7uZ1hKF1gRcb+pyiPyEGuYvyo9oMNLk8FlMvEL2JHsDX/wz6AHA7iNJ5NK7G/8rJguZqtH/thEa+gh4NQ6PVrnhQEhw8avZ2JSKmxfG4Cg/+F8tBA3YeGyidkF9oZF/NaSjumzlxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961793; c=relaxed/simple;
	bh=I8JHcqSr1Mqm7BxNvH2G+ew64E3zN8ICLGLmqbFjLoI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MRrxKYsXGEWlU+1Nc7n7Hc6gw5BQpNMxYiz1h8md8G2Pbx3U/1drAmOeGNGdpA/+0S+7ZCNys3bh6hwz4JExJLaqiSpAgJEmHpFui35p6t1P62LcX3T2eKS7uyqfVHOIoovIWlDMFahtCfHgpjTD3gpyV5hf3YWT4y1CpHIkxhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=C4vQJg1T; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="C4vQJg1T"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41a0979b9aeso29762775e9.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 05:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713961790; x=1714566590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vWtmZ5PdQ7AkuvXH/covTAsvSmEpguf1BcHW30rYhQ0=;
        b=C4vQJg1TpP8a14iLjHwwhR+MjDugh8eae4psu05cVhOkiCr8QxolaiDPb2ACb+qrv0
         PCrsfaspVAoS3bs6NerwKXBiEl66JMDmje4fCj0+m6S1aC6IoXbjlSp2YuSmBFH2BZp6
         ojiYE4s7otKcnnAeEtyo5FyZMBUj+ZtV55oq2oA4YJVuJzSDp8eSr5FXHVkb/S+PXrVE
         EZYB2iT7iOjqMGYSO1597ayqOOHVvLHxFF/a+PG7NKrzKNK2EigLYz6Y02qCaf77If2Y
         b42j5GX3sd1xsLtAmV5GpU9lgOTevRXnAS3P8faXdVXuCPOqgkMQwN/jN2DWk80Nh+jf
         QxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713961790; x=1714566590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vWtmZ5PdQ7AkuvXH/covTAsvSmEpguf1BcHW30rYhQ0=;
        b=d66vpToD/tB76hK8M1gUU/f304Bf7fSxCgabKNITYhCpYsE+ULUGU8x2Q5a5rw+STy
         qR2Jij2TldXv9ODQLauHBKPXUIJaEwTvXI9x2PXg1Fr9qdOxgbjdZ9Cl0Ij7HeJNoPGm
         E4krO7RwU+Uyn6xm1yhaXPocw832zGFD4lnpC8YY9EYgqTjyPyXeyIuJofUNLRPOkyDl
         4kM51fRiniSGfXaYyhZCvG2q4n6i9VEpz/ll30C8DoV9UT2IyU2baJ25FCIS7NBbm55P
         uGY1I4tjgtF4eZaKqw/7qbtPh+Z5H1Ec7qFtiWh1KRcy/D+PvwlSf9HB9y7es241fztI
         92vw==
X-Gm-Message-State: AOJu0YwRsQOyP7TyBnAnKNMk+X+w9tz7HnKe1ns+u5eXTsu22DAIERVi
	dBpYpgyWGu4wXyoaSDf5c7jpg0csRHmpDszIpCLBpYB/9vrr8BW7gow7czcEN9E=
X-Google-Smtp-Source: AGHT+IGulFqaqD6gbOE1TUdpd2CJEXWTKn3weFW0kCzg+pu7D4O+Rt4yeRNvsqtF0Ix1d6WsHfoE3g==
X-Received: by 2002:a05:600c:1c94:b0:416:3478:658c with SMTP id k20-20020a05600c1c9400b004163478658cmr1792376wms.27.1713961790457;
        Wed, 24 Apr 2024 05:29:50 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:da66:dc78:acc5:bb9c])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b0041892857924sm23750712wmo.36.2024.04.24.05.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 05:29:39 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Wren Turkal <wt@penguintechs.org>,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL returned by gpiod_get_optional()
Date: Wed, 24 Apr 2024 14:29:32 +0200
Message-Id: <20240424122932.79120-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Any return value from gpiod_get_optional() other than a pointer to a
GPIO descriptor or a NULL-pointer is an error and the driver should
abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
power_ctrl_enabled on NULL-pointer returned by
devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.
While at it: also bail-out on error returned when trying to get the
"swctrl" GPIO.

Reported-by: Wren Turkal <wt@penguintechs.org>
Reported-by: Zijun Hu <quic_zijuhu@quicinc.com>
Closes: https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com/
Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v1 -> v2:
- also restore the previous behavior for QCA6390 and other models that
  fall under the default: label in the affected switch case
- bail-out on errors when getting the swctrl GPIO too

 drivers/bluetooth/hci_qca.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 92fa20f5ac7d..0e98ad2c0c9d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2327,16 +2327,21 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855)) {
 			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
-			power_ctrl_enabled = false;
+			return PTR_ERR(qcadev->bt_en);
 		}
 
+		if (!qcadev->bt_en)
+			power_ctrl_enabled = false;
+
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
 		if (IS_ERR(qcadev->sw_ctrl) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855 ||
-		     data->soc_type == QCA_WCN7850))
-			dev_warn(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
+		     data->soc_type == QCA_WCN7850)) {
+			dev_err(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
+			return PTR_ERR(qcadev->sw_ctrl);
+		}
 
 		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
 		if (IS_ERR(qcadev->susclk)) {
@@ -2355,10 +2360,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
 		if (IS_ERR(qcadev->bt_en)) {
-			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
-			power_ctrl_enabled = false;
+			dev_err(&serdev->dev, "failed to acquire enable gpio\n");
+			return PTR_ERR(qcadev->bt_en);
 		}
 
+		if (!qcadev->bt_en)
+			power_ctrl_enabled = false;
+
 		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
 		if (IS_ERR(qcadev->susclk)) {
 			dev_warn(&serdev->dev, "failed to acquire clk\n");
-- 
2.40.1

