Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832E8155315
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848264; cv=none; b=Gi1oNqt+cASQcq5InggBRElhGilbdv/7AujhhiYln0KcuWp/uuabE2hHsKgcgXtH1R889IgCT5oxrAfeOCYYAGaT35nSefT7IH6uYHlCN83dbh4v4xaVdVpXf7aws8S0+xLdk+yr2Uedrjkt36YEmWFolkkP2sqMz5y7kM37ekA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848264; c=relaxed/simple;
	bh=RjrXaB43FNpiPz5wCGH2K5IEQTOlqgjA/UnGaEOyoz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AuGMI+4x8Bsm2sjqa+qz+iGpRs37ND7VPA+rpzG8U3Vy8zw6MSCh7XTRdqYihnlCupxCDrpbXhQhfCOGOAfeyEOL/YtR/5VwtDVPm7Go1G53zAaXE3vNooKNYEQF/uuRyO3bzHzgOQSx9CrYSyGx4TuvwDGp+7VKABOrp26coa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=aBx/P/U8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="aBx/P/U8"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428141be2ddso68922845e9.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Aug 2024 01:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722848261; x=1723453061; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfVnePU1U4lqoUTEVw7bELLkGGkHu7U5a1JhcdSjQFY=;
        b=aBx/P/U8vVUGqNcsHmx5vhkLq86xpLwSOl91+8IBW4csBwUlzoQPfEz6M7EwN6G5hk
         undpSKlpyVUe0fTKl2qzINlu64+qT5tjVG5IzCblboYpcUmH0lBNLLqzyVZ4v61cCJvh
         KWMbQ1k/IPapHN3P2DCzlyLtmnbhyVrZLd+KeYPbllbiSoQUfj0dmOhH2Nm927K+8xV6
         h+TjzM65emZuWLv8gbcoqyyXCTpRJ+ka/TCUxNiBMAooq6re5Lei8hm4ElklXq7gUape
         GXqoLQ8l7Zh/F37CUNbi/Q/2aUZG/xgYTwZ2GTuqdXDC5OIvTd7qd1Hzfgjsxxkt4EIJ
         KknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722848261; x=1723453061;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfVnePU1U4lqoUTEVw7bELLkGGkHu7U5a1JhcdSjQFY=;
        b=CMuNPXKYK6519P7wcrPq3sTRIQyL/GsapnOf6EoiK7X9RyO2kp0ops6YHQ/nvzTd+I
         RAds17EJO7gdXgGiNkkzuixPhZ21a3ajslURcM9rRgEyR1VNO5Vpjug7orh80IJtUcSQ
         XBqifNmCpgHcJrQEcX9kZJPlDd41qK0uIUvRljmP7HvdSyKLlzKNjG+8xjIf3H93F3qV
         xGzuTlXUFE50X3AD8UiJtnocSBjwzcw91H6lv7tDf3maMG2Hz4xe5zRUfo98uMBwUoMK
         rUt89zsGmtdLmTfl6wrFAkd4VeG3DRRg7OFYR/49JKs6/kLpQeH2975TMBon7uK2mumn
         SuMA==
X-Forwarded-Encrypted: i=1; AJvYcCVGMackpm4fOkT6QIlDnADc+ohlK/mgZfZC9SHTV7EdrxmBsZA+3vE1sNxJ8Lb4nqgm7wGDUdlOC1jpV6qQRiYvQZNz8mHmQr/1N9D7SDWN
X-Gm-Message-State: AOJu0YxoUGYD+YMMPsh1MzDh7mzvSueEhclwz3fnA5Y9UuXeKJFbrUa6
	xMYgRrqlLz9br9uRK/LmuCBfcM1UFBWGG8a59WyMywU+hDPwGXO5T8BSAwrFTl0=
X-Google-Smtp-Source: AGHT+IGKl1UyFCDoUX+r1c1fIZ2IpJPAXvxIgAXf1ueFqYJcbwWJ/qwRwwpv4BKDHTmhHmCCt7KoRQ==
X-Received: by 2002:a05:600c:4fc9:b0:426:6f27:379a with SMTP id 5b1f17b1804b1-428e6b08fc5mr72683335e9.13.1722848260565;
        Mon, 05 Aug 2024 01:57:40 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:1068:b792:523c:3f73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb9d786sm190235665e9.44.2024.08.05.01.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 01:57:40 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 05 Aug 2024 10:57:31 +0200
Subject: [PATCH v2 1/2] clk: provide
 devm_clk_get_optional_enabled_with_rate()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-clk-new-helper-v2-1-e5fdd1e1d729@linaro.org>
References: <20240805-clk-new-helper-v2-0-e5fdd1e1d729@linaro.org>
In-Reply-To: <20240805-clk-new-helper-v2-0-e5fdd1e1d729@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3433;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=QK9lIkgLWe2exxp3dFkUI/XLIgdmyowp3vZgiOokUZo=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmsJQCSVTssWuLUdAD5uSg13OUot2SX1RwmQ8k5
 u2csx2SfWCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZrCUAgAKCRARpy6gFHHX
 chfSD/99IX6hTwu8Gs17M7ZkqEe0Q5mP7I1wLEfKe5UmeBXmMQCaRw2woFzKpTw6rUmoCh18y2S
 +w94Oq8Rj0zUU5sv8IrFUGQLKF7raf33pQ23UqctXdqkTJPbu5L0W2b/tPtm1D8JMYY4DVle5r9
 E9zvJipdPxtn+8z0EKbSvKk3vhNIrBJNeEdNw074FauUX8nXPkbtvpDc/MXyw/A3Zt/xocpgH7z
 fQHt97/SLxKE1g5buSmy5m1M0G/bcy1NpAc2y/OUj9V6nrf9k/LQVvzmjOhVdWpNurkCmW7IiwD
 5ohUx0K62FbpELUcjCBNfn+D+gPtGcF5+JN7B9Gpwz+fY9SIsXg6AvOWKyHLl/m5TGLDk3aH1eg
 CP3XJ8zBf9uax6RZ7IjT/kuU+HJi2aT9obtb5852Uy2cxrtnzOQ9+OVm7leHNKeOs2Id1PWDFaJ
 kzxN2JoV7845C7Pok/Wcjz2yCbDN1OUVCyshdosDkv+Q0RIe6Qlg+qpS+GHocskFURqmU9oOtmK
 7+Jy9NgT/Jaoy30NmD9d2VfE6NJ8AUERlfm1CgpvlVo/HigXdKTX6bzK18dHkYwYaDhoThm+H/i
 Ut1jXnI4SxfZbttwCVNmsN6lMvoheBLSoMTzYSS39V+n4W8EkY96cgebGrcBRtLS+zTw77db/gm
 pB+X40l4HGzaWrQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There are clock users in the kernel that can't use
devm_clk_get_optional_enabled() as they need to set rate after getting
the clock and before enabling it. Provide a managed helper that wraps
these operations in the correct order.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/clk/clk-devres.c | 28 ++++++++++++++++++++++++++++
 include/linux/clk.h      | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 90e6078fb6e1..82ae1f26e634 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -99,6 +99,34 @@ struct clk *devm_clk_get_optional_enabled(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL_GPL(devm_clk_get_optional_enabled);
 
+struct clk *devm_clk_get_optional_enabled_with_rate(struct device *dev,
+						    const char *id,
+						    unsigned long rate)
+{
+	struct clk *clk;
+	int ret;
+
+	clk = __devm_clk_get(dev, id, clk_get_optional, NULL,
+			     clk_disable_unprepare);
+	if (IS_ERR(clk))
+		return ERR_CAST(clk);
+
+	ret = clk_set_rate(clk, rate);
+	if (ret)
+		goto out_put_clk;
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		goto out_put_clk;
+
+	return clk;
+
+out_put_clk:
+	devm_clk_put(dev, clk);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(devm_clk_get_optional_enabled_with_rate);
+
 struct clk_bulk_devres {
 	struct clk_bulk_data *clks;
 	int num_clks;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 0fa56d672532..851a0f2cf42c 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -640,6 +640,32 @@ struct clk *devm_clk_get_optional_prepared(struct device *dev, const char *id);
  */
 struct clk *devm_clk_get_optional_enabled(struct device *dev, const char *id);
 
+/**
+ * devm_clk_get_optional_enabled_with_rate - devm_clk_get_optional() +
+ *                                           clk_set_rate() +
+ *                                           clk_prepare_enable()
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
+ * @rate: new clock rate
+ *
+ * Context: May sleep.
+ *
+ * Return: a struct clk corresponding to the clock producer, or
+ * valid IS_ERR() condition containing errno.  The implementation
+ * uses @dev and @id to determine the clock consumer, and thereby
+ * the clock producer.  If no such clk is found, it returns NULL
+ * which serves as a dummy clk.  That's the only difference compared
+ * to devm_clk_get_enabled().
+ *
+ * The returned clk (if valid) is prepared and enabled and rate was set.
+ *
+ * The clock will automatically be disabled, unprepared and freed
+ * when the device is unbound from the bus.
+ */
+struct clk *devm_clk_get_optional_enabled_with_rate(struct device *dev,
+						    const char *id,
+						    unsigned long rate);
+
 /**
  * devm_get_clk_from_child - lookup and obtain a managed reference to a
  *			     clock producer from child node.
@@ -982,6 +1008,13 @@ static inline struct clk *devm_clk_get_optional_enabled(struct device *dev,
 	return NULL;
 }
 
+static inline struct clk *
+devm_clk_get_optional_enabled_with_rate(struct device *dev, const char *id,
+					unsigned long rate)
+{
+	return NULL;
+}
+
 static inline int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
 						 struct clk_bulk_data *clks)
 {

-- 
2.43.0

