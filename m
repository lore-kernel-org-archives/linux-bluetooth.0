Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E78F30E858
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750359176; cv=pass; b=ZMFT6TW0lVY0SL3vNLajVaC+No0kYAfX9SLYQe4rFvP0bNSXkaqiWnOJroMowNam37op0Jq00Fw0L6QvpNIL2eS9jlCCV3BiWw/r6ledgamraqt4vc1hM5T7WiygdJkJClo02TpkMMYpjRskhkOmYLMPZ96UhgAASf+ysfbOGGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750359176; c=relaxed/simple;
	bh=dtFLoQ95pyfKZ6RvdEdi6PMBT129XTNB47CokOqvTGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQMduAgSjEbrMKriTem/ZnuvEhSkdVo3RFg/0ilH0Tj/D0egGfDPoisnIn2DxrJUXKRKD5eGHMVqYctyNhFjGKPRCqYWE4I8nYgmdmpAQby+SrPkWYmw0XRCa+Zx4ovvPj2NkOsp9a8AoYbU3Ss5qRdkXW9YUQp5d8hC/WRguIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Uuxo77tb; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Uuxo77tb"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bNV956CmDz49QDg;
	Thu, 19 Jun 2025 21:52:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1750359162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qfmHLbV8M/Zwgr5aFqJY6EURsVnl2IoaiEWDRf7PFyQ=;
	b=Uuxo77tbBWmvjSC6lJQerdB7G8tCQ+YPLfthAfsur6vkWz1BfCKdh+W+uD6kSC6YSz/bom
	/AcMoG8E6JVTEzk24duCilWiD4zC702XP8Z3d16KX1XJ7+v0BvCZlG21B5GAVUzlo7V0MU
	KyK7AvZRfuIWWevCtlVGUaq0xVGMzNB4vhOnn3Nh3wXVPGr2YS/KQzQV/nC8SHLL4mXVgo
	gP0CEGdcXd3qw07X9RbK4DztBRgpM0sBbcVlQdsrwtnXYgV9OpH9ujTaxWAnfwGv92m2jO
	nY1AsnDNVvBKVR8XJR/ZtjEBMae+66OMPZnl47C2xrA7ynpG68v1zrtIP1PxIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1750359162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qfmHLbV8M/Zwgr5aFqJY6EURsVnl2IoaiEWDRf7PFyQ=;
	b=P8QEay8lrmzvsnrFsMrDsDki6gSXDjuQMxQjIQTnbkyBGiyitN+PXsAsmpjgYEO+tSq0dv
	Yw77K+p5bqPRmlUk0wdCYHFGmAlPeNHCWA3Kdx9K542hT3J8V3pwUSd2qc0n3Q4zrkvuMy
	3OnXjk34T6y7voPr5Tbl4z6/9VmiRLW7qnArmRaXmV1NgcFzUNgTitszu73TDJ5iDnZWdu
	moMRY2xizSKA3sg8mSKAAbA04/oLwlvCIXAr0E9zClfLYDwzNzPQHJGMymDhoLIP8x7eH8
	2P4lfIM/07fHHCJgfMmu4ggGmLiD6c9SPS93C1W7VW6fwc7klMkkL/Hq6G8HKw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1750359162; a=rsa-sha256;
	cv=none;
	b=IbxB9/qDb2FdnvLX7lBPhfIIAL+ND6nPNf65whG6idLoc3evbGSQee2mI5ARe+n3oFTg06
	MsJsQ3emM/REtRjZb7MVYHEGfKRcAlYC55zR4qKfFvdMnkCCQy45Fv1V8fOcmDdZDhWFp7
	K3QgwVK9XK17TzQcaVo8loVX23+RkcgySjDB7CdNNp0mFfIrPIHWKOyX0sfMbJCQy1oTIs
	eT9MOt1+ybxuP5mm6mgV9i+iLdcS06IeNvE6VX+diz1EYX7/idReRk6RY1Fo294XgklBlp
	SlBUysi5i9cvVTw7ZVfxvLbxCBKIBveu2I+FdqnU0C1fzci30bn8GSCe84oxJQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] src/shared: allow passing in stream's own metadata to enable()
Date: Thu, 19 Jun 2025 21:52:39 +0300
Message-ID: <dae73d42711856e8ea1100d0703cf861f8f5624c.1750359087.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If metadata is same, it should not be freed as it may be stream's own.

Fixes:

ERROR: AddressSanitizer: heap-use-after-free
READ of size 8 at 0x7b86a76f5d18 thread T0
    #0 0x000000836745 in util_iov_dup src/shared/util.c:353
    #1 0x0000008ea96b in bap_stream_metadata src/shared/bap.c:1991
    #2 0x0000008ebfbe in bap_ucast_enable src/shared/bap.c:2072
    #3 0x0000009226e7 in bt_bap_stream_enable src/shared/bap.c:6392
    #4 0x00000044037d in transport_bap_resume profiles/audio/transport.c:1981
freed by thread T0 here:
    #0 0x7f66a92e5bcb in free.part.0 (/lib64/libasan.so.8+0xe5bcb)
    #1 0x000000837002 in util_iov_free src/shared/util.c:392
    #2 0x0000008ea94e in bap_stream_metadata src/shared/bap.c:1990
    #3 0x0000008ebfbe in bap_ucast_enable src/shared/bap.c:2072
---
 src/shared/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 8d1c69d47..070f4fc05 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1986,7 +1986,7 @@ static unsigned int bap_stream_metadata(struct bt_bap_stream *stream,
 	iov[0].iov_base = &meta;
 	iov[0].iov_len = sizeof(meta);
 
-	if (data) {
+	if (data && util_iov_memcmp(stream->meta, data)) {
 		util_iov_free(stream->meta, 1);
 		stream->meta = util_iov_dup(data, 1);
 	}
-- 
2.49.0

