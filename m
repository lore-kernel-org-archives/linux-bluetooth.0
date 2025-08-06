Received: from s1.g1.infrastructure.qtmlabs.xyz (s1.g1.infrastructure.qtmlabs.xyz [107.172.1.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D2281ACA
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 01:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.1.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754442472; cv=none; b=UPHCgqq5XfuHNINxBDg9k1WqifxJ7d032B2vuEy2nItNByL8clLkf0GQoTTokRidWU08SModqPWcsarccSJSxs3BTpRIBehvBmO8y1bNzMY2HGF6i3BSeZxQ2q6AbaIGSPp1yTgvu8TtDqXNwE5sCJDiNAbtmPdVUHbaxJw6hcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754442472; c=relaxed/simple;
	bh=3zKhuKOGcIUyaWioseeapKNO/Jo5+rwyWv2tJA9Zp2I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nNG/7Mz3GmVVEj9KzYKgiLuNxMDA7Uo0mLgDr4YGNjcD/fIFi0+p5LCJzoxsRfo4eV/BUZPgGcfuvxYOgRQMDXq5Y5OUb4rQsZ9RzSZYJSKUIYgI2LQ5WMviPG3DuOPx5iSUn7nrUvD8njFzGPEG1DquxIbhUD4hIg62B0b67R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz; spf=pass smtp.mailfrom=qtmlabs.xyz; dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b=McBju/HT; arc=none smtp.client-ip=107.172.1.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b="McBju/HT"
From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1754442468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GKBAVXp0H1felRCP8sfvCb3ecjCWgXNrhyCAcQtDVj8=;
	b=McBju/HT+nhOZ9MROAw6zV2cMTUSxkMnebrpmQv70tPkd3VnNzL7kOdtCAHsvTEgk//ZjR
	sSWcld093MEfdocIrxwAlDYg/YTQz7ulkj1VGYKJqoaPQlzwk3PS+8FMfQUmoSGZPc1a7u
	fF9U2dNU2t+hcofZgvBspzhAiaq06NvdGVDsUvofV76NWSfGThISRE1G8y4AQhmIgi4KEi
	R80k1Wj9XLOhT5YX9zfndRZxACvydjzgQ55/ENEf7DpOkLsYgiS2r/oM+uXmzPcSvUr23G
	3FjK1rBOVMbRLcmf03sqVCCcK0k5iRpMPxKozyTp1S2gVbxBcl7tJxgGhsnU/Q==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=myrrhperiwinkle@qtmlabs.xyz
Subject: [PATCH bluez v3 0/2] audio: Don't initialize media transport
 volume from media player
Date: Wed, 06 Aug 2025 08:07:44 +0700
Message-Id: <20250806-audio-no-reuse-media-player-volume-v3-0-a64a2e22f719@qtmlabs.xyz>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOCqkmgC/5WNwQ6CMBAFf4X07JpSRNCT/2E8LO1WmgDFFhqQ8
 O82eNGbHue9ZGZhnpwhz87JwhwF443tImS7hMkauzuBUZGZ4CLnJc8BR2UsdBYcjZ6gJWUQ+gZ
 nchBsM7YEupLiVGYoygJZFPWOtJm2yJVVzUhPdotzbfxg3bylQ7qd/1RCCinIk1YadXHAIr08h
 rbByu+n+R0I4lN6/EkqgIPUhLoqFBGX39J1XV+EMy6uMgEAAA==
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

