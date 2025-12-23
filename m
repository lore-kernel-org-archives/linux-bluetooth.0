Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D538132E6A9
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766507326; cv=none; b=L0Ia73aAXvTrmWPOqfKXmPqQFqXbZq8AUizFC9dh7SeXeUaoBKftSTSluV1JaLlse5CyaEGWj6hsbKLrq1+6dHLMAiZ9CZk9Rfx3xBzQZBN3A/qEklfW9OMxx1mXeaJWHgWzVbx1IAiXfyRopbseqGzLlPAm1+lNmVnkLatxXM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766507326; c=relaxed/simple;
	bh=NT3EUu2gue1PBn9dcBIiyhK0KWj4TJP1QKL/9KIT6ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D0fi6U9QazKW4co4JHhgIeKiyUEpArO0zuXx8pIzGkCub7siVrUQNtfL7tRPbuFD+gc8BZHmFvjDoEhLowcZabmnX7D3jNqg+lz+zpPE1Xtiu51T4EmOkO6GpC5FbM6NY4HEvruPtccNk5tNqEqc6piHYiFSR4t0C2wDY2Rvh+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0turn6L; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0turn6L"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34c718c5481so4978784a91.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 08:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766507324; x=1767112124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hvSNTB016/aQQGYSiM98JLspbj7av1fNEDKBctWMEEg=;
        b=E0turn6L44t09X3Uvq55EbdIQpI/2cnA90n8i1y0/WY7dGUq1K1elx4AKQyRmNB55k
         T7zQGLpr9IbOEi7k+kvxnII8A4obAK4PNB0iCSm6Dy+GPrthV0JJX7GaURI/KkJkXgJj
         X3Y8ML5AkFHl+hzvfSqgVOlSVLRuPPk7pTyhqSIrmNkJHJ+KMsbYS73s7WoBJDK6srEQ
         NUSGMqSI47YLea4Wzeu0+6NXPnsKtdiJaz5MqylshCRjs9pLAAM3cPkzOdVATrpuonaU
         2bVJQkgcc+Tx9B9QyrHrIw1M5JeKBqNY9CAB8nF+yT9ZkI3rPBX542YJrhIPvBlnZvd0
         3BcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766507324; x=1767112124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvSNTB016/aQQGYSiM98JLspbj7av1fNEDKBctWMEEg=;
        b=GdBW4GCAUUpAJ/XpzK/RVin7PtpmAmrqYtMx6ihVakp1MOu+0fowq7yC9f8NJ/BT64
         JZ6Exye2P9a7q+22uEn/bfZlAX2SQkO1A0jLRveIN8SRdQ4i0rmvkIb33xAgiXjDQ9p5
         QGoiNHSZu1kIN/gOiz6JkeyRdTXP/d0FQKCce3fp0ZFtaq3kO4A+dT2euKp+JrI1XliP
         yN0KO4mzhVwgGGBBdfs4uo3XQBE71libCAdxtf77VCQlYikWIGzF+Uldph9pOtdw5hSG
         OEioeCXA8Hw/B1LG7ESMSWOLJEa4xObmoeUrjCGyhDlF/AleD+x32yqrFLRilyD9jswC
         L6Dg==
X-Gm-Message-State: AOJu0YwXv65Eh8Y7FbyK6I74ssERgOPI5I7BnggRHdmhcR35QJpknubu
	bVZ367nHCgV9Iu3bsiSLfFv/Cjk02tCAvVv4LtE4gK2UAZNEqAUXko4ZpecbUg==
X-Gm-Gg: AY/fxX6B6C9ILmECOi33Wzki7NIFZ4JkajT/l8rmUQ/7AegulN2qvg3cJXj6fY1KVMz
	F+QyPp/HRMB4VmzY8BDh9YfEAsdlqvXFeqePEBAohbybF746AMh35l5X0kZ+WfUTAX8ahqdcQki
	Ys/S5vjKC65E/xH0TQ0Q2K1/wQUkAx2Ltv13rshez4cMAdbT7c/+y2/cwWqCd581MXXXHmaj6BB
	2lgb1Qz+ey8UbYq3t1Rj8lISWw7U77w/ZVPbTsT1n/8y9oP362EUte7hrJYBfz8tGNpJ2W3Oj3R
	2LbNWvxoQkjVlXsf0vtnpQ2Jskv9LR/EJgqMWsBmIX2YVT3I02bk0DXKebmLGrfetgAHoId4O7E
	k/LS1LVfm3Q5HC3VvBCzU41+t+EpC7SKoQQXAmilNTQAnoFso4ZLtG7YINONR4Rm6UUIAM8Pqh4
	WuoD+0JnMMtq3e
X-Google-Smtp-Source: AGHT+IHVt3XtcSyypPT32HEvPZisUwcPvykvfS8OYYnW6csALjBg3RfJXLjeyv0zdY2Z0P1zcT6xHw==
X-Received: by 2002:a17:90b:35ca:b0:34a:8e4b:5b52 with SMTP id 98e67ed59e1d1-34e921371b7mr12453756a91.8.1766507323762;
        Tue, 23 Dec 2025 08:28:43 -0800 (PST)
Received: from techieernie ([222.164.16.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dbd618sm16381155a91.12.2025.12.23.08.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 08:28:43 -0800 (PST)
From: techieernie@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	Techie Ernie <techieernie@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add Realtek 8851BE USB ID (0489:e112)
Date: Wed, 24 Dec 2025 00:28:38 +0800
Message-ID: <20251223162838.42725-1-techieernie@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Techie Ernie <techieernie@gmail.com>

Add USB ID 0489:e112 for the Realtek 8851BE Bluetooth adapter.
Without this entry, the device is not handled correctly by btusb.
Adding the ID enables proper Realtek initialization for Bluetooth to work on various motherboards using this Bluetooth adapter.

The device identifies as:
  Bus 001 Device XXX: ID 0489:e112 Foxconn / Hon Hai Bluetooth Radio

Tested on Realtek 8851BE.

Signed-off-by: Techie Ernie <techieernie@gmail.com>
---
 drivers/bluetooth/btusb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8ed3883ab8ee..f39e8c2f83a1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -522,6 +522,12 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3600), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3601), .driver_info = BTUSB_REALTEK },
 
+
+	/* Additional Realtek 8851BE Bluetooth devices */
+	{ USB_DEVICE(0x0489, 0xe112), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
+
 	/* Realtek 8851BU Bluetooth devices */
 	{ USB_DEVICE(0x3625, 0x010b), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
-- 
2.52.0

