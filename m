Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81A3364E8C
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847673; cv=none; b=m3oMzYDxdvftzBoA6dZg5pCa5EQw9qWfLowcu0s03sd/Upyz3W/JzqYWChLiaZSXidW8QquNG+J/a2J/OCYS8tNUx4hpVW9DoOsi++7j8d0BebO+DBcvPyPsW7i48XJ1TV+h1DKjKzX4j1Tj4iSIvB879r/sYLzSAjxHhNIi6WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847673; c=relaxed/simple;
	bh=uxs/O1t4MJgE83VLwLmZ5lLCdtI8c+c02jiKLX03oek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hee3pZIWahdDEcfvcKKJPgSCBTtFt6ezpSm+AcesgLjhcWGKKB9Wjy6oMUCbepu095oGg5j70Ii0fM2o+G1+01j3oxygH3QxO6HZLh52ijNwLkvOemNqJiQgygRL5tVzaAgkvFZn47sCdhX3BAuBljF4DsJfgoifo7LR/z9Q07c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxM/iGMz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxM/iGMz"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48371119eacso48999455e9.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 03:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771847670; x=1772452470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruQhGiuF9FhysktRv+P3PWPBS4mTnGG0CPJP27Fqqnc=;
        b=KxM/iGMzgwXL8s/ade6h8ZkXQehyLDIrxRSAJC8mXMnbQEHY8jRQoOBEFtSmvwxszZ
         /6jFqZjre5NvhPW58nl3GmNP+LDqEGQ+4C8TC7jpZ4GGO4yuMUAxdNCVYED5Yquh4w2H
         o92PNyIpXycPgWXQyjcd0/DmXn09HsribWm+avamosx5ovlbkHcVo8hCbHa+z+BJRBfA
         fV23F5lK3+7Hw+xHeDLMx37RsOVDN9F4QhHIpK3O3OoLtEbL8g48m2a+ywFezHtjS5Gm
         t0fChT4LO6XlkOPgLB+WZqDXgCiGGCqYZi3cEKLgOgUOJ71vw+vu8XbGOwvclsJ+MvTH
         5kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771847670; x=1772452470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ruQhGiuF9FhysktRv+P3PWPBS4mTnGG0CPJP27Fqqnc=;
        b=MvREBGyAzWoyc9taFV8JOiWl382zBWWd/BVOhZNXBPUgOrH/YSUa9Rgmx7R0LcW0vL
         NME0FjNMnMvgros8H/bZfrFSBPUEryn+SMNSXO/KJKhx9kVY4xUBlWRRFEw8noufBs9N
         JxsBSwzyLYKxLJl009vARjqvCqUWcBzSj/jcDXeaARf1HP3LP1U7U8tn5ewogAIXhG0u
         JaLShxfG/ZRdSM0jk+ZWoPRo8tQWdX28vNhp8AkPCRtOODGjvg+YuhDzAf9mGPNfKqhz
         1ielqKpfggbAmmPiypjP+BMj9kAvd0S3KBQAR1xZZmuDi3FDRIlpKTl0kWbaeJvf3Cls
         wicQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHha9ovVts9uDq8cz6UKv2qYJv1iQfvA/7u7CwUocQ3yODVqH/4ZvxAYI7bIT1kkCfvgWl6HUJoS4YwiHsuoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEp29BeVtG843yro202XbNQv5Q5N6nXvC1lIZGUaT8xK/3Pohy
	X+d0Fx1rPk3buB2b0zSiIcx4XqTOfigEVopDX2aw9NgqGOCY6anbmsuuOMFdgQ==
X-Gm-Gg: ATEYQzw2kp8xpi3ACLOLCBLqX3wyHflbzVcyBdnxFvxwykWnjpqjDrwNiYNyAlUNUg6
	NKmSP5xxDpQMWqhlSJlOUtQ326jvtXxjwgshx+3Sc7U2GNc1jSZSkLNzTtDTIZprcbQNHmGb9Pd
	uC+P71m9guq6wbszPTcMz0MeMTcKmry+Bblr7D+SmT0parPO/oN7tVevgHHVfSRqAtEXG4l/hHU
	Azjhg7F20iJUrafZIDuAsn8k1SBRheNiGOuBblEzY2jTKtPHl+McDJyEWUZrxL14hKWdVESrmNd
	DiQkT2kNHxq6XF4FilxZTGXKH79xQGpANhsdQe1mOl67WybZsGtPTMwLUo8uQUKfee+SDFXcZV9
	mlj8fa9OnD3s+U8KDGrqNVgN+gftggatIhtlK0tw047kL5xM52Oe7KYnyqq2Iug7v9k+nDuC6XO
	GJUGROw1AFyi9dowiNimU3icnWJAUZ/4V4O/5nS/fiDxR/GsedCOIy2GtRdNgxLsKA3dh5odsTj
	HqSHFW5LuR0cWJ/CpG7E7ZReDHgRHNYXTBcUUkO
X-Received: by 2002:a05:6000:4381:b0:435:96b7:e0db with SMTP id ffacd0b85a97d-4396f153a34mr13314214f8f.17.1771847670129;
        Mon, 23 Feb 2026 03:54:30 -0800 (PST)
Received: from Lord-Beerus.station (net-188-152-100-94.cust.vodafonedsl.it. [188.152.100.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00e8bsm15675668f8f.15.2026.02.23.03.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:54:29 -0800 (PST)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Cc: pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <david@lechnology.com>
Subject: [PATCH v1 1/2] dt-bindings: net: bluetooth: ti: Add property for enhanced SCO setup erratum
Date: Mon, 23 Feb 2026 12:52:55 +0100
Message-ID: <db4c7eab9d0c2f71eb61baff240957596f099401.1771847350.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771847350.git.stefano.r@variscite.com>
References: <cover.1771847350.git.stefano.r@variscite.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Radaelli <stefano.r@variscite.com>

Some Bluetooth controller/firmware combinations advertise support for the
HCI Enhanced Setup Synchronous Connection command but do not handle it
correctly for SCO setup in certain configurations (e.g.
BT_VOICE_TRANSPARENT/mSBC). This results in SCO audio not working unless
the enhanced setup path is avoided.

Add an optional boolean property, ti,no-enhanced-setup-sync-conn, to
describe this controller limitation.

Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
 .../devicetree/bindings/net/bluetooth/ti,bluetooth.yaml    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/ti,bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/ti,bluetooth.yaml
index 290abc22e18a..92ed443cb427 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/ti,bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/ti,bluetooth.yaml
@@ -71,6 +71,13 @@ properties:
     items:
       - const: bd-address
 
+  ti,no-enhanced-setup-sync-conn:
+    type: boolean
+    description:
+      Indicates that the Bluetooth controller/firmware does not correctly
+      handle the HCI Enhanced Setup Synchronous Connection command for SCO
+      setup, despite advertising support for it.
+
 required:
   - compatible
 
-- 
2.47.3

