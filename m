Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AE91FFC7E
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 20:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750452188; cv=pass; b=G9Tvrg2prKN3WZUtpyIJu+++n4k7CUu6ZW/6Bfwm4qSDiDavvEil4+Dj0Mj4UJMpXbgOgCS1QAc6SYLCCaeK8af/3A7ld73KjQgmsvbjrSxZwR4meXUPYuDKG6qBZgPA7GWq9o8GDvddLxLRetHlPSaCUlWRL969ReF3TG/w1sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750452188; c=relaxed/simple;
	bh=echAf+1z1SOfCurWpBmzInwfbQ09TeRun4700aR6kVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HR7wveJp/yuhOfd7vHxIRHz2/mbLoYs+4gYCDqUhSf7H9y7eqxT/fFQR8ETExfpp4o8oZRvKHymrQb04Pxz6zJy7WP7/421moji1CpeZO11x77vJcjz2Ky6C2/b9NzyXov/v/BlnJzGNWa02WfxdmivHnrs2mOgjumanePgUaAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=krMcOQcO; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="krMcOQcO"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bP8Yn122gz49Q30;
	Fri, 20 Jun 2025 23:42:52 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1750452173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EZdUR1KVwINM/8zJyyfoobd3gR2dkW8mncm8q8IT4rU=;
	b=krMcOQcOoNKGu8S70jlz70XYgvDN7uEhrJnJcWpPA+UzKC+jjPb7+mIPo8u9HiXf3wwoCE
	6mpjXexIMtJROgxmLYwG1LAmsISwTkIauRM7K1v2R0HAcdvwTI14+bv2BLpfz2so+itLhe
	dBBv9VL2v/KXH8tBVvnvR8mwTawI5DYCCw18sMAyi/BdwPmDxY5oM1fwKh1Qhx8KoYnZvi
	hOhZaAy+pic/PJc7p81tFV+rqLi4KudGN07WB+RXtN0cpOF+bu68BGoEp9+ZBsRyUh6osy
	1LB/5mGYkzT6dj7iXSKSnKpkcgtvcceWVO/D0fVUMOW7bZq5JKCGo3ICxGN8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1750452173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EZdUR1KVwINM/8zJyyfoobd3gR2dkW8mncm8q8IT4rU=;
	b=BJu70HjgXkRKK9yxt9UlUVZsTRos04FdWOt0II1HLcpUbN16C3TUX8y3MtUgBxgSKF0rC3
	du7nzWpwi1GnenkKTgSApjdL7zh2RKpMY5aihVFsFh5asKjCNwTa8iAoqObWhsY+CRutqR
	k9YAHFNk4uE+AhWZ1/T82nraAaCZEgcOGd5DtKq+qAEHoRDYJx3p4+w9qELvWD1M3+OFX3
	8FWMxR2u6UwuO/cgr54ln8zaiW/NrB5IcHQKCbBLdB+d80NImWNaJUcbLqbXh3pzERf0k1
	geX1N+abxVGiLcQJxdecOfGFBHb3Q/n4xxURtB+7AduqitgQJGfsuLLR1LYxzg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1750452173; a=rsa-sha256;
	cv=none;
	b=I2lE3oQWkGjQAH2fBJoIxDDuGpl/MrCdf2cHlBxYoXVTOlZfZhtHQ0LjWNMpGSllrBGOXM
	OU2oeXcasp68cume5m3whWEw4AuOetcxOYi1FnLsvNvOq4ype770jB65hjGMUj5h6bBpse
	oyBHte+28kY8cuY22REbI6GoGl5yrivBkDxdYlixQI1OIhwZDBLgIsdmDPqLuSa19dD0tv
	xI4EZNJx7KM09N3C3oVJ9ck6UawEX0DnQyGPsyyODzB87Wm/El+slFmZUVxpD9ENWp2f3C
	fGnHBJz6zjTLtA1Ny8tPZtFVUj3NnU6zZQYKJsP44rhoZ63PI2lzj9vOdgMJZQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3] bap: don't pass in stream's own metadata to enable()
Date: Fri, 20 Jun 2025 23:42:48 +0300
Message-ID: <bbaf5b867f3756fcf72b8e0cd9c2e984d2622eeb.1750451973.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stream owned metadata pointers may be invalidated in bt_bap_stream
operations. Just pass in NULL to keep the current value.

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

Notes:
    The other option is to specify semantics as in v1.  In that case,
    because other bt_bap functions invalidate only if util_iov_memcmp() is
    different, it's best that it's the same and not only pointer comparison.

 profiles/audio/transport.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 9bf3b47ee..4800570d9 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1957,7 +1957,6 @@ static guint transport_bap_resume(struct media_transport *transport,
 				struct media_owner *owner)
 {
 	struct bap_transport *bap = transport->data;
-	struct iovec *meta;
 	guint id;
 
 	if (!bap->stream)
@@ -1977,8 +1976,7 @@ static guint transport_bap_resume(struct media_transport *transport,
 		return bap->resume_id;
 	}
 
-	meta = bt_bap_stream_get_metadata(bap->stream);
-	id = bt_bap_stream_enable(bap->stream, bap->linked, meta,
+	id = bt_bap_stream_enable(bap->stream, bap->linked, NULL,
 					bap_enable_complete, owner);
 	if (!id)
 		return 0;
-- 
2.49.0

