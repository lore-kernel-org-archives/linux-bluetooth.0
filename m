Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F28F382F19
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 11:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776772438; cv=none; b=lOpTBtAwUxtDWf9ETieZ9LRncmn98SMtDYajWusFPZur7OeOPL1sIiQ8RRdSHwx1ZaFjzjgyMIsgPGvbUtqFtSnASm8ojSU4Lji4FlQmZbGLUwf+XQ1n0iV3y7WHAJr2IvNx7aK9D14nfObcm6EdnvyW656jzMJW11yGRdiXYUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776772438; c=relaxed/simple;
	bh=yxMnjb7Q/aVt42qFmyhSxlpTh87sBoktrFRyOjtdA34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QSvIl69ivYnt6hlP0EcN1NatHCOH4oiz0NCqFMNWphjJCB2ZwN9gmwo7t5prhRg1TY5Ez/6lOFgAf4Tnyhbwswi0uaKPlgQRSaiFCNaxzZXwRS63aZBOsu9ujAuuh+nMekOqA8yfW4pwNQFrrQe5OQLHE8yAMLPwdSG631y4Aj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48a525dd2b5so1949785e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 04:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776772435; x=1777377235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/OjdGnv+jUltTzO6oNyOl9eOSq15AA1fhn11BjFGWs=;
        b=jUy9iatOsPtb6SF4PjoQ86RgJgvWigS3m19Ln1zVOORQZFaytltt9TNDIcRnNtNz5J
         f8R0eEQ4WLmgBRUf430TM+1mwscxfMYO+s6/J0BErkRs728aEYu/fF6pp2mZNJSYbdQM
         Pr1RE9GqmcVxlL6t/BtKYxghaHQmI3vFV2INELP58ggRizGzScA3x+A58UyaGyjyIWlZ
         ylvNkz7l/Jw6GnI2emTkp0+j0Tt+7Dehv4Ur5Vj7tNUOKTd2du8WElLxW6Znd9tvSVB4
         nBNJDf4fwwnUsdhItn6DPUrywvaZRUFJUp+nyovDWetLit2JGh0Jxxf5uww+/9WrsuIj
         9ocQ==
X-Gm-Message-State: AOJu0YysrF2ktpU8Q0cvtRZxC6Tl9RfuV/h8tlhYN3LsREOczFMtQW3/
	w/Ik6SK3JoOXS1c6G+TVDCEadw99etxi2cUTsPOj9wn+neKo2CWjNM1Ue6TuX9Gw
X-Gm-Gg: AeBDiesJ/VozVNfT4laEw3fHN98ZAqSNRd54jCC6akhz15J2/IqEpuBJvN+U+2MPdK3
	Wm4/zfijcBfdh8KOwSkMT4WXp4isPnFOkPiSCDNKSgs4Z4XkqytxNbcSJlsDV9RCRFS5IHX1DMg
	L6JNUz+F5IR6ugUp3uTCRb15iEWqARHUg4yDqOun/LXIv6VoNRHBLsk+sVBq0OAAdPEGiX3cwxb
	zhVmtw4Hu5VbTkzfc89b9nO8Bo9AECSYsAd6LImO7qurk0jNxU3ROKSkLNh1pd6gle3SxmDhqzH
	yKrUNrQgbvScfBx20V4PO+b4kncuBKYxfD3RfqqNc/+Xy2igkczHW55mwuGYutuOsbans1nEDNu
	cH0nMa+hXEFYiRNYZa5jlshz3ldIlROXiC3y5x3VOwJX3ESiRdOm8ZwmlPW4IrqYjHsU/wtmZsM
	LwXZ/P4RqGtwk40YBCy7b167GoD9hRPGgIt9YFMFv0ufuaeut44Dg8XaZnY1Yy3WwP4awXZabpq
	C9846XsBBWg2g==
X-Received: by 2002:a05:600c:c492:b0:48a:5302:8ed9 with SMTP id 5b1f17b1804b1-48a53029075mr39053625e9.0.1776772434933;
        Tue, 21 Apr 2026 04:53:54 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm605148105e9.3.2026.04.21.04.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 04:53:54 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	syzbot+ff30eeab8e07b37d524e@syzkaller.appspotmail.com,
	Aurelien DESBRIERES <aurelien@hackers.camp>
Subject: [PATCH] Bluetooth: hci_uart: Fix NULL deref in recv callbacks when priv is uninitialized
Date: Tue, 21 Apr 2026 15:53:31 +0200
Message-ID: <20260421135331.15425-1-aurelien@hackers.camp>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a fault is injected during hci_uart line discipline setup, the
proto open() callback may fail leaving hu->priv as NULL. A subsequent
TIOCSTI ioctl can trigger the recv() callback before priv is
initialized, causing a NULL pointer dereference.

Fix all four affected HCI UART protocol drivers by adding a NULL check
on hu->priv at the start of their recv() callbacks: h4, h5, ath and
bcsp.

Reported-by: syzbot+ff30eeab8e07b37d524e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ff30eeab8e07b37d524e
Signed-off-by: Aurelien DESBRIERES <aurelien@hackers.camp>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/bluetooth/hci_ath.c  | 3 +++
 drivers/bluetooth/hci_bcsp.c | 3 +++
 drivers/bluetooth/hci_h4.c   | 3 +++
 drivers/bluetooth/hci_h5.c   | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index fa679ad0acdf..8201fa7f61e8 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -191,6 +191,9 @@ static int ath_recv(struct hci_uart *hu, const void *data, int count)
 {
 	struct ath_struct *ath = hu->priv;
 
+	if (!ath)
+		return -ENODEV;
+
 	ath->rx_skb = h4_recv_buf(hu, ath->rx_skb, data, count,
 				  ath_recv_pkts, ARRAY_SIZE(ath_recv_pkts));
 	if (IS_ERR(ath->rx_skb)) {
diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index b386f91d8b46..db56eead27ce 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -585,6 +585,9 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
 		return -EUNATCH;
 
+	if (!bcsp)
+		return -ENODEV;
+
 	BT_DBG("hu %p count %d rx_state %d rx_count %ld",
 	       hu, count, bcsp->rx_state, bcsp->rx_count);
 
diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index a889a66a326f..767372707498 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -109,6 +109,9 @@ static int h4_recv(struct hci_uart *hu, const void *data, int count)
 {
 	struct h4_struct *h4 = hu->priv;
 
+	if (!h4)
+		return -ENODEV;
+
 	h4->rx_skb = h4_recv_buf(hu, h4->rx_skb, data, count,
 				 h4_recv_pkts, ARRAY_SIZE(h4_recv_pkts));
 	if (IS_ERR(h4->rx_skb)) {
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index cfdf75dc2847..d35383718212 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -587,6 +587,9 @@ static int h5_recv(struct hci_uart *hu, const void *data, int count)
 	struct h5 *h5 = hu->priv;
 	const unsigned char *ptr = data;
 
+	if (!h5)
+		return -ENODEV;
+
 	BT_DBG("%s pending %zu count %d", hu->hdev->name, h5->rx_pending,
 	       count);
 
-- 
2.53.0

