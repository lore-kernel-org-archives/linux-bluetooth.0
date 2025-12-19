Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44933893E
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766164256; cv=pass; b=SBsSITuZBp560ic+wyG3qwVcN6Av2Bh/189Fy0biUi3u4keRFPfHgYHAwmkUShdBMFYMyGNYv2L7iTzwVfMYpLK4TuvUP2XFIu34XhxAp59hFxVJBvulB8FdJhoEFsGmQFg0f8OnICUldrTWpgUUVY0F5RN8JFv1Tvh28On0ngo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766164256; c=relaxed/simple;
	bh=NRJmflADR4s5s9zPktzGuLVN3t+MikbLC4BiGbW1kVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p6eb7lCyFI+j7z8fPgKUZhk4/nyRlL7P4Wm3bZvSW22yoCjQBjZDXm04N/db7hAhAdxXq+1z7SHhYbW+Bprgk/F7+qwodpFCbaDt65ChvsdwtePCkVwRkZAictxB3nS7VGLPw21sKUKq5Emhu0tUn5vamAx7hE3EbvHBp/ljVSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=rlMK3Ndh; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="rlMK3Ndh"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dXvDz1bLNzyQq;
	Fri, 19 Dec 2025 19:10:43 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1766164243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OeyJ9tU89bl9j2j1zqBT+M3oroRO9WxH4JOnTTC+QDE=;
	b=rlMK3Ndh23hOuccYzKvbVhKcBlTbjaI4CB1KiBv1yk4MFxrIvlP/EyGD7+IWf2xRLDdAxI
	GXgPX2aG+942A/5hIOngWAKv4NvyrCibTGJj0IurghQlwLb/0HMX9DmHm+uXhTaoLY39Ue
	gwv1KNUgg5eTxvZl+xlZZwpi+K0av1E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1766164243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OeyJ9tU89bl9j2j1zqBT+M3oroRO9WxH4JOnTTC+QDE=;
	b=b+ouy2qx3T4/B6oAxbypjGyw6/highiLEnFQ1twaoNiGpCtr/TClZUuS1Cze4fadtywCry
	KTCYy2+l2T6zJJZNPocChKATbRTMlNkH6Ac3dYgtU+HFlPCiih5P3+rLENK+UdwNz+wey2
	3/hifsUxMYlYzSVVecZ3Wle43gkoQIo=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1766164243;
	b=AwCmFYuDMOotOCguXxF99rG+ALZK/Yh0z6jKOUEr116yI7dMmdmoxoV3BtRoeM/8YnlD4i
	ajQZUYDsv5uo5OnsVub/82sRrCCBKAeDnPR2bsI9tYN5bCWGsd5lfxjCz/sXxFyxOb2tok
	BE5Za5Yy4Jc3VKOeb3Q9nGQx0gVIM8M=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 0/3] mcp: expose org.bluez.MediaPlayer information via GMCS
Date: Fri, 19 Dec 2025 19:10:36 +0200
Message-ID: <cover.1766164144.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- use --index/-i option for mpris-proxy, similar to btmon

***

Select one of the local org.bluez.MediaPlayer instances as the "active"
player, and expose its playback controls via GMCS.

To do this, decouple media.c player API from AVRCP by adding a similar
API for org.bluez.MediaPlayer --> remote as used for the remote -->
org.bluez.MediaPlayer direction. Use it for both AVRCP and MCS.

In theory we could also expose each org.bluez.MediaPlayer in separate
MCS instances. This is not implemented here; it would need to be done so
that we don't consume ATT handles when players come and go.

Pauli Virtanen (3):
  media: decouple local org.bluez.MediaPlayer from AVRCP
  mcp: expose org.bluez.MediaPlayer information via GMCS
  tools/mpris-proxy: allow selecting which adapter to use

 Makefile.plugins              |   3 +-
 profiles/audio/avrcp-player.c | 291 +++++++++++++++++++
 profiles/audio/avrcp.c        |   4 +
 profiles/audio/avrcp.h        |   3 +
 profiles/audio/mcp.c          | 506 +++++++++++++++++++++++++++++-----
 profiles/audio/media.c        | 501 ++++++++++++++++++---------------
 profiles/audio/media.h        |  45 +++
 tools/mpris-proxy.c           |  37 ++-
 8 files changed, 1103 insertions(+), 287 deletions(-)
 create mode 100644 profiles/audio/avrcp-player.c

-- 
2.51.1

