Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B805D3ACEE3;
	Sat, 29 Aug 2026 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013392; cv=pass; b=od/2utLbCVf85h+0qyJWvqDoikRHjPkL0mpqr4ueCKUrgjuDMC+VWRyGnY28+NTAz3t/RUwVu+kz29lpJCxO3eTdGtrVv8hVzYmz/CIaIeSznpUc+VnxWpA6v4Qa+qmmUaWnZvald3iQOo7TtD/wV/nWNM+il+AMbk1RwcG18ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013392; c=relaxed/simple;
	bh=XgZgRJaCP8RbAxF2F6wwlCNm2i4NZfHfXxO5tbt+JDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oukzFYZjYirqkm4fYzw6IieN+3IXPrRcUXHQVx7v+rhQmnEFDt9la+7hlWo4X6wrJdee8RSMk3NyDWj7KLSQeFPA2GKciqq53UDqyL7WSp76sVCWsuXmS+Zncgu1yKaIurao1QqupJ7H9KCOlosjt8EtX3JPun+Oy3y+a7Mw958=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=cs4pl9v5; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="cs4pl9v5"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:e011::d701])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXHXk3YQrzyhS;
	Sat, 29 Aug 2026 17:23:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788013383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qbD+jA3FjbPdP0383wROCsVf5CmDmabv7/udhP8xkLM=;
	b=cs4pl9v5TgY5b0d2Q1jAeGjVHzY0gkFC0KmfCBq7aEXyLeqjOXHAqOWYbFmC4z+tEH8KMp
	vhGpuuqqIvQKfzvD9ghfHqQqwg1LWpmQoSonAbB0KbJdbkucFp5oRsMed2zqra/T/PAjRc
	xQ8lhtMqaRcnMFNEn400LVrWZFpKoLk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788013383;
	b=qRueV036TwZB1hTlcmmH7QS94jRf7OoB0PXKmI4VL+xk9558bwEdd8285iyKDKJyMV06ga
	e4Tzyo8z197DQYvRArf/OYw+xDeuyaqMTsnQpYkpFgl70siwzAvQKB7VLF5WnXgX86MNZ6
	3oAaEOXmWNLr6ewL9QMF55n9NxBK8T8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788013383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qbD+jA3FjbPdP0383wROCsVf5CmDmabv7/udhP8xkLM=;
	b=TNEGXl8Z7Zi95Re/Txs0rMpRB9aAh+VoLxHEN3Jz/H7qoLt3u1oeHS7DtLZrEE2VJJZ5BW
	yAonZQwuLyINkW9IVCGqaCybEzluUbIz6HBjGtQSmQ6ocbjywwztWL6AqZ6dXsZpnyg71h
	dT9JIplv0rhc2yUx6FTqpnGCopa9v8c=
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
Subject: [PATCH 14/16] Bluetooth: L2CAP: make concurrent l2cap_set_timer() refcounting safe
Date: Sat, 29 Aug 2026 17:20:09 +0300
Message-ID: <c7b6bea07c66171e17ead1faeec6a9b07d307e00.1788013041.git.pav@iki.fi>
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

Since l2cap_set_timer() does not check return value of
schedule_delayed_work(), two concurrent calls may result to l2cap_chan
refcount leak.

Change the refcounting by using mod_delayed_work() and checking its
return value.

Code paths aside from l2cap_chan_busy() hold chan->lock, so this has
little correctness impact.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/l2cap.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 3d00ffb66cc9..efb9b7f422d1 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -859,12 +859,11 @@ static inline void l2cap_set_timer(struct l2cap_chan *chan,
 	BT_DBG("chan %p state %s timeout %ld", chan,
 	       state_to_string(chan->state), timeout);
 
-	/* If delayed work cancelled do not hold(chan)
-	   since it is already done with previous set_timer */
-	if (!cancel_delayed_work(work))
-		l2cap_chan_hold(chan);
+	l2cap_chan_hold(chan);
 
-	schedule_delayed_work(work, timeout);
+	/* put(chan) if timer was already queued so it already has a ref */
+	if (mod_delayed_work(system_percpu_wq, work, timeout))
+		l2cap_chan_put(chan);
 }
 
 static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
-- 
2.55.0

