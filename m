Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698ED3AB27B;
	Sat, 29 Aug 2026 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013375; cv=pass; b=QweBDYh0rqDH1IhUBEz1vHJZMnIJ0ztJZlDdu4N44jfMGmxhFX08iETAQUW1AsYqIhmPufT28KF9CzP8NsbFkdBJsWolQH8aC/iZdtv8aH30PZIl1aLEIxKheVhHjdb9go3nq39OO+IH5MmFHWr2qJPsTHBMugbkw6mg2ihyyfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013375; c=relaxed/simple;
	bh=hmDjBOCGtFpW7PfYZu+2E/XC/CAovDyrq81e/lF6Cws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEPN408fC+L88mQBFwt51NK9BbRUrqrg9RboLCa/e5ZJ4SiOLTWbIyjb8IoKWgzwsQXW9QeXg8o3WNz75phzv3V4+7ZfXM1QT3Nuzne11FLimfqUxUL0pAoMrhn7qjF6PwRFxMKnYQ7H+CyDfhABRZMG5MGUn8AUzLjqZhRe6nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=LEGzGQ7r; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="LEGzGQ7r"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:e011::d701])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXHXP3JB5zyvj;
	Sat, 29 Aug 2026 17:22:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788013366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8k4JThe8kY96BoHqze5PbKpWjvfft1Dino9tH73u91o=;
	b=LEGzGQ7rVWEClF2UjRNV0LbA5xyexfQsTAqGWvIWb06PX3DbwDpbSh1t75BrznMAYl4NrC
	zoPEhxbZcqi1XvLXnK7u6wr3P6W0dVhE4fC2zQDqTRqWFZ2YjzMOQz7biWK2HAt49VzSbI
	LyhzugV+eFyv1qKBXojD/Qe39+uHGNI=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788013366;
	b=gxYpDG3HsKc3qEOh6anNfpiXq71sLmTLJWwc69pP4dPheUw25DRTcgqvPF6ClQOrdGzVpx
	S21TsPG59Ulb2Xkpa+IosAdLI93m0wPIzeKUcTzF9yYM2cXj6G9zBx4fH5V8xO8NgPKWWO
	l+u0xr5a9hZJvvsNfR1BkAxgQMIz0IA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788013366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8k4JThe8kY96BoHqze5PbKpWjvfft1Dino9tH73u91o=;
	b=Ubr6JO1+qHPtiu/t7Pn6FsGk+ZO0z2Q1fLldBTOx9n3otdVXPIE5zhkjt6+AQJYEjKPsb1
	rVzI/BYvYw1O4SHGVe8TBPvjU83/5mMW7lM7361EDUgwOYyhUQy5alAWYM5GN/+1pJEZGP
	QknxfZFD2r3Xt8fhnLHG8YC2Bq1w9OQ=
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
Subject: [PATCH 11/16] Bluetooth: L2CAP: hold chan in l2cap_ecred_conn_rsp()
Date: Sat, 29 Aug 2026 17:20:06 +0300
Message-ID: <6ad9b23ab2f5e3b0abcbadad91f9a667f426a596.1788013041.git.pav@iki.fi>
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

l2cap_chan_del() calls l2cap_chan_put() to drop the conn->chan_l
reference.  If this was the last reference, UAF follows.

l2cap_ecred_conn_rsp() iterates chan_l list and calls l2cap_chan_del()
on some members, without holding chan reference.

Fix by holding refcount while using chan after l2cap_chan_del().

Since orig is looked up by dcid provided by remote, it's also possible
orig == chan, so reference needs to be held also after orig use.

Fixes: 41c2713b204e ("Bluetooth: L2CAP: Fix possible crash on l2cap_ecred_conn_rsp")
Assisted-by: deepseek-v4-flash
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/l2cap_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 750b13f76203..cc86399ef0f5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5513,12 +5513,14 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 		    chan->state == BT_CONNECTED)
 			continue;
 
+		l2cap_chan_hold(chan);
 		l2cap_chan_lock(chan);
 
 		/* Check that there is a dcid for each pending channel */
 		if (cmd_len < sizeof(dcid)) {
 			l2cap_chan_del(chan, ECONNREFUSED);
 			l2cap_chan_unlock(chan);
+			l2cap_chan_put(chan);
 			continue;
 		}
 
@@ -5557,6 +5559,8 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 				__set_chan_timer(orig, 0);
 				l2cap_chan_unlock(orig);
 			}
+
+			l2cap_chan_put(chan);
 			continue;
 		}
 
@@ -5602,6 +5606,7 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 		}
 
 		l2cap_chan_unlock(chan);
+		l2cap_chan_put(chan);
 	}
 
 	return err;
-- 
2.55.0

