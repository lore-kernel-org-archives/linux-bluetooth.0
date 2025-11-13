Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9EC3254A9
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763075102; cv=none; b=r2iMNDJOp//GehzIlbmbwegsZlMehdod0bdEYLrmI4tFTH61KebuFquL9gTalHEI+ln0JevuKQc7/bVKMfYCPojyu2IjkZt24ZIuqeWXm83d/wvZ4bdUBhRINqczB9YtlFzfSGO8/8KhVUzbcOcCGSbNwPOPlXoFbTqhQnHc2aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763075102; c=relaxed/simple;
	bh=ONqpF6LSYPVL5eprFbfAoXpT+knQmqiHLlje6+G01hg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X5nJ+hIR4UnKpGMCaUMME6PFKXkid51nL+E5FfEt1Jot7q81DW/WDqoQG7UWvHpyMxH+Yee3F0N3KAxj73r73pPdDmoAjaNMoKEHT9zUR9Jl8m8xUgAWXi2wM3xdMp1S7BYdtCo9tqW2ltLrULctL/jL9sZ2K4HNA6TFO9zDmFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DG7Y1g7K; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG7Y1g7K"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8909f01bd00so123659885a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 15:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763075099; x=1763679899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6yZb7urwOCrrCshhu5/orntY9nPwWMZ38T4XJmYKxig=;
        b=DG7Y1g7KdlO5kvGkOmsxW9thekB4F6mqzkkKvqneBw54KPUVmXUJo9AXgG6OnQnaWX
         p0iO7XrirYyAIUdyRFjMNa+c3W5X+lImPRzbU2A73I+Kh0qzyGEccEdWTxg95dwuZIqc
         oPDANaF7QurNmfoX9uTR8VGEk2p0tTgMxeSjDFyNh/GnM8S1KPvY1vzyu8c2dw1kZFlX
         SA6HA6eZJEmFnK8msTEZYX/N7TZk9vTThq+4LuSQUS86cVaczv3jt9tH6UAw6aPCnZ90
         s+pLrYwnnBAGL9tK3Etjedl38Ucok7bkKkzFjkFzvmEkL7mHP3oiiBP0IwLDwOgLY0+8
         w1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763075099; x=1763679899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yZb7urwOCrrCshhu5/orntY9nPwWMZ38T4XJmYKxig=;
        b=lzb1XVN5tpPnWHMNX/CTQkEAysDPjGiiP5ci+xxd1+gXsFQihEiqDiT5sTnyOIFHj2
         lkqS3iXCHoJ7wSuNOLZJO7re6oDOM/t0tJtAgumQfAkuHFjvKp6Sb7NKLP0GyG0NIRdN
         NuNxjnnbtzubVktKGlzF7sljryRJBIFNqlRNRYpVX+2Xo1syWA8zNBg37iCu5d+DjyXk
         LQ8/cTQCvpoNI3ZFGt1l/BPIlIJ6kVSrHsDevwjNaWNBX0AT57vUxoas/quCGZSkZbj5
         WI93pbPAfDBhT740tftUdJXbP3Kc8XPIkhbfZFlEwQb7qxJDfShR/JpE2Nr1dI5v8nMl
         tzOQ==
X-Gm-Message-State: AOJu0YyfAqNE/rKZcImpUomLubiBEQFeQkORxsVohQRxecC24RYpLj9H
	OxWByXk2pqx2W4BYQwBk6pTYzu7wcWOwWEQajt4d0bLXB/8+xsRYwdk37gkD6w==
X-Gm-Gg: ASbGnctv4NKcv+bld1NZ1leTBmnIclDDxNCTXxkSGremW1z8ChDiHMjZCQK1jUaTF/t
	LSjhcNWEXTcUTaQjiP7nyzX03XDU+RKzOtXUcFPQyDLDUBx1Z3IJDAFYV+Jz5qPwuQ7boBh+FC6
	3dfmKnyniCwYrbd2fy3ICCsdtj50oSMgfjLJMSy7elUwuKjUpxy4ZUcwA0odmED0gHQmRVkCkUj
	lTKmSfe/gZj2Qc5Lw5YNyGC/Wp+bSfyjvVs015dBi6gGqHhGQlX3vOPIR+asmx3TlFsWxTsb0rC
	6AsL/lHKnY3aNCJFe7fQchzIIZh+314+oQMc9m5k8GhJR7SQi2nNWfMiOAWKt/4ejI8GwsdhuRZ
	op05iKGB5AcNxBdTD7Fc7F77G3aDmrx20taaTkW8V4eBkq9tMy/rkcs1lKiNnVoMXogFInA+XXR
	8jBj9F6MssiLCdaiSwpK4OPIwVbL6gMIYh
X-Google-Smtp-Source: AGHT+IHTvKfJTVQOLqloRn32xrSEohlNw8IuOzkApgfhR36j8zVImmhQH5zBFq9GzE6nHLx3Hl7KNA==
X-Received: by 2002:a05:620a:4692:b0:8b2:a3a9:f757 with SMTP id af79cd13be357-8b2c3145ebdmr149825085a.15.1763075099339;
        Thu, 13 Nov 2025 15:04:59 -0800 (PST)
Received: from daniel-desktop3.localnet ([204.48.79.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aee9eeeasm221336385a.9.2025.11.13.15.04.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 15:04:58 -0800 (PST)
From: Daniel Tang <danielzgtg.opensource@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mpris-proxy: Only be started by pipewire.service
Date: Thu, 13 Nov 2025 18:04:57 -0500
Message-ID: <2488030.6sBWrkQq0l@daniel-desktop3>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

After `systemctl --user mask pipewire`, all related services including
this should stop starting on login. A non-console-interactive user
without the default sound server is unlikely to have any MPRIS clients
running, and disabling the service reduces memory usage and attack
surface. PulseAudio is obsolete, jack2 users have professional
solutions, and non-PipeWire users can ignore the `systemctl enable`
warning or use a drop-in.
---
 tools/mpris-proxy.service.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mpris-proxy.service.in b/tools/mpris-proxy.service.in
index 6ae56c672..02a244b6e 100644
--- a/tools/mpris-proxy.service.in
+++ b/tools/mpris-proxy.service.in
@@ -11,4 +11,4 @@ Type=simple
 ExecStart=@PKGBINDIR@/mpris-proxy
 
 [Install]
-WantedBy=default.target
+WantedBy=pipewire.service
-- 
2.51.0



