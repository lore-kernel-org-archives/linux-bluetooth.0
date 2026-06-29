Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20AF3D76
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782765294; cv=none; b=AH68rXKodXtmhPg1h+J3X1TNYiXvusdfSFyN9M5MIhsbeiblgUwayLfd3YV24Ih5G2jG9/ANEFGYngPeFg9coHt2lST9Ogb8LgNH00OQnO6Z/MDNl84WmqJZWF4jK533xabc3n1P/TiPpXreAOfZso02kB8rh97KcEFsk4dOzqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782765294; c=relaxed/simple;
	bh=FVA31IKeqvqcqAETpvZvFzmB9ody0W+YeHYmPlrWMCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cmg4q0gdu/f+2U1Airyto94mDDWlWvhEmpnxQTN4TNYYygqwyn1RPEvB25F4Ctk0IdbAvq+/BeFQSTirD2dBLp0ZUrmQXBQ+RjR6taBFmO8pjXtKB39YlNIRP/cq86fgckZTGgEFomB2JT11oW5FpzjT7Ybso+HGOC3xZArNgAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2lDzBj+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2lDzBj+"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493a54b80a5so26978635e9.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782765292; x=1783370092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1tnIRfe2bguK/EU9hUHKI8euU6QS1GXoqRsN7SxaIU=;
        b=S2lDzBj+fSvKkWDN2VUWjzrlcq/x7CTiGcpfKkJCy4RbP5KTh6xKdpqx1+iUg1OI8c
         1zFNeLqU/pSOHvMwyfNbuO8b7wqNEQsE18WdoewIUDRHxbsqxPIAKd8NyODcgNHvoVe5
         2XDtv4/FrngCrWAvGF4e9I908WOgEkmJQOweNIK9+zyCnzqMdD1lZtD7L5qgpZpEUpng
         5vFeGoIrWtzUywJtUObB2WPcZxqwHUHo868e2tj/02nsh1YLM+5lagNz2xkWuDogA7sv
         ISS8nyjjMGfHRIkx6KuHLk7f6+Ymis0h3R4j7KrN0VsVmN5PeFJDizF9iFkbrPqAYNCa
         u/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782765292; x=1783370092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P1tnIRfe2bguK/EU9hUHKI8euU6QS1GXoqRsN7SxaIU=;
        b=RfzixVkOB/3wYNlhhWSuHqrVJ31rB+PbcqoSHl4gqcJhdKO8j4qdmHLB9gL096ar2v
         YC0hwSu5D9ks+SwbT+maO9EptLQ7Xs2y4DNCc08ilaKTRSwv1K1jaN5NvsxUuHP2zEy3
         xWM/QhYMt40I5c4wRjhDVZLMWSfFozygFWJB550X1dSMhJrIvHlopgBM1/MkP9frTiTk
         h1R++ZaklcmaQnGLs9ApGsvuEVHLpNkmDsgeeSAVIiklgJ/wjluM8pnd/boTtwWKjr9B
         L/LgCDyWPYk6hIl1+zW66dZkCiVVCrvMONb9sI57/Ph1J5r7bPK5qRRkJXVM5LzSWkgC
         wDVQ==
X-Gm-Message-State: AOJu0YwcgnxmsPwTNvmH7dgg9+exTlH7I1HE/2Gidt9lj21JlBKbJQEb
	KbrZvawGpKHqEhkn746lNUS3ekDt5RoYlECsFK2QnbcUlu9f3DXSJMhx
X-Gm-Gg: AfdE7cmzTiyLco8yiEMpt+47nkLjquszgSsaNk7iiFjUKZFemhxIgJPj8TbXWoZyIZI
	w1lU2lnMBoTbY7R9Xnwl/Ib7GsIyFtxn4Xa5Z06T2lllDJyWmBnfAp9ux+LBY/hTv3iKa6dMmuh
	bhAkA1YsYvc5VESYv6K5dlcHr0ILnCgPn+Mz0YuIwj+P7yS6BNBVzcwDr5miC3kqR5y83RZo+qF
	m/wgtGzpRDFUs7eaQu8WIg0b8YNCzjf1aJkrYVJ+3Lf+QJqFHVOI75XgcosK6jDWM/7J7S/CkZ0
	QYvZqwqnX4A8P0fQ/0SAkq6e5vE5MFucPrSe0+IwF2ebfIoT8epURd4113b1wiVtbMqv1IlCV5w
	oQQDDJP9iGu8Tw21zfrnkY0WeZ6bwZcLyBMHh9/by34J5KG2J+pUSCtsMGYuY7bqPyOI2tZHz0p
	dhC5unl+xzosm8Cw==
X-Received: by 2002:a05:600c:a317:b0:493:af56:8e64 with SMTP id 5b1f17b1804b1-493b82b9ea0mr15305405e9.32.1782765291880;
        Mon, 29 Jun 2026 13:34:51 -0700 (PDT)
Received: from tibor-herobox0 ([150.251.225.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ba1db27dsm2685915e9.0.2026.06.29.13.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 13:34:51 -0700 (PDT)
From: Tibor Harcsa <silurust@gmail.com>
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tibor Harcsa <silurust@gmail.com>
Subject: [PATCH v2] Bluetooth: btusb: Add IMC Networks QCA9377 to quirks table
Date: Mon, 29 Jun 2026 22:34:20 +0200
Message-ID: <20260629203420.24137-1-silurust@gmail.com>
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

