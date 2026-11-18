Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012055;
	b=UKFmEyY7H469FyUcFiKUSJ/39kcQBteNEaWdO7fxKIL9DhoyN3XFyiul+EblPfQAq0f9
	 0AyxzbGNnDrqNbnT8ff/WCihmrUJjRA8jlnDgRJvT6wB29zC9XW+TagtVKqOc3GHox1kJ
	 at4ekHycfrkESMJMhFW+A6HrcvTkQsKwcjKAZo/ZrpD4WFdWIOS6whOMT/ID1M1PQwgEg
	 QniVf1kGDIUv2YME+HbOx/E9YQwAB9mTf+u2GVRroxUx+bKRPwix2iXyhv9w79VRqq5gL
	 2m2gvYsB22uQ2UBsMCEz+4gVFJKEAJRd+uXfPznnLPj3B3UPUDgYwdd/Gh0vuNawUwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qKw5OUKAtP3pAm6iyjRuAjdpu6coiCZ3X5PuWwGgIWA=;
	b=S8x3FrjPBcjYOk2hvWZd7Rbsgb3WAa6apyQWxrDGLdYmI+WI5c1SF14eWmXO7TYYtTEe
	 tD/PMnl3kML8A+pbOGaIOX9RXahm1ioMUF11322uWX8gWyMRx3u/kwCAFEDN4xX7HpjWv
	 JPpuZtzjODkVYVyCC65LUkVE97KMPZCrvD1aG69vsnYuLKNtuz8MKizR/iXR2NonYG7Tr
	 yb+EWyjm59i/RQ33Y9H95jpT1up1sUhAGCGwxJccJcNiwky60OT44c4++JTUTf1p0Pxxb
	 60LoVnUXdH+Uett1WsGdybw2yUeXBn9mkUwhg8+LnMKBr9XggO/KKqIE4vzePuL+BUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rcDjcNNH;
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AF960A2607
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2AF960A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rcDjcNNH
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9906a5410f5so1622442241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795012053; x=1795616853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qKw5OUKAtP3pAm6iyjRuAjdpu6coiCZ3X5PuWwGgIWA=;
        b=rcDjcNNHAtcM7TrqMnWvUKzFJulqwyEMzhBcEpD3E6OX8nqfuXyyoOvTFTz04kxLEK
         a2BzAXouP2f5kW/w+9L0zCOyWcG7t87HqCNMPXYHVAHXG1f58Esr0cTU20+OoQo6gaoF
         fHWwuijLTeh7oGCWPFblVHz7xTbG6O6DE3RFm8xuADJ/FttKsuFpfk40ym+kI7HIc4Zk
         FEIQUzh5vBolQqpUgp7brFN39J6fa8bIuR46KjKd/T+6748sB02R9E28BjZ7Um0/gFuh
         +E6fRRZb6XNMt4yf+JpneMzGhVrt9WUPTjnWr+bm8y5/wfMv1WdjLJSj0CePZg5iJW/r
         tfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795012053; x=1795616853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qKw5OUKAtP3pAm6iyjRuAjdpu6coiCZ3X5PuWwGgIWA=;
        b=cnQ1slh1BPCunVIlpLVOmI+sJIbvc46VVp4cxUjBZu8eJV+4mo0xsAfqui7S75ptOt
         7dYbAmPTubN/EMpU9LqKB1hKayRNal29Lk5kanMKrPQ/gFiCLr7rSsIGCFonwFDMC7HX
         pL5PC1dR2961iw1wNAMlwh2e17WLZHACu5cFiunU4JfI2jDDNnIwzOfZEXw1DJ3vSQ1+
         wu4IjiOdWd1viZ1WDAWbrn45gOFFA2/QgtFndbS0MbdInWkwD+1d+o8ggBJBT5tMBh3N
         pbRWg4Zis072TQm453AvsM5MPKGqmirC2Zhfw6EYoDwhzVbZf2LB/DFOP2FGKf1rYizx
         rlgQ==
X-Gm-Message-State: APuU4Z+6IU4/9U2mklC4/39ddwAP1XT73/YT9XbmLswkIw86FvfbCW/9
	v8rjjAundg0Ea7ZX2ghTxjDpOqLtQWXyVBdlskHWup3VlVWamEXrIHJYYF3OmVx3
X-Gm-Gg: AYBFou0UC8g3jM/FiXp+RHOUYwNdYxG5du0tDMqCiYF9OF8JV3sSPGmP1YLSb9wStvs
	8KJbY3KsFQED2rfYzBWJQmtlFvaKv3nsNGYdio6uXRA1TQ4n1N1QfcBH+t4/1H+rDAx+zd8F9S2
	vcndfS3m3G07ND9W+HGpxJDntSLz/cTRc9PShsonVF5UNlNGKn66G9fYMWTakXc+LJSaHGRfqxx
	7O0imO6NRDqDqRZAyjUYrmyVVJWFkar4/v5VUKbeVhhlt8sgksXJHmZBxjMWPoi98Q3s/PIf+1v
	BC2uSaxz/P2Fg7UZjpZ7KJ9go4rVytCHW2Qr2qWsEGoZf58hd0T20J8GglENhwGZ87lFaDcZ401
	CRO8wM7Bhy5FvSXXDKt1frflIbqDKH+OhenRg95SNPMduo4RPAYrtzqUG0zCKRge0/PijTVO9mi
	HTRhZbSe5ZjuFiBaq/BZ3+7iL/9NpI/njim9Qq/Uyfy+8HkVZgBzyF533G3QaD72TxkdTqnSLjz
	sB6J5c6awYatwhMD2CGP8k2E2gOimO+3VknFTjPkAuRuIISmlIzkti9Uuz2LQLl2kMZMnrumAVq
	4d6FzbwnSp84hjVwMe1a8Fgz5ZWqmXajIhb5zLD9ubM1CQN4SOP/7STZ7keWaju/Z/8sPGMqoOp
	uxdstaqu8GG5lLZeZUkl7TkozHejwpyqAv+quqIXSbE0ys+9/LeMZ+xdY2LRb6Mc1UYgyvmRw3L
	VpDa8=
X-Received: by 2002:a05:6102:512b:b0:7b4:db17:bca4 with SMTP id ada2fe7eead31-7d6ba43eba4mr649827137.9.1795012053511;
        Wed, 18 Nov 2026 06:27:33 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b9185bc3sm1745946137.5.2026.11.18.06.27.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:27:33 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: L2CAP: Use a reserved ident for L2CAP_LE_CREDITS
Date: Wed, 18 Nov 2026 09:27:32 -0500
Message-ID: <20261118142732.102749-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

L2CAP_LE_CREDITS has no response, so an ident taken from conn->tx_ida for
it is never released by l2cap_put_ident() and l2cap_chan_le_send_credits()
has to free it right away after sending, otherwise the range is exhausted
after 254 packets and credits would be sent with the invalid ident 0, which
some remote stacks ignore, stalling the channel.

tx_ida only exists to track requests awaiting a response, so a command
without one has no business in it: every credit update allocates and
frees an ident, and the ident is visible in tx_ida while the credits are
in flight, so an answer to them (a L2CAP_COMMAND_REJ) is processed by
l2cap_put_ident() like the answer to a request.

Using a counter that doesn't consult tx_ida is not an option either, it can
return the ident of a request still outstanding, and a reject of the
credits would then release that request's ident and close its channel in
l2cap_le_command_rej().

Reserve ident 255 for L2CAP_LE_CREDITS instead: l2cap_get_ident() never
returns it (the BR/EDR range already ends at 128), so it can't collide with
any request, it doesn't have to be tracked in conn->tx_ida, and a reject of
it matches no outstanding request.

Fixes: 6e1930ece855 ("Bluetooth: L2CAP: fix tx ident leak for commands without a response")
Reported-by: syzbot+9dc8780713b11155dd74@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9dc8780713b11155dd74
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h |  5 +++++
 net/bluetooth/l2cap_core.c    | 28 +++++++++++-----------------
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index cf5c2df68af8..72d9d56c6f2a 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -45,6 +45,11 @@
 #define L2CAP_DEFAULT_ACC_LAT		0xFFFFFFFF
 #define L2CAP_BREDR_MAX_PAYLOAD		1019    /* 3-DH5 packet */
 #define L2CAP_LE_MIN_MTU		23
+
+/* Identifier used by L2CAP_LE_CREDITS, it has no response so it is not
+ * tracked in conn->tx_ida and is never allocated for any other command.
+ */
+#define L2CAP_IDENT_LE_CREDITS		255
 #define L2CAP_ECRED_CONN_SCID_MAX	5
 
 #define L2CAP_DISC_TIMEOUT		msecs_to_jiffies(100)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 977b41229a7f..3ff40565a05f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1046,9 +1046,11 @@ static int l2cap_get_ident(struct l2cap_conn *conn)
 	u8 max;
 	int ident;
 
-	/* LE link does not support tools like l2ping so use the full range */
+	/* LE link does not support tools like l2ping so use the full range,
+	 * except for L2CAP_IDENT_LE_CREDITS which is reserved.
+	 */
 	if (conn->hcon->type == LE_LINK)
-		max = 255;
+		max = L2CAP_IDENT_LE_CREDITS - 1;
 	/* Get next available identificator.
 	 *    1 - 128 are used by kernel.
 	 *  129 - 199 are reserved.
@@ -7204,7 +7206,6 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 	struct l2cap_conn *conn = chan->conn;
 	struct l2cap_le_credits pkt;
 	u16 return_credits = l2cap_le_rx_credits(chan);
-	int ident;
 
 	if (chan->mode != L2CAP_MODE_LE_FLOWCTL &&
 	    chan->mode != L2CAP_MODE_EXT_FLOWCTL)
@@ -7222,21 +7223,14 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 	pkt.cid     = cpu_to_le16(chan->scid);
 	pkt.credits = cpu_to_le16(return_credits);
 
-	/* Keeps l2cap_put_ident() from releasing ident before we do */
-	lockdep_assert_held(&conn->lock);
-
-	ident = l2cap_get_ident(conn);
-
-	l2cap_send_cmd(conn, ident, L2CAP_LE_CREDITS, sizeof(pkt), &pkt);
-
-	/* L2CAP_LE_CREDITS has no response so the ident is never released by
-	 * l2cap_put_ident() - release it right away, otherwise the tx_ida
-	 * range is exhausted after 254 packets and from then on credits are
-	 * sent with the invalid ident 0, which some remote stacks ignore,
-	 * stalling the channel.
+	/* L2CAP_LE_CREDITS has no response so it uses the reserved ident rather
+	 * than one from conn->tx_ida, which would have to be released right
+	 * away or would be exhausted after 254 packets, and could otherwise
+	 * collide with the ident of a request still outstanding. A reject of it
+	 * can't match any request either.
 	 */
-	if (ident > 0)
-		ida_free(&conn->tx_ida, ident);
+	l2cap_send_cmd(conn, L2CAP_IDENT_LE_CREDITS, L2CAP_LE_CREDITS,
+		       sizeof(pkt), &pkt);
 }
 
 void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail)

base-commit: f42f5cae154b90a0cb6d8232dc84c7614ca2e6a0
-- 
2.56.0

