Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826362F43
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 06:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748328385; cv=none; b=FCXfho3cqqvWc5ltqctrQKjDrvESdokyIXneSbAyoXPJpXL/GNOxzDB1TVyHgL2Ypt/s3wHpjt4/PBaLBDrk4GwQwJDlFIES8/pFSbeVWHQIYx/8fMAPMVw+rHydHM+Xgzu4KiMWJ88yMZNkgnIYC6IeucvPGTqJiQ//4/CaFV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748328385; c=relaxed/simple;
	bh=n4RDWhFiY4mGYhOrEEJVQUOfOjuT964c80/JLiHTH0g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=leycfAOUeEX3sgkmyX5RuBQJdE5ZKgi35oqzzpnkHw4mPixbGqq6J6z6wIHdaCWWRsu9mifuMx7a4nqvonOuYq2x62xq/lRv4fJTTp1X5+GZoRHjzZl7dUXZh+CeUq9nVasi95XcwTjoX7uQPzfqHE7WIjV56Y5eW5yLlm/KodU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VOJYPi7d; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VOJYPi7d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1748328381;
	bh=n4RDWhFiY4mGYhOrEEJVQUOfOjuT964c80/JLiHTH0g=;
	h=From:To:Subject:Date:From;
	b=VOJYPi7dn5gZjW7itARDefspzau+At7AYHI3dj6cUyZb//G9BNa6J9cACUf0j3pw6
	 K3TuO/iGhoUxQ7g8xNhO5RmvHx9pM35RH0FFHd1CQkUmnhrpGJXYCVPeWIiURqiJhT
	 qf0/+vjINat+8URGok2lSzu3R9+bh62/vDJUfXTyqZQ6HxuNnftwinDCA4qP5gOdNg
	 S5BfyIed3zzD1fVISS8FN9AxEER/gtMDA9qL8NWV1vOLLL8yfrdHLaXBAUQO29sDC7
	 M80R8CgFcSq2TsWI0JiRCK7Fl5WbofBXNUxnLLQ2d7V7NDRG2eAVc2TAGPkbHNwOw1
	 1pM0tfXa96cXg==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-Af44-1001-2F37-b1f9-024a-369A.rev.sfr.net [IPv6:2a02:8428:af44:1001:2f37:b1f9:24a:369a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3F93517E1560
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 08:46:21 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio/player: Update track duration if previously set to 0
Date: Tue, 27 May 2025 08:46:15 +0200
Message-ID: <20250527064615.125970-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Sometimes some stacks may set the track duration to 0 in GetItemAttributes
before updating it in GetPlayStatus.

Currently the track duration is updated only if it has never been set
before. To fix the issue this also checks that the current value is
not 0.

> ACL Data RX: Handle 11 flags 0x02 dlen 102                                                                                                                                                                             #287 [hci0] 4.537033
      Channel: 71 len 98 ctrl 0x0202 [PSM 27 mode Enhanced Retransmission (0x03)] {chan 7}
      I-frame: Unsegmented TxSeq 1 ReqSeq 2
      AVCTP Browsing: Response: type 0x00 label 1 PID 0x110e
        AVRCP: GetItemAttributes: len 0x0058
...
          AttributeID: 0x00000007 (Track duration)
          CharsetID: 0x006a (UTF-8)
          AttributeLength: 0x0001 (1)
          AttributeValue: 0
...
> ACL Data RX: Handle 11 flags 0x02 dlen 26                                                                                                                                                                              #296 [hci0] 4.589649
      Channel: 68 len 22 [PSM 23 mode Basic (0x00)] {chan 4}
      AVCTP Control: Response: type 0x00 label 9 PID 0x110e
        AV/C: Stable: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: GetPlayStatus pt Single len 0x0009
            SongLength: 0x000255a8 (153000 miliseconds)
            SongPosition: 0x00009256 (37462 miliseconds)
            PlayStatus: 0x02 (PAUSED)
---
 profiles/audio/player.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 0f72d7601..52844c9c0 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -1320,9 +1320,9 @@ void media_player_set_duration(struct media_player *mp, uint32_t duration)
 	if (g_hash_table_size(mp->track) == 0)
 		return;
 
-	/* Ignore if duration is already set */
+	/* Ignore if duration is already set to value > 0 */
 	curval = g_hash_table_lookup(mp->track, "Duration");
-	if (curval != NULL)
+	if (curval != NULL && atoi(curval) != 0)
 		return;
 
 	value = g_strdup_printf("%u", duration);
-- 
2.43.0

