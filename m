Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD2635F5E6
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 03:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024937; cv=none; b=DrbAB8p3ntzfXXpPbpyAIpBWwHBD7gr0MSHZWxw8hORcrd48+gkCvAy6mk5Xt5GNCysOl8gkKs872daWzO/4osvFLFIqdXhKcyrYGSbGi4yGwCxDAbHDiiftSJ3x7XByRY7t4TEcZF341Fdjah7pwEB0f56kzCf2ujdA9Ai1ItA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024937; c=relaxed/simple;
	bh=ml5V2qdd9T2io4TJQkt8qqVC7DHUeKFdlRVCXlAcR3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N6PmBvnftwhxXZWtY5rLCK0d5EEOME+8Hk5g3PhMFehvJSOskztMZvdkzJlQ/aVU7HwmWzvl+EMaH9B/DhDwbHDdUA8gG/sEpy9+MFlynzeYbPtkIssrwrbnNtkggg42FxQNyn1svES8pye/adWUEOQIFN6/RPL0T5m3Z5z6lYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRqtNlQ0; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRqtNlQ0"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2bd80b3aa13so89964735ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 20:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780024935; x=1780629735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SZFCBYxglQmmA3o/OnPCdkfCHIco6UXSh8qQA8d92ck=;
        b=WRqtNlQ0+MDHAWpeu9sxANfqilb9FmmiyjK+QnKQkL+rV5luqtsxKthO52nR+lVxmH
         uT7k9Hgr/bbKV6CIhand4nfBTdbfQB9dXkc25JkBdfMwM5W77HgO+HekDdRoXwQFEuDH
         QeLp2nX3Vrsm0XdTna0FzBv3n010FPr9en9s5+9y3YCHvKrknboDNuXFH0GNG2wVZAMt
         GWcvcx3fGfzXMnWQBuudInaNT1bnvMZ76qUtiAoSeWeOMu9kMXD7oi/rrn+zAj7O4NJE
         vK7TBXcSDwitxDstkxc3IGpRiUYUwwGxDAquGB6ED7wVcycqQl7+YVy00MtY0ohWLUVJ
         OUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780024935; x=1780629735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZFCBYxglQmmA3o/OnPCdkfCHIco6UXSh8qQA8d92ck=;
        b=Mu1HvKX9Nqvzpj7og0vbQEMEvQIc8zYgprcYjtwiA2xzJrGsmOLdC4QZrrAZ76LWKE
         nnVHjs++tf6XZhpmqYOkh7hiCviyOx4Rd5FOmzRGDqtCpkoLSy92bo3FbVn6c8PhwkMW
         kaOfz/lXQwpXQluZbdOa1uvpUiQA4+GBHoM/9Lokv8ZgaTq12T74l9UPT9+OpKeCN9Gn
         qulZx5ToOpVd4jBeoMUs5Z9zjGd6y02Vy3DbKKOFUBMhMxzBz8M8g9gIbuTFpRRmR+Sk
         N8romvvpovZwJ3IXOXMk2UXTzP7rhV65ogZy4VyEaKer3dzUknatpkt4xKpI2PIiAVGr
         RRaQ==
X-Gm-Message-State: AOJu0YzM8BPPyNnNed+DXgbmOlvQcNWGB4kEhh6Ww7bgJ4DA14d6Af83
	ZGpyK9sVwKzLujtiDmKvT/I+VmhGkxhZMpyy8VCcY0S+hrTySxXToekA
X-Gm-Gg: Acq92OEQ/0k9yBrcRQfUAy9+rGGZobYYCstJ1nsp4B5cdbfE0bWCxWLCKrn4MixdwiB
	5o7FGhmroZ4Au9b25ogAIQGpuAyZBvGJ2TnTojis6eLMyT7Exu5fLi7T63VbQPGjV2k5L1hJqzJ
	/FGIhxrfHFazZKqcXsr0y0zbgN8iGUtRoUJEV1nAgq9q9HG190ThbisXUbWHzl88dw1waz1cial
	dmFY1Ee9KFhuQvt6H4Xtoq3LsAIliqhPu7nvmzrF+abHkkECra1m0eRJPx4d6lsgyvvwpY3b+8e
	t2mbDGKtXU+X0ZgTxtXSzJuy1cgws0TnT907UjqNx6vQ/0wAE3Qjet90Ie2MQbo+jiCg1IulQ7V
	x6Z9fmaS0BkSSS2EKz63cDsm++PsbXQtXVOQqqZ6vC9CxjneTScgINtYwKNqmg3JwwK5zg9uD2F
	myvbg7SL2p/b0WsM9NCmBG9JRzvfcYTFE=
X-Received: by 2002:a17:902:ecc8:b0:2bd:2de3:519a with SMTP id d9443c01a7336-2bf204f16b4mr14840945ad.7.1780024934839;
        Thu, 28 May 2026 20:22:14 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c5c772sm2039495ad.84.2026.05.28.20.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 20:22:14 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zerocling0077@gmail.com,
	2045gemini@gmail.com,
	Zhang Cen <rollkingzzc@gmail.com>
Subject: [PATCH v5] Bluetooth: bnep: reject short frames before parsing
Date: Fri, 29 May 2026 11:22:09 +0800
Message-Id: <20260529032209.2269753-1-rollkingzzc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A BNEP peer can send a short BNEP SDU. bnep_rx_frame() reads the
packet type byte immediately and, for control packets, reads the control
opcode and setup UUID-size byte before proving that those bytes are
present. bnep_rx_control() also dereferences the control opcode without
rejecting an empty control payload.

Use skb_pull_data() for the fixed fields in bnep_rx_frame() so a NULL
return gates each dereference. Split the control handler so the frame
path can pass an opcode that has already been pulled, and keep the
byte-buffer wrapper for extension control payloads.

For BNEP_SETUP_CONN_REQ, name the UUID-size byte before pulling the
setup payload. struct bnep_setup_conn_req carries destination and source
service UUIDs after that byte, each uuid_size bytes, so the parser now
documents that tuple explicitly instead of leaving the pull length as an
opaque multiplication.

Validation reproduced this kernel report:
KASAN slab-out-of-bounds in bnep_rx_frame.isra.0+0x130c/0x1790
The buggy address belongs to the object at ffff88800c0f7908 which belongs
to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of allocated 1-byte
region [ffff88800c0f7908, ffff88800c0f7909)
Read of size 1
Call trace:
  dump_stack_lvl+0xb3/0x140 (?:?)
  print_address_description+0x57/0x3a0 (?:?)
  bnep_rx_frame+0x130c/0x1790 (net/bluetooth/bnep/core.c:306)
  print_report+0xb9/0x2b0 (?:?)
  __virt_addr_valid+0x1ba/0x3a0 (?:?)
  srso_alias_return_thunk+0x5/0xfbef5 (?:?)
  kasan_addr_to_slab+0x21/0x60 (?:?)
  kasan_report+0xe0/0x110 (?:?)
  process_one_work+0xfce/0x17e0 (kernel/workqueue.c:3200)
  worker_thread+0x65c/0xe40 (?:?)
  __kthread_parkme+0x184/0x230 (?:?)
  kthread+0x35e/0x470 (?:?)
  _raw_spin_unlock_irq+0x28/0x50 (?:?)
  ret_from_fork+0x586/0x870 (?:?)
  __switch_to+0x74f/0xdc0 (?:?)
  ret_from_fork_asm+0x1a/0x30 (?:?)

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
---
v5:
Clarify the BNEP_SETUP_CONN_REQ UUID-size handling using the setup
request layout from struct bnep_setup_conn_req.

v4:
Wrap the changelog entry that Bluetooth CI flagged as overlong.
Keep the BNEP code fix unchanged from the last submitted patch.

v3:
Use skb_pull_data() with NULL checks in bnep_rx_frame() instead of direct
skb->len guards before fixed header dereferences.
Split control handling so bnep_rx_frame() can pass an already pulled control
opcode while preserving the existing extension control wrapper.

 net/bluetooth/bnep/core.c | 57 ++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 0de5df690bd0..5c5f53ff30e8 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -206,14 +206,11 @@ static int bnep_ctrl_set_mcfilter(struct bnep_session *s, u8 *data, int len)
 	return 0;
 }
 
-static int bnep_rx_control(struct bnep_session *s, void *data, int len)
+static int bnep_rx_control_cmd(struct bnep_session *s, u8 cmd, void *data,
+			       int len)
 {
-	u8  cmd = *(u8 *)data;
 	int err = 0;
 
-	data++;
-	len--;
-
 	switch (cmd) {
 	case BNEP_CMD_NOT_UNDERSTOOD:
 	case BNEP_SETUP_CONN_RSP:
@@ -254,6 +251,14 @@ static int bnep_rx_control(struct bnep_session *s, void *data, int len)
 	return err;
 }
 
+static int bnep_rx_control(struct bnep_session *s, void *data, int len)
+{
+	if (len < 1)
+		return -EILSEQ;
+
+	return bnep_rx_control_cmd(s, *(u8 *)data, data + 1, len - 1);
+}
+
 static int bnep_rx_extension(struct bnep_session *s, struct sk_buff *skb)
 {
 	struct bnep_ext_hdr *h;
@@ -299,19 +304,26 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 {
 	struct net_device *dev = s->dev;
 	struct sk_buff *nskb;
+	u8 *data;
 	u8 type, ctrl_type;
 
 	dev->stats.rx_bytes += skb->len;
 
-	type = *(u8 *) skb->data;
-	skb_pull(skb, 1);
-	ctrl_type = *(u8 *)skb->data;
+	data = skb_pull_data(skb, sizeof(type));
+	if (!data)
+		goto badframe;
+	type = *data;
 
 	if ((type & BNEP_TYPE_MASK) >= sizeof(__bnep_rx_hlen))
 		goto badframe;
 
 	if ((type & BNEP_TYPE_MASK) == BNEP_CONTROL) {
-		if (bnep_rx_control(s, skb->data, skb->len) < 0) {
+		data = skb_pull_data(skb, sizeof(ctrl_type));
+		if (!data)
+			goto badframe;
+		ctrl_type = *data;
+
+		if (bnep_rx_control_cmd(s, ctrl_type, skb->data, skb->len) < 0) {
 			dev->stats.tx_errors++;
 			kfree_skb(skb);
 			return 0;
@@ -324,24 +336,27 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 
 		/* Verify and pull ctrl message since it's already processed */
 		switch (ctrl_type) {
-		case BNEP_SETUP_CONN_REQ:
-			/* Pull: ctrl type (1 b), len (1 b), data (len bytes) */
-			if (!skb_pull(skb, 2 + *(u8 *)(skb->data + 1) * 2))
+		case BNEP_SETUP_CONN_REQ: {
+			u8 uuid_size;
+
+			/* Pull uuid_size and the dst/src service UUIDs. */
+			data = skb_pull_data(skb, sizeof(uuid_size));
+			if (!data)
+				goto badframe;
+			uuid_size = *data;
+			if (!skb_pull(skb, uuid_size + uuid_size))
 				goto badframe;
 			break;
+		}
 		case BNEP_FILTER_MULTI_ADDR_SET:
-		case BNEP_FILTER_NET_TYPE_SET: {
-			u8 *hdr;
-
-			/* Pull ctrl type (1 b) + len (2 b) */
-			hdr = skb_pull_data(skb, 3);
-			if (!hdr)
+		case BNEP_FILTER_NET_TYPE_SET:
+			/* Pull: len (2 b), data (len bytes) */
+			data = skb_pull_data(skb, sizeof(u16));
+			if (!data)
 				goto badframe;
-			/* Pull data (len bytes); length is big-endian */
-			if (!skb_pull(skb, get_unaligned_be16(&hdr[1])))
+			if (!skb_pull(skb, get_unaligned_be16(data)))
 				goto badframe;
 			break;
-		}
 		default:
 			kfree_skb(skb);
 			return 0;
-- 
2.43.0

