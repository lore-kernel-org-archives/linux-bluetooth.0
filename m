Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1A544CF3E
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772138649; cv=none; b=PjI5K5NdGDt2TnoPRbCrA5Em02uw9UGdfvobIIkh/k+PpfDsq6XpJhR3EdP1PpjqHAntYypBlWPy4I3XdqSAVbHmnjkbsplIRIcgFIi6GE694n6n4uEQkiQrjsGAGP3KjIErQVfto8ieBBFLI2tVM5dRn2nyKBwrw3EIgDPO2JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772138649; c=relaxed/simple;
	bh=JAuaOpZNIaNKkJasQgrCvJdYadb2mZ+Vb2TRFZzxhaY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=W0FYDfbFIOMUXLZPvgCYTkyncy2ejoMDBVowHyvd273yhewelTHu3U4lUDqGxCXA8KiBxzwMD2l+mzqUHFtu92U9hXjvpo4dmZlO7PXYloYnJrPL9Ldqf5R7gxiFlFeRvnzgcyF1eWt5ij61LAOvGEX3nkcBnXd378ewNmkjq6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKSCj3Qg; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKSCj3Qg"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-567543b8989so566786e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 12:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772138647; x=1772743447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7VNfFG5u35WtFVBqgRIDcsG0TcMG/Bu7qJCfPegol2Q=;
        b=XKSCj3Qgd3ip/WqqJcbkc48thJCL70aeLcmprnuKLaUZw+jY9URmvv9/S2tOnKhvap
         UKo41AQ46Vo0PWm7vQsBGnFPOlo+hQV9+bT0xY68bl1v3AnfW8OxEgdORqRp+8WjVwdY
         39yecF/ZURj+A1vooxt9pb261JmlfSuNyg/I2q0YK12vdFkOv8t6fHKy4Naw5eghgbpR
         L3jaeRVJjQE5wpFbKg/pvZ2H6GwZrHLnwmSVLA91t61I7KMISpn0n53kh7W6O6/R0Pmp
         EuViREWQ7ZYitLFGRLcyk2VHwVf73O5rNPFZKCh+qB0MHbHKaNc3EyvvtHpsyf/A0uRr
         Yr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772138647; x=1772743447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VNfFG5u35WtFVBqgRIDcsG0TcMG/Bu7qJCfPegol2Q=;
        b=rAJgUxoZQuqB0xCQ9rL4dIqa9YOwXIeLksystEufoeme/YdSw17tm5Qie3MTZlrrIr
         4QSqg5Rf5pTw8x9hY81OwiOonQwnMp2VuMWdSpISQ29+ZdpjAkrmCjQvz8rhTAXYQow8
         00JPrMi7veyPG0rrSG2qwZSvIPCEkmZJTyRtjxOYN50/5t6iXJIMS8Jl/MSjUcPeDECp
         3umRbKE+sYjR052pY84shs5RWHbQLMkEbHPOAqFZX4vGyDjniuJonQU3pAUgjSvqOFJn
         llHdcQZ/QnJLmntu/d+AIB7bRZp2p3FenI3phaL0KsTHOvjVabew3+BZDj1z0qGn6XVq
         WRvw==
X-Gm-Message-State: AOJu0Yx3ptj1I1DGN2/ZOaBGaQjdtpUY3JZ0J4YUNMyJUXd0Mmm3cv1W
	KMg7lynsallbyA2qLfiobu4pjUB29q/opWYS/XjCXfh9zq9TP1dvvCeIW2JTNOubDjw=
X-Gm-Gg: ATEYQzwsUpC+bWg/bkjCxdNh4jMmFsO5XY4+BQJUb+Lo3YW66GLz4rtgk54xsR3iEd1
	97DMkRCIXlYfJZCJU/SMKuyJQXR7D6LCA3957RixHnzSsM43vr8B2/Xk2BOf7XXbiy6WRNeFYlK
	VabOeHADGPRR4IlI8lonQdWDExbj9UABsuRw7iU6thukEsNVyZ44uYOS9e/c44/PwXlCwUjnvRr
	ppr1fIlvD8lUPZw6dBVCDYA126z2W7udwlojhUYZVN/iCf9MXSPz+1MTzQbY3YvsvRPbX39K+zr
	Jrn5LAR7E8RwDjpBINuAa2ci2NHkBAKixahdRQuJO7LVLrxdk3dA4ro62sL55YkEHR0dfjNjrBf
	EeRQf5hSQW2e5aZUSQhoyrlseAh9pSFNvlDeys5v9GRr15+M8z5eAAKVR0+hirjAY5PxKYG179l
	ozEKcg21Zt/GZVW0AyLKq4w6KxChzCSUQXoULDZCgzPGgp7DyJclMF+su/zL45hCUcQhX8IMtSH
	znwvBejU6Yst20cTA==
X-Received: by 2002:a05:6122:1313:b0:566:23b5:ced7 with SMTP id 71dfb90a1353d-56aa0a13793mr310602e0c.5.1772138646937;
        Thu, 26 Feb 2026 12:44:06 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a9204934csm3902987e0c.10.2026.02.26.12.44.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 12:44:06 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: L2CAP: CoC: Disconnect if received packet size exceeds MPS
Date: Thu, 26 Feb 2026 15:43:57 -0500
Message-ID: <20260226204357.361000-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Eggers <ceggers@arri.de>

Core 6.0, Vol 3, Part A, 3.4.3:
"... If the payload size of any K-frame exceeds the receiver's MPS, the
receiver shall disconnect the channel..."

This fixes L2CAP/LE/CFC/BV-27-C (running together with 'l2test -r -P
0x0027 -V le_public -I 100').

Signed-off-by: Christian Eggers <ceggers@arri.de>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
Note: due to lack of L2CAP CoC segmentation support in bthost the following
test as expected to fail:

L2CAP LE Client - Read 32k Success
L2CAP LE Client - RX Timestamping 32k

 net/bluetooth/l2cap_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f550ceceb618..14131e427efd 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6669,6 +6669,13 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 		return -ENOBUFS;
 	}
 
+	if (skb->len > chan->mps) {
+		BT_ERR("Too big LE L2CAP MPS: len %u > %u", skb->len,
+		       chan->mps);
+		l2cap_send_disconn_req(chan, ECONNRESET);
+		return -ENOBUFS;
+	}
+
 	chan->rx_credits--;
 	BT_DBG("chan %p: rx_credits %u -> %u",
 	       chan, chan->rx_credits + 1, chan->rx_credits);
-- 
2.52.0

