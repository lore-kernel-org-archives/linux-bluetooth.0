Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDCB2F744F
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773857374; cv=none; b=BeSjNzhiH1gsu5ZSuNHMQuDqC/v1RWOv19BfBvA60dSd9WQnwh5TeuFLxisPeJHEYMzwHFOGaqkhkHtqVLtb1vMHjEYifL14lXmbHHF56xDvUOh54syAZWbjmgJ/PyGjNewe5Uy/fUAvMiLoDvpfx+1X0rK99/vDEdedvD/dGHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773857374; c=relaxed/simple;
	bh=TJCzmAS5rQ03YD6bHrVLgQgShJ41FsfuiETBU+VkHyI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Aq1+Cue/1PBUSK4xyc0RmrqT8O4ud88NrZYJt3o+grv9JxmYcXgbpGXjUUTtAAXAGlasyfEpdSM5OKm6e63OIPJ/6Rm4HC41gfZvp5y7q5bvUX/rM6Tv8SqQTo9O3pj20TUW7s+rQjhLakUQLxZTGof0Ln5SmW/HlJitEn+g174=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEBecmgc; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEBecmgc"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56cc8a021e2so82622e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773857372; x=1774462172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wIPYt7mdGt8Qnb09HDa1O2ltrO76tPPdh0yGZf5Dt2k=;
        b=dEBecmgcqYb7fpfiMzC5+1sx7xbXQBwDnF3DywU0bpFHtpTGYa0hNR8cvv8G/86aJU
         IU7TpfcRO69/cDBjWE/+05jE5hv+LgrX3FvnLWcfdy9939xIGG/rlz9JbQv7F5wCIgVf
         nFFQxtyes+5auNehGHtnoYeJDpiHZPgS7zWT/1PoACFQsx/UfWm0tDMT6TIfCCBfvc+I
         FWhYC1P/RoJFGWNvq3RS+Uojj9GMWvnYdKMMpc+dk3rsrCXaLXVwte7Ihl4BZ8pSN+rs
         zclo05Tf8RakCNa/6erx6+56nMHpFCwWpm31fbGKz0NOpD6boyYwZHlwwXcyoDqA2qau
         7lyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773857372; x=1774462172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wIPYt7mdGt8Qnb09HDa1O2ltrO76tPPdh0yGZf5Dt2k=;
        b=YC7X1zGZzywCany2xQ5UYiBzd91BVD4Tt6CDuEZ8U8BiG1ReGct/ewuf9UV/X5mSwF
         m7nxiSRDFpjbyGpnJuUkK8nYI8p7RBJFtuEsgamchT+HRigjbO9tUNLCNygLKElyIrpX
         Mdrz94Pg2RQAVHmltQsBze189LcZo6cHducJz0LxkPfr7UQ2n0BXBbFNIYLXARNuzjTT
         glzCNneTgUicOwlpDPgW6b1a/p6k1JDU4HgBtcCpfLLzF4RC7nMDbBRltgvB0+TepODL
         94XTqIwSiT+1D9RRA48R8CIB2eGRGqjmD5NR2uZf7AVKs0TiYTmRwgCrhMFWEXb7lm3G
         X0LA==
X-Gm-Message-State: AOJu0Yybr8J958IMB0cQmkC4nHggqCBCHrdxd9nFNCYMehcZjfhZim8+
	e+RLa5JaiIGH3RuiqzM/7JYIG7r6e5K8yhjZ8JCZlusNfAhUnq4FxHZAmhziICiR
X-Gm-Gg: ATEYQzzo1rN7/n30U1ER4eXqZ1sIJDT0x0xoFF7T1VvOmjfJvocvTpiALtFkjaLrRn8
	WuOpJQbQGAx06RlojVEWjuPAsgHt2OhC3KcHsqvlaxx8SvgReqerIdSdhWHvNV06kbspqU3RkmT
	mp5P79y1c+46nQLILCsbDAi5cm5XrUDd0DEqZdBpIhwR526HbZ0CsSghhyZceT507QtD+kGQF5U
	6p79l7rV85rWboqrL+O+XEhjtGlkNDIf1OZRjXtM2a/W7vvzKkSxhOirTBoervTgEnckck4SmH7
	48IraLHkK/IgkRx1lwwm/Qpb/A/bLIrIhv+zS7ikF+oKFgX3Fw8O1D5/LkmkB7CHZAfu9MNnVsN
	FYmbdLTgisH60tb4daN2F3FsdYsTvOee19odKqRFWaja49tlXXoG8BTlqAbni9MN1CSC2cPvBNT
	ThjPWP+rm5Y361k+h5KuwR0hvIjyNkM9tmUwG/0hhA+4vdBFNnKnE59KRl2gr3qbug0JjwFdT3M
	XL//nxwMcvx05merYQXS1IZgwTc
X-Received: by 2002:ac5:c76d:0:b0:56a:e3c7:7ed7 with SMTP id 71dfb90a1353d-56ccff113e5mr233448e0c.6.1773857372222;
        Wed, 18 Mar 2026 11:09:32 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56ba6e30ec6sm2218111e0c.1.2026.03.18.11.09.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 11:09:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: L2CAP: Fix regressions caused by reusing ident
Date: Wed, 18 Mar 2026 14:09:22 -0400
Message-ID: <20260318180922.307838-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempt to fix regressions caused by reusing ident which apparently
is not handled well on certain stacks causing the stack to not respond to
requests, so instead of simple returning the first unallocated id this
stores the last used tx_ident and then attempt to use the next until all
available ids are exausted and then cycle starting over to 1.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221120
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221177
Fixes: 6c3ea155e5ee ("Bluetooth: L2CAP: Fix not tracking outstanding TX ident")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 23 ++++++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 010f1a8fd15f..5172afee5494 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -658,6 +658,7 @@ struct l2cap_conn {
 	struct sk_buff		*rx_skb;
 	__u32			rx_len;
 	struct ida		tx_ida;
+	__u8			tx_ident;
 
 	struct sk_buff_head	pending_rx;
 	struct work_struct	pending_rx_work;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ead51dc0f3f1..a818a58362d5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -926,16 +926,33 @@ int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator)
 
 static int l2cap_get_ident(struct l2cap_conn *conn)
 {
+	u8 max;
+	int ident;
+
 	/* LE link does not support tools like l2ping so use the full range */
 	if (conn->hcon->type == LE_LINK)
-		return ida_alloc_range(&conn->tx_ida, 1, 255, GFP_ATOMIC);
-
+		max = 255;
 	/* Get next available identificator.
 	 *    1 - 128 are used by kernel.
 	 *  129 - 199 are reserved.
 	 *  200 - 254 are used by utilities like l2ping, etc.
 	 */
-	return ida_alloc_range(&conn->tx_ida, 1, 128, GFP_ATOMIC);
+	else
+		max = 128;
+
+	/* Allocate ident using min as last used + 1 (cyclic) */
+	ident = ida_alloc_range(&conn->tx_ida, conn->tx_ident + 1, max,
+				GFP_ATOMIC);
+	/* Force min 1 to start over */
+	if (ident <= 0)
+		ident = ida_alloc_range(&conn->tx_ida, 1, max, GFP_ATOMIC);
+
+	if (ident > 0)
+		conn->tx_ident = ident;
+	else
+		BT_ERR("Uanble to allocate ident: %d", ident);
+
+	return conn->tx_ident;
 }
 
 static void l2cap_send_acl(struct l2cap_conn *conn, struct sk_buff *skb,
-- 
2.53.0

