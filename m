Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703D036B05E
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775224521; cv=none; b=OqcAErW5MxyZku1M498G7+7gdZqAtcdX54s9bXeykBEV1if4bmnCRqWYWukkgqTAfbZv8ArmGTJpGTn86kxXmJbxo5bj2HN5JOKi5xGgRIXM0w63UXYWeqWyO3yJ9p9O4ZDD9YzLa0BRR/22kNhqMkssYI0Pxsqomu16tKwT7Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775224521; c=relaxed/simple;
	bh=v0N8xo6MFWIwVEW8StRaWQk6fHZBEqBZmxy286b/97Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AabjlkpDG7UZSrvJbk66Ct9j5Ggd+Zk3jRwqtj3WSVT+N8yoIkaz46HhbS4rC6neF5m2XKefb0KZxpp49eZt22PSRQCIWmx1Ommp2AyFgYIZBbkJm38d7sz3veLfNYboeUHryvvoNnivLwuyRhwc0qgtjpE3GDeUG+i6tAxTM3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=pitMKBff; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="pitMKBff"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66b2d49ffb0so2563311a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2026 06:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1775224514; x=1775829314; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m83BxTeATfqd1UWKENZnthRfrI/lStR1Bw2POp0MJqM=;
        b=pitMKBffVYy8pS3eVc2jLbEX/YabbXEkPdmH3+7Bh0wvmHVH5Lx5UqB0JyiLfRV5Xx
         gyb4BVZJlPZ42jWX1Cg7AlUIMGub913rXtCxWz6CwzAJ0NYuDKH3zxo76LIz1aBxqD/8
         r+FJswYi/uKfh7LO+qGKIS/mCccQ0OQWapV678f/NPyiBwjhfpSilCaBOf15iVDIK7tH
         d8UTXctvWm21Z9uVUDxUFIm3NsQuXfrd2OCOge4EiC6JsHDOPizkPJ9I74LvvWZPilQ4
         G6N6PfN5NL+E/YSry+SEI3N/NiRkholMSOzxdYHv7MkciFpqH7VZC6+DJWGtoSr1YdyP
         JIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775224514; x=1775829314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m83BxTeATfqd1UWKENZnthRfrI/lStR1Bw2POp0MJqM=;
        b=Xec8NKmqvQxANSo8OiqdJZye/AaFeT+yaVI+MvUuQ6pli3FVfzTV/Wix0LRVQ3NDpp
         uFplAeMNbKe4cD1SgN5zhJAwx8QQ2rJgwTXKD22p2Qf5bsvFUgO8JheWIXcTNKxMCR8f
         vrxS8sefVdzpkddOHJnH5Se9Lh0ztpYgYbXTT1tlgxEO/508tuXg+0WBu3uO0si+gv/G
         oe7YMXGwV09Yk6JJ0W/1ek0NHCqG3XfcBJBydEiF8rZYaKHv7adD/dT2RVIS9m7Pj8Qu
         JCfZ4WEvnUZpfy3Kb9t/ewMshHl9fn31qo2g/Vt1fEMka8mX2H3RUfpwTltPaO/ilevd
         3Bog==
X-Forwarded-Encrypted: i=1; AJvYcCUXuAoSDci0eCzB21C00lf/6fg8GSDvp9PI31Kn/wYCG8a9nyBlODw7xbNKAyo746FLeyFmEtW3AxgfqbFtf60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmQVL0EgzS1wsYG6V/CfTvCqVCm+D76dCbn7bG2d7+CRFseaXl
	AJNDICgmoV5jGht4DFzC4AXmr1NeMNO7OK+9ZuMn/RE6sMW5DojL67lrzh+OlfoTqFw=
X-Gm-Gg: AeBDiesA3Gmy1zd3wKBlR4EXEY//3mcskZ+MNkbxwAtA8vCSSwOD8181x6ekhK77dkh
	wS7zOQUmF/Nv2HcYMZ1rQc+hrV0SyscmfPU5LHwYeeV6n6fcDZC611+/x6s+B9VBM8zWCIh16xw
	e/JeZrV3ktN9zlURNWPQhi46waxX69rLTaEBFrC4HSCLxNMlrYGiPudhMWsK/TurkRG4Uz12ver
	XZdpMsJV6UdHxTjZ9cTxL6HkK1IjhjnEEzEot3udm6y9RbcxaKB1OOK8HXsJUTBUd1/i/zbIPG8
	dpvyaz9Yl45xtkgBVfXyVXLqzfFITFMx4utiOoadBKP8qa+zFdaz5kmo4PYjztb5XAfSy9XO66g
	7PE8icG68og/uhek1Pk65n0UR3TGgu6GBJwWAhwQktGKIKS1oqLjdmQqSi9AR2XZvKHB5YfPWA1
	JwdLYv+ieY1niBMFM4MmG/aqFq0hhSUMNCV0dIPE8+ZEuLofh0Ib36iVo6mG04JgnCFsy2Zl0D+
	0YNtonJsTJpRQfldYW2Og7sAt9rxShuz4SilA==
X-Received: by 2002:a17:907:d08f:b0:b9c:10c4:e708 with SMTP id a640c23a62f3a-b9c67a34a9dmr143022066b.42.1775224514386;
        Fri, 03 Apr 2026 06:55:14 -0700 (PDT)
Received: from otso.local (2001-1c00-3b89-c600-71a4-084f-6409-1447.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b89:c600:71a4:84f:6409:1447])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c972e28sm198057266b.1.2026.04.03.06.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:55:13 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 03 Apr 2026 15:52:47 +0200
Subject: [PATCH v2 1/7] regulator: dt-bindings: qcom,qca6390-pmu: Document
 WCN6755 PMU
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-milos-fp6-bt-wifi-v2-1-393322b27c5f@fairphone.com>
References: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
In-Reply-To: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alexander Koskovich <AKoskovich@pm.me>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Jeff Johnson <jjohnson@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775224512; l=1270;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=v0N8xo6MFWIwVEW8StRaWQk6fHZBEqBZmxy286b/97Y=;
 b=lmSluzrxl2IvHohqbLRwM8ZeK0TA0Y4HsWh+y4B3jOfVOirTRYkehiK7ceZ42CboR9e5Ts5BN
 rMEWV8MPDVyDP+/ux64qnG2NCnxwOhrrXEqE51f24EPFDrswFgQmVZA
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the WCN6755 PMU using a fallback to WCN6750 since the two chips
seem to be completely pin and software compatible. In fact the original
downstream kernel just pretends the WCN6755 is a WCN6750.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../devicetree/bindings/regulator/qcom,qca6390-pmu.yaml  | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
index 47c425c9fff1..105174df7df2 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
@@ -16,11 +16,17 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,qca6390-pmu
-      - qcom,wcn6750-pmu
-      - qcom,wcn6855-pmu
-      - qcom,wcn7850-pmu
+    oneOf:
+      - items:
+          - enum:
+              - qcom,wcn6755-pmu
+          - const: qcom,wcn6750-pmu
+
+      - enum:
+          - qcom,qca6390-pmu
+          - qcom,wcn6750-pmu
+          - qcom,wcn6855-pmu
+          - qcom,wcn7850-pmu
 
   vdd-supply:
     description: VDD supply regulator handle

-- 
2.53.0

