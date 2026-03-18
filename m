Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA636352F9B
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773856886; cv=none; b=GFxQ9GH5DzsHFqu/gYnHke141ax6pZsVOYeAuiTG2FeRbFj0ZMfHLahKKdlTFPOhCOF/Aiw6oR+hMpdekRz9OeMFQDTiwISkNj8WTTYVltOkX620xmGlwO33DBj9QKjDhLvonBt7JqLrdgd0LYhGnTSxBgXgGh8Qp0dppBcEhBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773856886; c=relaxed/simple;
	bh=hkJ8E3cp4SBNINPkoP8sohfLkIrPZ9GEPh/h5TuqQKk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=idDVhk+hQSBeY7640UsD1rAaHjATWPAnAas9ZC2MBMMde7UO0HpW36hwt/ln+JMvp24PbApxFyEII4ly2C5hR+1PkUTvlXC9XXEyPxItaeeSFYZMFLLJsADhOA2DPWd5Weajz87CWuPQ0n9I++Dp/y2nGc98GEboXJCPzLkIUio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbiJm2/0; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbiJm2/0"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56a86f0a23bso36330e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 11:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773856883; x=1774461683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bxq8QgCUzxDc2TZDeQPk6H+WTSLdAdWbzwCHQ/VJV3w=;
        b=XbiJm2/0eYjmrcFFbd9rQZN/0zzChBW9lW/dCOvTJGZYdMbmBF24xBYD6uifaE4P7D
         aeN9ifSTgqSeR9sJRPbdj7ma4EWIb16Y5nkj5pCB7iq8kVN4MH7mZx80ZMi+Ms/9Skq0
         KkJoVQ7Oa7W6bLV58NQF9YEG1CawtuRPBk7f2oZPHBC5CCWWA0OG/4VqNUUN2Lw3L+t/
         cR3+wsfAaly+0jhWMM1rS6lV7uPDnvVX9JbJbH2fR/6nXfloAG3jHwrgBRuIIzLNDQnF
         36PFt0rjpRKINfMWetun2LwP1oNXQI7ETrU2VTGn+rNqtAop4atb17CUX5ViOUcHKw4j
         zizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773856883; x=1774461683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxq8QgCUzxDc2TZDeQPk6H+WTSLdAdWbzwCHQ/VJV3w=;
        b=qOyax3tVM2lM5g4F59lgUMOQgCGm37X9JD3MtpqbjqsqgsaARR8ClW65UV2C/lTx3D
         A46PfD5OzZi4yByC6XjI6byig/U1Ua8QWIEOMT1xtFS53soRl2C+rFOaeiFsZWRQGL4d
         VVjIsjKLZNp50PwLt9ZmK5twu9qXBxOBQpZ2/O+mSaSKz2mVwjCdnFJjCzGXk8F9e9N2
         cf6n8PG4pbOQGrGU8n3mUtPxpUiopy5ot2zsJB4ACuZIPLkFhx8d9hnX5pB997Te6I3a
         /br7qSVo3/rLmjw6gtFCwdaJjTQVjvzZQUcv0YivvOdcMjRbe1+/Mwn8ENm8irAPAMLi
         cUDw==
X-Gm-Message-State: AOJu0YyQmtA0JRDoGRtd2u+6/tAyFx2WhNO80CbYimGAxN1pdQNzPiPR
	XBUHL3krCmhkO4IOH75H6///fbe7YNPltLN8MCj1lz5Vf5Xc71z72vm3n45WHa56
X-Gm-Gg: ATEYQzz+KbZiQkR/LXAwwsWR7QiJZoSDDUeS4WwNjCVXDtTuPuyRUg1DeOljiqKkgy5
	TA/eQpGLWjekqhlatJIsqOK6fFln5oNHWnbk/jiYPF3Ptp6ofIq+NiPIOjXv017BO2EIgDzD3ZO
	T6PYTkND8Bv1smVIj8yTkv5s/A68bSs8jPbZ2XCwjnOhWpqc/dPT+dKBRh6KzGruithy1wTxPBB
	NeRbCFRQmI0o7ZZMe8XEE/uQRYTo7hJNMQISRHrZ14+au9UG99OZ8o9NwF0mtYPb+lsY2iqFNYq
	iHa0lfWd6t4HhtLJC76zIww0PxFuUEuEKY2u0bCC9qoaYmIsqcCuvPK5VYnHN13CA4o8tWtJpu6
	Dd4FzhLk8R09nsU6XyRGI/jNbQzlKxsUJGHvE7GQifCYRm5QIawJHiDzNc8/m8oNvt4pXmNB3zZ
	BpI0kfHGF2zAX4Cy54QtZm7loIh60WwJQB3WoijnhHwqUX6cSYd2z8KpS+iZhTiifrL+krIrryu
	3qXhXwfdn5lnIJ8Gw==
X-Received: by 2002:a05:6122:4d05:b0:567:44ba:bd8a with SMTP id 71dfb90a1353d-56ba7143f15mr2578544e0c.9.1773856883028;
        Wed, 18 Mar 2026 11:01:23 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-951034737d0sm1636563241.13.2026.03.18.11.01.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 11:01:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: L2CAP: Fix regressions caused by reusing ident
Date: Wed, 18 Mar 2026 14:01:16 -0400
Message-ID: <20260318180116.288242-1-luiz.dentz@gmail.com>
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
 net/bluetooth/l2cap_core.c    | 41 +++++++++++++++++++++++++++--------
 2 files changed, 33 insertions(+), 9 deletions(-)

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
index ead51dc0f3f1..c7f1f817a8ea 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -926,16 +926,39 @@ int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator)
 
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
+		ident = ida_alloc_range(&conn->tx_ida, conn->tx_ident + 1,
+					255, GFP_ATOMIC);
+		/* Force min 1 to start over */
+		if (ident <= 0)
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
+		ident = ida_alloc_range(&conn->tx_ida, conn->tx_ident + 1,
+					128, GFP_ATOMIC);
+		/* Force min 1 to start over */
+		if (ident <= 0)
+			ident = ida_alloc_range(&conn->tx_ida, 1, 128,
+						GFP_ATOMIC);
+	}
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

