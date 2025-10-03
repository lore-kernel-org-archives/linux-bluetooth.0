Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179082D8387
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511351; cv=pass; b=IZpC6+cg5BQvb57QTarznQEMXOUH9+WL5ekEqU+zBqyXF6bTO+a6u4uaizExhNS2lJTxff+jsvqbp9yC0j/G5csxvqp+QbLxatvPZVAFWfshlf0RZ2SozV4UtZ7xKGnoZosr8hlVLFHUk4nJoAq5m9+0Xcg/Hs8chNKia86orrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511351; c=relaxed/simple;
	bh=zKiys4QT23UAb4DaDsGxbj3DbkBUuFs4VlFJUcy/+rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOT6HjVD3nTt4EjqsAgFFHL/JCAnF08I8Yc/FBgt+omWd8oHCylyI/+C9Lml0lUzw5iTS4LmjOzPeaqMYw7ovzJCpqAlfFaV9dSCnWf2W8TeVIVJcuwxafhVefIyM2xMvsP4Az+wSc+jsZemkNlpkvqEdsW2toQaOorCgsiFc/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=wohMEpH5; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="wohMEpH5"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cdZrX3STvz1065;
	Fri,  3 Oct 2025 20:09:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1759511340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLfiWaGTp+MvjkaQZKMXeGjAFFTq0ZjhMVkKBXXmLxc=;
	b=wohMEpH5yWTMFzNe/+POAPtqVLS2Mt0M13QeChuAYc0JMI6+b1bt1FSFWlCR+c2ZuN1awZ
	jOqty7SGGwj3+l3Wtq/iKyx00GHTj7SMDbjAQLr0ggaMWU0qn7AhdwtP2rWm6jFgSo+e9+
	G+pGWwBblzHoj+hW58sF/jiEsz8jcXQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1759511340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLfiWaGTp+MvjkaQZKMXeGjAFFTq0ZjhMVkKBXXmLxc=;
	b=xmXYzAgVQXfYuDYE0a2ztyIFbJSbFBl8lpB8PK3KzUsk//38xg9gVm31OP20KBNm+puSte
	usHYife+TrLGqKAH5+2ZjJGLShqeJlVce3LmKQRuJu6cUew2tRyNCmSUETqW+i535C8Qnv
	y5hn9SsUFZGnjSOCp7O/0f3/GoJMwnM=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1759511340; a=rsa-sha256; cv=none;
	b=TU5L4C2aDvJBgdIV4H0Bd/QwaeJyipnDqS3hLtBOJ6aa6JTZ4JSWfcqZVd9+JX7tcmmcOV
	P2MMYLF50XnTp+sHFJRj8Qfjlc8GlL4SPHVLKyYWGzKWWyYuf+1I6d+WDxxdK6geTmo/BF
	lPXP1/FQc/ndx+D1sGatFONhHxrWoZc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 4/9] Bluetooth: L2CAP: fix hci_conn_valid() usage
Date: Fri,  3 Oct 2025 20:08:47 +0300
Message-ID: <f2af84678d623c407d1b5ac367504716aba65e89.1759511032.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759511032.git.pav@iki.fi>
References: <cover.1759511032.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hold RCU lock while queuing to ensure conn is not deleted concurrently.

Fixes: b4f82f9ed43ae ("Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/l2cap_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 805c752ac0a9..7900a6dd2b1b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -948,11 +948,17 @@ static u8 l2cap_get_ident(struct l2cap_conn *conn)
 static void l2cap_send_acl(struct l2cap_conn *conn, struct sk_buff *skb,
 			   u8 flags)
 {
-	/* Check if the hcon still valid before attempting to send */
+	/* Check if the hcon still valid before attempting to send.
+	 * Lockless: conn->handle/hdev accessed, but shouldn't change here.
+	 */
+	rcu_read_lock();
+
 	if (hci_conn_valid(conn->hcon->hdev, conn->hcon))
 		hci_send_acl(conn->hchan, skb, flags);
 	else
 		kfree_skb(skb);
+
+	rcu_read_unlock();
 }
 
 static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
-- 
2.51.0

