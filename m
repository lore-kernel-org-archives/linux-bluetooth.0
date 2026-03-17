Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5839257845
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763394; cv=none; b=RRHhEJPsYaTuWvQgF/Cag7ZCKN6jHTMpOPayMo7d6c9uhVINbm+8UoW5L/Sv6wDEgFOX/WM+oL38bZpXQSvPp5jCK4HbuvDHutZxBp/8jezqZe76Aez97OdUxsiF/R84KplIhLvnCgezJcmbc3xfU8OCSR+EN9hK5IE4R3JN/cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763394; c=relaxed/simple;
	bh=636BVBD65Wk7bdRq3IGbTFBo3YallIRbUA0XU1zx72I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LqKPx685Mvb+q2e6sKhX9kxragKDJp5ZjjEovMOS1P+AwrJw48D+Zi6s2klUok42ak7AQ6ediLRHQyvjHu/sfDE/KyfREpix9qfR5XhsEaLj4g4r7egfVenQuxQk/pQhr323lGhwDfBYsQzAlfzSZGH00KvRtCSu4R8bNVE52N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TARIAQUt; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TARIAQUt"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-950c41532e1so1525663241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 09:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773763391; x=1774368191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ECNZdgFcHfUPs8KXR4l4BsSg9wXzJ9lfvs6fx1DGbvQ=;
        b=TARIAQUtP5kXJ9hoI0eAz+TUN9bELQNY3SejeQ2pHESaZCRAf2NdtNJP2swNuZvdft
         Oy2M9mqfT+esT05X1cGQhFLoq0wQkrIcSNJGADfmJradm2PTQrH/kc3a2V5a2MQUzSJD
         nuiWx/1sz4bRU/pv6Rpr/rRjgOJv2Y93uKJGIsTIUjgi2oR9Bk6CVB/VUEw0RYRJy3kk
         oByURxoNdo3nPhfFyQpSRTIdLHFAiSW9zQKBKKuErFVEb8FF/p06OF2fw72v2cVKHq8W
         Fm7UEb0D6f5QW2Sz2U0LxQBrnjGvsy4TTCMbhhGwA9xWdS44xDjfj8I4v4J+G3bMHlD1
         hSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773763391; x=1774368191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECNZdgFcHfUPs8KXR4l4BsSg9wXzJ9lfvs6fx1DGbvQ=;
        b=aqOqEkgcHwpI5awmGjh9z6p0irR+7Rp54jDPcdsLpaXhHDzYutQkQFbsJvD+XAJT9T
         DbFXW7ppW7UvadgZXqsuU8ydBPISlJWx5GmWn02BqwaIEDvE3vN9aYBeC7kKYz8pTWxh
         DxaOsWn/hNGoMGbj0YsCe2yQa7T/A4CaPh6SDz1tu3fZCOTt1CZeDoCc0Mqa/r1NZY2I
         ZvCVZ4V/zdA76C6FczGm4/B2aXvICweysQJ8I61trUq9bfSjAOhHaOy1QBRYWmt8mDn8
         TFjIoqR1gCbrmKv3AC3EMtBJAyGznOw1Y98b2j8GJBKxsOvgb2CGqR/3XnpuHUp8J1tq
         +Fsg==
X-Gm-Message-State: AOJu0YyhfPdkWGx1pcvSSl/Y5OhHQMf3DnH6Tbic2bZmeljo6Ac+JxR8
	UTwo9ScRX4PRNdjF/tFNnYXyl89gzbTLncQo+/xYKhSvfTpQUCpVDhfdB64XOA==
X-Gm-Gg: ATEYQzx0CqeCBvJmt07XXNt+ot7b1WRgY3F+jWsMOuPK9zhkijf7iodlqm8KRKBqQFm
	0lD5SY2yo+m0NXQjFutmHtX+r4xmwMdhz9CJDdRUVXIHDHNAuDdrGLPa12xNPUjPQ09zN1D0Bsu
	2MpfZt+dDnO7BaWgvOhsZ11aHvAjda2U4WT/+zrJhqiLHZ/D7TMEvquntOFNKEzA+ZDQsNHEmbv
	g3CkmSTsdXfcJ4trAwvs/z4lUOOrXYlXdSeFJd2J9YLzd6rVfRJ7BRgNHfHFANEBGHDBD5w4Zu3
	uQez9m9rEL1dLzVGLcUuxEKUlQKny8IWc7SdYvgLMsILGXUk4k3J7eNbcM3+IY+4E9ZMtsdhgXj
	DvAIvcYXYwb7eXOWNO1IIXGaf5a6yRuyNyP44uY9/fCi4UfTXXkcmdYKr/3O+vSEbmpODyug84f
	Of1XmM7tSNEUhLsXIJTFuA3sNX2NrJwjLrE5YvWfy+qyszgnTmXwVykm9uxbk3edWBnCtURm7uu
	eJWlfqr/k+2tYKldw==
X-Received: by 2002:a05:6102:a52:b0:5ff:c6b2:efde with SMTP id ada2fe7eead31-6027d0b1bdcmr155702137.6.1773763389912;
        Tue, 17 Mar 2026 09:03:09 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-601de6ca1c2sm8391208137.2.2026.03.17.09.03.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 09:03:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: L2CAP: Fix regressions caused by reusing ident
Date: Tue, 17 Mar 2026 12:02:58 -0400
Message-ID: <20260317160258.194853-1-luiz.dentz@gmail.com>
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
 net/bluetooth/l2cap_core.c    | 39 +++++++++++++++++++++++++++--------
 2 files changed, 31 insertions(+), 9 deletions(-)

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
index ead51dc0f3f1..4dbd7b1bd72f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -926,16 +926,37 @@ int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator)
 
 static int l2cap_get_ident(struct l2cap_conn *conn)
 {
-	/* LE link does not support tools like l2ping so use the full range */
-	if (conn->hcon->type == LE_LINK)
-		return ida_alloc_range(&conn->tx_ida, 1, 255, GFP_ATOMIC);
+	int ident;
 
-	/* Get next available identificator.
-	 *    1 - 128 are used by kernel.
-	 *  129 - 199 are reserved.
-	 *  200 - 254 are used by utilities like l2ping, etc.
-	 */
-	return ida_alloc_range(&conn->tx_ida, 1, 128, GFP_ATOMIC);
+	/* LE link does not support tools like l2ping so use the full range */
+	if (conn->hcon->type == LE_LINK) {
+		/* Allocate ident using min as last used + 1 (cyclic) */
+		ident = ida_alloc_range(&conn->tx_ida, ++conn->tx_ident,
+					255, GFP_ATOMIC);
+		/* Force min 1 to start over */
+		if (ident < 0)
+			ident = ida_alloc_range(&conn->tx_ida, 1, 255,
+						GFP_ATOMIC);
+	} else {
+		/* Get next available identificator.
+		 *    1 - 128 are used by kernel.
+		 *  129 - 199 are reserved.
+		 *  200 - 254 are used by utilities like l2ping, etc.
+		 */
+
+		/* Allocate ident using min as last used + 1 (cyclic) */
+		ident = ida_alloc_range(&conn->tx_ida, ++conn->tx_ident,
+					128, GFP_ATOMIC);
+		/* Force min 1 to start over */
+		if (ident < 0)
+			ident = ida_alloc_range(&conn->tx_ida, 1, 128,
+						GFP_ATOMIC);
+	}
+
+	if (ident > 0)
+		conn->tx_ident = ident;
+
+	return ident;
 }
 
 static void l2cap_send_acl(struct l2cap_conn *conn, struct sk_buff *skb,
-- 
2.53.0

