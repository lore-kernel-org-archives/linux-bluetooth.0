Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5943976A0;
	Sat, 29 Aug 2026 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013385; cv=pass; b=CXAW3yZuSBzD5NeynZJ5WajrfM0CxrHVhaIAOpdJ97EiMxnyYz6FR+4RjdAwy8UmaU18fr4VsnxYIkMvSV0vLesB/Jspj8vAOne+HaOgfbXP0gXQbhzNJ1njcjiS/FtyFQT00fYLnCVJLlTtvaB8Xp3wWBmj/hduSzLkFHDBiOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013385; c=relaxed/simple;
	bh=XyN5NjZUEUM9+dBFPwGVFU/jX/V94wkLAxY8T2tWdzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLzH9L3B0yD85QpK25YLKXnKmLc8He4Bpl3Vz+iedbevSV6zHLoPcPFdPdn7uLgkM2xIAWMPyPJSQThr74ZEGN8cUwSoNtFe7jz/VFJB+MSlpsTuRyZCM0j2kjt78hLqRDbCA4byom+Oqia+e23Kp+eil29F1JAMnX7wM4AfLIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Os9YX4pm; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Os9YX4pm"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:e011::d701])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXHXd0SvJzyvj;
	Sat, 29 Aug 2026 17:22:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788013378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mmFd3M5blw19vh8W/w2YzpOm5wkFPxgwIPhzOZGqPDY=;
	b=Os9YX4pmfjfqqmgv19z4mHHT53XElBq1xalZDzQEQozKHwDCNpzrUenfqAU8IlAMs2kHRP
	CPkg6//hbVzcBrtInQTh7WFIwnJrhwMjxU3lc9BDcT/nyxIVOXv29mD16BRoVlXg0StcVH
	bof7tIThj/6sEF0YfLo6zoo9v3oKPNM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788013378;
	b=l3dmWC6VRCJbQzd9a8SmzALV7hwP7v44FUzsi/uLNuaeNvKPOtXS1CovOciu8hR/ttsfl7
	JXvi7xmW4RqIzErgftr+C0FyR40MzdSPRVBEGeJV+SzpoDEwmypAWu396KPA2Jn/Bj4Sqx
	l6D5vXeLwIq+d4F/g4v+Y+LAAYGcFDk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788013378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mmFd3M5blw19vh8W/w2YzpOm5wkFPxgwIPhzOZGqPDY=;
	b=D1IOyawMTN+OEFwu05/3+BNWgywu8Orzep9NZCWARzbDeL8AhA1C8XznzALYu+D8de++c3
	cuoch5Di2JUxuXsJMJC2Dr9MJGbNJS2o92jf1AzIPbwy6atMmpdffMsmq8v3Bbbme1iZWv
	IGCcawVhV8sqcOJ2vJBMu5XvtCjd4VU=
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
Subject: [PATCH 13/16] Bluetooth: L2CAP: annotate locking for l2cap_ops callbacks
Date: Sat, 29 Aug 2026 17:20:08 +0300
Message-ID: <bd8694739253911798f99666bb7f76117503a338.1788013041.git.pav@iki.fi>
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

Annotate current locking context for l2cap_ops callbacks.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/l2cap.h | 13 +++++++++----
 net/bluetooth/l2cap_core.c    |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index f612c9f884d1..3d00ffb66cc9 100644
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
index 88a9596e4801..ff9529f2eb15 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4200,6 +4200,7 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn,
 static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *conn,
 					       struct l2cap_chan *pchan)
 	__must_hold(&conn->lock)
+	__must_hold(&pchan->lock)
 {
 	struct l2cap_chan *chan;
 
-- 
2.55.0

