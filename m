Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395482153D2
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Oct 2025 23:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760225395; cv=pass; b=QPvy05Ldl8QOmxD2WWrL3jIDLY3dWNy0ng907mtzxkKG3+ggVlsqjWQqRdUHK9GaDU23PGXLAbB7jZD424E5RZDNBxUeWhlqBGWArg41vPnXO6h3goMsBpdjs3wtUvquW4uJetpL2rr6b5OjhEUQqTtiFYHYTGp5LcxA4cg+icw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760225395; c=relaxed/simple;
	bh=U7i3RxwyJzVvaV0vpvdONd6TutciE70gP+uod2EKCEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uk33pnBIu1BIpV5S8QdGubOUn602Fctbr382uwxwFtTblbJQs3j1vPWqoW91diE8S9iimdXIHgovCRI88MA3cJmD4ZZ5YplAblJZKx9bpQGhXDFa7mWplhhruAfh5yczeigqbuF1lbwWXVckI/W5Viyv0NEkyWRLfrVmGxc/eZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=xxM4FmYP; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="xxM4FmYP"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ckfw76vLxzyS6;
	Sun, 12 Oct 2025 02:29:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1760225384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+6mah4TtVYOLslvus0rkeF0R/GHTlRHUXgOiKeHO5YE=;
	b=xxM4FmYP6lWbKtQwulvYbqVPokK4sqqd8ljbQNDCwhFtlLymXWiVP52HcGCduUryxXXIL7
	JfvkhGtc1/XmcSiaeGq1FndQJt3Pr3D+Nq7aKhnp6tY52e0lMSAkvbVmzGNa8Q1o5TkyKk
	KwQgIpwHaT7cXl9I6gVbb8Arhe1bpnU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1760225384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+6mah4TtVYOLslvus0rkeF0R/GHTlRHUXgOiKeHO5YE=;
	b=zLFUG3xEpG9W2KwxMcs19H+enNOMhPtNRecRBVNSA0Xol8UIV+6eIqPr3SqT9kJHbZ+TXe
	cOEid0CiNBZYSRafJhM0bfYPxmUbwW+g+WdNajzzYEjyveFGnPbdR77TI/f53rA0uG89bn
	YwOWovEN68y0BFgllckTBAPcCQiTzXs=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1760225384; a=rsa-sha256; cv=none;
	b=Ne72HOc2L7RHmEnNZabGLy6f1W8WEMPDW0ZXUY9cJEPjiiWjX9GbuGzh2v6huew2xbEfvE
	vMtplZBSG233Pcw+y2cKO28wzxLdP5BwoEvkv1ImV+q21D1UDYDRV6KTYNWIoh7w/zr6cw
	D5hxIPj8AVJQyC1ot8Du90f47lUy2tA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] shared/bap: fix crash when setting initial metadata of a stream
Date: Sun, 12 Oct 2025 02:29:39 +0300
Message-ID: <a2c50d6cae8f2c4a092172ac7dee870405954a7e.1760225372.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bt_bap_stream_metadata() when stream is IDLE causes IDLE->IDLE
transition and crashes due to UAF. This occurs if SelectProperties
provides a Metadata.

Fix by not updating state if stream is IDLE.

Log:

ERROR: AddressSanitizer: heap-use-after-free
READ of size 8 at 0x7ca9d83ec448 thread T0
    #0 0x000000927dce in bt_bap_stream_metadata src/shared/bap.c:6525
    #1 0x00000056ae75 in setup_config profiles/audio/bap.c:1790
    #2 0x00000056b865 in bap_config_setup profiles/audio/bap.c:1831
0x7ca9d83ec448 is located 8 bytes inside of 160-byte region [0x7ca9d83ec440,0x7ca9d83ec4e0)
freed by thread T0 here:
    #0 0x7fc9da2e5beb in free.part.0 (/lib64/libasan.so.8+0xe5beb)
    #1 0x0000008e3481 in bap_stream_free src/shared/bap.c:1259
    #2 0x0000008e4586 in bt_bap_stream_unref src/shared/bap.c:1342
    #3 0x0000008e4b6e in bap_ucast_detach src/shared/bap.c:1366
    #4 0x0000008e6b63 in bap_stream_state_changed src/shared/bap.c:1496
    #5 0x0000008ec17d in bap_ucast_set_state src/shared/bap.c:1857
    #6 0x0000008e75e4 in stream_set_state src/shared/bap.c:1543
    #7 0x0000008f268c in stream_metadata src/shared/bap.c:2250
    #8 0x0000008f2801 in bap_ucast_metadata src/shared/bap.c:2274
    #9 0x000000927d3f in bt_bap_stream_metadata src/shared/bap.c:6523
---
 src/shared/bap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 9b7395223..5a7d0af00 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2246,8 +2246,14 @@ static uint8_t stream_metadata(struct bt_bap_stream *stream, struct iovec *meta,
 	util_iov_free(stream->meta, 1);
 	stream->meta = util_iov_dup(meta, 1);
 
-	/* Force state change to the same state to update the metadata */
-	stream_set_state(stream, bt_bap_stream_get_state(stream));
+	switch (bt_bap_stream_get_state(stream)) {
+	case BT_BAP_STREAM_STATE_IDLE:
+		/* Initial metadata */
+		break;
+	default:
+		/* Force state change to the same state to update metadata */
+		stream_set_state(stream, bt_bap_stream_get_state(stream));
+	}
 
 	return 0;
 }
-- 
2.51.0

