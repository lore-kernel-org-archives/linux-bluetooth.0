Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9177256C76
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Jun 2025 21:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749418379; cv=pass; b=Y9vijoWzaGSG3I5oF/gepDKN1iTH/m5E/gyMkpjTnIWYZ4mu5KT2hCqJUGO7K1zuxWMm+Qo9/CZtvIMC6TSlrcDIniUJ/QXNVebXIEe/AgzOfqs3mJlLUhYcAOHsPoZ3mh1h7aBVdxn/qW74KfM0s7NixBpwKKAIPEy7S2DBAxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749418379; c=relaxed/simple;
	bh=tcMMgCGTDu5TP57NgiTsj8yRjQbnU79+1+vhS0/rzyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHge19VseG69dcAOsXqb7jSUabOC2vYnZElwDZpO7m+7NcbFVrsvbcBR7fHJkUUQagilV4qYvAlardIgfbx3XJ4QdtzD+i3W2ZtJFCMzRY/ocXBbWWAopi5Pv0e5/lRzP8D0yz+V+9mIMJPB0SaeiR7ECJ+ZrBxWQU8vvppyVHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=f5Uw065i; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="f5Uw065i"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bFpDy53D4z49QBb;
	Mon,  9 Jun 2025 00:32:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1749418370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BYbZ4+ctOb3cR+0kO3vBn5dgpf37oA1pWKmhlJ6wZg0=;
	b=f5Uw065i6VYJZKTawL69ASqlmVKrzgeKJGBc1cBhFPtfjquSYbYx8eKGRPCWsALCcbvGVO
	M1JylER1xukjtPLrTQAmcYqYxU0ysiSjTQkRA+440YI66sb3ckzWGAvTKlPeyUreCsR+Hr
	fKycc1s3fAszXWNoQHb9BYmFvJjLYu1Ee0oqhnsZ0h4J40Me8Z4Fh5ojXfDFxl6Nqeh2tq
	FAajMDxSJy6TsAWuELyfqMwXhLoME4zXMHnXGKx/hzDnXqxDwIYIcVxBHSsBiXSKvAMASE
	m6zOwxADLOPfzEG99cSneStcuQN160bvLstUSLcTUENjKftW3PVHM5ney6t8/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1749418370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BYbZ4+ctOb3cR+0kO3vBn5dgpf37oA1pWKmhlJ6wZg0=;
	b=QYpfK6iiJDfxbLDvVrkkyIszzRXlKZvt3N1H8vBtj8r4dfaP0/rRNGt0BpXgBet52bydjB
	c2eF7soIdMsGpqtNS6eFT7HTSwsWvApWXtD+JYrFpsgftMPnsjoZ+eM5BWRqDm+rsJXXwX
	4AoZe9PEcsR+va1KzLg/eH3BlVR5xbk//x95JTULu91W4vmy0EcjCCZ3kmlXHuSsPJu3Ii
	+nJgWwyKEAF4R6S+rSQvSUfzxXsnxaoKwOvYKt/mQXI+l5/gIM9Zq+boY0MWKFy+rAd8Xc
	6dvKbOX+RyWHpJzrthHLzWNQDgs1xxSJSnthifAGhMd1V/7bzklIVh5m8wACXg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1749418370; a=rsa-sha256;
	cv=none;
	b=JGAIK50RQYLTUUtBkNOWNIxmZf/xds0l9X18s+/PUTGIx1/6qkV1IRt18+lECm/RIh4RvP
	v7IlmGMy/4yVjZDznKCzeIM4tvxKD1MiYThCQzpyqpmiVYga6v01vgYVdF8pchuq4vZbLS
	4VsvGJtImPNw3qBnV0sumTe6pjlYmWMLlO8AcIuP4MlP9sHImR71k7M9X8DSredGTJ9jJi
	PCjyGiEdVBGfcYkTkZhIvuFtrW3mAdemJh5Nesqo8LMlxB/a3lFzxoRgKfg599oS+/fga/
	ePpESveOwfFxPmb3IIpTjw26XrTutR2nVSndcuEy7ino/P1PokFsnb3Pu12O4g==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 09/10] bap: don't show error when releasing stream
Date: Mon,  9 Jun 2025 00:32:21 +0300
Message-ID: <637fd51ab4d2e1a0687b61b60cd2948991aedc0d.1749418319.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749418319.git.pav@iki.fi>
References: <cover.1749418319.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When stream is released, just set transport to not playing and don't
show error about missing io.
---
 profiles/audio/transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 244d2c4ae..9bf3b47ee 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2147,7 +2147,8 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 	case BT_BAP_STREAM_STATE_RELEASING:
 		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
 			return;
-		break;
+		transport_update_playing(transport, FALSE);
+		goto done;
 	}
 
 	io = bt_bap_stream_get_io(stream);
-- 
2.49.0

