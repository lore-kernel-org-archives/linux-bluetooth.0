Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21947261B71;
	Sat, 30 Aug 2025 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756598266; cv=none; b=pfVXsZYmhGiK30dcbBBp+bfXxXnc1wCcsSAa7hdf726Ozf6zrRs/WWdwbjO9QlE8xbgdN8msudV1X/KGksBesHsH+wHvhJeQCHZ9AYFreVp73omllkjHmmg8BmHCeuQIPwjrrtkpvNzIWsaCz61MsrsFOjpN2gZbgy1zz9+w2p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756598266; c=relaxed/simple;
	bh=A1A15SP7EAbPOSRwf/khWmHfDr0hulG0ibBvo2Kw4rU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=obFlRbCNIv+otLu3gSWHpBmzkt7gBTFLKMvNJj2VosoC80IZbNR6+qTVj5y65c6Qhn4Qrb/FWO1F9zdDjnDoKtjLmG5r3a2Oj6jw5HQFzeB7GyOyDgv7/eYUbDrnJfPmbZL9SexfIHOXhFrOQ981hBMxVuKmfFRjY8INnXDpX1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTPlfIaf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTPlfIaf"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b6b5ccad6so18292425e9.2;
        Sat, 30 Aug 2025 16:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756598263; x=1757203063; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilggsvN1L5HlGEcAmG/8+r/KQS8Juj2kUTzaRgImlTY=;
        b=UTPlfIafiTcNrQq5thlzmfp0mUNSfjVIwjYYPQdlhFVaLVtZj6UU1J2MQmerFBsnk4
         8tWpYq+W0PQEmerFZx5Oe6ppfnsOq3HdrmP71Po6nMcPpXjo138hZfk+3a2Mc8bH+yrx
         oqiFZWAiQHYyFOKq/Co6ypWEjYadcrrP//KAk70WhwpICTAgw8aohVU0cX3bdR3u3E0p
         F8Fqz6n2qAdfpvxqriRxLCzLDouJb1unzfc4LnV8jbu9FpdaRly1z69QGBR9RqwXuCPB
         CLxF6NRHvE+DOQxmK/JDEiYAq7+KCGkRP2w8MYbWqi/gVp0zwEmR39gOeoEtqa9x3q3+
         TxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756598263; x=1757203063;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ilggsvN1L5HlGEcAmG/8+r/KQS8Juj2kUTzaRgImlTY=;
        b=Q5+oCbE3iRI5dtyCi6TEts3FjcdRW18xnoj988OqKbAiUxQD3E5toSIpSpGAYC6QdY
         eiYTxux6oBsrojVJZ5dP1sp8ATnpsG2NcWyV/iHH6o1pipQOKWaQXyHdF+pd5TJm6rgq
         89tV+qZODyg8f8KKDd8oxree/99WqtY6jHtWjehG002tOCrVDqa9tI1nksmHAaI2V+Ux
         FxtWwYZbXtVeJNgr8j3MalXRiIXgXDl6lEaw+YvWNIgK9aQDhtzmPUvXPe1jV6I7ajD4
         dtj9zRhLoAzm2Of1KvTyhkOF7yijHnuJkLci+CZI7c2dJJZxsChoNT+Ulvo2sbF1kNWC
         WZXg==
X-Forwarded-Encrypted: i=1; AJvYcCUsWDDZfgNdBBn3iQROuNMDTfmQ/js/Bx/nRt90mBPCrC3c6VKKnWQo2ynEWIDtmgLMDCp0BoWbBRiFV2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ZWtO4Tj0EvTCR8OBstse0Pnn+U0Hse9yrpD2PYNIKicnRw+4
	frxku1wLVF4RH1h7ANjBjLOovFTM47MqL6HyZ0UJ0l30jL46Clsx5ViVsF7pHA==
X-Gm-Gg: ASbGncvMujp1WOmpwVhUd5I828see2yvc0h4b3fgl6icZ8vmGXwCjfjrfZC7dn4kAv9
	RKY5Mg4qDB5vivGskNw08gZqXb6A6A46Sm8mF4rgjPyi5wuWh/Y7Qsc9b4ZGjSTBpJlNp7JZ8Wr
	GjX+nTBQgMoLjvWn37drexY0XYR7lNHjqzMdL96UJ4USqDIoZ3WB89Tjfz0f4YqoUxO988PV1hC
	2VgdTBJO8XxIupl4N8//1kA1X1IazAlSwcrav5stOPdBFCh/hdNRq7s/zgl+STYlldM0wrkTyHR
	T7klRlDnqLeibjvELVdqRlH3lGZcawS/OpwPy9yZ8DTMM5HVZYuPh0Jiojq0EySehT+vQA9kHQP
	CPfHBE8LMCxxUOxjCeaDV2EbpaROxVcZtOQHv7xdBL/nZFLFrKrLZKh1BCRiCgVAi5tkpRNlm+O
	Rf
X-Google-Smtp-Source: AGHT+IHr9YWuanOcyaC+/EbTQwdIwFzVmDWT+6MQ27nWbCfDaqdoybIaWDDRuEautlA23H2PYnycrQ==
X-Received: by 2002:a05:600c:4f08:b0:45b:6b0f:caf3 with SMTP id 5b1f17b1804b1-45b8843e109mr10491445e9.4.1756598263193;
        Sat, 30 Aug 2025 16:57:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3fd:be60:4077:be40:d68a:2e71? ([2a01:e0a:3fd:be60:4077:be40:d68a:2e71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7271cd01sm166167285e9.23.2025.08.30.16.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 16:57:42 -0700 (PDT)
Message-ID: <a2451dab-004b-4c2f-909e-89b5875eb760@gmail.com>
Date: Sun, 31 Aug 2025 01:57:41 +0200
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

 From 5d970b05c726749908540bf7d5ee34d634bf16c2 Mon Sep 17 00:00:00 2001
From: elespink <elespink@gmail.com>
Date: Sun, 31 Aug 2025 01:06:10 +0200
Subject: [PATCH] Bluetooth: btusb: Add support for Mercusys MA530 Bluetooth
  adapter

Add support for a Realtek-based Mercusys MA530 Bluetooth 5.3 USB dongle
which works with USB ID 2c4e:0115. This device was not recognized by the
kernel with the original device list and thus was non-functional.

The device is misreported in lsusb as "Mercucys INC Meucusys MA530 Adapter".
---
  drivers/bluetooth/btusb.c | 4 ++++
  1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8085fabadde8..94984791e454 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -597,6 +597,10 @@ static const struct usb_device_id quirks_table[] = {
      { USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
        .driver_info = BTUSB_REALTEK },

+    /* Mercusys MA530 Adapter */
+    { USB_DEVICE(0x2c4e, 0x0115), .driver_info = BTUSB_REALTEK |
+                             BTUSB_WIDEBAND_SPEECH },
+
      /* MediaTek Bluetooth devices */
      { USB_VENDOR_AND_INTERFACE_INFO(0x0e8d, 0xe0, 0x01, 0x01),
        .driver_info = BTUSB_MEDIATEK |
-- 
2.51.0


