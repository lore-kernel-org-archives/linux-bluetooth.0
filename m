Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2EF28BABB
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745524284; cv=pass; b=L4T7cWc+CO5gzvrNYrE3nzjutQqijj3IWUuKPg+oAE+Fc4yxmxXm+MvdNwO9waqHw9jymME017CTq7hcGLBi5oKU21klA6rC51CgN3qiZBESHjJifWcwSdNIpDox03yeG67L6V3cfZQXgfs1NQxMBT00+qcl81yskr3F78yEkB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745524284; c=relaxed/simple;
	bh=ANcZOPbf4n2WueDKJ7XSd5il9uSigblDV1Lawz1Gw9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3LyEJRRh6xNLE3aIyudthNVRCzb7GkVBk0G1hNfQUfAHLDRUVetC+z9KX0gvh+F6PF6Ljri7MmZokSf47FcCnGsu5kKJX46YagrF1Ir4stCBRod902C7pxlQrE0v5pqtPNnQ/8zyXYDuD41hFXjQGRPOOJDL7j+TWXyslZRgp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=HqFzeFHv; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="HqFzeFHv"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Zk66N4SBqz49Psw;
	Thu, 24 Apr 2025 22:51:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745524269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y/w1sGr15vGKh6YHtfQFe9xuBpg7BLUGFTt2v4engvA=;
	b=HqFzeFHvoLMvrFkoNrXdLQySbkTGaEfLDWlsL4dnPyEJUpUgj7Jdbh9oji/dYGpzw43rWf
	xS84F7HeCD2XirfUG4HVHvXOWNyp+sP5+0VSk/oW2tuANdpU7H+cX4zboQFwNVPhp99yv2
	wV6fK1Gs8MTF8XAIAhr734DGa0372Ux4CgqOqMbp35X6vL6NxotXYcPqoPVrgPAaN9yn0D
	n87m7C7MK5GqgukGL6bOHnoZl6Gr2NIzDB1gj4emys+k52rhQxdFmBxGzuPPK3/mJNvsqA
	MbjBlrUnjD/jyTMve2vTK69XMowuVLk9B0j8dwtHIsq63g5FEOE0ghDUrDSlbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1745524269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y/w1sGr15vGKh6YHtfQFe9xuBpg7BLUGFTt2v4engvA=;
	b=eMb5Wa/zoFuP0sQlmUAMt7UP/6Xu1I+421UFwJwweP3940uCNQCQsqounv0MKrgpTDp+QG
	xrD376NLhzlwqhOp0OvCKfBZE/wfgibGL+n9wWwgDy6my9uEQ9qJ27wni04ewu+j2JFSMb
	4KcsI5Fho7KEBOHvJaLmGWriuxbeNlEHCWx3NnG2vWHgJkoDF6IMsoSZ6atTQFW/iI1+fF
	Koj2d4Ax+YaoOlKCCFa9kc3XdbnoOFfOK1EeNF6w+5t7D5tRTqRlDBYcErhYyClrF8OMZT
	HIiELyMOcRwNMOawOflS+1Pne6TSlHp6jsxNdDfrIMDTlrjpsDUxPBfDEyeZVA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1745524269; a=rsa-sha256;
	cv=none;
	b=as5m598xMwUDzYgXnmR4V/xSgOumPxBQeu+5w2Sh7WFfAVt+wAEsm24RT9Hc7/dKawAPSt
	04exzWJHRnMtioYDJX8svqdnk9JszKAnN3YQXj0q40KBzd1/24fKjN9Q1CJcs1f6sUncKt
	i4/h9rGVhsVLi9PoZ0JSna8NwJshymkkLd3b6tH6lsfG+VxliYUka9eOdfBWbNO4IMEeA6
	SyPyb4DXhF7oXMTUh76dEsHg1mFKqGqr+xbpaCsm2J52SkCJ6yXqjzEEnj1ZdWWin2r9lV
	4fe0xF4K3n9ve17BLFY6RX0uSk0l9JbSFJYlp3N5kPlikj9X39YVrPv/NDUt/w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] Bluetooth: L2CAP: copy RX timestamp to new fragments
Date: Thu, 24 Apr 2025 22:51:03 +0300
Message-ID: <01117138d56019a8598f24f0df2dd289713cfab4.1745524193.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Copy timestamp too when allocating new skb for received fragment.
Fixes missing RX timestamps with fragmentation.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/l2cap_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5ca7ac43c58d..73472756618a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7415,6 +7415,9 @@ static int l2cap_recv_frag(struct l2cap_conn *conn, struct sk_buff *skb,
 			return -ENOMEM;
 		/* Init rx_len */
 		conn->rx_len = len;
+
+		skb_set_delivery_time(conn->rx_skb, skb->tstamp,
+				      skb->tstamp_type);
 	}
 
 	/* Copy as much as the rx_skb can hold */
-- 
2.49.0

