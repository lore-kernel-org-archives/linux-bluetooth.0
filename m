Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AE73537CE
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779707103; cv=none; b=IgHdkyS7xWmT4yoXJMS5jPKQCD8AA5oKKsCB3XPcEc/7ADopPEFLcFiu6PC86yFZtHzbXzXo8BOKMi0jReFpjIOuqcQ9XF7NMIxqPzzEePfMEipTPseaJzMxv8QkUM4ynUYDu/aSGQ4G1u5Mn74J7CI1qLRMo6ytoCP+MygKiQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779707103; c=relaxed/simple;
	bh=APGIhPHWPR/+wOGzlnoG4GOHhlB1pMxWopND9p9UWfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4Q/7zhdT4KCPnywgcTe6y5GW1WUQJUjwujgAI9EPshYL1BQoJBO96KUz/L+Pr2sH5yYZTO18X4cGNN0F80A/tiUXROk+yELLz5/o3FxJkBwkIShrN+NIVOgcHrcyTWhh8MUtlz4VPzKvVd/rV7H0E7pZt5iJQIBxp2lfzrl9dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5tDeD3v; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5tDeD3v"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b941cd869cso60539365ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 04:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779707100; x=1780311900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ev+qvGFv8hIErwC5zu3VS01UuSRGE6RIayOr3UZ1lFQ=;
        b=a5tDeD3vrbugEYuVAUwyeHSyRBfggxpnp3zf+xgSzkbK3t0aNY1YeKsJuyv1XSZP6m
         9+zD1uxLJ2QSrtHQP1Z6QUObTHJKZwD9f5yWnlW+BeqN/CGy8BidUi7cgJTRmihcgdds
         GXeIbUvqIGCLJYn8c+dERKNJ04dykm00Lcxg+gISxIX45TJgM1J2JdMEfLOhyeUadgFk
         vjEkUXcmDEY5Y6KSlnmojO+mTq5FWLtK6BfYhCdScvLirnZfL8P4AHJ9nTOI7zitbqOW
         O4ur8fXGPppzwB+Wrrynzciv9AEVrX/EFrS/cLZ2/CG0krgv7EgbdPNp6ysjh17kR2ID
         X5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779707100; x=1780311900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ev+qvGFv8hIErwC5zu3VS01UuSRGE6RIayOr3UZ1lFQ=;
        b=U12yns47bih45XvWlhfxZrjVi+70ic+e9ZXnWueIwZJjpYQYIEFvcIl4n6GIOTENOo
         LoUBqOjAoPnxB3u7iLx7Z+m0sfVwHuoUblMkgazBkaYlngcm5ltiO4o329Vdf82zvWTA
         POQC7HxrKGRQB5xAqHcKh48X72vPYoIX+YQLXJ6nR1mz/vHdW+olhCx9ZZkr2af2qz2U
         +Y2TLsvbdWr9Qjhnwzz+fveWv3hoqfPCM3vrGlrRceWQyaQOuFZGHLOeDv8H5LClOGTk
         dMG+lWhcUJVOP4wK/QG/+HKfGiIQ1uQweIh0JlGKaN6h1lPmTl3S7LXaBQr8g3UwRCkn
         F+LQ==
X-Gm-Message-State: AOJu0Yxms75clgY96C69jjukOngeu6ThBA2oMQYxvMLyPJx8fKIbnktq
	uaeiLGdsY9c1CTIrevRLrEiMKh4R8LYgOLRT8EzwT1jJIUhD9qE9tYaemrnouA==
X-Gm-Gg: Acq92OHWtKNhvc6blTH5e6Rf45IZH0qoST+GExrbVIfKhbKupGClAVWLWlkHHK7aX9G
	T82FyFxYvXAauLMs9HL4JW79OEbDFOBU4Mj0iJaSMd+2xDMqW9wM6PKbVKVWYj+jgz8kdd1VHeN
	8BuMuiCZCnE3kJb1Ih09RPo4zd/70pqLyZlR+g+fbzV/2cvwNlf82PuhHxOCppoGkRj8sPVIcuB
	HRlrjxgXUBher9Oh92aENeoPRIgF5dg8WHt5+tc1RdoPotMjLJJmbSni/RQ8wecVzyVGjYtR9ts
	lXzBOUOPLgcwI0F7HRnjHJF87HCZ1jC4ZKXV8eVDgHrgwXgZemz9U9sM4QyXaG5ZS1KnCSruKkK
	XXnfzQ50J4m8ApxM2Wglu2Cf2FZ5kc714ZmedLcInpFKKwFZ6Pw/O/j83/GGBsljOag6nh5NAv5
	pS0Mxjota7sGg7lZ4K9+d6u9pbGiVQ5lWvjsMiv3xZWTGSpRE=
X-Received: by 2002:a17:902:db0d:b0:2bc:ac76:c1cf with SMTP id d9443c01a7336-2beb0698547mr158655125ad.24.1779707099972;
        Mon, 25 May 2026 04:04:59 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695a29sm88776955ad.11.2026.05.25.04.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 04:04:59 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	pmenzel@molgen.mpg.de,
	me@brighamcampbell.com,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	SeungJu Cheon <suunj1331@gmail.com>,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v3] Bluetooth: RFCOMM: validate skb length in MCC handlers
Date: Mon, 25 May 2026 20:04:43 +0900
Message-ID: <20260525110443.139485-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RFCOMM MCC handlers cast skb->data to protocol-specific structs
without validating skb->len first. A malicious remote device can send
truncated MCC frames and trigger out-of-bounds reads in these handlers.

Fix this by using skb_pull_data() to validate and access the required
data before dereferencing it.

rfcomm_recv_rpn() requires special handling since ETSI TS 07.10 allows
1-byte RPN requests. Handle this by validating only the DLCI byte first,
and validating the full struct only when len > 1.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Muhammad Bilal <meatuni001@gmail.com>
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
v3:
- Apply skb_pull_data() in rfcomm_recv_mcc() before accessing the
  MCC header
- Return -EILSEQ instead of -EINVAL for malformed frames

v2:
- Use skb_pull_data() instead of manual length checks (Luiz)
- Add MCC header length validation in rfcomm_recv_mcc() (Paul)
- Allow 1-byte RPN requests per ETSI TS 07.10 (Paul)

Testing:
Tested under QEMU with VHCI and KASAN enabled by injecting both
well-formed and malformed RFCOMM MCC frames.

Well-formed PN/MSC/RLS frames and both valid RPN variants (full
8-byte form and 1-byte query form) are parsed identically to the
pre-patch behavior.

The following malformed frames are rejected before reaching the
MCC sub-handlers:

- truncated MCC headers
- PN/MSC/RLS/RPN payloads shorter than the fixed struct size
- invalid intermediate RPN lengths (len != 1 && len < 8)
- MCC payload lengths larger than the actual skb data

Frames with cr=0 are still silently dropped, and oversized frames
continue to ignore trailing bytes as before.

 net/bluetooth/rfcomm/core.c | 67 +++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index d11bd5337d57..364b9381c2dc 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1431,10 +1431,15 @@ static int rfcomm_apply_pn(struct rfcomm_dlc *d, int cr, struct rfcomm_pn *pn)
 
 static int rfcomm_recv_pn(struct rfcomm_session *s, int cr, struct sk_buff *skb)
 {
-	struct rfcomm_pn *pn = (void *) skb->data;
+	struct rfcomm_pn *pn;
 	struct rfcomm_dlc *d;
-	u8 dlci = pn->dlci;
+	u8 dlci;
+
+	pn = skb_pull_data(skb, sizeof(*pn));
+	if (!pn)
+		return -EILSEQ;
 
+	dlci = pn->dlci;
 	BT_DBG("session %p state %ld dlci %d", s, s->state, dlci);
 
 	if (!dlci)
@@ -1483,8 +1488,8 @@ static int rfcomm_recv_pn(struct rfcomm_session *s, int cr, struct sk_buff *skb)
 
 static int rfcomm_recv_rpn(struct rfcomm_session *s, int cr, int len, struct sk_buff *skb)
 {
-	struct rfcomm_rpn *rpn = (void *) skb->data;
-	u8 dlci = __get_dlci(rpn->dlci);
+	struct rfcomm_rpn *rpn;
+	u8 dlci;
 
 	u8 bit_rate  = 0;
 	u8 data_bits = 0;
@@ -1495,15 +1500,16 @@ static int rfcomm_recv_rpn(struct rfcomm_session *s, int cr, int len, struct sk_
 	u8 xoff_char = 0;
 	u16 rpn_mask = RFCOMM_RPN_PM_ALL;
 
-	BT_DBG("dlci %d cr %d len 0x%x bitr 0x%x line 0x%x flow 0x%x xonc 0x%x xoffc 0x%x pm 0x%x",
-		dlci, cr, len, rpn->bit_rate, rpn->line_settings, rpn->flow_ctrl,
-		rpn->xon_char, rpn->xoff_char, rpn->param_mask);
+	if (len == 1) {
+		rpn = skb_pull_data(skb, 1);
+		if (!rpn)
+			return -EILSEQ;
 
-	if (!cr)
-		return 0;
+		dlci = __get_dlci(rpn->dlci);
+
+		if (!cr)
+			return 0;
 
-	if (len == 1) {
-		/* This is a request, return default (according to ETSI TS 07.10) settings */
 		bit_rate  = RFCOMM_RPN_BR_9600;
 		data_bits = RFCOMM_RPN_DATA_8;
 		stop_bits = RFCOMM_RPN_STOP_1;
@@ -1514,6 +1520,19 @@ static int rfcomm_recv_rpn(struct rfcomm_session *s, int cr, int len, struct sk_
 		goto rpn_out;
 	}
 
+	rpn = skb_pull_data(skb, sizeof(*rpn));
+	if (!rpn)
+		return -EILSEQ;
+
+	dlci = __get_dlci(rpn->dlci);
+
+	BT_DBG("dlci %d cr %d len 0x%x bitr 0x%x line 0x%x flow 0x%x xonc 0x%x xoffc 0x%x pm 0x%x",
+	       dlci, cr, len, rpn->bit_rate, rpn->line_settings, rpn->flow_ctrl,
+	       rpn->xon_char, rpn->xoff_char, rpn->param_mask);
+
+	if (!cr)
+		return 0;
+
 	/* Check for sane values, ignore/accept bit_rate, 8 bits, 1 stop bit,
 	 * no parity, no flow control lines, normal XON/XOFF chars */
 
@@ -1589,9 +1608,14 @@ static int rfcomm_recv_rpn(struct rfcomm_session *s, int cr, int len, struct sk_
 
 static int rfcomm_recv_rls(struct rfcomm_session *s, int cr, struct sk_buff *skb)
 {
-	struct rfcomm_rls *rls = (void *) skb->data;
-	u8 dlci = __get_dlci(rls->dlci);
+	struct rfcomm_rls *rls;
+	u8 dlci;
 
+	rls = skb_pull_data(skb, sizeof(*rls));
+	if (!rls)
+		return -EILSEQ;
+
+	dlci = __get_dlci(rls->dlci);
 	BT_DBG("dlci %d cr %d status 0x%x", dlci, cr, rls->status);
 
 	if (!cr)
@@ -1608,10 +1632,15 @@ static int rfcomm_recv_rls(struct rfcomm_session *s, int cr, struct sk_buff *skb
 
 static int rfcomm_recv_msc(struct rfcomm_session *s, int cr, struct sk_buff *skb)
 {
-	struct rfcomm_msc *msc = (void *) skb->data;
+	struct rfcomm_msc *msc;
 	struct rfcomm_dlc *d;
-	u8 dlci = __get_dlci(msc->dlci);
+	u8 dlci;
+
+	msc = skb_pull_data(skb, sizeof(*msc));
+	if (!msc)
+		return -EILSEQ;
 
+	dlci = __get_dlci(msc->dlci);
 	BT_DBG("dlci %d cr %d v24 0x%x", dlci, cr, msc->v24_sig);
 
 	d = rfcomm_dlc_get(s, dlci);
@@ -1644,17 +1673,19 @@ static int rfcomm_recv_msc(struct rfcomm_session *s, int cr, struct sk_buff *skb
 
 static int rfcomm_recv_mcc(struct rfcomm_session *s, struct sk_buff *skb)
 {
-	struct rfcomm_mcc *mcc = (void *) skb->data;
+	struct rfcomm_mcc *mcc;
 	u8 type, cr, len;
 
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
2.52.0

