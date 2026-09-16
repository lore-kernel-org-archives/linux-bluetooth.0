Received: from va-2-42.ptr.blmpb.com (va-2-42.ptr.blmpb.com [209.127.231.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29FC3890F6
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 02:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611974; cv=none; b=kNNvzO9jJ7y4yk6CHiG6Ww4T3uJZDAYkSnE6e365AaJUzBiculKHkeGIqUq+scfmSRETVKjhauHWDpGwEDuh0A6tCIJ/rXdsVh5vcqUKPn6YXx106SyVPfG/ygWEjkpWKyUIw4tzmALn8we0TzERZytBaRbWyv323R6GrcIOics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611974; c=relaxed/simple;
	bh=zDUZFrgLuHh9/3Xf59lwrfsMCBB76YQ7LBx1rTiBQvI=;
	h=To:Subject:Date:Message-Id:References:Mime-Version:Content-Type:
	 Cc:From:In-Reply-To; b=P94pPbN7YqXUUif0pmKWeBci7VIili2OWVCpI3gAnCbkiA67LzSFLy1eFezRz/fjpnC97JgnelqleoRGV1Fi8HLJl2e3bUpn5+FYY3Ru3QJ41U7OQdwRUrQwIxVQwrI+dWGKX4Q3YyzIKRL6XKLC5xeZrJdDKuir814GlI07jrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com; spf=none smtp.mailfrom=bedmex.com; dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b=E5AmyymR; arc=none smtp.client-ip=209.127.231.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bedmex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b="E5AmyymR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=bedmex-com.20200927.dkim.feishu.cn; t=1789611961;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=OVoaH48sl0PaCsa57Dt8gMRXpE35SdnCUjpKOqA1aLg=;
 b=E5AmyymReM6f8KJOfJkDoocWNzUUO0CzkgCHvbEhkAB5URFUHqxBQHW/PMc6+y95YfmgLN
 w80/FdSGOPZGBog8FrBVYsXDhKXqnbmBwLXfjLaQ4L0QTxTWuW+BgU7cznGRnYUhsYmUql
 g5dNClqBKYO9hsrA3aEiXtpa+boJB0CiqkNjw47SUsDeRSsolf5Vmsqx4Fo194qFdxnWAI
 tF1tij4jgjxYbFnNfjKKcEqTK820T/Ay3wA+J+diQfenRJ54BpFUmrlHl1Z1zEt8gBKDmd
 qT2dE9kDo53Dl4fC2COG30euimoR/75xCzBqDgpY6bathJ+xCRC7O2JuLDxBcA==
X-Lms-Return-Path: <lba+26aab4fb7+1565d6+vger.kernel.org+yanli.yang@bedmex.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: [RFC PATCH bluetooth-next 1/3] dt-bindings: vendor-prefixes: Add AIC Semiconductor
Date: Wed, 16 Sep 2026 16:35:38 +0800
Message-Id: <178954773705.2.9860089868793386321@bedmex.com>
Received: from [127.0.1.1] ([36.141.79.164]) by smtp.feishu.cn with ESMTPS; Thu, 17 Sep 2026 10:25:58 +0800
References: <178954773705.2.3446471521233620446@bedmex.com>
X-Original-From: Yanli Yang <yanli.yang@bedmex.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: <marcel@holtmann.org>, <luiz.dentz@gmail.com>, 
	<devicetree@vger.kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>, 
	<conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>, 
	<zhirunliu@aicsemi.com>, <dijiaxu@aicsemi.com>, <chunqiuliu@aicsemi.com>, 
	<liheng.wei@bedmex.com>, <yanli.yang@bedmex.com>
From: "Yanli Yang" <yanli.yang@bedmex.com>
In-Reply-To: <178954773705.2.3446471521233620446@bedmex.com>
Content-Transfer-Encoding: 7bit

Add the vendor prefix for AIC Semiconductor (Shanghai) Co., Ltd.,
used by the AIC8800D80 Bluetooth bindings.

Signed-off-by: Zhirun Liu <zhirunliu@aicsemi.com>
Signed-off-by: Dijia Xu <dijiaxu@aicsemi.com>
Signed-off-by: Chunqiu Liu <chunqiuliu@aicsemi.com>
Signed-off-by: Liheng Wei <liheng.wei@bedmex.com>
Signed-off-by: Yanli Yang <yanli.yang@bedmex.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 396044f368e7..a55d0d974cab 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -76,6 +76,8 @@ patternProperties:
     description: Aeroflex Gaisler AB
   "^aesop,.*":
     description: AESOP Embedded Forum
+  "^aic,.*":
+    description: AIC Semiconductor (Shanghai) Co., Ltd.
   "^airoha,.*":
     description: Airoha
   "^al,.*":
-- 
2.34.1
