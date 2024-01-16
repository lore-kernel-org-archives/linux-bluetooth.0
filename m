Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB4A1BDDD
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omrmkIQK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE233C43609;
	Tue, 16 Jan 2024 14:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705413639;
	bh=gIkAEz9KvugeA7i0ffO2YgeIQYSh8u8S2ex1hCjShcw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=omrmkIQKaSUfBQuFXGz9+hBr2FIbPebzfboHEy66fvWO8bcRd+//hQuINqEH4BosJ
	 4+yioxg3tP3K44PA1YykcvIAZsiR74ciCZE3mdH89olRIpcp4fV+XLN8U3ye/HpXWg
	 eEfmkOWsGS4y9hRy43prlb+/niyGmv0veH2XJv0sLYQ+b3bfpWicsURj2LdENbFZow
	 g6VGOILOOoj4489QMRFinq/o2hm0/qE8GSHnnAbKimCz3qUiNidhe/TZvdJKi4oJh8
	 he/L0TPjye8Secpy7b1SWrlHAbJh00MRJdxqG8pd/dC4x/EpyMrr6AAL5dSQ5Lc9Zx
	 QFVOxHdTcYNJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB5CC47077;
	Tue, 16 Jan 2024 14:00:39 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 16 Jan 2024 14:00:35 +0000
Subject: [PATCH BlueZ 10/20] emulator: const annotate rfcomm_crc_table[]
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-const-v1-10-17c87978f40b@gmail.com>
References: <20240116-const-v1-0-17c87978f40b@gmail.com>
In-Reply-To: <20240116-const-v1-0-17c87978f40b@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705413636; l=627;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=NZds5ZvHb3CFb81d/ppE/ipwe1m7zAUlnTKfMKDPIOM=;
 b=JxjwP7lKY5Pg7j09p3ZEbOT71Tw8Ib18YwZ4TDIjxFhOCQxGaNUXmL7K23zo0UhNa49UhZRkH
 svAikt0TR3nDE16//G9EPLt4XDSoelPdMjcM+sipvmLjGkU/btfzd4a
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

---
 emulator/bthost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index c7d59eefc..8c40fce90 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -59,7 +59,7 @@
 /* RFCOMM FCS calculation */
 #define CRC(data) (rfcomm_crc_table[rfcomm_crc_table[0xff ^ data[0]] ^ data[1]])
 
-static unsigned char rfcomm_crc_table[256] = {
+static const unsigned char rfcomm_crc_table[256] = {
 	0x00, 0x91, 0xe3, 0x72, 0x07, 0x96, 0xe4, 0x75,
 	0x0e, 0x9f, 0xed, 0x7c, 0x09, 0x98, 0xea, 0x7b,
 	0x1c, 0x8d, 0xff, 0x6e, 0x1b, 0x8a, 0xf8, 0x69,

-- 
2.43.0

