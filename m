Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BF238553A
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775224525; cv=none; b=Q87zWXecEqHUL/L1h1PffrMDoveqkaQtveenB0nUq8+4wG5cjGlG5jHFvghYO8gzEfXp45FMJt1L+rpGdzbx7srqRb0pdoiDqad/OjErniUemX/Wr7/5tL6zYI9+tR1WPTDxC9kbeF0Z9cQwWKvH+KtsQRS6m/Js0P6aHQI/lro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775224525; c=relaxed/simple;
	bh=bX0RSkEhHMY0CQeWiiphb/xjS1x++AeW72AXUrJMhfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z5BFQm5h9HyzOhGH359WL4dF3O5lIb7OtfziljSWRpYqjY52RrYZNJW5u9i1a6mDnFN1EQF2Fy3ryx4S293CPl2l1HO8NdhPkZr1193Cv8ywYdaBgw88KdDdzGcc+FUm+nFJbDhAelJNxHJfaXktSPUvNvvfPmtl4y+Ma7q+fAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=eMcDUq4k; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="eMcDUq4k"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b9c745e18a0so125305566b.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2026 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1775224519; x=1775829319; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00QsAJAs94/ZqUyZhadzKRAFArz8oATvGeKh7GrAju0=;
        b=eMcDUq4kDbXtJoLjYpvN4DIgSbal4SfAiQ0Bxs0F6N25Fnb15cXqGtpmsKKdnHVpq8
         CqLdZzyAlFZF0Pg6taXCioUz7T70PZlIyUcFqndMcZvtkhWtJdV7ifrGRv4iQoEkzWt+
         LutD/N5YlETUMeRA+y1H5VXvk9QNwV6ekKOL/TBPSmBoBbOkbWWsjWr20FJbFexyVJA4
         6z7DNHy3x4lAfjn+IjV8t5AFlAvu9V17eucFr2iaXX9QwJGtVsziti/srrzqpDfl2WgG
         XPoae8DCwCp2WfzEYiwRVA7m98eNXSbdZ/wcKK0Qz2SJyVvWaVboN2jj8VpK3NgT+PSs
         jo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775224519; x=1775829319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=00QsAJAs94/ZqUyZhadzKRAFArz8oATvGeKh7GrAju0=;
        b=Zh4PyCABULlfu4L4pkry4Y9CMVgxQBeH3c0NKrc5GvaEqHZ4muo8x2/+ee4/adqnR7
         Tra5AcIpKWRiSDo6eFzaO1yPghtDRx5xG4Ji+7sIgyUWHUOuYw9NsQyhyXMGRK+rRxdK
         kM+NDFRKJAuXYFN9hNwkziJjtKvNf0wQCZwPXovATxCoUhvycLJx/FisdV47IA6rxXnP
         p9iskKnfJYoQbBXEk8qY0uHdqnNg2+ms9H2Vh5e+EOKyI5D3lTiqamLPm495cRDysptp
         98eAyWLthwBpN20w27eVjOSa6WcPSlrp75mGgQFQVem56Hbe5ZcynvhDa/RhMukoduAr
         3QnA==
X-Forwarded-Encrypted: i=1; AJvYcCXKIOfjjzFgnX6jhKq8x0byRjUcopU22Bt2GKGQNB0wqCOugXOOmjNLh68LCcGe+i58qO8s/8oDGf6bp7SFuEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1HucoKnGF5aL30cykSY4+NIUB/49LBAFArfn1juSMgZtXOlIN
	DrPrMoWINosUrCWRDtewvxtvSYaxmHRyayEuJOjs/qgxpolLiIsnAxS5wawcT31IfT/W8XDKViQ
	tmYausBw=
X-Gm-Gg: AeBDiessaWJoDB+99+mwYHq70R9ZOqecTu3z/UirXt9kD8CDuVIxn8RVClzoB7FoXz2
	E+GAN3HBupw8C6p75AvgBmP9BnegFvcVuiOfJDd/dhFj8D6bBgQ/IOlaS7/PNKU7aEExr9T4+Gh
	4OCIpzYNu2W47LH1jfIfhZ2FW2Wt0ycWAi+LwAqsEckjOfnAtC8sTos+rr+c1PVwM2ACeeWTGm6
	U5BR17DvBpkuPE2XIMSm1QxPhLErCG2ZqnuFtK0N2tJRv4JXVoMxHVbwp5DHHPkuIY1lXomWMOS
	qY6r9GqpYOAYwgWp1hUYKMyzlUYiAF3MTRpEyDN6ZDyg77SFi6dLxI+rwGvCPHOGwl0Mb8+WkXq
	JHtVUB8fU1R1lBICrhdILouCWm8u3EJymg9A1rGTJSc7Xlv29DZnRGJXfKybKl7DTciVJJSMr+x
	gTz+nsPGl5yDo0fppV1M3gqw+loOZcWL6ukSCX639S1qBOSn64P2KJS7a/rz/sZXR3Mjt920iyZ
	N4r1gas7cItJjOR7+pE+x5q+3EBilxWAsvOzQ==
X-Received: by 2002:a17:906:6a02:b0:b9c:cb1:a61b with SMTP id a640c23a62f3a-b9c658742acmr142510866b.16.1775224516202;
        Fri, 03 Apr 2026 06:55:16 -0700 (PDT)
Received: from otso.local (2001-1c00-3b89-c600-71a4-084f-6409-1447.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b89:c600:71a4:84f:6409:1447])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c972e28sm198057266b.1.2026.04.03.06.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:55:15 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 03 Apr 2026 15:52:49 +0200
Subject: [PATCH v2 3/7] dt-bindings: net: wireless: ath11k: Document
 WCN6755 WiFi
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-milos-fp6-bt-wifi-v2-3-393322b27c5f@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775224512; l=1239;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=bX0RSkEhHMY0CQeWiiphb/xjS1x++AeW72AXUrJMhfA=;
 b=DTJTtJ7BKJd8qPXVe3nd0JrxaYiQE2N8bwiN41dxZ5jihuyHGd6fmesGzuo/2w99jisvtHofF
 h8Mx18K34cAAflNUNQSKgyj8B17L/9Yc4dJVyM76qpuovDBjx8PeKjI
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the WCN6755 WiFi using a fallback to WCN6750 since the two
chips seem to be completely pin and software compatible. In fact the
original downstream kernel just pretends the WCN6755 is a WCN6750.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath11k.yaml    | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index 0cc1dbf2beef..94f8f8551756 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -16,11 +16,17 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - qcom,ipq8074-wifi
-      - qcom,ipq6018-wifi
-      - qcom,wcn6750-wifi
-      - qcom,ipq5018-wifi
+    oneOf:
+      - items:
+          - enum:
+              - qcom,wcn6755-wifi
+          - const: qcom,wcn6750-wifi
+
+      - enum:
+          - qcom,ipq8074-wifi
+          - qcom,ipq6018-wifi
+          - qcom,wcn6750-wifi
+          - qcom,ipq5018-wifi
 
   reg:
     maxItems: 1

-- 
2.53.0

