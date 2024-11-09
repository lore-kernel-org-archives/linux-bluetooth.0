Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083774086A
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Nov 2024 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731177645; cv=pass; b=AV/M5aFQTM+eQ5ov1YgMBcJkgKkdbJXwIbUSsVYPywUpIzWs6+VuYgEsWxU7hvqJ5uppk+cbV8+GM/6anQswgbQv/WlgCuLUWX5IRkGmp2iA79Z1KwBsO4lW4QyFGfJarFkYOzrf2IAV7v9V5DlO7dYiFzX6AGyU2cdomFCBdkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731177645; c=relaxed/simple;
	bh=j2Jqj0spIspA1h0zor9a/pLtDpAZmA5mSctpXmd7oug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=shpcfJWAZiuiL72bKWRPtYT+M/cbnQKUNTFicoclb3rDRdfa7ak3ITSVziFZDh3kUIMwDBBHv57w8BF7SOlX48PymiTiwUFIHF9tat//qBo9zl0QAADdSD3EmsjqSJoIOfjqMc7oXJGZykilYMAjCLdQkRNLIl5h+fzRkpxFj84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Es+VLZBE; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Es+VLZBE"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Xm4PZ1n2szySx;
	Sat,  9 Nov 2024 20:40:33 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1731177634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jywckjryWZuD1G+9MySPwKn09LqlPwX85t+An2pq7tg=;
	b=Es+VLZBEp0jinsQTR1admISr3bDJhsLRmUTJz/4B2n2W+FsHp8XEnu0KvARzOqsI0oaA/t
	6Ctj1DDztkawzHOCCm6nHjIC9QnWu/7OaoFOHMBd5/B/bx8I6tjtOUaLW8xJzwZopVkKlv
	h5OqmmLy4qkeQIAL7RKQ85KL7P3twC0=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1731177634; a=rsa-sha256; cv=none;
	b=Fc+LxJxmYUY5b+7wDoMMJhjxD3rI21tWPI/ReChoeK+O2vNDrbZt1eaqPNqW3o4JSX0hpd
	/PxrT7loRxRJ4EioDk7gZspYi2CxqpHqDzzR8VCBvzHmfh3MkSXK3eCbeWW3DdIReE1Qrv
	+wPiFql80ra4XCNmgN6DyTgl/eozaeY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1731177634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jywckjryWZuD1G+9MySPwKn09LqlPwX85t+An2pq7tg=;
	b=luAc/7jiAYufLGKL3hOqKX9yGz39JJZ5UyFK7fvxcHW37ydg8ElM9wFnEM9kCwQgYDACND
	QMrDNWpxp+69DDGcnySPZPcFgrsbGwAs8+ERWuXyB+KKyJ39jcEzhUPRtJXTZwNnxaNPlb
	U7nCQvEhpDPm5owtDs58GG5UNg4cKGE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] transport: fix AVRCP volume in reconfigured transports
Date: Sat,  9 Nov 2024 20:40:29 +0200
Message-ID: <9dc80086204f29041b29570575df9112c6988955.1731177363.git.pav@iki.fi>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We no longer reconnect AVRCP session on AVDTP transport reconfiguration.
This breaks AVRCP volume after reconfiguration, since there's no volume
update event incoming.

Fix by keeping track of the latest volume in btd_device volume.  It was
introduced to track volume changes that arrive when there are no
transports/players, but we should track all volume changes otherwise the
value can be out of date when we want to use it.

Fixes: 469a75ae182a ("sink: Fix transitioning to BTD_SERVICE_STATE_DISCONNECTED on idle")
---
 profiles/audio/transport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 8597313d8..dbebb1ea5 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2598,10 +2598,9 @@ void media_transport_update_device_volume(struct btd_device *dev,
 		/* Volume is A2DP only */
 		if (media_endpoint_get_sep(transport->endpoint)) {
 			media_transport_update_volume(transport, volume);
-			return;
+			break;
 		}
 	}
 
-	/* If transport volume doesn't exists add to device_volume */
 	btd_device_set_volume(dev, volume);
 }
-- 
2.47.0

