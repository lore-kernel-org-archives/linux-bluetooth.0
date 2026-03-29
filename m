Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AEA72622
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774772015; cv=none; b=qhGqKDMmRIZwGboICYQJrWSOkNXDJl8ID/PcpX8tzMghk/BgW4zTXG6yg3UVh0IDXTYE7yx6CJiHSW9ocgdslYbFyYQ+cGwxQN1pxji8CNm1ylQuvPyIv2CtOkxFPhL5fpwNaeScSZk6s4Ci0KcIv/3TRO93AedQYdr1SL7hZfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774772015; c=relaxed/simple;
	bh=Qkvxr1YxcRg8v38bXB0USom+twXiYNdde0wDNqkBK2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcizMBxBVcY+/e36ol9sWdDh5BCSpeYsI4xG8QFPKwCeD0qXAcUuFoVTKw5CS3wky8706HO+6CIDihz8GWaa3g56nybYeb9J1bAChSUKiK2YEf0KTdP6F/C9SW4/pOJAhWhIq8CwD6dCFXPgkdRJAo7t/M60fuOxHZ2dPhfcUMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzV1k65R; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzV1k65R"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-483487335c2so36245885e9.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 01:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774772011; x=1775376811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ST9GwD9Yhk7fcuWvGTTnV/Z66PgwCvGos9lZJe3pzFQ=;
        b=ZzV1k65R4RKKYp3hEdyhPRMjR2aIT3vGmwOJHpRrz6paB2w5q7wA70/w1YqOKt+Yxq
         /S6RBCviZqPOyJmBIBOD0e0tAoAsoXNmTTP+/2dbFV5VRsHBaznSRJ1mEw8axMhKG9FX
         4y2YrkaakecjfWRR5SwUo8Z5TF1Rena8mKoRcabrv6IHV5h6AdEyfrL2xv0l5J7z63Y8
         DrUP2JaGYcuo6PUXcvvo5G8Id7vpYOFRm1cl8OExkIO3O40FGLxOKErIVVw7QdQ00UlM
         CaK75riZq6KfVsq0jxAMHiGfvCEUwFroY+1leaXBUhXUoUmaETGGDWe1NlOeoTeWcbCF
         A7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774772011; x=1775376811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST9GwD9Yhk7fcuWvGTTnV/Z66PgwCvGos9lZJe3pzFQ=;
        b=MvMI/BXrEt9DueHFRRQhQZR6GBYnMyvPOvSB2kP/uFrXrtkhCxr9a5opVZUk9kdZ7e
         UkN9+6horvkv1lt/7U+JQj/GlamP/SX6h5s7etaCA9Qzq1XaxpRDVi54Hm+DNYTQYcTG
         QE9W8hCDnm+HWo3jQom7A7ruIHpYGQoiQOcbKNui+V0+6ZCTfZRKdZbuHRHDZIdK9Jmy
         PmdvVshAAz4zLURVdiG02pjp6bYGBAO+3iMeMIF0a8RuMf/KNsKuLV2HyYZYbYCFHu5w
         lNT88ZYxH/swEfvLJMPmcwtufaC1QnOGyeazSiHbzIKB4+2o2uP5jMScWRTXjpgkRmxB
         jvkw==
X-Gm-Message-State: AOJu0YyPrrW4RqraT2eDoj0qAseRraZIxwzEUFht9eAFhvo5JuXbUcO0
	UNj4pK0jYXL2dS4c6M14+T1+kUHokmEYltCNFQBhkwsLUDBeLA0R2nQMLCuxQadkq8s=
X-Gm-Gg: ATEYQzxd316DAoh5gvNH8GvXziJnfohpeSPNokHVYE3XZ8xrxi2g7U7BhWhTmR7yC7c
	HI16GJRqP29RdsznlHTa+UKnsTllrzEObG4zj1cvPEvP9zgI7BOQFzKAhYEEj3R+YlQZgcq/qjg
	C6s6fsrmNB20L4f4HlbwBh0PZjhMkkaCBtPOyQJZGVINuToaL1H6rsOSM+KqATsO1jzxn7zSfPq
	EkK0g8e0kVrHyeQhlAwt33EEFMFKZkjE+sRWn8N5h8JQ96bCCvTiVlmoigREHQ1qHd4Ss7gtqHd
	kP9J5i0P2c+7dnoRzKR+feQgEF0nL15INxYsebjZMtGeQy/jKuJR1SfDvShirO67jcIx8IWrKdJ
	2diiUm9HrIZZHMxtve/+lKfa+QXUZW8YKWR1/QbNgAC3ROU9ZonWh0koGd4B8toxHn46vJYOEZW
	IaLQrabO48lpWpdR/NkVEYH2DPG+MSNLsOyd1HuidnPfRoFWLbZRDQD0kiQCrHudMRgycbFnzpR
	UbQn3ATEDxkg0ZfiuVIjh+BMU/kUu1T98mYpXy9BY054wSHSQP2NNkM3DzWJrp84xMoyzRDZRhN
	CS8On0DrIVL2ckssHqRwYkLo4BlSPJdF8Jg22sdlNkfoINqyHTctvw5BPZE=
X-Received: by 2002:a05:600c:4fc4:b0:485:3f72:3230 with SMTP id 5b1f17b1804b1-48727f3b3bamr140329995e9.15.1774772011313;
        Sun, 29 Mar 2026 01:13:31 -0700 (PDT)
Received: from archlinux.kangaroo-newton.ts.net ([185.213.155.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48730688605sm152294615e9.10.2026.03.29.01.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 01:13:31 -0700 (PDT)
From: Christos Longros <chris.longros@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christos Longros <chris.longros@gmail.com>
Subject: [PATCH] Bluetooth: btusb: add Realtek RTL8852CE device ID 0x0852
Date: Sun, 29 Mar 2026 10:13:24 +0200
Message-ID: <20260329081324.123156-1-chris.longros@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the native Realtek vendor device ID (0bda:0852) for the RTL8852CE
Bluetooth radio to the btusb device table.

Without this entry the device is matched only by the generic Bluetooth
class rule (USB_INTERFACE_INFO 0xe0/0x01/0x01), which means btusb
binds but without the BTUSB_REALTEK flag.  This skips Realtek-specific
firmware loading, event handling, and wideband speech support.

Tested on a Gigabyte B650 Gaming X AX V2 with the onboard RTL8852CE
combo WiFi/BT card (USB ID 0bda:0852).

Signed-off-by: Christos Longros <chris.longros@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5c535f3ab..0bc77b29b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -549,6 +549,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8852CE Bluetooth devices */
+	{ USB_DEVICE(0x0bda, 0x0852), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04ca, 0x4007), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04c5, 0x1675), .driver_info = BTUSB_REALTEK |
-- 
2.53.0

