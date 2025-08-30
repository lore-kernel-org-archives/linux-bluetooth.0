Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E114A1E;
	Sat, 30 Aug 2025 23:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756596920; cv=none; b=Npwl0/BLvd0TosXAiYfGl/5QyT+14u4fTUSr3dd7/EKcVT36wykytHjWs1LGRDNQ2Kf8+co6EgQ5maquYmXZqDcH08/MSI9JScLuk3tX/WfB8cc4U1mtKky/u7RRFDYPzNz3md6v2LeMSZ7KEqA9LQTYn91nwL0IjhhcXYRR2Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756596920; c=relaxed/simple;
	bh=A1A15SP7EAbPOSRwf/khWmHfDr0hulG0ibBvo2Kw4rU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=DuLGSfbRDDEOq/6yqjfppeiE9FhFi7jPxbo7UIXM/DfDMcnyYZWtpeOLjapsWAygkdw0N9Xx4ghLNINM02yBJgg887M9VTQ8sfWTYX8XioHWUM1kPgNq0BymTtPUY73IrrsqAlhC1y0LFmyjx+dhR3lsjgk5VbQVmLm+BdltIPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpyZHil7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpyZHil7"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b87a13242so4352755e9.0;
        Sat, 30 Aug 2025 16:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756596917; x=1757201717; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilggsvN1L5HlGEcAmG/8+r/KQS8Juj2kUTzaRgImlTY=;
        b=LpyZHil7LYL3yTBsn+wnIK7MlzkSKkyPBPRymM9xZTxggb46ad/yBSPVM106mKh8Hy
         MwMI6kqGWtsBGiHh5v1POeUoyudTkB8zKXUQ/IezX5hOs7bcmeRdDwsk6spYj25eurlX
         D5UZPnQrL1JFfNTFLrniAktHuJuk1JbDOmUwjjX8AG0g+bHoHkPtlkUW2g4JHZvmEwLJ
         fUxNFoO/8G5v7BI9Agp6jRJDoC2ih1V9dQJFjBeELroFbtkMMDup46Ht/S1Dd76Z5hXj
         56Bl3QSq2abYj4GX/IpSiMQq7emULu8nWpMmHOcpCkwN9B5RRQeu+ijWF22wS4UKmi1z
         KmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756596917; x=1757201717;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ilggsvN1L5HlGEcAmG/8+r/KQS8Juj2kUTzaRgImlTY=;
        b=cU6nprbvqdyKn19ZfGlg1z5MynwbZz2LGYP7ZyQg7NhSwFAq5/yzELeuxoT9MLuLY9
         /TOaBAL7v9wN2r6x4hFQrFhA9QNbNqkxpEQDiE6B5FNv9O+jy29Ri81QI++ZFEzIMlLV
         ZbXXCGtQjsjhCqhvWW+o8VhBGNolMpTO4KHOjZWsR/FovY1ya5G5DirurtoynXbzwIge
         cdLAO/3eQLCPAd1WugcGzTe3WmtzVDGmruk3akEStGxJIYVA+BEa6aP4a95obb9/yLTM
         splLgO32nflL6g+aKIyZQ/4s9Gbb+e4pIDVFLaBYZsL3ULnljR2mlRqttvbUmNHm/gPL
         CqIw==
X-Forwarded-Encrypted: i=1; AJvYcCU1wY+SM71YDJlu5Z2f3iOvjnibfI5/SeIiW2Kv3uWSMaunwfU4CtIcdUPlDF/+EjSldIpkTChNPI9nVRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNCSkmGY5NqMqNrM5HjgJ3YO6lX9fYm+ei6KbOShwpOVS+N7Ch
	Etdc+z8dv9lyUHDNvx3rGqlSWBFiMZUkdQE0nIb7TqPT6PpvHEW3cqnUydFGQWFJ
X-Gm-Gg: ASbGncuTZ5DA9mqdAjTUfYM5RY7FZOzlXjmED867tcP1ZIZZWmM7liZGQ43cARiyUq+
	G5uDzswtpFanxtvT/bLer0Tdkr5FlkKqliSYe+HLZsEHYgQGl4q5vu3CzvOwre5AV2tErQ939Kt
	7NAX1TJliXG6KemU9LpVy0Okr3Sq6HBAsdR6/HIG7tuxnToHyuWb5Gp6FxuUq3+xCAHZRkC2MTc
	cauWm4VfL2mYhFSnTu9r4DyvaZCAGnuM8BQxhMXzJIeAhHq1Y/2mV+yGcjrQyC6iYj3aiWQ4HXo
	QS42puZvRBMW0orkwMKHCff6R/nHgs5D/QXtuW5LTqSbBo13WHmzlhTwOFm43uOuhCnCvd5E0LO
	ap1UIzby1RhSu40ieLEsVmfVRozP2oQ3NGSeNn4XCg1WuN64o+awYh5SJt9ZtYiQKTgiU7nF5Un
	yd
X-Google-Smtp-Source: AGHT+IFC1PTyg8i6C7QQ2+jCR+abwCDoKUvnDq/7ssf8LETuYb1s4YZQ/Ac1VpSuHyQkf9SPA+iDbA==
X-Received: by 2002:a05:600c:5303:b0:45b:86ee:415f with SMTP id 5b1f17b1804b1-45b86ee43ebmr20851225e9.6.1756596916721;
        Sat, 30 Aug 2025 16:35:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3fd:be60:4077:be40:d68a:2e71? ([2a01:e0a:3fd:be60:4077:be40:d68a:2e71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8876c9sm95167305e9.11.2025.08.30.16.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 16:35:16 -0700 (PDT)
Message-ID: <02cf444e-d05f-4af9-89ce-96276e29be14@gmail.com>
Date: Sun, 31 Aug 2025 01:35:15 +0200
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


