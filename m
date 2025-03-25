Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF33E253F02
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891827; cv=none; b=DXhXWiMnXTg/NX8cEQwQIL7dwk5pYRVOnbCO7vrNVPeROTXwzvxcTxLjHnOwyum5f8QbMcP67BMCqbz9r08IroZLuChR+xIJirGBqiXBE2QrPtDkBQoZ+bJK01sPvnKUnlRxGll9CQmaw/p8letT+P/N7FKab0AOCPe50iyo21A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891827; c=relaxed/simple;
	bh=yLZclUa3yrCxx+oiKfvg1LAa+zRjj3MWIK+oUeCzN2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VDfnzE5Lg9wSNPI+xBxyHF6Klr2tfy/T/DxDX/lKNXGSNbK7N5YnRzeEobEQ6me2/8Ic7ZmQKqbDNVLrin3jbpCpsf5F2ieHCHs5QjucqIB01G3tNImP2TZyfwOKPKO48OkvYTNCPAiEZE831zB4GmFnS1JcO9kxNCqnaLSkG5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=d298JpQu; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="d298JpQu"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A81132523F;
	Tue, 25 Mar 2025 09:36:56 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oZuLkHEUdTyi; Tue, 25 Mar 2025 09:36:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1742891815; bh=yLZclUa3yrCxx+oiKfvg1LAa+zRjj3MWIK+oUeCzN2s=;
	h=From:To:Cc:Subject:Date;
	b=d298JpQu2UlPHzBPr/71Ph5Sq3Wi9DcY6K+ya9Xv8UTXeqS7qTJ0VpbknI29AejHl
	 IfUdeYTkuvUdRpBYuVR5h1OSakGloatf2easP2/RjJAU0AJywi2LFfqLX426+VHqOw
	 xLAoctKJ0/TVbKzHkhSTURP/GpECf/G9Rl+4MMwoxA5VAee3JzZYel6X3Y8pIr0G3W
	 qjJpJfj2JZlljeRTWz3Q/ZzTm5dNw9p9MxnJ2OiiahUER9ga4twJ/XlXJXHY4Hw4nk
	 r0J+L1BvSuhi/4sWIrTlsCuABXx/gI3zQArnvcqGvBTdo8RfTSONijdm6W47npOMTe
	 ++orID2WFEVoA==
From: Yao Zi <ziyao@disroot.org>
To: linux-bluetooth@vger.kernel.org
Cc: Christian Eggers <ceggers@arri.de>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH BlueZ] client/gatt: Fix pointer assigned with character literal
Date: Tue, 25 Mar 2025 08:35:47 +0000
Message-ID: <20250325083546.31597-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A character literl, '\0', is assigned to the pointer. The corresponding
comment doesn't make any sense, since '\0' represents zero and this
statement does the same thing as assigning value with NULL.

Initializing value with NULL (or zero) is safe and correct here: the
only case that the initial value of the pointer is passed to
write_value() is that the if branch isn't executed, where len keeps its
initial value, zero, as well. With src_len equal to zero, write_value()
will bail out and src_val won't be dereferenced.

Let's clean up the misleading comment and change right side of the
assignment to fix compiler warnings about the wrong type,

Fixes: ee750bbaf68c ("client/gatt: proxy_property_changed: check for NULL iterator")
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 client/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/gatt.c b/client/gatt.c
index 4dac88590..b18186518 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -3207,7 +3207,7 @@ static void proxy_property_changed(GDBusProxy *proxy, const char *name,
 			chrc->path, bt_uuidstr_to_str(chrc->uuid), name);
 
 	if (!strcmp(name, "Value")) {
-		uint8_t *value = '\0';  /* don't pass NULL to write_value() */
+		uint8_t *value = NULL;
 		int len = 0;
 
 		if (iter && dbus_message_iter_get_arg_type(iter) ==
-- 
2.49.0

