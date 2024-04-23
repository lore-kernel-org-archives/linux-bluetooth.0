Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB592D61B
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912373; cv=none; b=ROXkQt/MXkG3CspY2X/hzGueBDGv8bquIbkWRsWpz96WM9RVqD3S//nVOaSkfdEuCXDqyAcgyeVBVwfv4HDzrPIPFyY7GIwOOe2153cDqYse/VKmD3nfjw1EIATMCGNs6UUbd/g82C0R580IfOPfrVJM0zz2dNC6bgIxaavOiOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912373; c=relaxed/simple;
	bh=q7O3opaKZiloL4BV7jWllO9aFNEXHI70CAKgGQENyjU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8AtZycB6FOdTVr8PBAED3P5ENhqeKU8HarZSIOZht+y4FBTyA0BJ5JjlxrWONiw8Tr0bTjEaQX1Edp7uXU9neGXgpcfLupXyDjI0E579M3F4PG+r1aXtJ/FNHJafjDjN96dqv4OEmSWksf0yUgsej2xmQ5WOcFlBk7HlfoVVPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwQM7192; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwQM7192"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-479e12bde9fso2203849137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 15:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713912370; x=1714517170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGu6LD9Br94m9KixDZLCSWUebSOfnN0Y/Udkomcju9c=;
        b=jwQM7192VPqMfaKR2I+OA8efVIaa/FhEGHvrrEUXLOFup1lwjJ6qAwS6EgxfjXa7iR
         1e+eNasNMmKvmaEmzFOIShHWQMAjgQhtVSzcaM8UQbOwvASfnv7P2gSBE1teocoAu06b
         ajcrjDPVRrMEki8rhn+CCBrLlg01UOJTrbm6Y4zXQ7OfCfJcvu3rqjGVEvvQD16vbQC/
         NuPJI/QdrWO7qUMsL1ySw6NawABxOkO9qNGtdjISi5o1wZZ2sp+YRT3CDa3/K8tbNeB7
         mnknMTYAiZ5uTN5QEwSIS8xw7AYBN2gHk7FBYM8/7zbxYvD4eoZvWISpruEsMPqSpnUU
         sR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713912370; x=1714517170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGu6LD9Br94m9KixDZLCSWUebSOfnN0Y/Udkomcju9c=;
        b=sGhWOLySzy2pnjQXVH9x5EKQR6P02kZ2CH57XL8zy1690vomDM+qRc8UbJZ+mvtQTQ
         jnWHXqfhyk51BL93fFhZJusZH+XzWsBfy5cSy/0QafeR8VpOBdp4PjZPprFYlyciGyN2
         vRar0aJnagh4aRCfGFbsfh3Gl8unpMPmMtAn/kD5xC0eXco791ffjVphUkjKnagHuEqF
         zZfpy2nPQPqCgYABc8zB8tTAjxc+luScc/VHQW2QiResRZdHowxwef7rK9BJT9NbczE2
         ibSOLDx/No+smi7WmsYM4a6rrmYU2fI3ENP1VsCbQ1fYMc5L9kWuELiWRBdIOTa8Afuq
         nNoQ==
X-Gm-Message-State: AOJu0Ywedq+X3n1S5JUmv8gMlYqNR9CEuNiTWYlsDxOtrFHwQ+P8eHtS
	9A71KHZqsMWl2VSJF05EfW3/0n9MuSr6Uevg7ciOiJGjJwsiW2vo5sY+AA==
X-Google-Smtp-Source: AGHT+IGoS2mK3XBcDRAz1w4Nmlm7jBjVNv0iFAT6dHBDrTUERm1mrscFqEsgjTIsczRNd1AbW8E/YA==
X-Received: by 2002:a67:bc0c:0:b0:47b:d7ef:243f with SMTP id t12-20020a67bc0c000000b0047bd7ef243fmr864689vsn.26.1713912370053;
        Tue, 23 Apr 2024 15:46:10 -0700 (PDT)
Received: from lvondent-mobl4.. ([107.146.107.67])
        by smtp.gmail.com with ESMTPSA id g20-20020a05610209d400b0047b8ee9674dsm2196056vsi.1.2024.04.23.15.46.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 15:46:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] ccp: Mark plugin for testing
Date: Tue, 23 Apr 2024 18:46:03 -0400
Message-ID: <20240423224603.2124790-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423224603.2124790-1-luiz.dentz@gmail.com>
References: <20240423224603.2124790-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes ccp plugin for testing only rather than experimental since
it is only meant for test validation as platforms shall integrate CCP
directly into their telephony stack.
---
 profiles/audio/ccp.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/ccp.c b/profiles/audio/ccp.c
index fe678de9fede..ae17a31f7ed3 100644
--- a/profiles/audio/ccp.c
+++ b/profiles/audio/ccp.c
@@ -206,19 +206,17 @@ ccp_server_remove(struct btd_profile *p,
 }
 
 static struct btd_profile ccp_profile = {
-	.name			= "ccp",
-	.priority		= BTD_PROFILE_PRIORITY_MEDIUM,
+	.name		= "ccp",
+	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
 	.remote_uuid	= GTBS_UUID_STR,
 	.device_probe	= ccp_probe,
 	.device_remove	= ccp_remove,
-	.accept			= ccp_accept,
-	.connect		= ccp_connect,
-	.disconnect		= ccp_disconnect,
-
+	.accept		= ccp_accept,
+	.connect	= ccp_connect,
+	.disconnect	= ccp_disconnect,
 	.adapter_probe	= ccp_server_probe,
 	.adapter_remove = ccp_server_remove,
-
-	.experimental	= true,
+	.testing	= true,
 };
 
 static int ccp_init(void)
-- 
2.44.0

