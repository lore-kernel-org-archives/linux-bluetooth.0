Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD6C2557C
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368367; cv=none; b=XTZ1VFkNryiYVcWzLXau7GvNC1c1zCm3wgMytggigF82Zy92sAbG4UPeBN/TL7yAbRP9WrTvNxBEUUoQMAxn8AMgcYhC4aEUSH2yg09DTMS5RZWeWeb9t9a9X6s1kebSaD5m2g3wvAFoSl18Kb+RePOkuX2oWzsqF4kD8U1xpiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368367; c=relaxed/simple;
	bh=FA0RH7sa1frVBvqfGINmd4c3JKMT3Ro+MyBJJvypS3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UbQtdPSVZvMlOOPpr+5mZDWmCvr+Ow2EtBibImRrYKSvng+WJ8KdhTjdg5MCYkWkKAVp1Cq1vtPxtW8NPmK/xnmGSCD/+fshSoJ8MhEDggo6rEGrrl4r4C5+Fyjj7cYE7Hk/uDZO1tci1k7Svtw28FkA0+njTf11ULN8YfXwLFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXWi9X1I; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXWi9X1I"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de56ff9851so9068906a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 05:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739368364; x=1739973164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wdw54P7t4XFkeo35lZ8ncbndAnMZUttw5XcXZIycs+k=;
        b=fXWi9X1IABo38gOt5Dc0CJu8ElOloIMbxrUWTPUwraf9JZCc5kv6+785El20CwrtbY
         tR4kT/cA8GBfaA/dOne+QaLmIp1m9cA0Jr9BkxMhnMSctFrGxMrD191hjzb3DxcAQ/3B
         efh+RItuvKpiroiCjf70229q8X8wYU0l04Xqrc5buRc5AcZfd7BmDG94Ke+SiTWe0M+x
         xN1VBie6cQwCSLlikRIpRWbwbFim8o5pxxzJXmujYDjv6XyVw7u/kONYcU5ADg466kUw
         WZLPQp+23jaZQdyzCGSz4RfLSdTl5P2Z2Z+i46uszKgeSKrUzST62Kb8RjlDEvHdcb//
         DFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739368364; x=1739973164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdw54P7t4XFkeo35lZ8ncbndAnMZUttw5XcXZIycs+k=;
        b=nBJ4rxPcsKiHb9thjkJbKl/L3zdfJNwStpWyDoX4/RWffyxgGEODIh+SIrUxi9Hcu0
         ksKEMUr5j0vbKZiZjkBcXU7PDU6UwNCamCWGKsXGEkF4vq/MqNwSj5Q6EDrOVgYVm3dG
         X/VaEAEHZaLFrw3t0/9g0IJm2E2aEzuCjo9ENLdOHkniTHNVnxaojhHzksJ7ziI5CAee
         V25pQgL5HNfdkyMZlBswgYG5+5mQ5xHjKx+mIH2G1ysEh3CADGuKERJH+o5usmhmuTf+
         YaO+R26C23++DeAw//fvcPTjlsmopAPmnd06itMKjkO1pIEtH7glMCIBQIQrMDYSQ3CG
         NVVw==
X-Gm-Message-State: AOJu0YyQ1kppAxKXiTp2/8zFMzF9MN9u35vIXsTTKak9fxaMFXoRelm7
	551f5PeEjBWaa5ZXmIW83Pvbybiup3wy/VcHH0qvBLGWr1doUxtiA2nsl1UN
X-Gm-Gg: ASbGncud+9vNPYoOgDlFDAARS83zOE8XQjMTrwkBA8Cvu65Oyx4hHg94tjMJGSQzIDC
	i+3ZkYMS38DpvetNTz6x8Wl2p2u7Ub2IipDqDEmkjQQpezJZ+Xyv7eWjSuFyFLTkiJA9D8wMjo2
	vln+rWseg3B05xfgraVF82TY77OW21MtuMYa8w+UbjkQgiRnCOaN5qCcLD3J+UO/ob+eTIPJOrG
	PjcJuU12SaRsXXVZaC/tFx+4gZdskVcMT5IxsFzHCzt5B4PBYx6URNyv11vWR4vLWgtYRo+pkf/
	YPdJwRG8u58XXou00cJg0tlPkMRpjd3rdzni4XH9yuUIOBc3wcYQgQDIwDqX0GUQz0Od+feGz++
	Y8k71BoMa6qM=
X-Google-Smtp-Source: AGHT+IGS6FPsC+BwMDoNxgZdZstW2u/G4mpvkk6HER9gI5wl7XMYunkCjTb5FtipE861R16+TrzUjw==
X-Received: by 2002:a17:907:3f17:b0:ab7:f0fb:3110 with SMTP id a640c23a62f3a-ab7f3714ad2mr287240166b.5.1739368363530;
        Wed, 12 Feb 2025 05:52:43 -0800 (PST)
Received: from localhost.localdomain (46.205.193.135.nat.ftth.dynamic.t-mobile.pl. [46.205.193.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab786aa2c60sm1169870166b.102.2025.02.12.05.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 05:52:42 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH 1/4] test-runner: Increase amount of RAM available in VM
Date: Wed, 12 Feb 2025 14:52:06 +0100
Message-Id: <20250212135209.129361-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using default kernel configuration from Ubuntu 24.04 patched with
the configuration from tester.config, the kernel image is too big to run
on 192M bytes of RAM. As a result the test-runner exits without any
message (because of the "quite" kernel command line option).
---
 tools/test-runner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index cd8b86d7a..77c89f3f9 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -211,7 +211,7 @@ static char *const qemu_argv[] = {
 	"-monitor", "none",
 	"-display", "none",
 	"-machine", "type=q35,accel=kvm:tcg",
-	"-m", "192M",
+	"-m", "256M",
 	"-nographic",
 	"-net", "none",
 	"-no-reboot",
-- 
2.43.0

