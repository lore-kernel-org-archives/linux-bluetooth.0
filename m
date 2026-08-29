Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23EB1A262A;
	Sat, 29 Aug 2026 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788016418; cv=pass; b=DEWIoztZ9XxWSOPVbUUT6xHfzZmNM3I0IEeKnAYYG2jN8UMm8btqmrKqh7uyv8wQyJjeR0iTxywMfHBxXIpjJbn+FY4MZMiRJZu4yNuX/KkpLnGNAfYRd0n2H10oZkgk8nRT12YxeeMw7/N71t9YC82ilxuUt/pMkTQUkgINCzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788016418; c=relaxed/simple;
	bh=1QW29S83zrbhgoV7fhzqgwLU75l2z9RMV4npe5F0xkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lq+4clcHonknvFyl5fcSuBkSYiV+CSSjDapwjpbHRaBbH6imFxEl7xi5bssqv9tfgWxZJUy0i2D1vgmHyE7D3/lij03GjFew6mSaeB0dRHBUxlYoRDXkBqNGQJSlzSUrPDQtE1Z4zKK5ltCqkQKwGUXglAHGORgFdxzvLaf6A40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Dasr92B8; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Dasr92B8"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:e011::d701])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXJfy0fRbzyQ4;
	Sat, 29 Aug 2026 18:13:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788016410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uK619zr+vaN6Kye2qGfp/0h508rZljMJSpuf5cJtL+8=;
	b=Dasr92B8q2vw+YPyZX5Lu98KgRCY8+3t31fHQb6bgIGhaScvZ6PWhxOS4p6FKK3bzJTO7/
	ftJBgLYNrZZNVIG8A1IhqGPL6G6j3wXKpq74pGD4ILnMOku8+DUG8pp9UFX5ln9K8oVCfJ
	ITVzibtuGHWYKJziHLpZGs/q6K9XOkc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788016410;
	b=a+THK+5RVZk0hgG6ytU5S3FmOo0CGUu8SK/1n1JusNjY2mfcWXZrvOIlnEneBLNmjGXfJP
	UY80P4RVpL0jB+22tnL9GJ6W/B+Tde3VjwEu43IY2PKPCZTTM4DkOhO5uQa/Nex9nT40Uw
	19iIcOk78CeAh5ZtfHo+F5mY4ILOc2g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788016410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uK619zr+vaN6Kye2qGfp/0h508rZljMJSpuf5cJtL+8=;
	b=tyFAxQZbY8yA7n23HuSZwQE7oh4qbS7kG1+nfALuMUe0SwlpasstJ988AUI6JeZF9CN7ed
	mrhXk6TrbrNbGS/rocJ2rgX7vCo8bVuuoZ9/B7h7NmPqM1TSfbq+c8a++Ein2efUwmBufD
	e1lQyMNqecZlVyetjuKSGAwkptaX8FE=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: fix wrong identifier in __set_ack_timer()
Date: Sat, 29 Aug 2026 18:13:26 +0300
Message-ID: <efd26a64addcb562db0745aa4e0a8d2252be1d65.1788016177.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__set_ack_timer(c) has chan->ack_timer instead of c->ack_timer like the
other macros.

Fix it to use the timer corresponding to the macro argument.  In current
code this is only called as __set_ack_timer(chan) so this has no runtime
impact.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    Saw this one in Sashiko trace.

 include/net/bluetooth/l2cap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 69d193fee351..99c07f1278a0 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -873,8 +873,8 @@ static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
 #define __clear_chan_timer(c) l2cap_clear_timer(c, &c->chan_timer)
 #define __clear_retrans_timer(c) l2cap_clear_timer(c, &c->retrans_timer)
 #define __clear_monitor_timer(c) l2cap_clear_timer(c, &c->monitor_timer)
-#define __set_ack_timer(c) l2cap_set_timer(c, &chan->ack_timer, \
-		msecs_to_jiffies(L2CAP_DEFAULT_ACK_TO));
+#define __set_ack_timer(c) l2cap_set_timer(c, &c->ack_timer, \
+		msecs_to_jiffies(L2CAP_DEFAULT_ACK_TO))
 #define __clear_ack_timer(c) l2cap_clear_timer(c, &c->ack_timer)
 
 static inline int __seq_offset(struct l2cap_chan *chan, __u16 seq1, __u16 seq2)
-- 
2.55.0

