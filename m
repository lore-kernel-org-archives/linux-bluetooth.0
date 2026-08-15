Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C338632B
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786827906; cv=pass; b=Ur/TwvfkqMT0L/kLQhvFWIcLLM2NwZ1EiBnsxwBh7O/EMYF4kMP+uC2rrnOTVxEWIe9UgIrjGWlwY1/tKS58yqk+JwXCThzAK6/PuxQa3UqWFGf93itzZgcs6bftYq1nDkmFVBKZEoFGhSNPfuuOwPml/LD+A3HWDqkH3P2K7nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786827906; c=relaxed/simple;
	bh=6OX+01TL/IzxMQRUJfOQVbq1aR9MHINvsPRTEFXrQTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KyrY5zF/6nQVPgoYjNMoD7CcK+w9rWhbU8kAmx0Kh2IukmLOCgcFhVY2tmc3i8LX6AF0NPRqrZ9demC7661X5WApVhiaxabozVXe/WHVN99yaVXwH7ZNmIgudw11EQ9fZ7ewd3aWX9jb4yHW8J/q+hsDJA1ZP3p71yu8MigKEl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=WcEPBJkQ; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="WcEPBJkQ"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:f410:40::a04d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hMs6q2V6PzySY;
	Sun, 16 Aug 2026 00:04:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1786827891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CA4yt6wUvv/zC40DflTUx2rc0+prZbIIhcRMUV+653M=;
	b=WcEPBJkQ/3B4C1coZQlLnVEoRsjri0LXsNiKI78X/MUjz6gdk0NKm9VMmXwdVEpSzYFvY0
	Nzy2/bzlr5wVZ0bcCyPH5zs5/Rseib3GKjptRWDFcl4Pp0KqkKighDUcCdsyK99/ZJnaNO
	MbmUZlgNERIKGY+itX7a9tjW0FNykFU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1786827891;
	b=D2xRnSc0f02S7QIbZiGJzeJ/R26c4wxztIHp2fRnfLP3oKkRx4BFhhd53O8cPXUw4vZZ/o
	4s4uxBorCxhTEksRVvFQYDLqi92zbYPkTuTyodsK2p1qSOwNgYCULjUq87x83fQhrwY29C
	/aK5rHQ17aYTE45zRADhsTVCTue+O2s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1786827891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CA4yt6wUvv/zC40DflTUx2rc0+prZbIIhcRMUV+653M=;
	b=QIiAS0XkjMiPGlkrBZt5Z2T4rXSDAUII/B+xZWRcaF0Dwo++Na9P+wQi7lAWyIKNVjUxH/
	/hlfAaauhtJigou1cUnrqFS9isAgUI5Fduwv3u+x2tj7khd4AF3nN2eoRf3hAUj5eEAAMg
	l6UjnrDw+gjKODXc1Ni8wuzITj7TNPY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] media: fix wrong argument to lp_get_uid() in avrcp-player
Date: Sun, 16 Aug 2026 00:04:48 +0300
Message-ID: <f2c2db83dbe2a47623828db3e5f4baf476336d9e.1786827817.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In track_changed(), lp_get_uid() is passed struct local_player although
player_link is expected, which is ASAN crash.  It takes void * since
it's avrcp_player_cb callback function, so wasn't caught by compiler.

Pass the right object. Fixes AddressSanitizer: heap-buffer-overflow
---
 profiles/audio/avrcp-player.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp-player.c b/profiles/audio/avrcp-player.c
index d335e7ef6..43db0dc45 100644
--- a/profiles/audio/avrcp-player.c
+++ b/profiles/audio/avrcp-player.c
@@ -198,7 +198,7 @@ static void track_position(uint32_t old, uint32_t position, void *user_data)
 static void track_changed(void *user_data)
 {
 	struct player_link *p = user_data;
-	uint64_t uid = lp_get_uid(p->lp);
+	uint64_t uid = lp_get_uid(p);
 
 	avrcp_player_event(p->avrcp, AVRCP_EVENT_TRACK_CHANGED, &uid);
 	avrcp_player_event(p->avrcp, AVRCP_EVENT_TRACK_REACHED_START, NULL);
-- 
2.55.0

