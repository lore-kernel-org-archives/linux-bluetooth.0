Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC0D3655DB
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472654; cv=none; b=D1bd3dK4NxSpugRm99n848DgkSMYZfc8GxQcQHNvbn5SLVGKwdmLNuEXQ7E1Y177XGgle7W/VPKkvfMAfJDn0nQ4iOg9m2YjZ2kt9lxQAZ8TFJsF1K7fj5LA0CgiATRBwXZBwbQ5wkNc922D+gJACQ2q9BkY6i5CFJeUE/4zjn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472654; c=relaxed/simple;
	bh=wikLoVl4AbM3L5+Zq1/t7qxKsF/SJ1XW7843dCnZgQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYcRT6+BDYh+f33O1d7k1EkXgxVyYp22gE3+7hLhwgkKxP24cEZh5qtZOWcBCqiBnCaMKbbIohQNCHpgJy2R9pZBxDx7mmHB0gjaOznHi32xp1BfNkMaFFBTKTVYuZFg2nk6fX5TNRWsdQNOeys1mmo+0wEi1ZQVHhIYInWg3CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgWOsch9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgWOsch9"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6877c719cb0so4663776a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 10:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779472649; x=1780077449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bR5EQ3Z+bYBcnVE3TKPfJID/2BeP76rf75SuWiw1z5M=;
        b=XgWOsch9kunGhAvBfHanxyYknycyOxKNWMYJkAssc64jIdeKZwmNMY7GVhJqbVzBry
         b+cW9QUNnUGpI/hYOSdb1p2YLzrzFoqYk3kLGn6zqDrY3w9Kol4E6aAasUx48EaOQgB9
         DpQBP76Oqdb09yzd+Nb1gP5OTXps5KRrzDGCAO/ys/y97y/iO+56s7vd/YyB0YPkiPFX
         jv4zHOCm4Pcnh232x3RGrLvFNUxQelMDT4h6kGomNzpSvSV6qcyNbSLqjP5KaJpoFvxK
         XGSImC/K99JlykAKBbgWlqJNT3NNZaZfBNfUDGSotMojTAowqj2owFre49XPKgr5iJ8m
         khRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779472649; x=1780077449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bR5EQ3Z+bYBcnVE3TKPfJID/2BeP76rf75SuWiw1z5M=;
        b=JC+tQegKVkOqJYlQWCgNa0yZRYJmDeSHm2k2nQ6IXbzWbSNzS8btlZZCQJxQIxHIuJ
         wu0Kye2r7cRQ9mbhzM4U8WpoBFZ1XQSEf4nULhosAB2HYxw4Tw7OYJYiQyaRWwLBMuUq
         eR3pfw1dvKArYjpxvpulyDFR5pGe4F54iAOVYeyqiBFHjpMkk7HFdOEpBAFodSTRKn8Y
         sOcv4t4ZfT0ogFWb8je0HnAiKnLsaQRnZvg89W9TfCADKhZRYSAY6oT2QasvKM/WeUQI
         8FktPSIcokyiKw9HhqFuazzwykAdoIbPHSQLAbQWZjy6YpE0/Bm9UvGy0o7cz6G5YVj2
         8/eA==
X-Gm-Message-State: AOJu0YypDDuamL5Acjbc8Fv5jDFJggwdTKXb3bXHLKJg0F+2e4key/NJ
	QeL2+Qn2luvt9ffWKYGqH64hdG5Y3pSjYrOQieFYMurH5tjVkz2+gACXz2WbqrJd
X-Gm-Gg: Acq92OFXNadX4xfZZeMjNHik90YoIgzph1+aiOjqyLbDXpOKknEpl3Nx7lUUtZQSdm0
	U3rGlYUhhpYTSH445ze6HMKyrWDuCNdtWh5JiKTUXIsQHip12+s5Bol7yrvH5tyiNsTUd8ZAVPo
	MgR3uHRm6oriDlEKkreeYG7MetwEp1H/jdF8GVwIwas38CJVv72A+ZJI11yuGa+oUFK3hF5vwkv
	Bv5heot3UiBQ+BManTD9uYThW7F9aauObw3eS5CerUYrEArHgJ0R+wCq7aKR85OO4cpPbHSo5fE
	aWNt3/Lszeol+Kn5emaXuee4nKe72jfEoKPIFT6uoIeBynLf0VZvLMPtzPwpjZMeVKzKZ/EK2yN
	0yZPSRxGjvDMM91BoeUzpy6a+UeWXTBeEsdxI0HtzOZ29CGlNLgCgtGJAeNmzOSrN3W8dgH6INP
	oBnFTbJ5PLvcMe+hF2OUP8mUw7NolDWss90dGp8ykd6WM/h+5YQq9ts02Sje14XS5FHBY0MN+ry
	oiniPFITxD/9BAuDrAHTu9yH5Y=
X-Received: by 2002:a05:6402:5110:b0:66e:cf8d:6970 with SMTP id 4fb4d7f45d1cf-6889c46833dmr2397386a12.20.1779472648784;
        Fri, 22 May 2026 10:57:28 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688b9f60898sm1002376a12.13.2026.05.22.10.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 10:57:28 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org,
	SeungJu Cheon <suunj1331@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] Bluetooth: RFCOMM: add length check in rfcomm_recv_mcc
Date: Fri, 22 May 2026 13:56:58 -0400
Message-ID: <20260522175658.41667-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rfcomm_recv_mcc() casts skb->data to struct rfcomm_mcc * and
reads mcc->type and mcc->len without first checking that skb->len
is at least sizeof(*mcc) (2 bytes). A remote device can send a
crafted UIH frame with a one-byte or zero-byte MCC payload to
trigger an out-of-bounds read of the second byte.

The unconditional skb_pull(skb, 2) that follows compounds the
problem: if skb->len is less than 2, skb->data and skb->len are
corrupted for all downstream MCC sub-handlers.

Replace the open-coded cast and skb_pull() with skb_pull_data(),
which atomically validates skb->len against sizeof(*mcc) and
advances skb->data. Return -EILSEQ on failure.

SeungJu Cheon's v2 patch added a manual skb->len size check in
rfcomm_recv_mcc() before an open-coded cast, but removed the
subsequent skb_pull(skb, 2) without replacing it. This leaves
skb->data pointing at the MCC header when the sub-handlers are
called, causing them to parse from the wrong offset. Using
skb_pull_data() here avoids this problem: it validates, casts,
and advances skb->data atomically, and is consistent with how
the sub-handlers themselves were fixed in Cheon's patch.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-bluetooth/20260414010741.233892-1-suunj1331@gmail.com/
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/bluetooth/rfcomm/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index d11bd5337..4e8047012 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1644,17 +1644,20 @@ static int rfcomm_recv_msc(struct rfcomm_session *s, int cr, struct sk_buff *skb
 
 static int rfcomm_recv_mcc(struct rfcomm_session *s, struct sk_buff *skb)
 {
-	struct rfcomm_mcc *mcc = (void *) skb->data;
+	struct rfcomm_mcc *mcc;
 	u8 type, cr, len;
 
+	/* Minimum MCC frame: type(1) + len(1) */
+	mcc = skb_pull_data(skb, sizeof(*mcc));
+	if (!mcc)
+		return -EILSEQ;
+
 	cr   = __test_cr(mcc->type);
 	type = __get_mcc_type(mcc->type);
 	len  = __get_mcc_len(mcc->len);
 
 	BT_DBG("%p type 0x%x cr %d", s, type, cr);
 
-	skb_pull(skb, 2);
-
 	switch (type) {
 	case RFCOMM_PN:
 		rfcomm_recv_pn(s, cr, skb);
-- 
2.54.0

