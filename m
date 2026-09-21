Received: from va-2-42.ptr.blmpb.com (va-2-42.ptr.blmpb.com [209.127.231.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E7A2E975E
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789975557; cv=none; b=Z3BLHnKszEB1eGGJod7tNOOxnE8hGfH/jzDyh1YXbpcGWZPG/2YrKc0im+oRIoWBCrnG7LeJqypDSju7n7wg8Nk/GlA4lzDGiCOOsPZ1lERxoVkht/HpJHrK+AGGTxb8nfp0/IETqsvDXts164huz2zP+crjZ2vdL0SATcY9OIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789975557; c=relaxed/simple;
	bh=ttOxI5Y229QMz9DbVBXaGOtOLX5sVcTcavTN6OTo46Y=;
	h=Subject:Date:Cc:In-Reply-To:Content-Type:To:From:Mime-Version:
	 References:Message-Id; b=Qp62+GoNtihsWmID1PIReslIUsZ/WGJEvQ1FDY4fQMeEM1VbN56itV1Fp6iV1I2lx2Hr+PVvnq8KVl+H54kLhuBniLjSst6XIbMjxsuJvMNUqM2IuhJ+CztaZ5+p/cOEKBHrQJ7AYXFgfGHMIfz3j+HtBrgKWBg1lMikTotWrLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com; spf=none smtp.mailfrom=bedmex.com; dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b=PZ2yi49t; arc=none smtp.client-ip=209.127.231.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bedmex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b="PZ2yi49t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=bedmex-com.20200927.dkim.feishu.cn; t=1789975550;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Ad85azF8NuUWbQOZeE/AypEFZ0EAh0ubTf77I/hzDg0=;
 b=PZ2yi49tnQ50CGjZ9BvgD3dZ/B943X9edyAQZ07l7TNXaS1AQu0dDcqVqkMt+Eby0mLzdm
 c4cGSWJPtCB2RxxNxaAoxumGzuEXNFW/EIrKmmCzUb53FoFvWFW1BzcmpBjwxEQt7TxZex
 q72O5RqzsEGBI6kXpf79znjMyMVbim1TociZOi4mHlEvg56pZA4gLgwppRbgGl0rKBH9+J
 U6RVzRI3ubPGWI0a4JHNOGojalDbX37MovfSFvu255RBMQD5cUCM4vIMhwCC4TSRZc59VF
 M/LAzynwEECmg6/5jWfVfzOEJuthyrtts1SPIwK6kc7jg5H1jtqHlZZRbo5MNA==
Subject: [RFC PATCH v3 1/3] Bluetooth: dt-bindings: Add AIC vendor prefix
Date: Mon, 21 Sep 2026 15:25:41 +0800
Received: from bmxpxe-virtual-desktop.. ([36.141.79.164]) by smtp.feishu.cn with ESMTPS; Mon, 21 Sep 2026 15:25:48 +0800
Cc: <marcel@holtmann.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>, 
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, 
	<linux-kernel@vger.kernel.org>, <zhirunliu@aicsemi.com>, 
	<dijiaxu@aicsemi.com>, <chunqiuliu@aicsemi.com>, <liheng.wei@bedmex.com>, 
	<yanli.yang@bedmex.com>
In-Reply-To: <cover.1789974593.git.yanli.yang@bedmex.com>
X-Original-From: Yanli Yang <yanli.yang@bedmex.com>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26ab0dbfd+0fed7e+vger.kernel.org+yanli.yang@bedmex.com>
To: <linux-bluetooth@vger.kernel.org>
From: "Yanli Yang" <yanli.yang@bedmex.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789974593.git.yanli.yang@bedmex.com>
Message-Id: <b6dc98c56da4c5ef8da3fad8004d6e0245a73b2a.1789974593.git.yanli.yang@bedmex.com>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.34.1

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
index ba2002969373..8d35a4b7d8ed 100644
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
