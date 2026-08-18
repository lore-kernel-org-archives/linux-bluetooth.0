Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEBE37E5DB
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787017810; cv=none; b=Gkc+J/+ql9UEqNKXHvU6CDUZvCb9lVDOGY80ZdXms0ibWVhEBehkFR81WHnYYa1Cg7hXQ7IouSf97X46M6iymQlpMauEyxrsTINhl/pCbFJPIO/Z5G5HVUd0UOvstgHLtRUis6MeVrTPNwD2FkC3nM5Okohom1nMkXAlxrf/FlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787017810; c=relaxed/simple;
	bh=14ZJCz1b3PYPlQZdK+J8ksfvy5pPcXd3uJYOzeBcKww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNErOtFLV2tpLmFJGGuxo6V07GQ6QsDT8gjmBGLklvLjO89Eig+EZaVrk8n5vo4f0xFzdGejl02UCsD4yXIUjVYMJxdzhsKJoQo5XIOvihBV7pdwq+pxJPXl3jnZ4hLcrIzHC3VDLNcj2nwcqSIYLMAVjlfsfufby7BMr0SdTRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=e5ZaZE6D; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="e5ZaZE6D"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so4164669a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 18:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1787017808; x=1787622608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z4xDj0w3ozT3KZ9ITWnqYhsyzdEsf8N4l5Lp5dY2A10=;
        b=e5ZaZE6DY6oddnVCiVxe29Xwvfcn+XQb8R3RGQDCgRMDn7cPsS+pWKxljNUj+EgMW+
         H7ICrR0yXN9bSXXtaqoOCyzr85DFtkZdQqM26yJDmDA1dN77iWwGR3K59aLTc/Spcsu1
         VH/ZVjGFHk7g0zAvRgJ6PxyCnjRa5ikBh8upa6jMPDNEa6EP45xFNdIPUJgdEGDKLkIz
         pb3K1BicbZoRkeTXmx/vZvPhdACWLnu7iiSnweG1dzWd+czrrb7/4mcnpN+rgwuy7ShG
         k3vH8Jb1iW5xATkBl5pIpd52Vdlme44BOjMVKo5940kyOGq0D4dU8rOYM7KerBYL5zbF
         Y7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787017808; x=1787622608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z4xDj0w3ozT3KZ9ITWnqYhsyzdEsf8N4l5Lp5dY2A10=;
        b=LhFaeRTdAn6iggZGFeKZJSsXwTAq+jUrl+c+BuoobVrW4wQcBlJwIwv0XxqFLDWhQk
         rA1M1GsRymN7RlX2o1jc27pG3L4NaCUgti7CJAoXD6UW/3dg6xF72c2z3Dw34QqLfjBn
         ZAvMMw8fAuvfqsoHDMaxGnXq1o/vjXk22JS4BgdbXHJpPx5DD4W2JQpgcgkp+fNhlgLU
         x0S8WecDeYbuM1f0BzNSRDS9xRDAy8CeT/cc9hBOoAaN9QS2FiPX931chh6YRenJf8en
         xVPGJwGE3/kMN+o8CkOJqEMUNRlx7DT5poZSQXDXi7kawa6kj/E/AIX8dhDgLFT/hIcD
         W7MQ==
X-Gm-Message-State: AOJu0Ywe4YBY4HaIpA1C9tUUtXID+k9sWOrMs3ePxSubbutrpdW5i2Y+
	/883R13QOCDnG6xEXUTP3xj+1uH5sQpBBKwY7iPujcgpQq91drV2l4213+CUSpo09fA30tsS4xK
	i8nI=
X-Gm-Gg: AR+sD11vgmr9HBhkKw3iaE1HuQWi3lJb4aQHNWU9F0AJqulsx2gL09zCJ+mrp+8lbZA
	id+33WoIBXpzB9q7zVNuk21QmcZzi/XljVa7rPM9p0z+OgGAYjZguRXumq8tYcPXYorGv4Lr2L0
	2FJ0nSmpZIGGoyCxkEdjOPuIavXZm9jRA70enHTNIADhgLhySjBwPe4edtCW80CrWFII3L4EK5w
	UWOuJ54vwTrmLvjaciLIJ57XpiSfeyUKXLMb0Xdayv5xn3+8Ad9nTmIhWQ6RCSw8BkE+nxKrWWl
	SPYcGSIMcP+68t8S3IeaYbWqDWrXjs1VyIOAU0OxlmbqTCck/ANrNh0/04XmGxoFwnU86EllBoJ
	KBk7LlZp/hPG4QYiNm0pgU64lWqRo/pK3kw69L4vlPCQT0uyNbv1ow1js2FttsfHK5rOjalxX+A
	HcRcU17IQG4Zj/ZfvJRLI5bXVx0gsS9+BOLAuaH2EtynKlxIwi/ovIpksynjPEVSAf46ZlvEDWV
	i9epdU3e5WjK5K4hXRDVQWD8kbVHsiK+JgJtyVzOHNl28+KzssRONrb5788pabbY/EnWfN/Rdlc
X-Received: by 2002:a17:90b:4fce:b0:37c:6910:5758 with SMTP id 98e67ed59e1d1-3955a3dd55fmr5823371a91.1.1787017808425;
        Mon, 17 Aug 2026 18:50:08 -0700 (PDT)
Received: from TPE-build-server-2.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e84118sm7364750a91.5.2026.08.17.18.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 18:50:08 -0700 (PDT)
From: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
X-Google-Original-From: Kaihsin Chung <kaihsin.chung@synaptics.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kaihsin Chung <kaihsin.chung@synaptics.com>
Subject: [PATCH v2 1/2] dt-bindings: net: bluetooth: add BCM4384
Date: Tue, 18 Aug 2026 09:49:47 +0800
Message-ID: <20260818014948.996739-2-kaihsin.chung@synaptics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818014948.996739-1-kaihsin.chung@synaptics.com>
References: <20260818014948.996739-1-kaihsin.chung@synaptics.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the brcm,bcm4384-bt compatible string to support the
Synaptics BCM4384 Bluetooth controller.

Signed-off-by: Kaihsin Chung <kaihsin.chung@synaptics.com>
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
2.43.0

