Received: from s1.g1.infrastructure.qtmlabs.xyz (s1.g1.infrastructure.qtmlabs.xyz [107.172.1.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2606E18024
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 01:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.1.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754442306; cv=none; b=BLMViUbef74czaFp+Ua1xxfq+iPuISA3ox+qsYqX+sstoN0gjOZCpV6iGgysb8uNpULTROr1w3PiEMXrQud5U0iByJ2uc2Vrtosz33J5teCMIgcgyir1VT/YifV65OH2phRRVp5EaQFKUfZyYIcLvtq25ziHiFA6cHiJJPg6OUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754442306; c=relaxed/simple;
	bh=oDShRK8Yy5zLxzIOKqDxE1Zh79hiGi1BCmBLxIOj+Ks=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QtdZoPKOegAhGgD2o2F9tjzw8pAZB9wteutu7UYrY7i3iaVR4FkdzFTUepxUse+OgtZtIrVgDhDUh2tskJ55CNSdqxj2oo+eX8SohpWrKNyQeTx5UNRGBfAx220eflBnRLkjwFEQtlYDFLoNBLKl6BBk9dFWdEnVnROKjJR5I3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz; spf=pass smtp.mailfrom=qtmlabs.xyz; dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b=dLkfCV/O; arc=none smtp.client-ip=107.172.1.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b="dLkfCV/O"
From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1754442303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6lWEJ1eM7rJcSwbGKT0ji8gwSlr558oejVL7aP96Vuw=;
	b=dLkfCV/O0P89LKgg6ILyG48StI45uHimyqEBvhcqTK1jBPHs5mYwyO5AwDl+gtM3cyJk9v
	Iz/bkXE7c1VhF2J9o3tW6zzWoMADARNcNCdvSlbuud/J/aiv+d2VEdBrFVb1nr/nkKSmyV
	NdYXBbMxfG0OG0bEb0i+e3Se1sOCiWPTqHSfAgCrwqVV9H4fPvofw9eL9pBXwB0aN2+uwq
	tnhbHWmT4ITF57IpItw0/pippsKy3oEgciVnshTYxPrzlas9p/C4PRhcUBVrvoqhYcDpEE
	YmCxBUpY0ZjAK0ZlRbkWEBLP7cf8ZleRC9kYkkF98IYvMdw4iKV7TuimhjDwqg==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=myrrhperiwinkle@qtmlabs.xyz
Subject: [PATCH bluez v2 0/2] audio: Don't initialize media transport
 volume from media player
Date: Wed, 06 Aug 2025 08:04:55 +0700
Message-Id: <20250806-audio-no-reuse-media-player-volume-v2-0-cfeafb7dee0c@qtmlabs.xyz>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADeqkmgC/5XNQQ6CMBAF0KuYrh1DqwRw5T2Mi4FOZZJCsaUNS
 Li7DTdw+f9P/ttEIM8UxP20CU+JA7sxB3U+ia7H8U3AOmehClUWdVECRs0ORgeeYiAYSDPCZHE
 lD8nZOBCYtlNNfUVVVyjy0eTJ8HIgT9HaSF/xynXPYXZ+Pegkj/EfJUmQ0DVGGzTVDSv5+MyDx
 TZcljUD+77/ALUjLzXdAAAA
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
Changes in v2:
- Remove media_player.volume
- Link to v1: https://patch.msgid.link/20250805-audio-no-reuse-media-player-volume-v1-1-c9fdfaf74a71@qtmlabs.xyz

---
Myrrh Periwinkle (2):
      audio: Don't initialize media transport volume from media player
      audio: Remove media_player.volume

 profiles/audio/avrcp.c |  8 +-------
 profiles/audio/avrcp.h |  2 --
 profiles/audio/media.c | 47 +----------------------------------------------
 profiles/audio/media.h |  1 -
 4 files changed, 2 insertions(+), 56 deletions(-)
---
base-commit: 2c0c323d08357a4ff3065fcd49fee0c83b5835cd
change-id: 20250805-audio-no-reuse-media-player-volume-fbc2983a287a

Best regards,
-- 
Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>

