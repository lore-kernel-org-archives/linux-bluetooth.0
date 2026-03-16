Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4967B338592
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688206; cv=none; b=jRRZ8HAuIrq4njNPpBDaCcjlRVbA8svY7itbfIyCuB0y/DnffbkGGptr+N3gPdZawokBRTVb0tQooEq6+zcZ1LMRWxnQrrIogZZsd16QxahCINkbhgaCNJwzwZQRR3crD0wh+rC4HM6gMcz1Jiv6MM3kP4FU07OrQsdrcqO6mlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688206; c=relaxed/simple;
	bh=H6R2KcIBrKZDtIk/HvTkaxbKjwmbitOJJFos/h1l8Hw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Jd1eq/bnh1SQzU10J/1b08OCJBN6v/fW05+yij3ErnXqt5B5a/elXTC29FWMiYvOaxz5FgtgizdS3HzWdww6ylpPheetUET3zvm9ocVFlqeXbBsM2wZ339MCo4Qvoni0ZMrNftkhxQhY4AatRsNjscRiMIXMqA3/W52/mGD84DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZD7pXvx; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZD7pXvx"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56a8e0ea02aso5193562e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 12:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773688204; x=1774293004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0aSyMufGnxTZ3C8Nbto+Amsdl5WZ98N16h7WGbiO45k=;
        b=JZD7pXvx/dVTX6km9zjgtNFzD6kyi3JrXeSaUy3tSwH3gNEyjznIQKChxYf4XXAh9w
         cwyKSqDHhG9g87cxCTWad3h4RLeVBL/XrOPQiHQo1YB8pvPGDBRFQdsY1TN81+AVn2Su
         7kiU+FqBETAPdnt3lKVSctpECPG9e/QoVb/18KJyohzy5rxLZVwV/I76PMlndHvJbUNV
         3u+cqVHB3MjmGJTKq4C69rAn8oFUEOgRajhK3NQ0znkR2iAZcXVuS2KbyGstO1VPM/rp
         YriYSh3fO35dQPQRti2ph3m3WG0QWMlC4AL8rYnjZqdvuQDXd2PRyQyZDA8/z3fBsE+J
         YTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773688204; x=1774293004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0aSyMufGnxTZ3C8Nbto+Amsdl5WZ98N16h7WGbiO45k=;
        b=Rs0b5dkO8KjhfwLn3+u/JUqm8IWbWV+rGzVRlQ9JRNl5cY6ZlG3cxMLf44vGPopY/D
         sRic5Hv3N+zv5dFL2XOJFwVDOdcYDlZiTZDWbAl4LNFO81h21Q4gYOP7qvJepBdWuwMb
         XHvJ5Y4xiR83xRdhKCByildJQ0QRu1+75meQBrXkzlilWlMSMCCwkNHgwDyYMaQWUpfK
         I7XzHsu4I5opWjNF7Altt0iqjr2YXP4rVeoZkf1ASDTQ1KOWaWAuu67f8ExgN2oUy7Rh
         OW8V6/nu4XCc9zMYCAVI3mI7Q1Q0o3x2sdeQtBEGFZZrgf2dB9PjSsX1BsswuwRXaGw8
         pEoA==
X-Gm-Message-State: AOJu0YzZ6YAcu5PXMuOkP2uD6PhL9eaHz4rh5t6B3ZlJneqOE64ShfCz
	R5CCJEl1sUUoN+1GK1S3cb+Nlc+UQwIJ8uqG41SB+mXirBpGN049dr4DbNywd591
X-Gm-Gg: ATEYQzyKtZf8HEq3MZau8S/ylwsCsNJ2QxGMF5zOPfeLfVGZiY6gcJaEXuZXDGzZldn
	DzD2t9BQ1QvYhtBjIi1Vc/DiNY0/edpXotVIY9ZkiqFvxOj3cFmDoOudMXL03egeJ/6/IUZRVhg
	X77YikF9Bsz8pJzIxzFxYtpjZg5+LYx6/vIGKxjUwlWq62WACjLF+Ls+S+pjGiDY7gt9Sy0Gq2Q
	LFjgRhTlyouBXP250lH8XeSMzHtGrWif1sEMwKR25JszEtH07BbtPwnaRLc7iWjiCzJ0Q6empjA
	/2RPC4dHhONnAM68F2suuxNYxmRgrEZvkqkX391LeFPviKsJGWlxCj1Nov5+48JUFvd8WKChfkI
	z6GS5wF2gJmO8jITVxyMu+NUcL365sn9TxcKWs1Xv/hzktECxB7XmFiYH224Vc1HgIQY4W5lMWB
	MSAYQ2M9KKHUaIiMkPJiYZ9pc3gJGlBnJggTKTSvWhkvIe8CE0P6ngagyNUPxyR98911OeJqsD2
	tVst39Z6ork1U2RcA==
X-Received: by 2002:a05:6122:29ca:b0:563:702b:e2ab with SMTP id 71dfb90a1353d-56b629f960fmr4960152e0c.12.1773688204081;
        Mon, 16 Mar 2026 12:10:04 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b6bb4191fsm4695082e0c.1.2026.03.16.12.10.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 12:10:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/2] Bluetooth: L2CAP: Fix printing wrong information if SDU length exceeds MTU
Date: Mon, 16 Mar 2026 15:09:56 -0400
Message-ID: <20260316190957.8433-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The code was printing skb->len and sdu_len in the places where it should
be sdu_len and chan->imtu respectively to match the if conditions.

Fixes: fa768fce4aae ("Bluetooth: LE L2CAP: Disconnect if received packet's SDU exceeds IMTU")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4c63c949d839..6394cbcc838b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6705,7 +6705,7 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 
 		if (sdu_len > chan->imtu) {
 			BT_ERR("Too big LE L2CAP SDU length: len %u > %u",
-			       skb->len, sdu_len);
+			       sdu_len, chan->imtu);
 			l2cap_send_disconn_req(chan, ECONNRESET);
 			err = -EMSGSIZE;
 			goto failed;
-- 
2.53.0

