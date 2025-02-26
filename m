Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B552222CA
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582366; cv=none; b=iHZeSkQEwwgm1p0JSAxfsxi9JB0TrfcgessgSxeOWzXgWsAdybSRsg9MxW61TJQolQNFzOV++S87845jTLLKA+GflYqx6TfJt3nPwrGToykl4HPTLauRRJgH5AuBcPYxF1WeMOSJLEPsdYXHbszJgk5rPRJUTPMSzk+oRRAXBSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582366; c=relaxed/simple;
	bh=vRZ/bL53bzCw1yyvx7x26B2NV6/gdhQUZCkdhC0OGdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pqiLxKf5DDilQZvA/BbDmd/adDC9L2zvy8ZtxP8YzRLG5E3BUts94SlMADJ00HP6HdvFZFhxS0dVgMnMPEV3nVFjtqbgmAVdbhM2+t3qSzNAA52En+4IOpIpHPQ1gZXqq/IFRk9POjqFXmmhRlnuFts8tCTev5Qi79w9KeOoJJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gxUH4izz; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gxUH4izz"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390dd3403fdso521157f8f.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 07:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740582363; x=1741187163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDaO3BY71HAKuoTRgTuSjDJ2RyZhtvPwoshdk+/Y5f8=;
        b=gxUH4izzZNiVYl5smDjfWmZA8tXw3XS0YRbmScQcw01u50o2Ea5WshtGZTvl4oKJUd
         46RCeIZpksEhW3PkuiiUf5Ny+KOKpoF87qX/GWUaD9cEBLtQDJwr6VyRh2DKX/3IquL7
         8jA0FnwLGby4iQvHCJF4XDru2s/JNw8cgSYT+li+h0Ne3xR7GvnF5byaWNqIC0bWUG33
         MARui6Rg44YEzcSGPEce2v5AUL8sWgZuTVHfGGeOlwpIb3B7tYxr0tuo7fmCIggx8RVw
         drH2ZPNwfl4WtjKaTTSTUl3xTnRE9OXRLKyGvgkPc29gcEky/RudPNBUGrqw0q5PDP1m
         nwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740582363; x=1741187163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDaO3BY71HAKuoTRgTuSjDJ2RyZhtvPwoshdk+/Y5f8=;
        b=C/u5Hq/c7WRpJd+8WHgRr8R/sPQhFGrObhYYZ89qPheMTv3AwzdhGjPsVWNdhcsYqX
         s+7/2pelF3uUzDj4yFEaICp5J+9ngyZNaZUuScW7osZVSYBI86SeWQRTuroK5RnM3RUK
         ANHpZCt2QI5a/WoByQ15RlUX8+LZ5KLXSc+WmUgfQmO8sSDRgvyV9IMkCy4ckoNrFERY
         vLFhRYfQKPy58kuhMJBx5gLy3QdDo7FcAgrb3J+/Bm9nUetH02ygmYaR7PkWBzzwMzOc
         YT8+mrU3Pb8QY/2cT4Qc+B45/ghMcxhduUjoQwZMfuasS6vTo3kHwFhTbHeakIbKaJWC
         jdOw==
X-Forwarded-Encrypted: i=1; AJvYcCWDnYPm8JIUn6mQgWrf07tJ0v5aFRhhXWZt0icWA/O2uuVs/WlBxGQP9eyG1O3SYILbcf6arLZRh9wVABudSpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXyo8F6wmyVus8cyDDDxzQFEzpTxdLz3F8M2OMcwe0ZfA16WEL
	h7ZKlBuIwH9UK+WMVtdgLHFrhf7mFWlplVrlIs9cVXDJwogvZ9vuKPoCgGkiDa8=
X-Gm-Gg: ASbGnctA00fzW2RZU3r2+d7qLTjxuabkIMqGvkjAgp9qK8Nzzy6ubkGp1TKQdRkTjNy
	r97HnnJBh6ZLnwufnnhyDsVK6cP7QtRHfmV4B3iF9FV9iqWVc03zXKMu2aFHbS/ghRTJk8R0AYT
	sz9hbzQXchyvY8Nun8L6FUnFCKDxs3EEswrq8gzFK95VweKVDO3TsKGxSyKPgq9k7++4qJ0ns/o
	87L5ZcRCzlAugFTJXshyiQUTDGxLc6f+tfB/xfyP5zDw+DrOmcuKrWUdgX5Yr8Ob2Evg8XdP5Ab
	wXzbVzQl5HkuE8iOM3i2u3M3DjlDBls9JulphGjV5gSk
X-Google-Smtp-Source: AGHT+IFxW406nMpESeWK5wpzY01hTDi5yOdxdaSstbB/R+kzLqrjAky18gB4IKJyz6Q3V4p/RrZsmw==
X-Received: by 2002:a05:6000:1848:b0:38d:d5af:29af with SMTP id ffacd0b85a97d-390d4fa3e25mr2712639f8f.49.1740582362779;
        Wed, 26 Feb 2025 07:06:02 -0800 (PST)
Received: from loic-ThinkPad-T470p.. ([2a01:e0a:82c:5f0:ad62:b2f0:914c:91ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8fbc31sm5768155f8f.85.2025.02.26.07.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:06:02 -0800 (PST)
From: Loic Poulain <loic.poulain@linaro.org>
To: neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org,
	robh@kernel.org,
	krzk+dt@kernel.org
Cc: amitkumar.karwar@nxp.com,
	conor+dt@kernel.org,
	linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org,
	Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH 2/2] dt-bindings: net: bluetooth: nxp: Add vin-supply property
Date: Wed, 26 Feb 2025 16:05:53 +0100
Message-Id: <20250226150553.1015106-2-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226150553.1015106-1-loic.poulain@linaro.org>
References: <20250226150553.1015106-1-loic.poulain@linaro.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To specify the VIN supply for internal buck (1.8V). This supply is
usually referenced by both the bluetooth and WiFi nodes, as they
share the same combo chip input voltage.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml      | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index 04f55fac42ce..275c1e5a6f72 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -50,6 +50,9 @@ properties:
     description:
       The GPIO number of the NXP chipset used for BT_WAKE_OUT.
 
+  vin-supply:
+    description: Input supply phandle (1.8V)
+
 required:
   - compatible
 
-- 
2.34.1

