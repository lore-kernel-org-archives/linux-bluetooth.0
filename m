Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34B7441633
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787828598; cv=none; b=KktIfhsXK2XaVTX6hGWyrU3rvoOxLl/g50KTn87Opw0tXGFvDbND5kBeWQ7rhunF//PMc9fwpbYV30KFmI0O3qshexrPLgDPzyfiwIc0zCQetzYMmNFWlIvgD2uOt0gLYMPRuiBNhp32jO1XIXdDOaA1Khd3TR1vQ5+jShEIccY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787828598; c=relaxed/simple;
	bh=XTB5xuF5uY/8UybwiMT72tjE0QsyTO6cDMaO3SC6jUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LU/lfYYtpk66++xXqRm+o9Jjf/3yHwmp0ztoiFTQXPDwdvbvFuw9XNwwdO5cbx/DKjKPdD1WjiZWbMseLnuePrYLNq0ALZly94C3SQxG9yRRD8ohR07Vd4QYNH9ZsRETpYiHs11h4mYM/bx4h7hEd8LOgzuU5VVRtAUrzWvr2Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=ByUayKZg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="ByUayKZg"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d71ae3455aso20088655ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 04:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1787828596; x=1788433396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8bfzXAsxwnf/4gzRnr8dq+1MNvADmSphpzw1aSpUIeA=;
        b=ByUayKZgiG1qPK0/VMaTxk7RP9dnv8e368axD1gqNs/ezBTbfumzCGh+VB6vnh8xBa
         uFWpWPjf1/hLXlxpTNw9uyny7u2x2blPwtb53O0/fQb/ZoTruPzpTi9cYL+hFdU/9zpS
         qkNIJ2AFw8ra106mq/cNO4ifByjkdxyvtsyaq2p3EinKiOujOtn4ue74QKZDXOVW+bku
         u6hScyxUbrP9nS9CRzJ/UKuudF/Gz/sHoYkuQtgaJpeaVGy/aCrwNk+vEF6Myr9UZ2W9
         LUBFf97541D0ak/rDtxIHUGiOcxKHuw/4/3YTTkoCFzyclFVuVZGnUmjGUZ1mOCPhizG
         zhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787828596; x=1788433396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8bfzXAsxwnf/4gzRnr8dq+1MNvADmSphpzw1aSpUIeA=;
        b=poVcY+Dr1AX1mfW3Kz5nGmV10RZxidxYDJ/2JLCUtcsSSyDzJCvGkGdVi401NjvCiO
         Y4ykQ67MqJui9DEmA/M3elJCPSl2zzdh+53tg6iKaoAqI3mBRobe0x+99gRz1++HJC8l
         zNZdlUptcw9349aEL4SaBeeEZMVgWPtsCT5Q76mkVELR2nqoCwaLjZ1pLaRBa1XxcL4Z
         STJ+T0Dcd58Gd4f56SkG1wJlCt848eT9kpEMJePThFVRjgDrnN1sy3NFNeyoaukm/RMx
         zwo7tCfshPh8wW3yWGkxXaLySoBYoH3S3vNa++FdxQZdwo0aWkqvu5pRDMK29dyTa9op
         JCbQ==
X-Gm-Message-State: AFuF++m7jpbjArbRwCWJxIW+H/7BBvC62EJrUExouhmBMtvQUX7KTGbq
	fc+3JFx1BO+V2AiGZ7DxS+kjG4cwrzyXzYS3FApKhUSDYTgvS/QR2SyUdvcuVEV6PfYYhChuzov
	R5544APA=
X-Gm-Gg: AR+sD12yJPfiieLps94JXY93iBa4bzKl0F7hugpShu1ZjRgOV7kWs/DvovVocyOCONU
	W4Ie/VDGrFNjU69n/6p2sVco5kvl04RSmEWYenHZXKr4DuHyXphRNaPvt6j0X9OUwL5X5m3GVft
	zWnP6D3UuacCc0Fg7B8hLy/sxth8raqws8+TLcLCuTFa6wElySdw1bWDzaTDvFPkyECvXvFXHww
	Dk1l28KIFvcqPsl82okDbasr2IFjjqZItk8izoDYZxHkifuSbPajg0fgqUO4PgqkOvjlsT2VURE
	TQBknPatdJm9oraLEYTb2glvOJZhNAauWwWoRaAmRxSEflPqQvHnNJTfm3RY79uIvkTSQfqSerH
	nYaFvDLQdJXFNhUJwbcAKBlcMQmlPN/kj1rUuBROUFnboovM1FXwnxOpVU3Madkx0UUNX+xs1Tc
	tByi8wHmi6MDkpdSfaiRIkzvIE4igNDKJ8IUsR5Z0iafKTV6TVzbdG1MuDMd+8Hopi7/aInAn1U
	6xvp1ICtMVpCza7wEaS2QJiyQ2XXEf0Ir35DRxq5YXrNYuF02HJfgjO6u8pEeO9sSX4Z27NQTKQ
	xg0J0y4=
X-Received: by 2002:a17:902:d4c7:b0:2ca:6d87:cda0 with SMTP id d9443c01a7336-2d7079fa6d5mr226663585ad.6.1787828596313;
        Thu, 27 Aug 2026 04:03:16 -0700 (PDT)
Received: from bt-tpe-server.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d704c4bea8sm15081585ad.82.2026.08.27.04.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 04:03:15 -0700 (PDT)
From: Andy Chang <andy.chang@synaptics.corp-partner.google.com>
To: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andy Chang <andy.chang@synaptics.corp-partner.google.com>
Subject: [PATCH v1 1/2] Bluetooth: dt-bindings: net: bluetooth: add BCM4384
Date: Thu, 27 Aug 2026 19:02:41 +0800
Message-Id: <20260827110242.1203546-2-andy.chang@synaptics.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260827110242.1203546-1-andy.chang@synaptics.corp-partner.google.com>
References: <20260827110242.1203546-1-andy.chang@synaptics.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the brcm,bcm4384-bt compatible string to support the
Synaptics BCM4384 Bluetooth controller.

Signed-off-by: Andy Chang <andy.chang@synaptics.corp-partner.google.com>
---
 .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
index 95501e858e6f..612d21123aaa 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
@@ -31,6 +31,7 @@ properties:
           - brcm,bcm43540-bt
           - brcm,bcm4335a0
           - brcm,bcm4349-bt
+          - brcm,bcm4384-bt
           - cypress,cyw4373a0-bt
           - infineon,cyw55572-bt
 
-- 
2.25.1

