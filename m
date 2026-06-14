Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E165537B41E
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781432833; cv=pass; b=euWhr8nslSBHaUmc0bUctcS9qezB98+8bmy0KZqCK5hSwMGDwW3TEhZf5A65ALQxE+zsfx3z3deIdgyL0xcMi0dPxO5j4TJGdWT7sVb/4932zr14BCVaw9CXnMImwaC/2K3Mgjggveja0e9z/GCtYaKrA+GWvmPHv5BYNTioxys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781432833; c=relaxed/simple;
	bh=EnoQHsigu1eSkecK5aI4+76eRW70I3Gt5xcDhOtRe9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPhr+sVNjyViN3MCYMaukEAzNrDtm4XTsbRL00s9UWWJOgTkZnjMPStRud2w6d4Ht1d4NWpUgQla1Cslafym4mELCiSnaRtDmKIuODp9bk7cPhj7KL60UlVRD7K+Y9AtLCFMem8Qxyo1Yh34WcHRimB6sVJH1gsLIkop2dOwTvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=TA2hvMAv; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="TA2hvMAv"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gdTvf2nlxz109q;
	Sun, 14 Jun 2026 13:27:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1781432830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/0aNeJkd7NA5coqDc8Vq32gNuyNtDtHCbpXrKMu6VyA=;
	b=TA2hvMAvzjgqVNI0UDEum2ZS+a5RVwaCricw5UYXwKWxD//NLKR7STyZRd1wwxfJZgXqd6
	x8qgafjzMTJrDv+aZ3Hvu/P3cPXQvAcKpQ5o544ejjgeQ6U+WvQ/UOqY7IYAkQ+fn2XQ7s
	x/VH4FULyPHpNB+6OegeV65QhRf9Y/4=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1781432830;
	b=i8DjPeGYUf4s94yfY8WA81QPAfLXlChj9ga7j0lXfHDBMS80M32BlGBYIqZ5E4rtZVLJ/n
	nFLBx6dLyxiwylhN4TikMpd66OzywPPf/i3yArsUR0zqbzXGIdZa2AnMRvYQTMmgRt2TkV
	LZOJyf2vx7r4yTxnWKrpsOJup2VvPwY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1781432830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/0aNeJkd7NA5coqDc8Vq32gNuyNtDtHCbpXrKMu6VyA=;
	b=tBHV5moFfWO+ODWRC8//T/OiW+FJqxawa7BY1w9Eq6IBxfKSnuBm3NpbMfevp4OjQJJhw9
	3lVK+BgKMbb7vpSS2CFddiEPtXC4KDZPuEcDwMB0NxTwBayzM2pTAhQo6f/7L7qyUJETFF
	HmIIiQttAiH2tduGwz2pQomqCLSx1Rk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 3/5] Bluetooth: L2CAP: Add minimal context analysis annotations
Date: Sun, 14 Jun 2026 13:27:04 +0300
Message-ID: <8b184228dc43e4bde42255f9473a8ab6a4222531.1781432726.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781432726.git.pav@iki.fi>
References: <cover.1781432726.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add minimal compiler context analysis annotations, required for
compilation to pass.

Don't check complex conn->lock usage in l2cap_sock_shutdown().  The
analysis cannot know that chan->conn pointer is never replaced by a
different l2cap_conn.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/l2cap_sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 4853f1b33449..8558a7071ff5 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1351,6 +1351,7 @@ static int __l2cap_wait_ack(struct sock *sk, struct l2cap_chan *chan)
 }
 
 static int l2cap_sock_shutdown(struct socket *sock, int how)
+	__context_unsafe(/* complex chan->conn locking */)
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan;
-- 
2.54.0

