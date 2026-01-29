Received: from mail-vs1-f68.google.com (mail-vs1-f68.google.com [209.85.217.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8627374748
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 23:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769728937; cv=none; b=B7WqMHbvymmW6b9m3PWPz9Rh91Uq6LEY4rOToB9rY1Red6iV/j+YdzHwHcXl10j5BvIocX1fYa+1wEC0zsBOHhKL3dl9Jd+Y3mpNV5ENcPGP+Pdx85V/BLbdejKpQTn4KXaZk3hzLs7XsMmlG8bfcxNC1iL1hluOreTG61dIIY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769728937; c=relaxed/simple;
	bh=Yo2dnJMKIIRK3XhJwA8lHZ8Io0tLZoR/RV/TYJwYwok=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBczKUR8Dl/ssXSmV3e2/+ZUcySjMCQZloLdU9kthSnS1fxNpSpSwkQ3m1IWyrFMwMCb9Zf8OaIubGqThmq4NWYcp9B9zdBdgMJa+kC1QRGb2gd6ba18L4fdsTlitoty4djZd2g7wEScBNuBDRC48kOoxDCuDzfLw3VWs/MGDDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DstMasd7; arc=none smtp.client-ip=209.85.217.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DstMasd7"
Received: by mail-vs1-f68.google.com with SMTP id ada2fe7eead31-5f524301a76so1661111137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 15:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769728934; x=1770333734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rcmv8V0LgEtmnRj8orA35ZQL6VByltU2Pph38tCJxfA=;
        b=DstMasd7t70Q2ThYC7cP64QFuT6Z711JQ4IubyIIAIcbrmzIQToxU/rloAv7v+Mic+
         2ro1JzatfwomJi9D2esUvov5KpcFKIi4/dsW+USPOa4lEFom4rFydhWH6KYDoES7K5iH
         Hp+MyWBgdYHNEx/KvrOV6CjSdlvuecLcCW5mMA9/yxY/ENWeCUQ4dH+1y6znHSSabJD9
         r+OhP0+vJQs1DSgf1Y5l9G/lsUwdT7LMzVpeyIuHiNTMnX7EI7iyJZ+xg5Gv7i8DV6L+
         Y6wqq4qN7TtvzGLut5SC6VjiY+1YkQo+tWIDIf/OpJIdOofKpcfxiTQBG9DdONZ1oiwN
         ZB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769728934; x=1770333734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rcmv8V0LgEtmnRj8orA35ZQL6VByltU2Pph38tCJxfA=;
        b=SOnKoWmS89F1AaikKQrH8vgPTcXyO2nVnMrgbOPkW6pAVd7K2TrMvQYPZ8tQo87aBc
         Tpz+4/ugVYiZzx2OLyzUFtujV/S5cixIBxH6iqLCIF1CFG3S83wdfmgxVewzhDIQS/GU
         7wS8jbX0R8RxHGswEI5b7wfA5fnekP5MY3K+0NpoY5fLxtWFfB4jlcL0O/JeooxbP2wp
         wiIyobjblGhhl195y9fWhOJGCeBXDIHYHJ2SuZnQl2n8E5xW+ZzOBVdIMmt+zxkWjla/
         QrMpy/ndGtMRrUBlm480saiIOz1IVw7werfn/vqlozX1G3jYY+Dh3eBFDkmeau9RD3md
         i66w==
X-Gm-Message-State: AOJu0YzBCPIOAUc4SDKwa9pSFTBrhIHFRoz/+xGdCboJOMz2IG5SfF8Q
	ohMXMG1nPQ050y2QvOm8Xeu3rY7G3JTUp5E0fS/vdGyPD338+HH29H0VpR8aBEGx5RM=
X-Gm-Gg: AZuq6aLWFvPLNXt2rn5xBNX0CRvja8W2uRjty0hyvoEmsBs+8eavcvkJEn6IFnTbal8
	il2+j8erQQzJpo4GnEWepYaQKdBvLtXCr3mdTBQCLuQA1uVLyzBn6ncOEOo27dFkV71OXiifDc9
	FCP8ESkxh98JJR9tR+k16hdOogjIVwNO9Avn06rm2972vCKrpDnxVwB9lePg5apmXqPqJqvBWvs
	LQyzFFWAMUOTZ86/Teb7RZ1ws2fM4JtPzNsUeamJw2N3NoS38wNPxSzE1VVhQsr+T+hR23UPlKe
	1GvgZlozRscxHnHAXRXJJuxkJXv/rfes7L23NXc3sOfkzyJUQ0gRa0lwifjSF50cxz41xIXqr7j
	cKXkyEFmJ0engAJdsS8lhVq3/V2m6BX2jqh5bsSiCY67Q6xyxFuGFORRdIieXJomN3XgBSjvWJr
	z+0IuReRgn+pp+oB1yNK/7BbD7QZVYn1s2yhtaj66JwXlzmCNGs91PZvBrv5pLvdQpzfrwlynp7
	MHCRw==
X-Received: by 2002:a05:6102:e12:b0:5ef:a3c1:86e1 with SMTP id ada2fe7eead31-5f8cdbcdd81mr1533459137.11.1769728934410;
        Thu, 29 Jan 2026 15:22:14 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948724cb7casm1535890241.9.2026.01.29.15.22.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 15:22:13 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 03/15] doc/bluetoothctl-admin: Document arguments and add examples
Date: Thu, 29 Jan 2026 18:21:42 -0500
Message-ID: <20260129232201.1049568-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129232201.1049568-1-luiz.dentz@gmail.com>
References: <20260129232201.1049568-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add parameter documentation for the allow command explaining the UUID
and clear parameter options for admin policy management. Documents
how to allow specific service UUIDs or clear all restrictions.
---
 doc/bluetoothctl-admin.rst | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/doc/bluetoothctl-admin.rst b/doc/bluetoothctl-admin.rst
index b0f7f94c18cf..635582ea104c 100644
--- a/doc/bluetoothctl-admin.rst
+++ b/doc/bluetoothctl-admin.rst
@@ -27,8 +27,27 @@ allow
 Allow service UUIDs and block rest of them.
 
 :Usage: **> allow [clear/uuid1 uuid2 ...]**
-:Example: **> allow 0x1101 0x1102 0x1103**
-:Example: **> allow clear**
+:[clear/uuid1 uuid2 ...]: List of service UUIDs to allow, or "clear" to remove all restrictions
+:Example Get current allowed UUIDs list:
+	| **> allow**
+:Example Allow Serial Port Profile only:
+	| **> allow 0x1101**
+:Example Allow Serial Port Profile and LAN Access Profile:
+	| **> allow 0x1101 0x1102**
+:Example Allow Serial Port Profile, LAN Access Profile, and Dialup Networking Profile:
+	| **> allow 0x1101 0x1102 0x1103**
+:Example Allow Advanced Audio Distribution Profile only:
+	| **> allow 0x110e**
+:Example Allow A2DP Source and Sink profiles:
+	| **> allow 0x110e 0x110f**
+:Example Allow Serial Port Profile using full UUID:
+	| **> allow 00001101-0000-1000-8000-00805f9b34fb**
+:Example Allow SPP and LAP using full UUIDs:
+	| **> allow 00001101-0000-1000-8000-00805f9b34fb 00001102-0000-1000-8000-00805f9b34fb**
+:Example Remove all UUID restrictions:
+	| **> allow clear**
+:Example Allow SPP, LAP, and DUN using mixed UUID formats:
+	| **> allow 0x1101 00001102-0000-1000-8000-00805f9b34fb 0x1103**
 
 RESOURCES
 =========
-- 
2.52.0

