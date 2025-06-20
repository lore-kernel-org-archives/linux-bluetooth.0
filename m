Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A7C224AEE
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750409962; cv=pass; b=i812kfN/9yPL6IPWqxMA9BudT0B/vw05KrHZVtbGTQwzHVe00k0knwAO9yo4BFpVQAnOdtHug352A58v7S/bTj4lDl+CKMniOrXscudR7VDaDhEf4N6+xzlOhFu03xzjESPjd6AqfIUrNhxDUOxygdJWUZWMKn8Lai2NsKwW838=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750409962; c=relaxed/simple;
	bh=6hQU1tusfOqCBP9PIMpFr/VOB8+HRpoZkpD7NzEIEn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BlJV3pMiHOUfmxVtWv5humV9uYnn/mTVcnRobQkShYdTmRQt9TKYQtGgB0RtZyRMfNM/SfCzO8inVTJfUiICdXrASFrRHVaHVmzVcw7emU/95t5Q2F25J4WBsy5ztdZSpmyh/4AmCt3JeTXD9Qqovup6SIJQwnpszP6sIwsT/oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=e8E1OKxA; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=VSp9Sbs3; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="e8E1OKxA";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="VSp9Sbs3"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4bNrxs5Ynpz49Q6b
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 11:59:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1750409953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xEepSpen11pGJAAKfHS9Pv9I6hDxwJg51PGYlypXyhU=;
	b=e8E1OKxAoY2MqY6fQl4HTUeyslYRjC9q+JxDCifQhOp/zR3FLcB+PNxGTZ9O3hzFXcXX+X
	r3824d+gMRWIBELY+/p8MT6BjZqf6Ih/qxcdc5VdGXLyiuAuchHWXJ2HWVX3z7bxngUoyo
	BCjlBrQGChy6AFH3Vbnh9shRi1Q3HgvU6caX1CZwJz496VCowFkZ8teGPYtu46Foa0if7O
	00hsVIy2+AT0HL/Ud8y2TSe/QPkabcjcm/b898GGyqgKRYrybXYUDNF+PzB4c7VEMfKwqz
	yJ3sP2NwLaN2BSsurzeHXLdoSRV3ki1kELwAdDUtypDLfm/9rtf8D8LboL4sig==
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4bNrxj5N17zySS;
	Fri, 20 Jun 2025 11:59:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1750409946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xEepSpen11pGJAAKfHS9Pv9I6hDxwJg51PGYlypXyhU=;
	b=VSp9Sbs34iiPJXxqHjNrAbrBlj8Rx9a24zEcPG9iA8cKN9I6/Qb6Lm5wpWj+vc77OxANI0
	hfZFZEChaShGsVUC40yxtrhfPZHnviN8CzlK3mq+mSXX4naABeD51qOdXPtVu03K9gIr1K
	ZGN7oJcTnuBaRXk8l7qC7qrJbcd/n5Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1750409946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xEepSpen11pGJAAKfHS9Pv9I6hDxwJg51PGYlypXyhU=;
	b=wlKzckkJyLQzQAjBNrdPosi5zeTmxklJAQetUD59dZaZLjM+JCAEeCBHcA8mbFupXjDHnZ
	gavbP7os7kPVoufxXVZXn4Vyzz+jxTqphr20GTtZsOpO2kRiPYk2ne6bBIDmvtPRniJltC
	Sl1aqcmIJ9NP2UjA7yM34hdSLm8EbsQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1750409946; a=rsa-sha256; cv=none;
	b=FYFUH57K0UEQelHD32sCZgXOPTlwM3hrxvalr42KW809VLkwkmEd9GSameMT/PUd5mn7Dh
	oEUDs9mEKHZtGFX+BYHLvo7zsFAe1bI23VjA3nxdeV+r9hlxFFE9tGIArSGiNooXsHvOT8
	LXD47AkfagbKGqx1XTD+AWkEMqvOVJ4=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2] bap: don't pass in stream's own metadata to enable()
Date: Fri, 20 Jun 2025 11:59:02 +0300
Message-ID: <c257288ce21dd2c25624d0adda2f42b0428f7a43.1750409838.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stream owned metadata pointers may be invalidated in bt_bap_stream
operations.  Callers should make copies and not rely on details of their
invalidation semantics.

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
    The other option is to do like in v1 and specify the semantics.  In that
    case, it's best to be the same as in the other bt_bap functions, which
    use util_iov_memcmp.

 profiles/audio/transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 9bf3b47ee..62abd83d7 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1977,9 +1977,10 @@ static guint transport_bap_resume(struct media_transport *transport,
 		return bap->resume_id;
 	}
 
-	meta = bt_bap_stream_get_metadata(bap->stream);
+	meta = util_iov_dup(bt_bap_stream_get_metadata(bap->stream), 1);
 	id = bt_bap_stream_enable(bap->stream, bap->linked, meta,
 					bap_enable_complete, owner);
+	util_iov_free(meta, 1);
 	if (!id)
 		return 0;
 
-- 
2.49.0

