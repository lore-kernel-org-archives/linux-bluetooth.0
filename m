Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BB03E6DCF
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872958; cv=none; b=EKGOhpkcvgIL2UhWDbJVvphD07USBUxZeOvzGFo3AwGz/X0YylfUD3JRMAYflRlraLirK1wQIeiTo4efRTey5ikIm9KBLCBSepJQTR+u0d2AcTtgaXrPw4nKcr2FSG3DcrWkfy4wIHOBsY4LKZ5uZNaJEoTyWnIkR9UE9+SXC0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872958; c=relaxed/simple;
	bh=U6KnoeAETP1m5hguoRuypA196uPeJEMIIHuIq1Tny2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dyljly1v73UFo2RWHsvJrA2eIRnxSp/gy8Pg/ERD/ziK1AatQs3APQZPE/WCwUrSiDlxpmNGFM08z6V6Ri3HPjtzADxynDzOsMexEVOwtHYENoFUndNoB9dw1C+TYhIjXYvMuFbWOIO+gsCzDR9ERinAmMSlAnz3hDT4tAl412Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=qA7/mKAH; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="qA7/mKAH"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b45cb89f7eso77381315ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 02:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1779872956; x=1780477756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9IJMJXfRZjRGguojSjLvij17reY/DFrRYdSWxgmMi0=;
        b=qA7/mKAHXBRU/Nef6pQLQELb0y0ZGATx2x6DtO1EPLN52xt3E9HNtAv1AeI6axykLs
         aLGtkha6XG08COzTM1X4xLQPBt/D6TwjXMi27gU2ownOzT1PHlCtdFS6B+45bZGoe80u
         q9BA6P9yI3MhAXVKZGMMfYC3j3a8duOjgH/5cgTdIe0dyTmnlaUM4NWYgkRdXYNoBtIx
         2kjf1+wD0O06wBU8rBlx14BEsDt3PqCoTnRwIYuhQPUSvwg9KRZ8PIauC4OBPlSxK9Kg
         +b8zGYxzT9EhbPxKSn5NdgLjajRoMwg/jVPosw4Za7EZfl/fsuSj13iEvLkqfCgvAe3L
         luVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779872956; x=1780477756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g9IJMJXfRZjRGguojSjLvij17reY/DFrRYdSWxgmMi0=;
        b=rRMHTmwNuGbcRqVQ1Hml1dCNjO2anV15GJWMq3SLof7unzoViHzLj2oNtg5po7sQU5
         JDkIRISJbrLytn+/cjZOMUAzd205jW6VUgVuwM2d4ToFezP4GoHt/obzx7twy9Y/D/we
         yTOFwyWiFiFsbakaUgFFAHVAB/qjqNljwN5clp5pscxspCZdj75BvRP4kEZjLz8GaDrd
         gY42obOR+qNbtE6vxt4l3ssdN6nIViTqbjCxqoeavHE640uoM69zImdszgxOoM6vDUwV
         mAveegADXp6MbdqWvnPZm+rjbj1SD9aSBJgkBGePWnKmHFlwmIVvXBM5AKeIRzHciZ5w
         d/BA==
X-Gm-Message-State: AOJu0YwGOzv+cwVsNZIbamKuDf/lHJHnaQkxYHqOpRDyBnap8YByJJtw
	QmSmQr3VRsqC9keUUGsT+TqhQRtYKrMupT5iyQO3zFfQ/kI7kvRGTWXpqeMIGrZSo9y/hrXpiGb
	f58ZUFQ==
X-Gm-Gg: Acq92OGFuP11jqzBZ7V/u7CnkcFQap2pGNsSJ3IxF3eWABYWDlWjM0bVx+Wv84+Gjtq
	Mse2zVT3DwaHlOyXPoe0ZuNZyVZpVzckG2J44QYQS7v6ePSCmgaMgQYwuE5av+cYGOd+GRQpHn0
	u8retYhYX8sYeihJLt2LjJEsypwxWoXTzn7SIYKY5N2/zKMzZxpfAWdmdCyJDZ3AyWlXWOZx/b4
	/r6flNL/IzxI2OTunskUu//x7CbepOAGrtXNMV7RWiVCKLTwT0ayxnRNhocVkq/1Li7/IPfYKbo
	ggNiprc2Mfi2EZ9lIayVsPR1d5ci5gQNaYDN0G+BSZ3EErxHSoTLITag6jjUkcHSvyRaAVd5lys
	D3kxvM7r7ZWTlxbF5f08qLSI3DoJiaTQRwzBy0qQsiGQXRqZCmZp5GjKVBnLRzFfvGxouQIjuDJ
	wb9ptB0zTHDbFVEZzMdb/jP2V19Tim4FDzaabJThABeqZeFvbJGJmrtXIKjLPTxKqOskH9zGZRn
	e7nC3TW5qF2ehE5Rm3xUxmCzXMbmJ5ZeZr2pVY=
X-Received: by 2002:a17:903:198b:b0:2bd:9766:bd2b with SMTP id d9443c01a7336-2beb05b5994mr242492405ad.19.1779872956387;
        Wed, 27 May 2026 02:09:16 -0700 (PDT)
Received: from TPE-build-server-2.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm92430365ad.2.2026.05.27.02.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:09:16 -0700 (PDT)
From: kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
X-Google-Original-From: kaihsin Chung <kaihsin.chung@synaptics.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	kaihsin Chung <kaihsin.chung@synaptics.com>
Subject: [PATCH v7 1/2] dt-bindings: net: bluetooth: Add brcm,bcm4384-bt
Date: Wed, 27 May 2026 17:08:48 +0800
Message-ID: <20260527090849.3647601-2-kaihsin.chung@synaptics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527090849.3647601-1-kaihsin.chung@synaptics.com>
References: <20260408083217.1915419-1-kaihsin.chung@synaptics.com>
 <20260527090849.3647601-1-kaihsin.chung@synaptics.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible string for the Broadcom BCM4384
Bluetooth controller.

Signed-off-by: Kaihsin Chung <kaihsin.chung@synaptics.com>
---
 Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
index cc70b00c6ce5..404853933b7c 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
@@ -26,6 +26,7 @@ properties:
       - brcm,bcm43540-bt
       - brcm,bcm4335a0
       - brcm,bcm4349-bt
+      - brcm,bcm4384-bt
       - cypress,cyw4373a0-bt
       - infineon,cyw55572-bt
 
-- 
2.43.0

