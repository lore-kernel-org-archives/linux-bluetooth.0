Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F4F13A41B
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 23:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713309163; cv=none; b=X79TaIawCS1BCtTl56KEsoXmreWyYQg9XVB4v2VkUP04dgP/ILbyhIta6oSlR7rIEdw0/PVJAAakeLcwT+Ksld7sJii7wiXHQNMdJdBt2P9iMQEwg8hJyqw5Ep0iXi2AqbYLUYO1UnBVraLDmf8hgif95obnPB8SIMApjOfFPeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713309163; c=relaxed/simple;
	bh=1TKspkYf+9F6y2j8Kg1/KNzdB7ymYeiCHLLoObFx4Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeokL8dzKdiV/jtltVXF9g11tJ02Ixz6AOJKKzsdbswHJ4HgpgwiMpIhSTkiJaRT1hpHtlnMvnpY5X8ZG2mOCSQhJ1TTugOW3n8dj1zche9e1jpwArHEBq/xYzJh6Bzr56PrNV22r3Z/ETR3qNKVOK6c/N4KL2TTfTm9uYnt9DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=prestonhunt.com; spf=pass smtp.mailfrom=prestonhunt.com; dkim=pass (2048-bit key) header.d=prestonhunt-com.20230601.gappssmtp.com header.i=@prestonhunt-com.20230601.gappssmtp.com header.b=nOIiwwqd; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=prestonhunt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prestonhunt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prestonhunt-com.20230601.gappssmtp.com header.i=@prestonhunt-com.20230601.gappssmtp.com header.b="nOIiwwqd"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a2d0ca3c92so191613a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 16:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prestonhunt-com.20230601.gappssmtp.com; s=20230601; t=1713309161; x=1713913961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ol4WJWFSVmNN5OVYbKYuEN7Zk/kbba76aARUjvkVMxc=;
        b=nOIiwwqdEOJZedarZtfFQm7LToHjfXGzeFDuEnuGJYU2I0UK/JRg7joy6FhFjsWW8w
         RjQ4Kip9Fvz6/0moYo++/IQZV/PA1r6ViMaUnBw1JHJWPtLaGRPsAbr3O8y/ydVxsilc
         MQDr4UQeQrFeNGqepG7lZPnCV0W75OM4ZKlpYrxOXHTPFcGZfqP9noh18z9hre/9y0om
         x867taXGGDhTfUrz6bpuf7So6di3i/4Fy7yrfFn+Byb1RPQDfYBbPzWHEmNkHZTKMWAr
         xfxcl8TnSBzEk1Csxbv1wyicrRdHzWGVAwpU17da24zGRIwfJvlTTvOWzKVQdpjZykj9
         JScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713309161; x=1713913961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ol4WJWFSVmNN5OVYbKYuEN7Zk/kbba76aARUjvkVMxc=;
        b=gyddgXeRBYEJEPmJRWWreRVla5got/sT2TfAkS8zXZUfGGFjuE6LXBei77zi6kXJ/2
         m4Qago8JWKYlMjj1iRfl38xZEXHf8IXr7+m+KaXi3ntt8B9GBTyeeypj/qCOHx1DbJa0
         NHKihv9n/9lEWgL21dQ8dZFtmesEWHfDLig8R/tswlVNh1fBnjQBtE9LUkEagtywI06A
         B/FAiBOJ45H4hZlMaHG+k5qQ/z7qioqjsToSvYvNUmVIbAb1LwFabGpAWz5duyqICWlb
         WyvLv/Fb6L94Lh7fBSWmytTnTDsx21ToQ38V4CzbenAHIevhaVb7pJKjX1qufjU6pj7o
         TLtw==
X-Gm-Message-State: AOJu0YwdM0VEF1akGFI3aF4FaFVTGuAOrPfMnwHc7houVX0JAMz4TfxX
	BS20dXv6sBzp7uGMu7UzxNFIRepU21FLvfCdt62jVONYig2wwL8xWVxxSQEGGXtMydYdKfFUn0J
	I
X-Google-Smtp-Source: AGHT+IEWgPvXeUW3iUA32HCaEfPQoeh+GfLVYviyeCN/8SNddj25Gmv31WDFuKNfe8d5Sb6s5qcVkw==
X-Received: by 2002:a17:90b:1054:b0:2a5:506f:161c with SMTP id gq20-20020a17090b105400b002a5506f161cmr4960868pjb.4.1713309160700;
        Tue, 16 Apr 2024 16:12:40 -0700 (PDT)
Received: from localhost.localdomain (97-115-102-176.ptld.qwest.net. [97.115.102.176])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090a010900b002a67079c3absm160081pjb.42.2024.04.16.16.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:12:40 -0700 (PDT)
From: Preston Hunt <me@prestonhunt.com>
To: linux-bluetooth@vger.kernel.org
Cc: Preston Hunt <me@prestonhunt.com>
Subject: [PATCH BlueZ 1/1] monitor: fix spelling typo
Date: Tue, 16 Apr 2024 16:12:05 -0700
Message-ID: <20240416231205.2116175-2-me@prestonhunt.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240416231205.2116175-1-me@prestonhunt.com>
References: <20240416231205.2116175-1-me@prestonhunt.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 48fff2ba6..5abf164eb 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3779,7 +3779,7 @@ static void print_transport_data(const uint8_t *data, uint8_t len)
 		print_field("      Provider Only");
 		break;
 	case 0x03:
-		print_field("      Both Seeker an Provider");
+		print_field("      Both Seeker and Provider");
 		break;
 	}
 
-- 
2.42.0

