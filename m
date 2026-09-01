Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0CA387347;
	Tue,  1 Sep 2026 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788296702; cv=pass; b=DSoscg3HWulBha+vRSZFlaag5G2hAUt+G6rBXJut8SNMzftXc9vL0KNN/2+H7kg+OK0HSR7AlZdlcnoo+UjLbOYUQgxjsavIOPVV0YSBuy7dTdVGv5bKrd7WZhvPFvnBhky6df0TSXv2H63o7QT1/s2cOzWz3O2aZ1BAb9Qtc2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788296702; c=relaxed/simple;
	bh=Z4wrzi/jCko2jVUjv/y05CcT0TV0/eHdeWoQdL3wWpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzcFEoby9hwcLznTBA1SIEYVfpF5+TBKW4g68fZ7avN38mhOh42s5KIoq2HV3tWl4pWT+R456e0hCXINRbB4lb0BEqDeWqHHwVVwBbQE+3suLDwI666offLtiRk1jhRqd95LRR31LblvPDZykxb+Jwi/csJgzVeUqMsnRstTqm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=BqIr+eoZ; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="BqIr+eoZ"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:4:f011::dd01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hZJK25X5GzyYW;
	Wed, 02 Sep 2026 00:04:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788296694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQstipzFC8XSCMgp+rCFNiXIjI+TWPVN6KaF5ptHhNU=;
	b=BqIr+eoZ7ktqaZURh5h/44aKGe0rNTpEDfSJUDRTX38SZwvQhsTMpE0kPEQ1zSFlITEIkr
	+dd5pwTP30CuqAsEAxxC4DF8OXCCH98b45xpNTHm4P7Y0CAWKeonz4gh3mjxhevk65KgBJ
	Bh1oYm0HD4dwKqlCUFvu9EEhrjzK588=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788296694;
	b=s+VnxlymNDdaHmF2mTrg3ycK3dQVp1FEjLzXB3QCSAuYgP26YPfhdyxyX2el6X1WwllZ+N
	+fyC/g01pqxFEdIp5ddTPb+REGAuTTacMzmu3sXYshBaTh9gndqcUdSI4p59jK5W/zSMyC
	vUiZ1Roqj2LAeOccPsaFkPHJXIq0WxE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788296694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQstipzFC8XSCMgp+rCFNiXIjI+TWPVN6KaF5ptHhNU=;
	b=wsqijSY5z28rOZE2t0pbhJYB/c4+rPHv2Spcu/hvQk8tbLbWbDP+o4cPjIF7vMTJZFdmVZ
	hYL7bK9hNqtvbH7/r1qPFHOYARonfwLLB70/uNZj300IoU7y9snMv+SDAJW8KLIhhe6lZx
	QKprSSd2KhCnDULmxnsX4hNMxO8cM3I=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	elver@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: L2CAP: annotate locking for l2cap_ops callbacks
Date: Wed,  2 Sep 2026 00:04:35 +0300
Message-ID: <14d8b302f8673675ab69ed236674c647969d7589.1788296635.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788296635.git.pav@iki.fi>
References: <cover.1788296635.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate current locking context for l2cap_ops callbacks.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/l2cap.h | 13 +++++++++----
 net/bluetooth/l2cap_core.c    |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 3e1e2b36d7b6..efb9b7f422d1 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -653,21 +653,26 @@ struct l2cap_ops {
 	char			*name;
 
 	int			(*new_connection)(struct l2cap_chan *chan,
-						  struct l2cap_chan *new_chan);
+						  struct l2cap_chan *new_chan)
+					__must_hold(&chan->lock)
+					__must_hold(&new_chan->lock);
 	int			(*recv) (struct l2cap_chan * chan,
 					 struct sk_buff *skb);
 	void			(*teardown) (struct l2cap_chan *chan, int err)
 					__must_hold(&chan->lock);
-	void			(*close) (struct l2cap_chan *chan);
+	void			(*close) (struct l2cap_chan *chan)
+					__must_hold(&chan->lock);
 	void			(*state_change) (struct l2cap_chan *chan,
 						 int state, int err);
 	void			(*ready) (struct l2cap_chan *chan)
 					__must_hold(&chan->lock)
 					__must_hold(&chan->conn->lock);
 	void			(*defer) (struct l2cap_chan *chan);
-	void			(*resume) (struct l2cap_chan *chan);
+	void			(*resume) (struct l2cap_chan *chan)
+					__must_hold(&chan->lock);
 	void			(*suspend) (struct l2cap_chan *chan);
-	void			(*set_shutdown) (struct l2cap_chan *chan);
+	void			(*set_shutdown) (struct l2cap_chan *chan)
+					__must_hold(&chan->lock);
 	long			(*get_sndtimeo) (struct l2cap_chan *chan);
 	struct pid		*(*get_peer_pid) (struct l2cap_chan *chan);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 219d92431be0..b7d5fa6f6a83 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4214,6 +4214,7 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn,
 static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *conn,
 					       struct l2cap_chan *pchan)
 	__must_hold(&conn->lock)
+	__must_hold(&pchan->lock)
 {
 	struct l2cap_chan *chan;
 
-- 
2.55.0

