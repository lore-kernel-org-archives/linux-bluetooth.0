Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942333009E8
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933777; cv=none; b=gt1Isfk2jTRd7uLfyMGKbovfMYu5WJms7E+K2oWPEuy5eKCP346SzB3o2xwgfjYlfmWptEK4QPaPLHal/8kcC9QN72Lml/bnc58wY+aRCVg+SJRcIkyTx7N4EnU59IEUj96q6ef5yHi8+X+eK5ToLhNC3Sc2rYcwY1CIVTBUKao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933777; c=relaxed/simple;
	bh=w9dJHMk3Zx4V131RrxDqxML9cBTv4gELDwC7vd5+8l8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=n78DbFqiTVyLZc29yYs3i6CBuULoPAHs4bWjgcR1FWBbi2mIhMjIDyNgVt+S4XyPbt8Ht8Y+EOifZUyRgoin+SLscA7Sy3/uYeuDLuQlzRolCwsptVKbTUTF63/hik5dvnLLuNkCjFzGvumyqtxFiv1Ok4+F0yPoUDFILMFQ+l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2IbnWuP; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2IbnWuP"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-94dd7178d63so424107241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773933774; x=1774538574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0dd8M2mD90F2rxm2sWFKk5kZjBTgRUA3+2uVhFpXuKg=;
        b=X2IbnWuPV0l8R+0usCEnUkTEQaf20XKIFvZJHgsdeutbET130LjXyHk96jjrD8ZtLl
         Bumeshxvybozcv19xZ9Fqv0VMUAYMuXNoPFqx+m+qTaVXP8V9iw0m3CpzDT1a6AMX4Jz
         +hRYO2uZTOrxgyydHldnNtsxLNmtR68h8v4guJyZ0iEmROmJlvNiaO9kBUrbB1prVCm+
         r5c19pHNm9+oP8QWi9+HW5dSEbyQ+WD9zmEB+6xyRXyOueEcJOcip1WKG1xTKT/dLV8b
         34JDZvSmEMn0eSSNWGuUMhw5AOxBY9L84xhEGWhBDZSLUNAsA4cFJU0HXAxRLK49kY1E
         COyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773933774; x=1774538574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0dd8M2mD90F2rxm2sWFKk5kZjBTgRUA3+2uVhFpXuKg=;
        b=LbuhpTvo8qzDIsOzEKqLgP6WDDoCw224wpGp0/Ut0gJbfsuLHdiA7ABVcQTm5BTKIG
         mQv7NWR7lKFbC2u69UD/aMn63hMbggCwvfA04BkyAymlPxCwQSxYrJaeIiVq++g2w/sW
         SxvDoB2rF4qwdVJhDGnWbRI9xUP+zBQt6FuIfsE2GnTvgPLq0k5Kr0NBbMCUrJg+zJYa
         HgEDJPsr40u5e/3Yjef8S0MycPLH9/k/Q2vrkm0xXvzoBUszbt6+bFBDW/QNBVx59tqz
         hIX6Cnee3uYPRVutg9befl9BJ/eq7bXOev7oM/RjKVLzLnSEde4KhmPgY0Wb//spKsKC
         3oOQ==
X-Gm-Message-State: AOJu0YxOJEIUZj1JiaYWFd+rTgi+S3Ljrm/7QDDJ0CeqJTSPx14dtbMC
	+JQXae4utb9MZs0UDa/f55tXv13SQd+yfX0QYOR33sN0wxJ1Q3tXrfzZ8gETK82hGzU=
X-Gm-Gg: ATEYQzxKFDFFwIneE+AZ0RrtA/oimMAb1KqWtJ3lrghdl+IjGQRlaM93p/2ZZq28l3g
	FsRON/ttms4vje/i83CDPMXvT7SIw36J5PyvZ1Y+xgEQHObNMHDA6nbXpa+5ZsjYaEHyeJE0NiY
	2xkaH1h6ugLQq+0CYnPDpK7sjM4R+C27k6zSY6/flYgf47kDioYpsp0wYbsK3xWuzfN9U1NnY9U
	s753D3nB2Ih/O0FWTbfcdn68RZGglTl0gtsonYb0D2l6+W0lphscIBSJCFHhCXUJuDdXvPY7HPD
	sCt1YsKrQQDz0/zxu9TmRCZzBcfeyKZSYTIY0PsWsmH9832G8SeZVEEoXBAcm7FoBpT6sfB7gE0
	d2qcEn0qoptzKh59g33xWbwd5SmZhfX3GjgmHLa5oNbfrnuRwYzZS6iig6tyfG85P231eJYaczE
	ukswGuAwx00FxmUoCSkUi9B/Aa+8DCN8cjWodT9fRjjtxfvZODQOcUGungkBAXqbQ/DmrorAcDc
	tU/V3BnzEMp4YFQUyiDJuquVSEy
X-Received: by 2002:a05:6102:3908:b0:5fd:f2ad:c653 with SMTP id ada2fe7eead31-6027d13f529mr4210006137.16.1773933774220;
        Thu, 19 Mar 2026 08:22:54 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9510344384csm2844877241.11.2026.03.19.08.22.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:22:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: L2CAP: Fix regressions caused by reusing ident
Date: Thu, 19 Mar 2026 11:22:47 -0400
Message-ID: <20260319152247.13225-1-luiz.dentz@gmail.com>
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
Tested-by: Christian Eggers <ceggers@arri.de>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 29 ++++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

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
index ead51dc0f3f1..2a8851f36b1f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -926,16 +926,39 @@ int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator)
 
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
+	ident = ida_alloc_range(&conn->tx_ida, READ_ONCE(conn->tx_ident) + 1,
+				max, GFP_ATOMIC);
+	/* Force min 1 to start over */
+	if (ident <= 0) {
+		ident = ida_alloc_range(&conn->tx_ida, 1, max, GFP_ATOMIC);
+		if (ident <= 0) {
+			/* If all idents are in use, log an error, this is
+			 * extremely unlikely to happen and would indicate a bug
+			 * in the code that idents are not being freed properly.
+			 */
+			BT_ERR("Unable to allocate ident: %d", ident);
+			return 0;
+		}
+	}
+
+	WRITE_ONCE(conn->tx_ident, ident);
+
+	return ident;
 }
 
 static void l2cap_send_acl(struct l2cap_conn *conn, struct sk_buff *skb,
-- 
2.53.0

