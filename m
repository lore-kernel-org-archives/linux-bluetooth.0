Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A059A29D260
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jul 2026 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761342; cv=pass; b=ShlsesaJ6lIpjTEa/ChAD9VcUaVxkdLLDKUh98WkPObpegG1xJNo/eo+qBdYIQPL4wLZCOB8wYTrthaSAVlp/64e+4RvcQMVJvz8JjNbqvaqDjCJF0PC5bPLs7ZdThD0AyR0jGZNpr20km4YdbiC3MtS/f4M0/NtaRZsovTyGJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761342; c=relaxed/simple;
	bh=hsJuFGBmIudIJwRfi8QCBTUCqXGQSOev7gQfG7T/poc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eQgInu3kVDoHNPD91MaVbNwQPh9vVuBjHefYWYjwkw2CWtF8Bx+448yOj1BF8x1rvJDl8fjVp+KqjIvmB08F8lgaALPSjAZvCNUc3fbuo0PF9RXSgIp5RF4gR/dmHE/LKvsQY75m3o15L9/w7qz7NtDCBSIWSKumgUoN0k/Ofjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Qg70jkvl; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Qg70jkvl"
Received: from monolith.lan (unknown [185.65.133.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gy32T1L7lz49PvN;
	Sat, 11 Jul 2026 12:15:28 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1783761329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ewdj6KJ7iZU6J4YvkzkaqcBiB37nk7epuXpEDiMiXz8=;
	b=Qg70jkvl4yDMenJIvNF0zQ3HWt/PuVqkysyPGcTxREjw3srvD1nAZewqU/im8GrVkouEAu
	Oec3sjQKkq4nDXMV+Z6F4K2l8qmq+c7GeORXtmGoiohV2aKBMWiSgQCbtBbUp7JcOsvy3P
	YusoLMW9hL9i8v75HJIc1CdLv1pWT5PAr5vWjDJK/9oN4lOkFpAAPQaG8Uwsbbu8DPaeZp
	h17tzc8moBYl3L+C8biv+sD3snPvuKNBskTaL2YT4luZoFLFc9E6aA7epnIrZotYnLokNB
	fRjYyuqhLLkOR2hMXJK3arb9oNHtEb5bUGD2rAId/hlPibfYd3x0OAnW+YLqIw==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1783761329;
	b=OkJ54kIeMeTckwiZZzKX5TNhSn3eQW54OakecCmFyMPYuNeJwzrXVPInlP9/1V6FmQUiEM
	/+T7Z2XId5bgsZ5C04BLDNjRxWogmI6EdsHiiK1Y7nwMuSs5zwnFzrTbPOwfOiU9p/4bbp
	quaExxSh/xDXaZ8pE/IHq21JI3P+bznHic9s4ulVWzygJVq8NSaSpaQMSN3YA1cFQepRL6
	ChKb6hgUUAjiSWwWoQnvh6neYqjb/qteeIHmT55qOrtlZ9e0IF5piNOx5yIQOmtC2srW+e
	pYbhlIP6EoWlt/1lL+ygQGW9Z1fiYhP8IQLn/TieFM5AHeVsIpUdxFmqrRmFTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1783761329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ewdj6KJ7iZU6J4YvkzkaqcBiB37nk7epuXpEDiMiXz8=;
	b=GkIAATUgqO55mhh1yMCRp9IXsXrG47gPoqYTadycQWS2ec6vhKNRrgbnZlWE/11EW/9MS9
	6fB0W6V+OCOUke3hPdTCVz9U0X/Awca2cY6ANcJ8wfofBuT8sPoBzVmvDy7lAbzcuDSPoa
	DrbdIxtC/OmwT9XbCuvMLgP/9iGSm/a3idXgNyEpxSqb3nSoIJI1r26GP/oMgQ7oUF3u75
	lITw3dD+YP4pYQm2BlX/N17H7uxm1cWyfnj44rRyRupq3pCLjWKkxPSGImAFBbnJEe4QQJ
	xWy5aCMhjtE3K+d8lZD80QyP1OF5IkydI62nLqwaL/y/9Q8ArUJJELXln0J+sA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 1/2] lib: add iso_data_* macros to hci.h
Date: Sat, 11 Jul 2026 12:15:25 +0300
Message-ID: <e2b3c5425a653eb198700cb28c453607e2d82840.1783761325.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add macros for parsing ISO Data Packet header items.
---

Notes:
    v3:
    - no change
    v2:
    - no change

 lib/bluetooth/hci.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bluetooth/hci.h b/lib/bluetooth/hci.h
index 732477ec4..2e4aa394e 100644
--- a/lib/bluetooth/hci.h
+++ b/lib/bluetooth/hci.h
@@ -2335,6 +2335,12 @@ typedef struct {
 #define iso_flags_ts(f)		((f >> 2) & 0x0001)
 #define iso_flags_pack(pb, ts)	((pb & 0x03) | ((ts & 0x01) << 2))
 
+/* ISO data length and flags pack/unpack */
+#define iso_data_len_pack(h, f)	((__u16) (((h) & 0x0fff) | \
+						  (((f) & 0x3) << 14)))
+#define iso_data_len(h)		((h) & 0x0fff)
+#define iso_data_flags(h)	((h) >> 14)
+
 #endif /* _NO_HCI_DEFS */
 
 /* HCI Socket options */
-- 
2.55.0

