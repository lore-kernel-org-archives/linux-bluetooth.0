Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6FB219A79
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010120; cv=none; b=r7YfHSpLQ8pyLYX7YDON8znpQCTGwvXc2/R2dl5hH3MHYKD0bt1lGup9UYeDC7LEdBTquElSJddFEcYD+ICu4uZ3XEEETdUEDFsLOwOCEMJcBsIHWBF6+G/GafySV08qaTdGVxzPVEuWpZDaBQHEogixKDg5KL6fFvIJ9n1hDwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010120; c=relaxed/simple;
	bh=oKt+TJWqyStRMCKk1W9jz+VuWUxxZ79pbpj1FVu5hKo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VYDXV0/HDRJp6NXmxr0D4Al4EukrEgc1GkhuSfvvsljIue28Ng4fF1MW0G26OhfAQWq+ZC8Cd9HKcZ9WBOeMzQOGfg//PdktRZAiN6rrS/0xZBiaesGpzS/5/gtQDTL64QSOLcejhcTdMI0Xt5bZEGhWII4PP5eUXQzPfZIDhvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mtroyal.ca; spf=pass smtp.mailfrom=mtroyal.ca; dkim=pass (2048-bit key) header.d=mtroyal.ca header.i=@mtroyal.ca header.b=cn5I5NX/; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mtroyal.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mtroyal.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mtroyal.ca header.i=@mtroyal.ca header.b="cn5I5NX/"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-52403e39a23so74303e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 10:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mtroyal.ca; s=google; t=1743010116; x=1743614916; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DnFKKB83AHK6QdBloILmeM8/LL4TGbDb871A/NdEh+g=;
        b=cn5I5NX//IiFFUrWEuf2/VCc6jFR76VQjdyfb1ipYiXcra/f83XxloXiL+RuX5yQIK
         Ns8edghr9PepNjcW3SFgW8mSw54PkyocTo0evyI5H35+ThpgelFbyJe/bixQRZRCZ5SA
         K8QypVqCGd8F/NCFv/iH2SpIZaBiilJXxOSoj7bjiuLoIh43sycjv7t5fmInSJ77K3FF
         P0NxLHqiEW2Pa62+Zdo5ZCT89X8TaV67vH5GxcmhIN/NMkf8NNcWHGUDCWlFK1aDO6HQ
         V8WvKIsnqWkEzStubpLVG7lWH8N8FV2U0D10BsKVGHd16BUykMSHRCPL766lr22/obup
         1mrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743010116; x=1743614916;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DnFKKB83AHK6QdBloILmeM8/LL4TGbDb871A/NdEh+g=;
        b=tpyUOe3ujNnu+keHKOHe3F/VRNWkWmNnHCGRDJvTZaD3llKp8z6RRw3RQwTNMxJuzO
         /ZwfTK0ReIkFax2fKLOj2peWfIBCsaycIv1BHOEiFvj8ai2OmhJWL1jza4qOiwCfw/1A
         Ali0Ea17p9Ag8la4L5O0BlsgQNGAtc6IN6FMGB4s5yaN2/qM/z9kl3yOdHP0odfVr+wf
         1EA++cMzUvLBEAcwympvVPA7S0G4C2a1ree7XPHhJcSyHI7pd8KkCugjXbkvL5WIaVwo
         UkXkVQwJKemwIhQYv3+08dwv8xfR1oVFPrSGXLPRcYflNjtZitiscALswFCNdZ1JVXnh
         yknw==
X-Gm-Message-State: AOJu0YzBIVnQH9kEMOTS/y1aUiTQzYWM6BjB+bHamgfF4YKbyKm9Zs9s
	YNOdFDpsp1pF6GFfckFnJGmJJs+n6Wn2fdAO9l5HWahq5wYk7HJZJzNzuYO3Flb5NeYo5HgsJ1S
	biJ2gboTGqH97HFYdzrhb0alruhFWxIRh+9CdXqs5ZiTbb0z+diyI
X-Gm-Gg: ASbGncuHWa2PscJs80zjyf3lCumitGMYBYqJvGQfwa7fBwnzvdaOD918zXPniR7oe/j
	q/8bt9IRsiJ91pZBWpa6gPDDqmy3XLciKrO3/OTPekEcomVaOG5iCk/PXc02NMIjV4AWtzSSDBn
	8coDO2s/8g+GJOYvl3Y5iOzwCgmtEvZuQS+jMqLsxYSBKRn39m99UNybT4oWs=
X-Google-Smtp-Source: AGHT+IHTEVES3E7yvKEH6kXCoK7OqzN2cJjE/BYKxwOODulv2btgTc48eKqaBdFhGyOwAyJGFKhRUpfyqRfJUgkDklU=
X-Received: by 2002:a05:6122:8d3:b0:523:f1f9:d03f with SMTP id
 71dfb90a1353d-526008d0d5fmr581007e0c.1.1743010116288; Wed, 26 Mar 2025
 10:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Matthew Hrehirchuk <mhreh594@mtroyal.ca>
Date: Wed, 26 Mar 2025 11:28:25 -0600
X-Gm-Features: AQ5f1JqrPHaHofLZCfX9KpSinbKHknbHEky92oCIwp1iHqZDQ-IW1rGaj7YxIq8
Message-ID: <CAF3zC4z36GuA+vZte8TwLSfPEe9tZUUbT+=GRAFtZvt2g_Jsnw@mail.gmail.com>
Subject: [PATCH] added support for PRIME B650M-A AX6 II motherboard network card
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: marcel@holtmann.org, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From 2bd405f7ce07d6891bff195c58c5b1a0c823a0ff Mon Sep 17 00:00:00 2001
From: Matthew Hrehirchuk <mhreh594@mtroyal.ca>
Date: Wed, 26 Mar 2025 10:17:16 -0600
Subject: [PATCH] added support for PRIME B650M-A AX6 II motherboard network
 card

---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a0fc465458b2..44b9965541f3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -536,6 +536,8 @@ static const struct usb_device_id quirks_table[] = {
                              BTUSB_WIDEBAND_SPEECH },
     { USB_DEVICE(0x13d3, 0x3591), .driver_info = BTUSB_REALTEK |
                              BTUSB_WIDEBAND_SPEECH },
+    { USB_DEVICE(0x0489, 0xe112), .driver_info = BTUSB_REALTEK |
+                             BTUSB_WIDEBAND_SPEECH },
     { USB_DEVICE(0x0489, 0xe123), .driver_info = BTUSB_REALTEK |
                              BTUSB_WIDEBAND_SPEECH },
     { USB_DEVICE(0x0489, 0xe125), .driver_info = BTUSB_REALTEK |
-- 
2.48.1
