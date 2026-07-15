Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC31F2BE65F
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784135279; cv=none; b=gA3EXO88TSCeXwXvTsZm0uqM98H9FguqviOcukaxKBHsW6VOPVYGL7xwJjZFGfz2iBJCEKqkYwkYXoXxa33GeIyu2QTdU2XH3joS4kBlkYnVocNt8OKLflJd4gcZNpXT0gEX+1YxObpAB/WrVUFfT72/vjK4ab4P2S4D978MFQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784135279; c=relaxed/simple;
	bh=1LOIgGkNhWtvpNB5GFlamxLNJZTrtDiC3LQ0Ygd7J6g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=m4U1K+gCzuzmc0+788A+08ot/bU0aGlpd5P6IMkmpSR6V37JNrqJq3mZFpae3OiqvLlx+lY+jk7f+ja7D43FpolBNgZjgFzhMMWsmDV4STU/EB9Y3slByiH3YxWN6aLIVmBGE5KRk8vGuy544Tav23qfmneSYvKgChtveji0G+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxyDGuyi; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxyDGuyi"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5bfc5b77c02so4031021e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 10:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784135274; x=1784740074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NzPetb1NHtzdEgZyulOXVbrMIY179nZN1u3KYQBWtxI=;
        b=JxyDGuyi9CkfYIBH4ijsuWbTq2z0WPsokm8meEvHrC2StMOeMJm1R9n7MExue8gsI0
         DLi4LrlkhL9+Si8WR5XH22YTI6CfHoSUA1avmlpLSTp6HPq8t22GlmKZmAN4053nadaw
         z8uYB+XNDIZriGBdcFk7C/UPFTbOy8VrEKyyOZ/M2gu/Iv8Pvap/B7Pv7TDJL/OZhxKN
         gVIVtCMWwRj+i7bWqeWkuZRAGUT8c6RzknG+AaDHIhiRNMDjhuCjTBBwAHLn5CZO1OdF
         8VS7j4uM0MOY6jtmmWsKbhY6VsQ110KcfppX70Zj0lov0Aq2ysOyITEFjyyNnvovZr15
         o42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784135274; x=1784740074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NzPetb1NHtzdEgZyulOXVbrMIY179nZN1u3KYQBWtxI=;
        b=RSMM2fbDGKeKa9qiQogtIZXilIt6J8h7W+bQ+9qqs+xyOAMiwpqlNxak3pd7e/Z9IW
         kWaOHmSeNGRBD0CR6aQFtP4Gm6cK9pmXg8Z0+RNGd1mhhle5fXoo1JUap2vyQ7yxLF4o
         RR79S/s2mqnqv4LN9P8kPjJj1YM5p3I5zoQR7OZUnleeoMwwtM5COezXsix52dbpILYW
         atumZmKTzZde6yF0oz5ajPlZkuxjZW1BTIDFyPQOvkaOZoNUFjNe23W1VZnY2ClzgzOK
         N0bkr8CJ4ng4UsLDkvWZBayC2+hAXfTt+ywK7peVczHfWTlUar12cMh1uJ/SuVbe3DHn
         /yLw==
X-Gm-Message-State: AOJu0Yzfx5E3GubPQ3j+fBFQGDjRu1CbUBXe2o4hX23JakpfOVy6dT+e
	yckUccPFDseHEkREdi1Yh4Bxm1l9oNhlVeg7SxJgt4NrQbwJyJOnOB9En7nqH5OCH4s=
X-Gm-Gg: AfdE7cmPZpqicinhYQq/Z7UqsXYv7MP0WRHilIkTenIe/IoqynTttStzzzXd8G0w3pO
	geefP+OPZLiO0P6QQTfqBW1bjWRONcu08XGo9ZUJRWjkSUF6gjQSnQn8HBnxzbMvqMqOZKNUW9/
	vEakpKDagW10OaTZ1UtQ/er+9ytD8XJNGJfBXX2hCBnZwsJFwcQZiYVoa5NAi+SeldjfYnRFDIn
	dFGQk58Re+tfNe9LbpWSejo1kfFIoO5o5JAbEuoUnxLYyUigS240OUDs0wTmRL5G8svtK2HAh45
	r55un8pYISmwujlfDWqG2fP7TO6csQRUKwb1XRqo6rLgCE24CThfnhMEDfcEurmlNJBUfTZCHic
	p8JLCm1Zv1Y3fCV/o4ULPRDVpyNpjJXhP1DdWnR8ALUlbqSTqJ6jhkyQ4RpuDzHdmpgOSBg9SnU
	qu/cdgLhimL9lKFQhebnlUxRVqlVl7f8+HD87DqWuKy00p2NrB71bUzGUngGtcziShnZMyAf4mT
	j1+j9Q=
X-Received: by 2002:a05:6122:3c48:b0:5bf:9461:91d with SMTP id 71dfb90a1353d-5c12509ee92mr2319851e0c.5.1784135273997;
        Wed, 15 Jul 2026 10:07:53 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bfb10285c8sm9176618e0c.9.2026.07.15.10.07.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 10:07:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] monitor: Fix build error
Date: Wed, 15 Jul 2026 13:07:47 -0400
Message-ID: <20260715170747.1933443-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following error:

   36 |   return __builtin___sprintf_chk (__s, __USE_FORTIFY_LEVEL - 1,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   37 |       __bos (__s), __fmt, __va_arg_pack ());
      |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index fb053e2b413f..82afef6011d2 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2928,7 +2928,7 @@ static void print_features_subpage(uint8_t page, uint8_t subpages,
 					uint64_t *features,
 					const struct bitfield_data *table)
 {
-	int i, j;
+	uint8_t i, j;
 	char str[18];
 
 	for (i = 0; i < subpages; i++) {
-- 
2.54.0

