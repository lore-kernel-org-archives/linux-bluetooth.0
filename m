Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DC93D16EA
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 07:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779175571; cv=none; b=J9KmjHWpZC+X36hp+YxD6pY9xIftEzqe0oVSDukgEvExnYzrBFXHnJOKPfMshpIXXi2rCEXBmkKCMi1o9LcXvntQAT8RZwYz1ZUAXiMOhnpFtcEGZOs7cXmfwKEryDou3k6KnrfIwR7pcEaO8rNXhJbVm2oyl80TyhkZJk3D8AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779175571; c=relaxed/simple;
	bh=E5tbrL6gDSZ/C+kamk4PKO0Wqa9UDvCknl/PJPOeSAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1a0RGtGep8J9qwaXbx+dYNF1sWGX6922ZtDDCK11vp8MPO9NPlDurn9sxMPFw9hbcDlbtAev4kxJBc4jKG7vPycp56DYAVZ1R9xoXAQVdXVMkg+Q7temWc0PnYWYYPbXkLQ1QRsN/RFysWdR0iB9ri4pnVUyDVsCAIkdlgfBt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8VtNZt+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8VtNZt+"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso32689565e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 00:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779175568; x=1779780368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0yD7Ov4S/iFthQxZco1gvVMz6aNPT7+SQbTZFwmogE=;
        b=a8VtNZt+5y+ixT244aAYDcFwUDEJcJkqTr8ACOGDp6cbyE9XPvTx06mQiZoDp7F1BC
         e0d/fPF0f+iWdNr7sAw3lZLJDWeF0wGmQg1HUhUiQY9E99DFDi0scixr0O/WFsRzbbh5
         x91Q0jqRyNNn0weY6KR10WVirKTZMy2zWmBur7GfTUHWYGRDKV+sSfLRbMoGdjCNDmkr
         ITl8HayIECN9LEsHxtAdnjCxONeSLUyA7+HHO7slBGlkKn/06w3tmUYJDiCYeYlgAHlW
         b7H3l73Fbyty9C0JemelCefvLYxuLHV+bm7DXXKJac7yF1Laf2vD5QaSrs7TSmfxh2sh
         bOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779175568; x=1779780368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J0yD7Ov4S/iFthQxZco1gvVMz6aNPT7+SQbTZFwmogE=;
        b=BnaIyenPOqBAMXI8hzCR84NacBsvkt7GAA3mU1TIIfwxlvEsXyhqMIEgua3TRi9YIY
         IO7ALER475+4oB1bAln64YVBAM4ZaEfPv4DVJPWSx5agHnn22Do7NdK/N7Bu3n8kOaGb
         GL1ijNeaJvhwtWyQxMWPDlfs55mpcUKZ6Nuj6QegdH3QKGcK5rw25ZeCNwTgzOzZsSB8
         nGLkwgX5OhpfPxRUNPBZdayP0D1lt6OpQ8LpOB41uY7mdFCwjgPw5iqTzIdpXmk3IlFf
         sFp0QzAmcY3z1+UHGCcJPiOsFLaQdpRSlR6okh71XZBmNNqfrwc93cOcUzb2LvtO+Yuh
         4QCw==
X-Gm-Message-State: AOJu0YzLqyFPlICXl1QMpHCVIDFLY91NNh1Ud3YC/TLR9x+aQV1CGtBn
	QX/3ZZxLeixqqdMHMyz5Syz48wbx4q95B2phwLRbaoT70aT3lbr9Es+bAbwIiqnu8cA=
X-Gm-Gg: Acq92OEUUQ4qvZskZLCQGFgJN1V8a0LpGZ1dIIzY4OMP7SGD/TKxTmh9YHauQU/mVhw
	Zo3mETmdfLmxOJLbY+1B0aZcU/3pIYprs3LgvCgzRviYxHqbOYcKTDXfXbJplXKjvQm/vIZRcGL
	FWZuTRogvtwtnChkv8hk10RSf4nipEbStNdpuoQ2pGVrvWsCoTeAgg5Oi/KZlWiBfwRW1loiQjh
	6ioQUm6ooX7tXudVD2dacYhED4AeTRbWubOxJJ/41xHF+KM6O5BseVrrCpHJYT/tNyd/mii8T73
	JsZZA8dWkqmYGZqQOKPwxBtAn/U3sbwogVd040cqo5BBCJv157hGmcNe80Dai0JQCxkNzMKPQ8G
	sR0L1LjPv5XR43CMJJ9AdHtUCgxhAp9RV8GLsBlGc9QF47hzwPnGVRiZsc7/bxy9ES/y577jGkK
	swC2mkU6MtRcj6Q8VJ3wjKwTAp6LXEuDNz860W2E9czG0oAdbChmAiTzxZUBIu8Oik9CbPKCW1s
	Q==
X-Received: by 2002:a05:600c:8485:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48fe537fb70mr3651885e9.9.1779175567423;
        Tue, 19 May 2026 00:26:07 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c88e5asm327422845e9.6.2026.05.19.00.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 00:26:07 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	kees@kernel.org,
	kuba@kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2] Bluetooth: RFCOMM: add minimum length check in rfcomm_recv_frame
Date: Tue, 19 May 2026 03:25:47 -0400
Message-ID: <20260519072547.33974-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519042017.29564-1-meatuni001@gmail.com>
References: <20260519042017.29564-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rfcomm_recv_frame() casts skb->data to struct rfcomm_hdr * and
immediately dereferences hdr->addr and hdr->ctrl without first
validating that skb->len is large enough to hold the header. A
remote device can send a crafted short RFCOMM frame over L2CAP to
trigger an out-of-bounds read before any session state is checked.

The FCS trimming code that follows compounds the problem:

skb->len--; skb->tail--;

If skb->len is already zero the decrement wraps to UINT_MAX, causing
skb_tail_pointer() to return a pointer far outside the skb and
producing a second out-of-bounds read when the FCS byte is consumed.

Add a minimum length check before the header pointer is assigned. A
well-formed RFCOMM frame requires at least addr(1) + ctrl(1) +
len(1) + fcs(1) = sizeof(struct rfcomm_hdr) + 1 bytes. This single
guard prevents both the header out-of-bounds read and the skb->len
integer underflow.

Note: SeungJu Cheon posted a related patch that adds equivalent
length checks inside the individual MCC sub-handlers
(rfcomm_recv_pn, rfcomm_recv_rpn, rfcomm_recv_rls, rfcomm_recv_msc,
rfcomm_recv_mcc). That fix and this one are complementary and
independent; neither subsumes the other.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/bluetooth/rfcomm/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index d11bd5337..6b300237c 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1741,7 +1741,7 @@ static int rfcomm_recv_data(struct rfcomm_session *s, u8 dlci, int pf, struct sk
 static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 						struct sk_buff *skb)
 {
-	struct rfcomm_hdr *hdr = (void *) skb->data;
+	struct rfcomm_hdr *hdr;
 	u8 type, dlci, fcs;
 
 	if (!s) {
@@ -1750,10 +1750,17 @@ static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 		return s;
 	}
 
+	/* Minimum valid frame: addr(1) + ctrl(1) + len(1) + fcs(1) */
+	if (skb->len < sizeof(*hdr) + 1) {
+		kfree_skb(skb);
+		return s;
+	}
+
+	hdr = (void *) skb->data;
 	dlci = __get_dlci(hdr->addr);
 	type = __get_type(hdr->ctrl);
 
-	/* Trim FCS */
+	/* Trim FCS - safe: skb->len >= sizeof(*hdr) + 1 >= 1 */
 	skb->len--; skb->tail--;
 	fcs = *(u8 *)skb_tail_pointer(skb);
 
-- 
2.54.0

