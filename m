Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1EC1F4288
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743006069; cv=none; b=KOjJZoJy1M2ikAtAylBn9OS8mAVYGhJJ9zRMoOQkroeSM14DhQHtKCJ1fjD7CRXZfqC/oWeUSFI/gPQjauzF0s1LXTRrmb7gaGuFpzomAIFlikLq81fBr7J5RzV4BJyFOxru3J3ZsL73m48dXr1NF4EWU6URDXl6a7zoK/yntBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743006069; c=relaxed/simple;
	bh=O5+8wQdv8ghwbVE1ZeBiwV2SJ3/NSZEdZfUhttFgFNI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=F6w1RPzMyrgSLpH0tpEk5xPeb/x9Hm5UjtDV0OmLeeW54zzHJvbZN+j0b/XL9O+mhMogSOHR4TFzfi3FwKp82lYNJtR9u9jmfr4/iDspHE85TWkxiTPUyAoJS/8ShYmlHLm3VitpP4143JHJ6qkjyy2jmbY/RZq0tAzDM+UkeiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mtroyal.ca; spf=pass smtp.mailfrom=mtroyal.ca; dkim=pass (2048-bit key) header.d=mtroyal.ca header.i=@mtroyal.ca header.b=jqFREjtJ; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mtroyal.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mtroyal.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mtroyal.ca header.i=@mtroyal.ca header.b="jqFREjtJ"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5259331b31eso15312e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 09:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mtroyal.ca; s=google; t=1743006066; x=1743610866; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NpLl5p7M88H6d6RIJYytmiw2qktU6ADlpO/6olrM8Pk=;
        b=jqFREjtJhlGDDsod2VeDim+VssUM1IuJ2y4rqg/npb8K+yh5FfQyw3vUGKEwxm+hQr
         VDQIkNS075gY2h9OG8UwGD9nL79HVQPQpPUWm3/VIjxQ2dCiwZsGg/LUGkR+G5XQ2Zym
         iXJT1XaKv52kvyFImheaBoOaUIKth8xw8MFXZDTB9y6spJMjrKSjpM8AboZe0r3A0sE6
         Kv+60o7Vc/Lp1jMAPuJUaENNqCJLQdfZ+lJlq2P/6wt7uOzDkDTSH9j7cqzkVsUh5c8Q
         XbGr73rVXOkz7g98dDaF+/lY58FzBqd/Jy7op6NiRL7D2W6zOKjUqiHwAWKnIh/bdipf
         epCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743006066; x=1743610866;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NpLl5p7M88H6d6RIJYytmiw2qktU6ADlpO/6olrM8Pk=;
        b=GMDiKAhMxzHfwRI/zuZxqs2GMaQyF72/XHJwNHnxJpJpiyX4XuWohhPLSXr56INM02
         ZFBBzXf6qMOw0I/W/buUpRESxvKQSCPkEzWuOuYEF1osrKXCAGvSfD1aJJxaYL2PEinP
         RL5OrAbZkUfTE3IhDnvxSOHB4i5+T2erykwbkzUtcbmqwEFkTkNIZf3SWtsieaw3FkWP
         JfBPiTU23vk+J8IPU3hiUFQ1JZ4Bklrzewah/PkLjwxB+9X83xOx7JN2S24PyY1HPJM1
         Zg32quDsYF1Cc6o05Laq8yCaTRNoNRMsdfTMm363UhyNdEUHogpAE0Mpiezq9sRXa7YZ
         xpEg==
X-Gm-Message-State: AOJu0YzxZg4S27VNNmvW/n392nfjQWYH96mdRTaSRktt93J1PaHLt6IK
	N6uSqkDxAO4W4ohiBTBCDnwx3uROmmd2H+y5vaaAbdOPUrji3iSJ7/fc+IoCITnuOE+mse7JfGm
	YjyWJZru1oCja5oaqLD8eLP72D/ExK4JIBh9pXtyQ+R7ag0Z9ISDL
X-Gm-Gg: ASbGncuInSi93vBHuGWNKQ/Tpv7mc/6EuY2TbcTfU7obRD8qw5s+HqZ/8K6dI6T+/65
	ITayb51lPvj1IJwhcyceMQUYBQrlhQt4+21uyGkKLz54ADi5bugXLHyoPVvFGk9FHHl8NtE46g4
	EwO2Mlaxz/xge1vWowMR3NYEDsMOmMdFfiYxmIhslkwAIuGfEFXyoGnXGa6DvAZe2tDLZfRw==
X-Google-Smtp-Source: AGHT+IHqSlmW3by3Q/qOxjqAqZjL1bkZux35Bvcmok0s/r9NSoGH+IuJxN/x62WDQ8vT7MuYdMHI3Yld3Yl6k2QMTM8=
X-Received: by 2002:a05:6122:4684:b0:520:64ea:c479 with SMTP id
 71dfb90a1353d-52600ae3260mr361406e0c.10.1743006065871; Wed, 26 Mar 2025
 09:21:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Matthew Hrehirchuk <mhreh594@mtroyal.ca>
Date: Wed, 26 Mar 2025 10:20:54 -0600
X-Gm-Features: AQ5f1Jrma_sj8nlFljLTl26W90CHX1EHr4s8UsykBrtqJI12sM3oTk_gErewTdM
Message-ID: <CAF3zC4ytEK4Gj+Qi3xfxMuzUsyMg9ZQ8J+C-u+eDuLTwz7OMjQ@mail.gmail.com>
Subject: [PATCH] added support for PRIME B650M-A AX6 II motherboard network card
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From 2bd405f7ce07d6891bff195c58c5b1a0c823a0ff Mon Sep 17 00:00:00 2001
From: Matthew Hrehirchuk <matthew_hre@outlook.com>
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
+   { USB_DEVICE(0x0489, 0xe112), .driver_info = BTUSB_REALTEK |
+                            BTUSB_WIDEBAND_SPEECH },
     { USB_DEVICE(0x0489, 0xe123), .driver_info = BTUSB_REALTEK |
                             BTUSB_WIDEBAND_SPEECH },
     { USB_DEVICE(0x0489, 0xe125), .driver_info = BTUSB_REALTEK |
--
2.48.1
