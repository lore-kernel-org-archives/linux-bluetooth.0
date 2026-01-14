Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0653A641A
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 21:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427416; cv=none; b=MR8HZltPdJpbzauS12Ksqnh3IhY2VjYENiDemVbRSQ+AgZn1y91W9wFj9QcnatlshdMgIaPyvD1Efr0Fpxgf5kpU9kgn2M0CUnDtNZW1WuCwDA13oG4Jyn05fHXiDeT9ZjchIqJy7/5KWDQn4RkaH1RPBXzD2bezxw/iUzxc4fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427416; c=relaxed/simple;
	bh=8+DUQDEDLv1Tf7nx7T/OWeJNKDGqLQ7n6CkJXN35IEA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8REp2EbGbdWScC+YSXXUL7zMbYDegiC2buiMysGcmrWSo7mHAO6DNT8wAmsvjwG3i9nAdo46wC4I+WusJnUfL3X8nFdzM4ZeauBN7k9dud2m9br/VQD8j7P4R8+57ejx6j3010qwFAkS8glDRQB4hMlrERkXucveVq9oTK73WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0si2lvW; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0si2lvW"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9413e5ee53eso206941241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 13:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768427393; x=1769032193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FV/6uKsFxEvsgbL+MyzBSWbTHLznZnBXjAofgq2LMbM=;
        b=Z0si2lvWk7zDf8mp4RdtNvul2T9znf9919xKnJ1HwNB1UMIi0AIBabnkupXFv9gB7L
         3xy8f/21SxxoI/V2xt8tPBAOk+8koy/ZCeuwrGkV9q5PfZreWIQTyKNSBddUBWU4A1kJ
         yux/rc1JKoHAwEd8veEZkgX6sCu3BHthGH6oITdRxO2Donete9wyLJRxncxN53L9wB6B
         pz8cWUeuQJ//ULuA/ZyKKCtsPgllsJuIP8R6pW43hE9r2vsSPjpxiQGd3muCx6H6SMUs
         V9xBY5Zsxkf/ZWSV+lA4v9Z636S2p6W2OGwIYaomUbQvRO0jFZiBQcmrfVnttvkSdyyp
         s/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768427393; x=1769032193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FV/6uKsFxEvsgbL+MyzBSWbTHLznZnBXjAofgq2LMbM=;
        b=NyBljk/Yog0i/JA0+/Toh0hVpV+AKXVW8GkPxiSrxGT89lPenBTMNiAO9G6OSpl6KD
         H1udLo0oNPlFSpARS5/pyB0iZZs0iM1wmT7UEDH8PonCwhOGf3oNSU/gUjZOu1AOI4Od
         wx5CiVMgpInbTpbr0ngPLz/CERz9Sa6NEiV+/gXC1M7j/tY8VKU4x+dW/LfZWFk87IWY
         yUFB3p7oN3FxI/jI1KREzMatvxMBNdXzDr8YgINHXtQ3zjkei1wuW7FqBTguUfdDY6qo
         6iUspJsIBnozthRGHRzAMi5T4MgvqZpLFygDKyk6oTHymRQlazY7IYDG8is3dON7XmAN
         z4qw==
X-Gm-Message-State: AOJu0Yz46Ix3sxdSo60zorDbPmazxVZsvB/9oOrsqjOO2WHoZOignTfl
	mso8WyI+gLhyX4trbmfCNqYyi5oZUB3xMBUycRCrLRBhZDXp14Oi5n8mqZp47Q==
X-Gm-Gg: AY/fxX6IklOr4m1yYay2+VidiDrIEMwqwhbmAVWLwoYlnul2fDjinatSHb5HlkT2kw2
	27BdomYJVMA+tUZjZcLLRlxNYF6sQcmpSkKmVlGareX5HBmR8wqYx0WfzroXusmLyiyRdNR2jJ2
	4IvHHap2VbjAjst9AuRfP3G/bcFkxHFMij92Cdxi53igdfVV7E4MYeaPZjHieP7OhUGClNElcrJ
	jOyCfPOE6lHhWAg6QWn54tok+tBSiJWjDw6Ps6dXrQAdfCnX7+6s+ULUQvpTVU5JIs+HmnlgJiY
	DyUGotGLlgui7sYZspM2aKK4kVAQD92NmwYlf2Qb679TsXRDMl7XjQf05rOmuW+gJnkFwlQowmf
	VTXrNdzmjstR2lw4cJr5FACrIG0Ec7jeHQpRL21FseAW2LHTGIIFkfYICMPY7xYF+Ya970WJGYm
	D6sAqHEJ00nOtDg3Vm2TIuKxDbyNv95aSo77zq0XQGdWrqwpK5XWifheTt5Uw5kimmYNqTxbL2o
	B6Guw==
X-Received: by 2002:a05:6102:c04:b0:5dd:b287:e5f4 with SMTP id ada2fe7eead31-5f17f23b837mr1874302137.0.1768427393525;
        Wed, 14 Jan 2026 13:49:53 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ec772af325sm24985649137.10.2026.01.14.13.49.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 13:49:52 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 6/6] advtest: Fix displaying RSI as a byte array rather then an address
Date: Wed, 14 Jan 2026 16:49:37 -0500
Message-ID: <20260114214938.1417430-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114214938.1417430-1-luiz.dentz@gmail.com>
References: <20260114214938.1417430-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

RSI should be displayed as an address if the intention is to use big
endian format.
---
 tools/advtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/advtest.c b/tools/advtest.c
index 706b2503b74c..7e744dca8021 100644
--- a/tools/advtest.c
+++ b/tools/advtest.c
@@ -53,7 +53,7 @@ static struct bt_hci *scan_dev;
 
 static void print_rpa(const uint8_t addr[6])
 {
-	printf("  RSI:\t0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",
+	printf("  RSI:\t%02x-%02x-%02x-%02x-%02x-%02x\n",
 					addr[5], addr[4], addr[3],
 					addr[2], addr[1], addr[0]);
 	printf("    Random: %02x%02x%02x\n", addr[3], addr[4], addr[5]);
-- 
2.52.0

