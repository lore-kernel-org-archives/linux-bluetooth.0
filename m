Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EE33B6BE8
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779267728; cv=none; b=b+50AIYDc8uAf4OoSr14DhaCKIxJs5niHwQbO0bjhupBnj4zSeZRBE5wBjgqRfRB0yjIUlB0ynkNlM7dHPyWNG/rdqmYjsjbzeTBlgpcaYFjrr55CjR8AUewtnFREzzuHh54hPjeaDcjDpXp/4IYjsPR7sx7lUmoh5cmW2t6Amw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779267728; c=relaxed/simple;
	bh=dp5+POnEey0/7EXBB1Vf9pQfwHVexw8zR83v68QLvLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYty6qwtcZbnrD9zsmZGWvzhzUjX4MtwA/QoGyBMdnUisuANUyLHuFL1efghp7MuRQwmtJCnom8h/BwobJG+OyX47SlI+24J/WYhgMAFhdWtAERiSIPIgH484Uj4SACpH+4YqzoM30IdMUVLk5M65gs2STAp2g53ZCz7JQnYAcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=gVPd3YrB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="gVPd3YrB"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ba3e3c4f87so45941415ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 02:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1779267724; x=1779872524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+67D7Zy2FvckAbfClBrOfMt459tI3Tddj9D6/yQmDHI=;
        b=gVPd3YrBTfztWzLvpFxOaIBYE6Iu88o8/r+7jfZKEC81ZtbblQbAtohmK8RD3fPGj1
         BKJRQSQcZ2nF7ElMpKgqxMATLpbcRYwL7iHzr/GvAF2+gcfsGmCJLIfdX2BlzplX7Alz
         sQhp1CziPIn1bL/RkDbeGnEdBUSneqL1mivE5uzMpAu4m8qCpvxHX9gNRvHzZPV95XWT
         ddOQn68WtxCAv/0wrzc/8TFd9DWfMM2y9tucdebqXDyZGjNuih42+GLtT1cd2YSFGu7F
         M1znryS5CV4XwisDR1Ir/mkC0ehet690vQJphySO+zLVLnD0D/bKZ9R3SOv6aXHIEmWq
         6lcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779267724; x=1779872524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+67D7Zy2FvckAbfClBrOfMt459tI3Tddj9D6/yQmDHI=;
        b=gJeTKopOynqwjCNngraIT+VIUu6wnkoSXkyUBFquJWyvyJnoOt3QGh7C2fJRaNk3zD
         PG+k0e8DfLcCqQPNsX5HnvdRnS2Ux6m1Ru/WdfuVhTSa2NZdgCzjRnULm4uu3Oxol8dh
         PTjAd0ipig230DaLuevJMAzobtT4AbVodJVKBYK8fSzPZhUV1jueSxPW2jwccwOdNom+
         oQgqmXwRIKKvXdAeHx2NqjsYc/f6LoIdEkFLhuj3iSQAnHbD6j7YD2WDuWaC/cBMwAL1
         MU1KXkjujuEJ2vLcDd3emuY5De9zzv8vOf9f/H/wfSBcPMH2kEICZ1Q9bZwgK103/rNf
         3ZXQ==
X-Gm-Message-State: AOJu0YzUg5YoMUM3SSn/z2OaS1S7t8KwXl0u8HlXiTiMnPGuehjp57Wp
	O1zxfV46AefQMAd5FGe2fyOGz1EXdrtJ4Pk4xTE06eq90mmsnyXLywJOCbToW4dEtC2zN6TktKC
	zxnLMKw==
X-Gm-Gg: Acq92OHYk4jQSvlzgVLDi1FDh2nsKs8J1ehCEtOL6RsSb/Y+qoorLHU6vML4Au+hJpL
	HjrPg5Z4ghXpPd5KxpSgPcckQ4Or9o7mMQiiV+FQz07UyUooNmyonnSeaq+xi2OqiLL4cvLVRuS
	Hi5r5MRkFaHY17UAZ0xZBQEazfRNELFM9c5Blz6pYDm8Kk1d6cZhSmrClP3O6tYgAqh9LQYz0t8
	Njc8psUMUMaPOpKoTNRHAfpu+cScBIXwCZzlpPwIE6fWE38Db3S/yugOA7obQbw5/Z8bKrroyyd
	nYxVHIypDppqQejL+hoH/20OdjVyHlVAGc/JTtZ+RdVqBk3NSENRUJBjphkeZjKLvGlFb784ADX
	uzuswpLWCyWprpf/LQ2eG61QDHR7XvfEK43sPDpu03eQqh+KWMDT6mk3P6R/jzICuSbxyPBKWYq
	b0UzOv1shDS4wEXABvCub2pMkPIQgl8p3s/ra4nwEMVslA83yLbhqc4spdID75zziXcC+dAV7rd
	r3cy3lTDFEwvLt8YeGfhJ/7JueimCBUJhlUVjg=
X-Received: by 2002:a17:902:f547:b0:2ba:3e2f:6883 with SMTP id d9443c01a7336-2bd7e8f9108mr232567035ad.19.1779267724376;
        Wed, 20 May 2026 02:02:04 -0700 (PDT)
Received: from TPE-build-server-2.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fc47sm205333065ad.10.2026.05.20.02.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:02:04 -0700 (PDT)
From: kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
X-Google-Original-From: kaihsin Chung <kaihsin.chung@synaptics.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.von.dentz@intel.com,
	linux-kernel@vger.kernel.org,
	Kaihsin Chung <kaihsin.chung@synaptics.com>
Subject: [PATCH v6 1/2] dt-bindings: net: bluetooth: Add brcm,bcm4384-bt
Date: Wed, 20 May 2026 17:01:30 +0800
Message-ID: <20260520090131.3505676-2-kaihsin.chung@synaptics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520090131.3505676-1-kaihsin.chung@synaptics.com>
References: <20260408083217.1915419-1-kaihsin.chung@synaptics.com>
 <20260520090131.3505676-1-kaihsin.chung@synaptics.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaihsin Chung <kaihsin.chung@synaptics.com>

Add the compatible string for the Broadcom BCM4384
Bluetooth controller.

Signed-off-by: Kaihsin Chung <kaihsin.chung@synaptics.com>
---
 .../bindings/net/bluetooth/brcm,bcm4377-bluetooth.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/brcm,bcm4377-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/brcm,bcm4377-bluetooth.yaml
index 37cb39a3a62e..139d9b47329c 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/brcm,bcm4377-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/brcm,bcm4377-bluetooth.yaml
@@ -23,7 +23,7 @@ properties:
       - pci14e4,5fa0 # BCM4377
       - pci14e4,5f69 # BCM4378
       - pci14e4,5f71 # BCM4387
-
+      - brcm,bcm4384-bt
   reg:
     maxItems: 1
 
-- 
2.43.0

