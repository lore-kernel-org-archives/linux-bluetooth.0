Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781602;
	b=lQrGplOEzzYMhW+iTdR0YD2BXpNpRQXXsoCfzzBAjpHmuCnqlLzOD94zP7wLdIdwzwt3
	 yRRrb5lDH81AAwmujI+RtzwVQV47oIA4haAnqZqrpXGhpdkJmmWF4nSPEGfeRnBSsHZma
	 E8E77umnD4uHa8p+kMrDox8zng5XC1IxcLxwj+I8WcqBAnD8jt5a7j4yLQvNSWGfdPMlX
	 dovQ69BT8+py2ks3hXnhfHHNTe3oWMTMlbnQenI2HinSTgSJg3A5BMnWprsRNJVYw+qPb
	 eWTK9CEMXIbdknropKbjquBjnmPPoZFvVHXuI6XgkM8PZSJpwJl6TODkzSRgFDlTXEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=70NVpUqFgTkzYNK4CG9pogYd6+4MP/QOiIjimd4goYw=;
	b=NnKXNLGjcGlx76hdAv/Q3Ctepm5JNJhajggTaUJzEpDrF3lLAN7PR1KbtlvXUvTE4a/R
	 waRycD/tHyVuaLa2BaE/oWlPtN0/PrEx4PBKFLLRZS8aOD5njMb40GvUDLgv4WbuJTmwM
	 KMt93lWvY6jDilcCjZqhs9tqhYJI2r/9uqaIJoGuldu8B81fujg/9QcI1S/f+So2wRfuL
	 Rw1/cB1ufObd92J87GcZKSvZgWtU3/xS6P2gFboBkTE1T4LOVkueX1aAcsAEIzfEEeige
	 y9qwHG1Q9PeRRq5JdHyvd/kuXWyZiAQ1hJnhcjl97kDYQlQiB/Kkc54m3lEokooXYWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b="CIa2MO/V";
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E526606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 12:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E526606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=CIa2MO/V
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bba5e17cbeso26235455e9.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 04:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795781601; x=1796386401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=70NVpUqFgTkzYNK4CG9pogYd6+4MP/QOiIjimd4goYw=;
        b=CIa2MO/Vt4LyC0B4fKb+C0KNSKRnH/+cObKydQtqMpKgH147dajftacVdjgNIqzV6h
         dAJQLHrrrTiuT+ICGctE+Jiq29gXsg6E43GShoHdJ8MuOn6aWkGQy0dQ3QIGIUJwNIzA
         /NVW4yoX4wbENQzxJP4MUGyFWEPWyhQNNDWK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795781601; x=1796386401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=70NVpUqFgTkzYNK4CG9pogYd6+4MP/QOiIjimd4goYw=;
        b=d6rFwV9WBNUdRHy3ZapnXsjfZenk3EWBKM5TRi/hVY27q4vCAfGVy63Q2oDEhRMofB
         mkDVvewf0KYx2xPq6LtPwUAQZ1mf3VaHriCPdfSIkI62f1J022ICOpOq/UnyR4mKZIyS
         P1JYdyu12f7ERDJEMoiruu4OwrFL8l1JUP1qHImmTgEqyDciRKb7zEYYiumjwGUFsFVv
         sUYsgS4dC6XSQAKE3fSq2mWXcBkPk9S1+j+o1R8iu5fpF7qIu8JoqtdKllFt5t/NRgGX
         is1Sq83QL4BT929xX+XLcMS9XykqJ1v4nQ+gavieZ2qsOhLEsDqAQ58VcajivmCQZ73r
         UoDw==
X-Gm-Message-State: APuU4Z+iqWDWFhFZ9skBkJ7OCyAED8JOYqAF0MwMwLSNG579XsGsAPaQ
	rWbIWsiTujiDkiX6OrUuDIwE1UJc724Mm6IADVmrV16iUCDXGMEEp/JctZhOA5djLaQ95NDONW5
	oJ+Zc
X-Gm-Gg: AZFdTZeUAg8PnWow8H2M4P9o8uWBpQQZvPrHi+9FqjvrZpIn0+GP3m+UoKO/97ATA9W
	l1uYuW19FD3Gc0hYN+1J4SAAqci9U18usWE2kuGsifXI1AjM2W3O5o9VIrLgPelXl7DF/tNNXfs
	J0gjFE+h2veAxn62qe4CT8mmWGHXmDl3WZZL4bgh/rWl30acuiDCY+ZfGAiaRwDbQjXgATxwnFv
	YdZjF2YAEbezRf5KTAsL8lI7emBAxd6ZL09FJFmSNfQwLmTrjxW5XgAggeKXWsr4W6/yx0Ezj4U
	aAnSRUoHuuhTOaNTk/sWuweTwnxkgLJndNMLe3ozbOFMcv+/CPv05t2aHz7+lQjvFguOtsWXken
	yBOUfW/kjY51sKp5WXYh5vzOSyEH4hvQnHMGJO3gcjluh9h02m26YaiKMQGkJlgxkjo538R0Cu+
	jAPb2gAJL6NCBO6co51Yg/l6IBWK7zWjikgIoxJBFes4XFqRACz2r3igQsj3Ukcaomo9AWOMOIc
	cKXfhOlORMbj6HVbnjgRhmuMoaiZ1Jz44fDPbS6h2jp+q0tJgQw1LaM4VR+ZQe9TMav4N+qYwWt
	NAfCap+UfwlajXcG/9kn9PrEUQmksQraHZay0zgLWyo4STEMuQ==
X-Received: by 2002:a05:600c:4e16:b0:4bb:6f77:1e35 with SMTP id 5b1f17b1804b1-4bb88810991mr523367065e9.21.1795781600695;
        Fri, 27 Nov 2026 04:13:20 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:1a97:1eed:9575:b56f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884865a2sm714096785e9.3.2026.11.27.04.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 04:13:20 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: L2CAP: Don't lower the MPS of a credit based channel
Date: Fri, 27 Nov 2026 13:13:17 +0100
Message-ID: <20261127121317.2377676-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

When the first K-frame of a segmented SDU is shorter than the MPS,
l2cap_ecred_data_rcv() lowers chan->mps to its size, to hand out
credits for smaller K-frames. The lowered MPS is then also the limit
for the K-frames that follow, so a peer that sends a short first
K-frame and a longer second one, both within the MPS we announced,
gets its channel disconnected:

  > LE-ACL: Handle 2048 flags 0x01 dlen 2
        Channel: 64 len 241 sdu 672 [PSM 128 mode Enhanced Credit (0x81)]
  > LE-ACL: Handle 2048 flags 0x01 dlen 4
        Channel: 64 len 243 sdu 433 [PSM 128 mode Enhanced Credit (0x81)]
  < LE-ACL: Handle 2048 flags 0x00 dlen 12
        LE L2CAP: Disconnection Request (0x06) ident 2 len 4

  Bluetooth: Too big LE L2CAP MPS: len 243 > 241

PTS does this in L2CAP/COS/ECFC/BV-02-C and BV-03-C. The lowered MPS
would also go out in a reconfiguration request, which may not lower
the MPS of more than one channel.

A peer that does not use the whole MPS runs out of credits sooner, and
the receive path already hands out new credits when they run out. So
keep the MPS we announced.

Fixes: a5c3021bb62b ("Bluetooth: L2CAP: Detect if remote is not able to use the whole MPS")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 net/bluetooth/l2cap_core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index da947b65d26a..289e6b95cbac 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7269,16 +7269,6 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 		chan->sdu_len = sdu_len;
 		chan->sdu_last_frag = skb;
 
-		/* Detect if remote is not able to use the selected MPS */
-		if (skb->len + L2CAP_SDULEN_SIZE < chan->mps) {
-			u16 mps_len = skb->len + L2CAP_SDULEN_SIZE;
-
-			/* Adjust the number of credits */
-			BT_DBG("chan->mps %u -> %u", chan->mps, mps_len);
-			chan->mps = mps_len;
-			l2cap_chan_le_send_credits(chan);
-		}
-
 		return 0;
 	}
 

base-commit: 77bc0f253ff9fe1656f6e0fe9e9f5d3da91faf60
-- 
2.43.0

