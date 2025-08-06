Received: from s1.g1.infrastructure.qtmlabs.xyz (s1.g1.infrastructure.qtmlabs.xyz [107.172.1.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1759E23CE
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 02:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.1.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754446973; cv=none; b=OkkVj3kOdsrU3CCXf2IbRxCEXcEXfT/thNxUjZZNWpZ3kMjNDwpR06yshh+aFthutve4h90qAslJ/12xTQs21Xv8CWS/m0zkcrg6/zhMsN6ojlCfzyMKsH4H7GosRPrC0RWMx64xefrMCGnZCyxgVNFK1hhRvtXCFhO9Oj+74Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754446973; c=relaxed/simple;
	bh=VeNhKJVSyBiYJ1aihRN6KR7Ev4kD79r1ASUf1B+UXcU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uvz5CljaLtpQdD7N59RKF3vIdN/nSp/f6aKideZtE2xUcnjrwJqoSxf1HkTUz4SabbYsrqHZEoehjfun1jSfGDwD7tJGC7N1unn2vop3a0gpXKVFYdGYA7ny2SfiagPDJKRKjHCNROhGf6tG3OL4CG18l6VfWFzrWph5SqR9xg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz; spf=pass smtp.mailfrom=qtmlabs.xyz; dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b=SnHszeqh; arc=none smtp.client-ip=107.172.1.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b="SnHszeqh"
From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1754446969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rha5ySg5Y77zjg5BKZriShY1XZrOJu2fzdpHJZ0jVlY=;
	b=SnHszeqhf3bCWRm8dURWGB9bw9Ei7CgEfPJLMrLG2R7elSJ9Tq9nXnItqfmVoBO04kfzaW
	vBoY5QJugmvb/ZNHFEj7si16NLLPsdKRn+siKkECasS2Nyr5UbMW0FF9CyLHUdrxv9Q8VZ
	wVOhtTRbHNsz6i7EfYDmxxyLVE5TGc5VrJ2Pg/KxppkPzpaLsNQ5c6HrXj8kWM6uDC90dS
	XGwLRG8oqvreVy9FQuXY9pQghsQaS9A6slZN1ngmJ/ERY2A41n233YJoGSX6BNqIdDCnd1
	R4bVdJ/g5LT1Y7yYg1LJbsMaQT7AdHy0rfGpnfUJ4ZeuCMvB3HmjWF/ZZzscCw==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=myrrhperiwinkle@qtmlabs.xyz
Subject: [PATCH bluez v4 0/2] audio: Don't initialize media transport
 volume from media player
Date: Wed, 06 Aug 2025 09:22:45 +0700
Message-Id: <20250806-audio-no-reuse-media-player-volume-v4-0-a59d9a4848c1@qtmlabs.xyz>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHW8kmgC/5XNQW7CMBCF4asgrxlkTwJOWPUeiMXEHoOlJKY2s
 UhR7l4rbFp1U5ZvRvr+p0gcPSdx3DxF5OyTD2MZ9XYjzJXGC4O3ZQuUuJeN3ANN1gcYA0SeEsP
 A1hPcepo5Qg79NDC4zmDbVISNJlGgW2TnH2vkJLp+4i9xLuerT/cQ5zWd1fp8p5IVKDCts46cr
 kmrj8/70FOXdo/5Fcj4Ez38C0WQYByT67RlluYvWr2PVgWlQ03IiE6r9je6LMs3dcY07YcBAAA
 =
X-Change-ID: 20250805-audio-no-reuse-media-player-volume-fbc2983a287a
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Spamd-Bar: ---

Fixes an issue where if a Bluetooth headphone with hardware volume
control was connected while mpris-proxy was running, disconnected and
replaced with a different one without hardware volume control, the
latter will be erroneously recognized as hardware volume
control capable.

---
Changes in v4:
- Remove unused variables
- Link to v3: https://patch.msgid.link/20250806-audio-no-reuse-media-player-volume-v3-0-a64a2e22f719@qtmlabs.xyz

Changes in v3:
- Actually remove the correct field
- Link to v2: https://patch.msgid.link/20250806-audio-no-reuse-media-player-volume-v2-0-cfeafb7dee0c@qtmlabs.xyz

Changes in v2:
- Remove media_player.volume
- Link to v1: https://patch.msgid.link/20250805-audio-no-reuse-media-player-volume-v1-1-c9fdfaf74a71@qtmlabs.xyz

---
Myrrh Periwinkle (2):
      audio: Don't initialize media transport volume from media player
      audio: Remove media_player.volume

 profiles/audio/avrcp.c | 10 +---------
 profiles/audio/avrcp.h |  2 --
 profiles/audio/media.c | 47 +----------------------------------------------
 profiles/audio/media.h |  1 -
 4 files changed, 2 insertions(+), 58 deletions(-)
---
base-commit: 2c0c323d08357a4ff3065fcd49fee0c83b5835cd
change-id: 20250805-audio-no-reuse-media-player-volume-fbc2983a287a

Best regards,
-- 
Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>

