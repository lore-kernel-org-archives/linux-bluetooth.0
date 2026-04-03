Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355E37881E
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775224524; cv=none; b=LWGPY62r3Ih7ViRdN++oo4JicxCurCs7dYNCJLB/kjH9vPKZjFXGAx7pTT17KH7/59Swgw2Qs6RVAxsPykj/dOqQt8jvH+hxnVTpf+utCr+sNUD14SG0qxIyb82BUpjAXyNr5VYJF3TzWcLJA69VStqv6ufoBcrF0O06HXaZzM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775224524; c=relaxed/simple;
	bh=pHexCrMEYsMQQy8zIs+sRrHJ1/ttZ3VMNeWvno6IS14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BNGN+3Xh1FQvdM7K7CtmdpFDtgFxtHrWSP6Du8fLA/6i3RWrXSkmK3/e/MBdvYNGTtlfuC+TmB7WEKRYE4v/94uItVEOH5rvtIpwvd80t9oIT5tCBMRT/XrFId3mxptyDtGOUrOzm8JxvuxqaEJ2TMe3ZGfPnYX+q7smn8SEzT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=lhspZ84U; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="lhspZ84U"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b980785a0bfso242393266b.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2026 06:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1775224515; x=1775829315; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YOCuD1EIBix+K2H4tXL5BYaPaJquyNo2g3/MFSpuIHI=;
        b=lhspZ84UwlEkwAdlqjW5n7AVdmK6VsAiJ46y93iH/lNolffn7OPkbasRDhuPcWmmuX
         BgOMcQcCeBibMYg/ffAMRc998pjmsYuwBu5oPVaP4pdWaJlbXPeIn4Fotyva5x8S2N2Z
         GPtxOVEb9oQa3XB23ngXTYBqUTWnXFSj9FexaYvclASjAlf0EvxQJ7yQWCPqi6hryNav
         fqsnytSrW3F19wTB1X38uE0aQCgxyEaeb1ztiAE57Nir4f9+L/glB++C83mbIgk0+dZX
         w019zZjzxC0qeMU0dlidIWaQwouTbryA+R77eZZRYsUxVsfoWcKCRTvxwFzP/pP5SD10
         nSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775224515; x=1775829315;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YOCuD1EIBix+K2H4tXL5BYaPaJquyNo2g3/MFSpuIHI=;
        b=a83EX8Wc3pQ7dw0pt2UNJTFI/MMiKZWzSvUYjHEBqdMma+/I+BK2etuI7M9y2lndlm
         NtJf257X8avbpJ55/4yTphX6jkspQNWE/Y+u6Vkx/8KWie1M4OPCoIRQRv4QISwn9TMC
         i1AkhjLMG1Gh3kfyLfetwlXmu0F0hVsW5TmkLkaEcrP2zpFx0A1ipVvj9CSek1qWFHj3
         H0cmLQp3m4fviL0hcY55MVA3LU7e1SyV3bzsQLp4XuhWAAJ0LfeGneZd44dxve1Xr+6j
         NGYUeSjd8mybxXJBvVhGW3LIpnVRsink1afqFOoUDOjY9u1GRQbtjayqUKxHZVuN+5M2
         eSIA==
X-Forwarded-Encrypted: i=1; AJvYcCXYLnuh61YaT9l1N9agETw4sCI4rotmHZsS8+dEYDYu2qAFW+o2WyknzNEyGNLgJeP9BFyxOT3GdgNYW3AF50o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQL80IkCR8qqXeEigJTOfgVic0vRKb8r2+naPkZBxaDD3e7+Is
	vD8ULmV+bPaVaOkym2fs7HTANji7GJDAtFdXw1vj5oOFQbveqbycTHkyw6CluEXHo+0=
X-Gm-Gg: AeBDieutUnX084ik5k8plLVkxyoqxWmCdvo2ser6SASFWLmwalCFq83xXBpcLziV1A9
	03DvnlhbsdGnXDmFCMMMJINmF+78kMXmXwbIsY11A4Mpw80IMug2DFsSr3WvzxOIYlKNU1YdZqc
	N5J0c0RguMnhcpkoqYu1CR0riUq/xKU9BtIEajMWrFsmGPwyoaJ1NG12vfimVfYfnSw4xxgvpFV
	8ngZCRnbRawTJK0zqX018NF4Z91FGXV7cw/GLU++RFhDv8etisvvvt/mm49O7gf2PNgaZabBmJ8
	B2EHtTG1l0zcH5VjuRym/tLaLM+tVIABpaHzeWyfoKCtzXJPIUDvAn2o9pq+PJlVNWcuNiBvi+u
	BbKOsTGJpxSnudRxgklsOtsd6C4JBl5L30zH1jJXIKIj+wF66rSF1Vkmf2gconFsnoquKyCYAdm
	47YrfaHgDx/qjNG/+t9DC+ZMs1RItCVMyEQ5wILtFJ0da4DCLTJzebVbO3ctiyE4U/S+NLBb3zU
	d2gm6FmjzwDInxPNiNbjCBEOLikRRIM3YGy3A==
X-Received: by 2002:a17:906:5189:10b0:b9b:1ea2:97d3 with SMTP id a640c23a62f3a-b9c67924de3mr103637866b.35.1775224515233;
        Fri, 03 Apr 2026 06:55:15 -0700 (PDT)
Received: from otso.local (2001-1c00-3b89-c600-71a4-084f-6409-1447.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b89:c600:71a4:84f:6409:1447])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c972e28sm198057266b.1.2026.04.03.06.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:55:14 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 03 Apr 2026 15:52:48 +0200
Subject: [PATCH v2 2/7] dt-bindings: bluetooth: qcom,wcn6750-bt: Document
 WCN6755 Bluetooth
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-milos-fp6-bt-wifi-v2-2-393322b27c5f@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775224512; l=1081;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=pHexCrMEYsMQQy8zIs+sRrHJ1/ttZ3VMNeWvno6IS14=;
 b=XCK+78nLfEjrwFntw0oaIZ6QCMaMqe0pdyMGnaJ0nfiCKkScqZ/j56Z2tA7Pr/+6ADMeTVzTg
 pRaItd1h5BQBiCmYvoHhG6jioNRifeUAqMjZopZPnAysEnsr3FFCL+h
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the WCN6755 Bluetooth using a fallback to WCN6750 since the two
chips seem to be completely pin and software compatible. In fact the
original downstream kernel just pretends the WCN6755 is a WCN6750.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml     | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml
index 8606a45ac9b9..79522409d709 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml
@@ -12,8 +12,14 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - qcom,wcn6750-bt
+    oneOf:
+      - items:
+          - enum:
+              - qcom,wcn6755-bt
+          - const: qcom,wcn6750-bt
+
+      - enum:
+          - qcom,wcn6750-bt
 
   enable-gpios:
     maxItems: 1

-- 
2.53.0

