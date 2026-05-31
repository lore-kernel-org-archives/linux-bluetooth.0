Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61233368D4A
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780222712; cv=none; b=bHsWQFmt27Er1cf3OABNE5UWXL9+skWVTwFenAi1zA5ORS+fombA++Bx4Odo2NkGl/J5UAj5b5R7MKGfIX0eqYMTq1O87vXvICUViBnmP8IXYNKZwz83vqsJPs05xoDpL8afPQ8muYU4V2Y1yo3sghf2ifIbZe5t+riTv3gYMas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780222712; c=relaxed/simple;
	bh=jW8RPyCPCC8S8v2TWTsaWGbqpjJy7byDhmB3sdgy2Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YatCC1QhXALObZ3I5fGNjbB0HWqR61qNc7XtLBBWPDK5OIjf+ba0aS2TbGR0b+xJHPwQerebmI8omvLiNwePlrwHfdsmhUeRSI51Y7b/JUNO+QUOZNaooZpAdedFQ34FnDILAPTOXagFvj/UEwJ4v2XfBGoodvfUv2QhrF9VSFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=KtfoaOGP; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="KtfoaOGP"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6870ad8072eso11532691a12.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 03:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780222708; x=1780827508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Bd1Hf3VuUjzL9yKeLsLVCvJ0+C3p0AGl32xUujIoX4=;
        b=KtfoaOGPNfcx8i/Y8rcbEce5tQJgZ29AHji7G02x5IzCaVuuTcVkR0xcDJQ4xoSQWg
         i0JfBLB4iadjaJ8dHuHM1wgH3PgNHHGtkhJnbVshrLGKwcKi1FAItibVUd/htkuwh1Fq
         mtgGEqKIRX0mUrBddIASKN3EXwk3tYv7yD1RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780222708; x=1780827508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Bd1Hf3VuUjzL9yKeLsLVCvJ0+C3p0AGl32xUujIoX4=;
        b=OUD62z27XqSTTCIUviWszti+1vQ+kI1OyVnafWl5MhEI+yYl6mi+bcxuCHaX5WbTUF
         yG1I7TC6nZVg2bxKPwuaRtqbbOt9dQo+0iFoZcLOSkG6LjTbklV9xPQFM/W2JnG69kQH
         77rDbvRm3y0f+eR40B94vKstbcdHry3xXkmwKROrzMa1fRak7hN+NGEw49zi2HTMoG6r
         YlbAu/cvMuVjpHlPvyzTtPFe6j7kNAMaqpx+GFMd0kmZUcSWKCsadGl1J0QsvEzoFWv9
         EyfDSjfu7+zl1I0IhgIX0GbN0BEhOCv6B8JLshs5Avqt8vQV4KJzEHW9gEymErFeCnO6
         Q9NQ==
X-Gm-Message-State: AOJu0Yyq7yLfXp70Zol3p5ohj9FmaHkVhAv2hMwwD4+x3D+GltV83HFt
	PoNovQZPc0LDhRMRka5sMjeb8Ry1hxC/opi0f0LDVsSeKxmoDyBKshbyGoNTHqGAD8N+fsNCYe/
	gn9J2/A==
X-Gm-Gg: Acq92OGFl7D7Mle/ahXZR0nq4kCi3AEItLJieVjY/fv5iM8tq9bR2lgVG1hemVWQQ56
	RlE0ZMhSmUZhfgY1SgX21TC4cZbRHpBhTYKrIdrQ8fT3ywNe0xiTwIfpvjl8KLpG85/f62tN44I
	/AQtuSnHRKlbbNcyT0uHuJ3zaK6aEeF8HY2Npjtuy4sFPjPcZ2cX19dT4j/wTe92tRSIklhe4+E
	c9R7IfGFFVXXZlcPwK0lSCLyrRAu/bPmkH+YYZmr88tQWfEd0E4rWn3VgrZCiJ5RpToSIG2URNf
	m9c254kQLyWuKVIKy/x2Ljt+yRTcf0YMsHSvXX/OcHGMT0n33ATJQepvp04RQkG5oPReiJRSIr+
	YlTwbjz7XAJc7VSj3aqnymKf8+1aPdiNWgZM3AkQ819yl4FVNfWNNFoNoFP24Kpe9/eQ18x60+s
	2syR422JBcSFOLX/DMEbbcEHyyiiuf0C+NPRZTJ6J+JOrlV61T3iFBmKuf+MgfN76Ybg6YL+K9+
	wY2uKSLGPVlMkcwVFs+3u0=
X-Received: by 2002:a05:6402:ea2:b0:67c:fb8e:41c8 with SMTP id 4fb4d7f45d1cf-68c94f6e8e3mr2205594a12.12.1780222708630;
        Sun, 31 May 2026 03:18:28 -0700 (PDT)
Received: from great-eastern2.. (user-46-113-6-2.play-internet.pl. [46.113.6.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68ceb6f98f8sm974823a12.0.2026.05.31.03.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 03:18:28 -0700 (PDT)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ v2 0/2] advertising: add property with advertisement Instance
Date: Sun, 31 May 2026 12:17:52 +0200
Message-ID: <20260531101754.3325247-1-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I renamed Identifier to Instance and added support in client

Michal Dzik (2):
  advertising: add property with advertisement Instance
  client: add advertisement instance support

 client/advertising.c              | 38 +++++++++++++++++++++++++++++++
 client/advertising.h              |  1 +
 client/main.c                     |  7 ++++++
 doc/org.bluez.LEAdvertisement.rst |  6 +++++
 src/advertising.c                 | 13 ++++++++++-
 5 files changed, 64 insertions(+), 1 deletion(-)

-- 
2.43.0

