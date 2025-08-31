Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2547E1BC58;
	Sun, 31 Aug 2025 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756637460; cv=none; b=S0fiRBmcJvvZLKzGSpPufC2OBHZhuWNZ14Y0OR4XGX6A0pwISoWBUopJYCov3XZnSHKTYxTBQKsE1htUnmTbZU2OceXx27aWiUS+k+oRGDBJ2v/5OpJsLw6c3u2G9kGrde96JQl74fKX4qfGzR3wfoGe4DzlhUDoMCeuzTzDEfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756637460; c=relaxed/simple;
	bh=QHUMTmkYDvB7GFFnj58OHxmDkw+glLVRULTTUbpJ8V0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=fDJ/KGt/PSiPi6WzIeLxqLG3HhHkPCyvH+g4crYjORKrh3JrWb1fcxO67qgc/nyAN9n3QgFkMoWzNUUP3xLm7xI4lH1gNZ/dtnAiBu/7HVhQ50aLBuL6oa7J7alp0J/OI6Tzeaa7kvjClCEiRm7fnMT0E1sEN3vCgC+4uwfSWis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0ieeVeA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0ieeVeA"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b869d35a0so4932065e9.1;
        Sun, 31 Aug 2025 03:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756637457; x=1757242257; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHUMTmkYDvB7GFFnj58OHxmDkw+glLVRULTTUbpJ8V0=;
        b=X0ieeVeAj3fkPt/6hjryzAPNKaUze2H3KkYFylaVqdYPAKOdu575snQbnIVzqcV/Y6
         SOx/57pugWilM+BPomFtrIShCcJZCoJ3JyCNx1SDjbP0h7Ssmsm9dlAax6RK4TFjNMdh
         W0pM1eEC67Wp/jvjsM1II4X+wH8JsdKNuk0loyvo1n6BiiphWCbnSBQeq/ZMNb649FGS
         kTJY6FkcrcfPag0SukP4O0z/N8QLkb3zbHXV8reKqbEs0zXtgmrUFqzi1VPf9vv/IW9A
         +q60QH8EoaMFz0eGLPPrXQ7N/d2Xo+HyB2CZ1kQd8WbLip63tQ2cMM9AUViKfq21467p
         Bjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756637457; x=1757242257;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QHUMTmkYDvB7GFFnj58OHxmDkw+glLVRULTTUbpJ8V0=;
        b=T0X2nweVtnqICrlmxCwE1f38mE/jaccPu2A+HHDfm90DVD0Y7jNYzS1uOulZ+2zhqm
         ghC+TQMOF+tvGr6AoluC0Zv+4n5il6SydzQIMV6hFxh4iJ6EIaE/htCB6JOEsanoxH1h
         cSFDCsG/qLK6KxQp8VdpWmCrJcF6l4Ar+irYUyVHvgnEGbaWh5lSp7G+rNP8zOGDxU8e
         qc4U3V+nCxn0M5BY93kPJnD6QdokxYKw832yAAlZKHPtOx5LB3t/sTJho3Smn4gx6vU1
         sCwCj8vHr3LiCFg7KbAt+4dWKz0p/cHG7cBQkRuz+OZv4LmuuqQZU+H4xeW6LGePtS9J
         xMKg==
X-Forwarded-Encrypted: i=1; AJvYcCUrr4BdPdXYYw52ZvaN8nOuDXp+g6xM+fWumr5e8etcHXRFTYI3GYwtXRQAzjQu5rpdvXdeOO8iH0xTSPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRB3WAdXiMmis2guvx9J0b/RAbJp37/L7TqV8ZA66woL+WkmxW
	Z68fzvMX58VSxcyCWzsAocmK3TgKfwsrVDY/29yTccYlIWM1jIdFHpEN1Sxdyg==
X-Gm-Gg: ASbGncvCDtKlGFalZfFvtquFoKwU7YdA1YM8H+k+0jomsHyGs0h4sbLtdMloFNIFyRK
	bU5KSazCJpntYekA0Lya3hr0pTU5yCyTm96Vlwack9dZ8TUdMB8nbLhK4B50R85rY4+8Yn8HH9I
	81ETpejqzpodeCco9YzkiUQ5Jr/lEmOIS2lvcOJ4AOwbLyADFJXYEztVSXuLk6JQy/hnV6nsyzn
	lC2FQDtSyr9Cto1QLlEujciPj0exIYzlnoTqbVVfFw15+4itOtZTl9SZ0DCIeJZZva3pDPtm0pu
	lHtAvYCZfKyXnLyGa3EacZDs1ZEZ/H3JgMZkdzASXlQtVLsBXrxtaOO2UfdGDcYV3iBRWt62NFu
	k0MbKYiJ3iTMcNoQeYRKrL21QsLsvA5wo/PHxHr7iED14gFaR3gDkgZYRHVSztAwA4olrxodJ8Q
	7J
X-Google-Smtp-Source: AGHT+IEZ8HLONhPPvUp48Mw8vbQZXrQAvE4mhvEjamgPT+/rDgkRt4WQwSrbI1M33byzWSvQxjtyIQ==
X-Received: by 2002:a05:600c:8209:b0:45b:868e:7f7f with SMTP id 5b1f17b1804b1-45b868e8289mr34054735e9.17.1756637457218;
        Sun, 31 Aug 2025 03:50:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3fd:be60:4077:be40:d68a:2e71? ([2a01:e0a:3fd:be60:4077:be40:d68a:2e71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf8a64fce8sm10330534f8f.34.2025.08.31.03.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Aug 2025 03:50:56 -0700 (PDT)
Message-ID: <12b048b5-aadd-4b06-a9a7-8480f27c65af@gmail.com>
Date: Sun, 31 Aug 2025 12:50:55 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-kernel@vger.kernel.org
From: 3 <elespink@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add support for Mercusys MA530 Bluetooth
 adapter
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

 From becb0b090d9783afddf7d43d739ee69b82fbb32a Mon Sep 17 00:00:00 2001
From: lespink <lespinks9@gmail.com>
Date: Sun, 31 Aug 2025 12:35:47 +0200
Subject: [PATCH] Bluetooth: btusb: Add support for Mercusys MA530 Bluetooth
  adapter

Add support for a Realtek-based Mercusys MA530 Bluetooth 5.3 USB dongle
which works with USB ID 2c4e:0115. This device was not recognized by the
kernel with the original device list and thus was non-functional.

Signed-off-by: lespink <lespinks9@gmail.com>
---
  drivers/bluetooth/btusb.c | 4 ++++
  1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8085fabadde8..84ebeb317dda 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -593,6 +593,10 @@ static const struct usb_device_id quirks_table[] = {
      { USB_DEVICE(0x0489, 0xe130), .driver_info = BTUSB_REALTEK |
                               BTUSB_WIDEBAND_SPEECH },

+    /* Mercusys MA530 Adapter */
+    { USB_DEVICE(0x2c4e, 0x0115), .driver_info = BTUSB_REALTEK |
+                             BTUSB_WIDEBAND_SPEECH },
+
      /* Realtek Bluetooth devices */
      { USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
        .driver_info = BTUSB_REALTEK },
--
2.51.0

