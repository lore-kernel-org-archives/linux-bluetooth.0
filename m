Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D57621B1B4
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797852; cv=none; b=CJb4TmwjQSZXqUWu+TXN4qhGYhshiCDx6oY8OHOSBnIUpumeGGLpiDqJ2EIGZ89GkWmP52C5xyxjeEOvb+fIdBMjqH0xQdvkEZ7KWj5nEMPDUX3nKnnHpT34mMtfTmzsiHO6ymF8V7aN/Hq1PgIEqoQfy9Sa36zho3yX3pU6tp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797852; c=relaxed/simple;
	bh=lDSLWAKy5zVwxaRI3b4gArEF1npqKdDWOnLwOLH996Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZzfnuTD2YOcxdqCNEV//IxM5zCFB7YcTZ0nxJYJAWxB6dTanzKUiR0FTGQYQmnR02JXqM5syQNdC5QM2JZRLcQJ1g7yk21nYAjOafyRM6VVqSpTTSWhtGYSmmED67Rj2QKQ1MS09xOI6bi5LlgB4fsO18ocjg5tKhJPUqBwzxXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yAqVoynA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yAqVoynA"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f3913569fso908951f8f.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 05:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739797849; x=1740402649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bYncmRmaNaCf5wVabkduYC5FODT4da0WmrLiept0GSs=;
        b=yAqVoynAr90tcy4hjgAFtCUhriB8JVUjoH5dlaT9yhAR/hCv8YseRLoUKbq7pbxlKD
         7Bws7QT7y7ulpfE7eAGRffiyM8T3TM17MfEzhlDpm2QHyuwRlnmKAaHjE83QlynHRK1E
         QKRaaCfzZ1gEUrtPX1BWq+gqdFkHwQV61kI0196KdFRvU3EQG1yUnwamUAC43kRg0ux3
         HEoo2fpfz9VgYTwFSyk7dJT4sgaLqyc3K6WlrG/ovKJWwhwrygi3H7+D3mHxo8J/Pxpe
         aj1VR+EtBQsPXwPmOukM0TAb7zRw6T11DdbKHntRS9GxGn9jMoM0RqPmyIs0rQi8oekD
         8ItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739797849; x=1740402649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bYncmRmaNaCf5wVabkduYC5FODT4da0WmrLiept0GSs=;
        b=lZ1dCyiT/rYj4YqamgDuYctRmiNyeXPj5hwdD1hxD/p9KIa6P/8DnYUPe4JdvqJzFI
         wRqMb+X2zp5z+XPWPz7N3r+RUpTV1M8vaHPvrxhHSPbHq5CU/VkjtZNavbDbpQ/VZCSD
         NeduqNtxkCIPc0N+PUoaXzROUJZpVJWB4AwFBzOohkP2L7s/N0Qf2lE5DSq0uSK7hP3S
         m7eUpD5hnf3YGgGWWyZvSmQxjDbezmtJuh+PxzHR35+wYrHmghh32SrnQLV2lYCKdVmK
         5WGc+MxPjJJauOWUuibbAJJ/cOHQij3W030okmfNNOnw9A4UJ/x8Pzyv5c9Gt1nhoRgd
         MHBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/fU9HROrlXqG8j7xvcZ/OO+SnlTiqkzAYdBAT1axSOTVBzf06jl+TkWDjkgRIMVnD/2eMgt7mcXkjXNtkqFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu/hmOsi4AcQbhO/SEuVDeLC10ZYrEAqe2d0m8in1+QgtE+SIU
	x7TcpLGaVTOFbK2IlJHuukKPtAp/kcfONQ7rYrYapVyr4k3HNyHbUwyuUN+/AgQ=
X-Gm-Gg: ASbGncv/MZcm4ypJE8Hp1ObtBzOGfgKC1O3QCW07KMEhfUXI5ukONsPeoC9AH5sq7v6
	W8XGiNijR+nPFyJHCbykLrsTGeeOrZDhH3kvC2HYtUij2u4q0gajJhXvH89dHNFJmHBgItipInT
	6u8qyQ/IfXi8kyPisOw3v12ilSALwerMF4RcJdtRprbBakfr1LT6ujafiFW2nCTwXekzbS9v1fY
	2Lm16YhfsXq7R/Nfq31M2Z7B+N18keP7UHz9xmtyOa7y2YskrXZNik2UOZK1M/Z69IW5Xxk+MYd
	6A3vW/rzO1yNN5ajQXj+1RSWWmPfugcrBw==
X-Google-Smtp-Source: AGHT+IFxGLPejkLm/Ee75L3ZBZEK7rAm12A2cDmzH6F0gcxZ6/ES/ueYG6ZKRwfFu3c+6K9OlLEttQ==
X-Received: by 2002:a05:6000:154b:b0:38d:a695:6daf with SMTP id ffacd0b85a97d-38f33c20c39mr10292031f8f.19.1739797848840;
        Mon, 17 Feb 2025 05:10:48 -0800 (PST)
Received: from loic-ThinkPad-T470p.. ([2a01:e0a:82c:5f0:ad62:b2f0:914c:91ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f5fb6sm12043763f8f.44.2025.02.17.05.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 05:10:48 -0800 (PST)
From: Loic Poulain <loic.poulain@linaro.org>
To: amitkumar.karwar@nxp.com,
	marcel@holtmann.org,
	robh@kernel.org,
	krzk+dt@kernel.org
Cc: neeraj.sanjaykale@nxp.com,
	linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org,
	Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH 1/2] bluetooth: btnxpuart: Support for controller wakeup gpio config
Date: Mon, 17 Feb 2025 14:10:45 +0100
Message-Id: <20250217131046.21006-1-loic.poulain@linaro.org>
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
 drivers/bluetooth/btnxpuart.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index aa5ec1d444a9..6fbb8daf6f05 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -540,9 +540,11 @@ static int send_wakeup_method_cmd(struct hci_dev *hdev, void *data)
 
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
@@ -552,7 +554,6 @@ static int send_wakeup_method_cmd(struct hci_dev *hdev, void *data)
 		pcmd.h2c_wakeupmode = BT_CTRL_WAKEUP_METHOD_BREAK;
 		break;
 	}
-	pcmd.h2c_wakeup_gpio = 0xff;
 
 	skb = nxp_drv_send_cmd(hdev, HCI_NXP_WAKEUP_METHOD, sizeof(pcmd), &pcmd);
 	if (IS_ERR(skb)) {
@@ -616,6 +617,13 @@ static void ps_init(struct hci_dev *hdev)
 		break;
 	}
 
+	if (!device_property_read_u8(&nxpdev->serdev->dev, "nxp,wakein-pin",
+				     &psdata->h2c_wakeup_gpio))
+		psdata->h2c_wakeupmode = WAKEUP_METHOD_GPIO;
+	if (!device_property_read_u8(&nxpdev->serdev->dev, "nxp,wakeout-pin",
+				     &psdata->c2h_wakeup_gpio))
+		psdata->c2h_wakeupmode = BT_HOST_WAKEUP_METHOD_GPIO;
+
 	psdata->cur_psmode = PS_MODE_DISABLE;
 	psdata->target_ps_mode = DEFAULT_PS_MODE;
 
@@ -1266,6 +1274,17 @@ static int nxp_shutdown(struct hci_dev *hdev)
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
@@ -1546,6 +1565,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	hdev->send  = nxp_enqueue;
 	hdev->hw_error = nxp_hw_err;
 	hdev->shutdown = nxp_shutdown;
+	hdev->wakeup = nxp_wakeup;
 	SET_HCIDEV_DEV(hdev, &serdev->dev);
 
 	if (hci_register_dev(hdev) < 0) {
-- 
2.34.1

