Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3C6214812;
	Sat, 29 Aug 2026 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013277; cv=pass; b=utNvXazjkamhtQHYuNGZVG65Mf0IJnnBkv5Z/fDl3pd/WRnBg8nJx6Lejph6AC57AtifS712sMAwf5VCZEqQGsR+H+dolWKsjaIqcH41J9sV4aluoiF4Q+tTWqfqAv/Jy9zle4jXCjHeu4kMo3n1XBDHlMWjg/M5wT/BKvcQDsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013277; c=relaxed/simple;
	bh=op78QQZtGTeyMDhLgHzUcodAjobHlPaCPwDpOIpAZVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGaDp3TBCsEIbaY/0Tbu/7Oyo5G8aU0huFl/oTxAJewyw8/C4AYfp6GGQntgcARneejW09VXjFft5+M31gb0I6MYd9u/ogPgbuDeqGyTpx/xSZ67jnOWjaDKKmqmrUDD7LoyfdOBTo+ozsJdsj2rigCcLQXUEc5qOqHUHgOaT1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ZGuh664Q; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ZGuh664Q"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:e011::d701])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXHVX3QnJzyvj;
	Sat, 29 Aug 2026 17:21:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788013269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P9qAXeGSbzvkrAu179qZnN8YI/+hurMqJgOUWHWSjoM=;
	b=ZGuh664QQwg7StBG9iUYxRpjze8Oko2bPkmIgZfJYIP5GRHxF+8BLLvJsG1MTss2VA+Xza
	7fTH5kwfD8Etk9SNQIwJP4/KWgXaWIvqwRpbtm/riSYz/rQ8RlnGh3KpDOYQm7ttlIHYN1
	kaIXefR5nwBhG0cSr3Bw8jAybCMzUAg=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788013269;
	b=xOhd5iC7Pqn3R69RU9qrKaDijKDCJt02l1iHrm7LZ37+iA978gSdDLJ7F9+l8OM6iQD4MV
	3eGL0kV9LibozmE7jhQle7Ty0cqnXesdUUQ4YTHf9Ezd+7Myh9fim225bek9Yf2UpjlWUe
	bT+se5i57IqFq/ypu6rJEX4uv8gMuMc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788013269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P9qAXeGSbzvkrAu179qZnN8YI/+hurMqJgOUWHWSjoM=;
	b=yWnt6fsp715hlf2WtLyM+Wj3huqvXU9kPuSN/jAK8OSSvDxHFwFRAvDflB2qL/XnuhOav0
	EDDTuHvTb7+fua+BblkNgFhHi80Ifyq7SP/dSixvmOxHN4urMHPJTDlnO2zI+9TYlKuGkc
	9sRanRvsTlcgejr698IVt4N9Ogab06k=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	oss@fourdim.xyz,
	error27@gmail.com,
	elver@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/16] Bluetooth: L2CAP: remove unused l2cap_chan_close()
Date: Sat, 29 Aug 2026 17:20:00 +0300
Message-ID: <c3a70bc5340454cb9d253ea370c7604a34110e54.1788013041.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788013041.git.pav@iki.fi>
References: <cover.1788013041.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_chan_close() is now unused, and l2cap_chan_close_unlocked() should
be used instead.

Remove l2cap_chan_close().

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/l2cap.h | 1 -
 net/bluetooth/l2cap_core.c    | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 84f557d354ca..e395ab5493f7 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -961,7 +961,6 @@ int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm);
 int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
 
 struct l2cap_chan *l2cap_chan_create(void);
-void l2cap_chan_close(struct l2cap_chan *chan, int reason);
 void l2cap_chan_close_unlocked(struct l2cap_chan *chan, int reason)
 	__must_not_hold(&chan->lock);
 int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 58c88e116ddc..c9b3321f7f90 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -880,12 +880,6 @@ static void __l2cap_chan_close(struct l2cap_chan *chan, int reason)
 	}
 }
 
-void l2cap_chan_close(struct l2cap_chan *chan, int reason)
-{
-	__l2cap_chan_close(chan, reason);
-}
-EXPORT_SYMBOL(l2cap_chan_close);
-
 /* Take chan->lock. If chan->conn is non-NULL, take new reference on it, take
  * chan->conn->lock, and return true. Otherwise return false.
  */
-- 
2.55.0

