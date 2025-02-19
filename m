Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A1A1DF73A
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956519; cv=none; b=Y0q4jAMvR7l0EJDHYggdeAoh7W0XW5/V3AOkOZDVDZT1RNYWmdXl5lcLD+sb5qzulHVWngukvtkpD9rIu65hnj1cbt9hO/FfNCdWTmYGMMIotGpzEILuY1DcKQw1rwspY/8gzzrCRy4e+VKIjM4vExQRv1TjEjsnaf382tqbyys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956519; c=relaxed/simple;
	bh=H8M+KioVJ28c5tqEeq6oBUoHWGJRZJgMO8fattyEah0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MjXlq23MhUcdEu5EtCw2T57sZdrYqu7YD2BfUiJvp5D/urUerXkeTpKUMTF19MAr/98xp4CAtwigPpVHlpy2EkBglS8kV6FVNHOt+pwe4VCaCZMW2vI8Am9DE3eupjnWfJvCzI3/QrIjui36eufqA/Q/2S+Gtb8jyKV4GxbeaNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hNti0nv6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hNti0nv6"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f378498b0so3191647f8f.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 01:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739956516; x=1740561316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vKcwOmcPKfivUFGu30SDPaYB1K0Ttk6s6NwpxGL2HUg=;
        b=hNti0nv6rtc/95pjS/R/gQ1FbAyoU67Srw8Hg8bmWFqnbJbBJezbyhB+7qA2NIcT6L
         s/o4nVlLaUXU01E6AyKFha1FYvvn+sB+VYssUFhESqx08kFi9jdHI0ncbegYe9Ca1VYn
         W+xOkrIkzzmH9p7xjYeqYKpRXvOY6kv0A0oGwxbU3uTj/fO1XmZ39tYckQ0sCNsqXXQr
         iy6uWSJxeiqQO/JYDeWHiHbmkB5xtYyN8NG0Ym74EoXOp2Pp2tJyCTEls7tuvPoXRJm4
         bPDu+pEAyBw2QabMhaNSyNB8M/Ne0aKgjpMDuLE83dgsilM/dE/J6veNz/zy853/QYgw
         eYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739956516; x=1740561316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKcwOmcPKfivUFGu30SDPaYB1K0Ttk6s6NwpxGL2HUg=;
        b=HRbwwFQp3Ruy1Bijsc+6hoRRJkcbBqtDi+RZCui4KJ8E++cAriL0mFxNYus6kRtlHp
         fdgpC2a55Ihdr2w47gMJpJASh4rIk7wBD8XPihpVNSYuxsaxsebaq7UXoTZNAporhKTZ
         WYxzyDAvBqVcd3HUE+yc79Y8q3yc63LH4eJ+DIO2JmJxZiWxGYJStHadEEwXMkzXbNQN
         UxgtengbFfP2A2GFhbPrOF9XaQ2ul+DKRrPTd+JJpDq7ussgXAN6MDxvk9fGIiVgKwCD
         4YoR4tlo4kKKN/yRps0v2ggzbLRk42IhKcp5zOjOTq3JtPolqzhlx6/XkqEMYOzK5SMB
         Ts+A==
X-Gm-Message-State: AOJu0Yx3szbvR9HMymo6gO0Hlq6pdfpWSXrvGkk1u+5Xgn/5EcQfnoNh
	kwnX3artbSDjeaUlrWWW7IQrGM6v+G4wHp/SgqzMBKA5LjeCfqChFFqqBlvdmOU=
X-Gm-Gg: ASbGncv/quBVOcanRQchCyZC90zoXexJ5NB+QPYVTWnxHYmba89KBdXgVNv4vXTU6Z3
	qA5cHZxgSpdTEMOnDD9ibmmEiJFAF0r93X+nAWJ6WshumnVwKLhlwvgGfpXFff3d4YxVwAbvq29
	cVYY4U1RnVNn895lH+LtvvjXP8fS3/7CEcXNf56bB0fxOQ3oLw/be1XtxW5OPu2ybBL1uJqNOeC
	TjFmYM6G456ecdg8aa/rNtp3239dK5yGVvMV93kPYcxe1LlHW2dJOjlolhNe96t9Wdjsb7vDg0t
	GtzLtaWLQJxxtIKMgc8eVf3XkCEzn8z/jA==
X-Google-Smtp-Source: AGHT+IETOPciWX74+ZE9Bl6l1lcO3l216e9P8MiGUAdRNpHGDW1StBCSDR5iTiLz9/q2G0qWR+sSbw==
X-Received: by 2002:a05:6000:1842:b0:38f:2856:7d9a with SMTP id ffacd0b85a97d-38f58782b96mr2427856f8f.3.1739956515874;
        Wed, 19 Feb 2025 01:15:15 -0800 (PST)
Received: from loic-ThinkPad-T470p.. ([2a01:e0a:82c:5f0:ad62:b2f0:914c:91ae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43987088ecbsm75404005e9.31.2025.02.19.01.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 01:15:15 -0800 (PST)
From: Loic Poulain <loic.poulain@linaro.org>
To: marcel@holtmann.org,
	neeraj.sanjaykale@nxp.com,
	robh@kernel.org,
	krzk+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH v2 1/2] bluetooth: btnxpuart: Support for controller wakeup gpio config
Date: Wed, 19 Feb 2025 10:15:11 +0100
Message-Id: <20250219091512.290231-1-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using the out-of-band WAKE_IN and WAKE_OUT pins, we have to tell
the firmware which pins to use (from controller point of view). This
allows to report remote wakeup support when WAKE_OUT(c2h) is configured.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 v2: - Move pin properties read in ps_setup
     - Display warning in case of wakein prop without related gpio

 drivers/bluetooth/btnxpuart.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index aa5ec1d444a9..4f2f429c9800 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -447,8 +447,14 @@ static int ps_setup(struct hci_dev *hdev)
 		return PTR_ERR(psdata->h2c_ps_gpio);
 	}
 
-	if (!psdata->h2c_ps_gpio)
+	if (device_property_read_u8(&serdev->dev, "nxp,wakein-pin", &psdata->h2c_wakeup_gpio)) {
+		psdata->h2c_wakeup_gpio = 0xff; /* 0xff: use default pin/gpio */
+	} else if (!psdata->h2c_ps_gpio) {
+		bt_dev_warn(hdev, "nxp,wakein-pin property without device-wakeup GPIO");
 		psdata->h2c_wakeup_gpio = 0xff;
+	}
+
+	device_property_read_u8(&serdev->dev, "nxp,wakeout-pin", &psdata->c2h_wakeup_gpio);
 
 	psdata->hdev = hdev;
 	INIT_WORK(&psdata->work, ps_work_func);
@@ -540,9 +546,11 @@ static int send_wakeup_method_cmd(struct hci_dev *hdev, void *data)
 
 	pcmd.c2h_wakeupmode = psdata->c2h_wakeupmode;
 	pcmd.c2h_wakeup_gpio = psdata->c2h_wakeup_gpio;
+	pcmd.h2c_wakeup_gpio = 0xff;
 	switch (psdata->h2c_wakeupmode) {
 	case WAKEUP_METHOD_GPIO:
 		pcmd.h2c_wakeupmode = BT_CTRL_WAKEUP_METHOD_GPIO;
+		pcmd.h2c_wakeup_gpio = psdata->h2c_wakeup_gpio;
 		break;
 	case WAKEUP_METHOD_DTR:
 		pcmd.h2c_wakeupmode = BT_CTRL_WAKEUP_METHOD_DSR;
@@ -552,7 +560,6 @@ static int send_wakeup_method_cmd(struct hci_dev *hdev, void *data)
 		pcmd.h2c_wakeupmode = BT_CTRL_WAKEUP_METHOD_BREAK;
 		break;
 	}
-	pcmd.h2c_wakeup_gpio = 0xff;
 
 	skb = nxp_drv_send_cmd(hdev, HCI_NXP_WAKEUP_METHOD, sizeof(pcmd), &pcmd);
 	if (IS_ERR(skb)) {
@@ -586,8 +593,13 @@ static void ps_init(struct hci_dev *hdev)
 	usleep_range(5000, 10000);
 
 	psdata->ps_state = PS_STATE_AWAKE;
-	psdata->c2h_wakeupmode = BT_HOST_WAKEUP_METHOD_NONE;
-	psdata->c2h_wakeup_gpio = 0xff;
+
+	if (psdata->c2h_wakeup_gpio) {
+		psdata->c2h_wakeupmode = BT_HOST_WAKEUP_METHOD_GPIO;
+	} else {
+		psdata->c2h_wakeupmode = BT_HOST_WAKEUP_METHOD_NONE;
+		psdata->c2h_wakeup_gpio = 0xff;
+	}
 
 	psdata->cur_h2c_wakeupmode = WAKEUP_METHOD_INVALID;
 	if (psdata->h2c_ps_gpio)
@@ -1266,6 +1278,17 @@ static int nxp_shutdown(struct hci_dev *hdev)
 	return 0;
 }
 
+static bool nxp_wakeup(struct hci_dev *hdev)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct ps_data *psdata = &nxpdev->psdata;
+
+	if (psdata->c2h_wakeupmode != BT_HOST_WAKEUP_METHOD_NONE)
+		return true;
+
+	return false;
+}
+
 static int btnxpuart_queue_skb(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
@@ -1546,6 +1569,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	hdev->send  = nxp_enqueue;
 	hdev->hw_error = nxp_hw_err;
 	hdev->shutdown = nxp_shutdown;
+	hdev->wakeup = nxp_wakeup;
 	SET_HCIDEV_DEV(hdev, &serdev->dev);
 
 	if (hci_register_dev(hdev) < 0) {
-- 
2.34.1

