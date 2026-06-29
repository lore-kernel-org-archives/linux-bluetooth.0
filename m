Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB2718B0A
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 19:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782762829; cv=none; b=rvKbp4GqFyoCHbwQXSwZQKJY/cfsqC68GVabxb+APYw2oGstqthHLcLx7+jALqIVPjj3l7Krd6HJwwgr6PWT98/qtQZS458fKj8YqYoYFVAl1dEef3VGb2pK/pcvUH0RjCxttDlcG22NLfiTFlwEw+vGHqo+n/NTJN1SRjNZpSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782762829; c=relaxed/simple;
	bh=pdYmlox7wvP8FNPYtOxwVwhVgmMiuMfNVdV6AFzfvxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsmYpF6q9Cx/2kQYRMLteS0/5M1IB1IvJeLXciPcMfY9c++ppXFbr6arNpxGb2bqhRLAtf/CiA77ml6I//qXuaBg3lxK3HiRYfKMvurWzrNd//aA/TGqG9m2+CNbydtoPLs3/EvDPnrKxlpUPfVQ/4mKnqPqLuBkat9Dl3co++g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihFA4gsM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihFA4gsM"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4924593f45dso48631515e9.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 12:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782762826; x=1783367626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1DT3DoO2F+B/zFZkMDPupEIQfu/nZYFxRc1kTaLRjk=;
        b=ihFA4gsMyi9tNs44pUpharMVh56awJeyxKF0+actGs6N5erK3nCqc1FiPqBq5IDdsU
         RhZv8jqXlxi0cQxcb9hyeRThdCqUUGgF4E4GxGRFs6kwyhxIlD5zXS1W1oSXj55DRTdK
         OSyUk8KcGThK5OqdDxt9inkBvzpEa0u9o4L8Gyj+UiiPP8JO5xbvbMub80CgUUvhgXx4
         Dy64+5TBSqUeUvWCIF75nn3Kaj3n3+JyJWKimSlY2r/hS3L9uq52zzfclv41Xlj3M8Ii
         CtfHU7+mjkvvbsCQHh7AFbRX01iZ+j6/NDYWoHJ2c3ZD/y+nj+p7+iTgVFDz2j63Kw8L
         SQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782762826; x=1783367626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X1DT3DoO2F+B/zFZkMDPupEIQfu/nZYFxRc1kTaLRjk=;
        b=Nz4i1OsVeKhQoLc65EogRmxLom6KHs/lpUSkfbfUxAONLGgg6ANuFQ0bsmCj8SUGzZ
         VkS/iVRqS2xzE2nrsXK45uaSE+1ZFkl78JWt2ktm2I+sINlde6qPUiHlZw5VdmRpRJyt
         jFyAUgX4REGMLFXTi/SssJOX471wPIS26D5JraLGSf0uiXhT+1OuzvHkxkWNr79fCRy9
         g+LnJS8jLZj67jsLxf/Nx4O5o9ocAAFbcMqBamm8yDqCbRil710NP6iQpVF9MGl4TaFz
         lrEjU/pGksSyoHfUND5zmPE9v3CnnM/SboEygWgatwZuJfC6GCfxBzHblyI9si/LsFNe
         cf9g==
X-Gm-Message-State: AOJu0YxZ3x5Pmmky55pa0+tqt6dwNMCGeEKAvc22kJhRRWIWJPSO65EM
	CoMaEY0EfP2x52tbfTeN5wzrntPl4sUvRMeVPKV5gHtsysp3h6QkY3js
X-Gm-Gg: AfdE7cl0DgNfw9aOdSRa6hQGY5Xge960qnEN0Lxd3UhFndueYhzJD90n+0dQ584epgO
	aNPy/ZarR1BNvl1IWgM02x9shqEdxa5n1vVgSV7Snvx2+TZOvFgVz/ZrP2iz71uRmxW18REOiRv
	+n1iShDpd/ftNL5N+o5s7wWNwzYV/EgaYBk2WtgIySkUybco3OluHrIT+bYZenXyTCpNnOzU7hF
	jq3OntcWSKfuHln7qIUhq40Ws7KkNt9nCnwvze1lnwmAbr2qFpbVrvmln34qyhybYCeBNng6k3P
	rmXF8qhlM4gmdSTz+fDbYEqrpGp8LZIm7QhTgKAQv6omUBrVNOhl7sIObB2qTgmTAabIes0l/xU
	o0KKN8h+iV9mG3/1xYHwLNqsMshhb6cnHvr8k8C/kbzjc4n6sHL+F6OsMaddfUeICuFa9leQVOO
	arucIjVjch4QLzAA==
X-Received: by 2002:a05:600c:5392:b0:492:4cce:53e2 with SMTP id 5b1f17b1804b1-493b8281690mr15979945e9.3.1782762825880;
        Mon, 29 Jun 2026 12:53:45 -0700 (PDT)
Received: from tibor-herobox0 ([150.251.225.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8ccc639sm10841515e9.3.2026.06.29.12.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 12:53:45 -0700 (PDT)
From: Tibor Harcsa <silurust@gmail.com>
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tibor Harcsa <silurust@gmail.com>,
	Copilot <223556219+Copilot@users.noreply.github.com>
Subject: [PATCH v2] Bluetooth: btusb: Add IMC Networks QCA9377 to quirks table
Date: Mon, 29 Jun 2026 21:53:34 +0200
Message-ID: <20260629195334.11944-1-silurust@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260627153505.20173-1-silurust@gmail.com>
References: <20260627153505.20173-1-silurust@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the USB ID (13d3:3503) for the IMC Networks Qualcomm Atheros
QCA9377 Bluetooth controller to the btusb quirks table. This device
requires Qualcomm Rome firmware and wideband speech support to function
properly; otherwise, BLE scanning fails with HCI unexpected event
opcode 0x2005 errors.

The device reports the following in /sys/kernel/debug/usb/devices:

P:  Vendor=13d3 ProdID=3503 Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Signed-off-by: Tibor Harcsa <silurust@gmail.com>
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 08c0a99a6..7963fd48a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -297,6 +297,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3501), .driver_info = BTUSB_QCA_ROME |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3503), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* QCA WCN6855 chipset */
 	{ USB_DEVICE(0x0489, 0xe0c7), .driver_info = BTUSB_QCA_WCN6855 |
-- 
2.54.0

