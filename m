Received: from va-2-46.ptr.blmpb.com (va-2-46.ptr.blmpb.com [209.127.231.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016B23CC315
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 09:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789897843; cv=none; b=Cc+tj5wamIcBxBW0CVereFfO2zd8N1IMud0n0kYHsGnBjbR/J2Hrf0G4lOxJzSTXcnNg+aAXrrAHuL9J8I0RNaJpBoVbsNSmENw3uIa9bymaWn0nOGTU49k61W1KcWZ2QkxTJlhlE1snit5kxCnFSCwy2/RxTiDULTLJOSfbzI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789897843; c=relaxed/simple;
	bh=ttOxI5Y229QMz9DbVBXaGOtOLX5sVcTcavTN6OTo46Y=;
	h=Cc:Subject:References:Mime-Version:In-Reply-To:From:Date:
	 Message-Id:Content-Type:To; b=PC7/eVWJiaCNM5frZiFKAgsEg2VNYMfypuwuXYRYE2HbDS2t0NGygVo20ui48wV30S/0OIZB1NJ60nGqMiFtoSkSM4VW8S/xKvGMv93TspGMW6SIYsyMdMxGNNsu6Zqq1GjHZbPN+96ICusLa7ftQdk1zWWVGL6ndDB6zZv+aU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com; spf=none smtp.mailfrom=bedmex.com; dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b=NFekP/8k; arc=none smtp.client-ip=209.127.231.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bedmex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b="NFekP/8k"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=bedmex-com.20200927.dkim.feishu.cn; t=1789897834;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Ad85azF8NuUWbQOZeE/AypEFZ0EAh0ubTf77I/hzDg0=;
 b=NFekP/8kvjF128KV6JcWpkz+nZWXoFosT17l7gTDQ5+M3zc0ii+kZN5VbTEokZwcD9v+P3
 hyIqFIiNgYe51ykpy+k0Cttayrw/MyiW4flTgovlB3Hvr/l89A+QnlZsAm/G5oNtzzaaFJ
 lq6vTSMJKH6wLIv8jzsEMieCmAOd6eKjqV/aJ88lA8sW6q4mJi4xUF3u2zNF8fhqyHF+C8
 +xFJvXe3ESQVOu2pTFItCKpqYiWVTBbPxOkXC+hpqyRdVnJ1p/mXHH9TfMRT7OwERBE8Nm
 5uqfNl9HDWKBJ3GxSz3PZr6wpxRCAsGPNXlmCXz9D3NiQNSpg94PiZRZxrt2Wg==
Cc: <marcel@holtmann.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>, 
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, 
	<linux-kernel@vger.kernel.org>, <zhirunliu@aicsemi.com>, 
	<dijiaxu@aicsemi.com>, <chunqiuliu@aicsemi.com>, <liheng.wei@bedmex.com>, 
	<yanli.yang@bedmex.com>
Subject: [RFC PATCH v2 1/3] dt-bindings: vendor-prefixes: Add AIC Semiconductor
References: <cover.1789897503.git.yanli.yang@bedmex.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <cover.1789897503.git.yanli.yang@bedmex.com>
X-Original-From: Yanli Yang <yanli.yang@bedmex.com>
Content-Transfer-Encoding: 7bit
Received: from bmxpxe-virtual-desktop.. ([36.141.79.164]) by smtp.feishu.cn with ESMTPS; Sun, 20 Sep 2026 17:50:31 +0800
From: "Yanli Yang" <yanli.yang@bedmex.com>
Date: Sun, 20 Sep 2026 17:50:24 +0800
Message-Id: <7a2c93192831b8756fe071fd60ec064a05703b8b.1789897503.git.yanli.yang@bedmex.com>
X-Lms-Return-Path: <lba+26aafac68+58014e+vger.kernel.org+yanli.yang@bedmex.com>
Content-Type: text/plain; charset=UTF-8
To: <linux-bluetooth@vger.kernel.org>

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
