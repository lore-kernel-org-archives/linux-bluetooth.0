Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53984295DB8
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 23:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766620460; cv=none; b=i8q8b4U1HCNrMu2Ry59xuSd3wRbbM/W4pDcjuq+t5iROpenPQEBkYDBPyY660ZLSo2IVG0i1uotLsJsne4fscdZ8xkM4tYj4yE7gSa+VoBkn2INMSsbPSXyhTUmJBO0s69y6oRY7MrvP4E0RrmWXBloGfzr6hUiFxnco/KbXGKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766620460; c=relaxed/simple;
	bh=w0v4tX4mseckg2+iLUxgfFSsK4vg8zMZvbRYnGc6RnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OW6uyK1AwmSt94oa3w/jqUuBQuUDPA0t5Q4/ENtXueRkumbzZFYKWh1GZb5uT3nRDfW68xSXmnFD//Nw/trta1/NC4+Q9c0lTnj/ZkVUE1wlCiv/Jnp1spo/H4HKiNNonpcStqlsAft/MiFBISDfuvGLaFAEYAeqEdDWfa5Rkw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4COhyb4; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4COhyb4"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso9463023a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 15:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766620457; x=1767225257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NA0rUVS0xrAio4YdZs9DHUZnF1aKMyxAVaNNj28rtl0=;
        b=K4COhyb4ylBJQP3QlASyiGmJfupdUqNzre67dSW5RZFTowC+R0rVDefuAOfsKel6cq
         z7XAFb18s5mkVP84+a3mtDHq/6UJ692TUuvFvDEnvmB9ZPFCb46BK27exmuZinaPT0iu
         FWeITZ95OtPl2jSXoheZIRuJkQJnX9GQdc+mdHX9lV8IQjY37lZGPd+/2ISfVMIAqX5n
         npGddlIBvm3bZYvz8LQV9bWPnvEbGSGaaQ3GugChYYBAZLvihN8+lrM5cTY8YtgxwQ1t
         2kAmrEzmVR4CSwjCsL7zk0NnoNKkxy8bYsJh9dPUvkiR8uglRgkgszYNKyMAaVSzqsp0
         fVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766620457; x=1767225257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NA0rUVS0xrAio4YdZs9DHUZnF1aKMyxAVaNNj28rtl0=;
        b=GuGSQVXJDVr82aX+wUzdlS1bIWVb7p1sF5x7saEwl3dI6B6eSogbRnZo+woqBR2NGC
         PfjaZdYjCeWGRJhwZmQoeQ6MZPf3Ut2p4rp9XrXmiBplW1r8wKeT9/7yxCJyhHuA4dcj
         o43TKU7oHbP3aN+5L5JraBBCzEMk6oLPw1suZiwvNAOpFycsYes4YVRptDy2uhHKx7WG
         8AkNEi/EnhvOFn50YDq5Ue5A4s4jTL1uCQgx3fS+5ig0JcSgfjqMtPHN18lYC053rRir
         cI+GHfA9vTKLJOZDKyDYklw6oRhdLrFNZ4g22yU0pZ3JdM40Cvr1Shq7QtNN0EhYqUKJ
         Rp0w==
X-Gm-Message-State: AOJu0YymX1q3CAs3ZHPYwOfKIGkKyg3ja9ZzPmLxny+CAEEkCj6e9YLe
	jjvhnBYtfROtywQCW4u6pCjHTMYpUFETVpdPtdBfEgn32xvVD63nZoQl
X-Gm-Gg: AY/fxX7CLY8WV/o9EVkZ7Cl06uqw0DmYLfjraFW4cuZZK+2ZANpvONX3fv1nijq0Msg
	lFy9EUjCfHoe43ymO0sdZ/kJb8dMtWVIZoNz77oj6v6cpdyZiPCgeF/9U8QB4ChUl0nrmcWQupV
	kdLnLE4DPwXgsAuY42RRT3y5TJWEFmhwME0GyvmAphwT0FaRRkoL8CrQXNc6t9KYGQuCngQuTn2
	1AbWJEm8hAwy24wKfUfNaZJt+gfYTaF++3O61ve4Jvar82RpelCv8A6ozkFiUgPV70aucIQYkG5
	Zp+4J2a7DcxfhjMG0AS/yvh5gQrhVqS7y0VvtmRnaNRTYL55uzOxh02HzZuvbkbgpLNCHjCsOyq
	kQdP7KlC+VlIzdEAICPXAmePHz++sRjIw1rUpzxHCXTb6xy222U+qR2aJlAD7NsZWfn21XfkDqj
	Bb1QUnOW11UVBSSqLfuGKSYYv3
X-Google-Smtp-Source: AGHT+IH+E5/I8GdpN3VNJfPlbMktwWF++c8gFdwZl+Zj15raohvSlarp3yRp94DY8l+PQ6BIPy2Nnw==
X-Received: by 2002:a17:907:868c:b0:b43:b7ec:b8a1 with SMTP id a640c23a62f3a-b8036f28da0mr2086792966b.24.1766620456525;
        Wed, 24 Dec 2025 15:54:16 -0800 (PST)
Received: from prometheus ([85.11.110.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f0b7bcsm1972149266b.49.2025.12.24.15.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 15:54:16 -0800 (PST)
From: Szymon Wilczek <swilczek.lx@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+4d6b203d625d2f57d4ca@syzkaller.appspotmail.com,
	Szymon Wilczek <swilczek.lx@gmail.com>
Subject: [PATCH] Bluetooth: hci_core: Fix slab-use-after-free in hci_cmd_work
Date: Thu, 25 Dec 2025 00:54:07 +0100
Message-ID: <20251224235407.46333-1-swilczek.lx@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a slab-use-after-free in hci_cmd_work.
The issue is that hci_send_cmd_sync() consumes the skb reference
(either by passing it to the driver which frees it, or by calling
kfree_skb() on error), but the skb might be accessed after the call
in certain configurations or due to race conditions with the freeing
process (e.g. vhci_read).

Explicitly hold a reference to the skb using skb_get() before calling
hci_send_cmd_sync() and release it with kfree_skb() afterwards. This
ensures the skb object remains valid throughout the function call,
regardless of how hci_send_cmd_sync() handles the original reference.

Reported-by: syzbot+4d6b203d625d2f57d4ca@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4d6b203d625d2f57d4ca
Signed-off-by: Szymon Wilczek <swilczek.lx@gmail.com>
---
 net/bluetooth/hci_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8ccec73dce45..af4ef31295c4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4149,7 +4149,10 @@ static void hci_cmd_work(struct work_struct *work)
 		if (!skb)
 			return;
 
+		skb_get(skb);
 		err = hci_send_cmd_sync(hdev, skb);
+		kfree_skb(skb);
+
 		if (err)
 			return;
 
-- 
2.52.0

