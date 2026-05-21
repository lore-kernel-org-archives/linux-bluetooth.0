Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191F4318B9C
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 05:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779341190; cv=none; b=PYLPdptPyQPsHSHYLV/Mg1U/+PlcI3MA2YkEF993o6Grv+SHPw2jwO36/AfGcBfykYsaPMOznGiA0sYjbEBdlUrIrew0SHNn1deUFZ61LYnrOHtAPXiRUv6EOxR3gjUTCt7pMcQ1YZvAv/sEdPcN4Vyd8LHXJqMcb5KPnpCbfqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779341190; c=relaxed/simple;
	bh=wOONB0aNuYCXWjs99uZgkfRlO0gOO2Af2A/K3wYEPSo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gFzCDDYIxnD7tBKUhamF8+ePLH2r3/1Dep9ctbRz4nIWP/8trIyZfvR+p8VO4GcVgcrFe16fs9Fy+cdeCGnby23M4f/W9Agu3upGa1bbqGGaes3xirKEJqMh6jWZYoqxyHsB5apgtzuAsRydYRqWu3grpWkUkdCMUrSWyILPiqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Up1dA1kv; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up1dA1kv"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-82f8b60e54dso4778925b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 22:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779341188; x=1779945988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=It4O8aFwzCXQnnzJXWNnoxbkN46m+ZVAZARcQcv9gog=;
        b=Up1dA1kvd4zGOgStvV2odLjHvl1ykaKcfcx4eaamUOpvvXRG8JVQOAg9U+wLLNlaKn
         NP7JL7S3Yp54JwxlYZr/RdM9nlVPk2nDxgDFkIWuFX7w8u87iayFXeN7Hv7kBhxLr3pZ
         XH75kJCX3gC+lYvfk7NvjO9tmzkLZ2cI9In7SPFAkUnHRmafMzw7PcYLuWMxLfhXQWgn
         YGU2B6S5fQey+lNiRrcni14390t0PmIc0L2tzL1VS2Qa9fvPdOpKkRkTT7UoMNKrAlcz
         MkoaDIjTod7PQWsQIOEm9gUOnkf4TNH4L01psLhj00jYbgNxk5zkb+C80b6CwOuY7Gsi
         TAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779341188; x=1779945988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=It4O8aFwzCXQnnzJXWNnoxbkN46m+ZVAZARcQcv9gog=;
        b=gRQJAjRr26+zd4v7EPX2PSZ0wLfzcXXaYFQrIS1wrplsa5PN1jn3RSC5FDWSmBLbBa
         61BYBwqk/x1rQdG4UiH48gejLfeODTiaamdWxcBUiFzFEmJgS+arqc4AIYrvUvAC3FRA
         JLtVpPG+VkLlNJw7r6FByvWnvt/DQ4PFJg/vpRKlL/dvh83C6RLpzzfZzYk7iTsiculG
         u8aSEMesCLFiygtVliUFO6mjh8ZXRqbne2vLnwazKhkcyff/tDM6uyD+nze32XShX5/w
         bPfKg020fD8+0tsf9xKcbTQDH2k3bj4EJbxD4N04q4lhehzvoCpl9CKbR5cVkjtPU60J
         3DYQ==
X-Gm-Message-State: AOJu0YzyHuRYdokHSvkPlGkv0yV4ub8gxUXtxnm9uBu/hRK5KVT7fSmM
	KA1rhkiWXTiiiqxnGINOZExNSMqz7y9fi/aOkLQ5sPZWcT4B0GvRMTDC
X-Gm-Gg: Acq92OGk68lCkgVWsOTlDb0VWYXMrBD4VirNA3sRFyBBjssZUytRNHgR4kC2tHst/N7
	5yE68oOVN0RUcwQK4BZK+z781fzlTTnaMwnHHHu/9BhVXhRKPDCoEQpeYAlRBRxeQ1BaCdiSDwy
	yH/tf9LQ4pfn1/qtEnnwFojaoyNMht88IzunA+NDPMbUzB9hyPCIDKIrcATY7kRADGev1t8KfKg
	xCdH/o2NYByy+lWOBxVFQJnR/lUkaUfZ3RNze/iV6852W9/sfkVYQ1JmDChumzj6lCZwuUvvCe4
	8W0hU5GlMGA+cjnt19QZUu0ZSMnx2XzDrZCqdwUqNbuhlRX3lFim8y49dWrjSpTGQCmqDNdCCz3
	SGhIqcmmZ53Xsd3lGY94ArCIX2ITIhrtfVXiAY1UDK/bpH74FrJ9j2Q322Jgqcg1NejONQ5Rsd6
	LkH7398HHDvniZPj85G9NZhcEwKlynxtzZefLRee5afg==
X-Received: by 2002:a05:6a00:bc8c:b0:82f:5125:a327 with SMTP id d2e1a72fcca58-8414adfae02mr1594629b3a.27.1779341188284;
        Wed, 20 May 2026 22:26:28 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f196647aasm21454730b3a.5.2026.05.20.22.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 22:26:27 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zerocling0077@gmail.com,
	2045gemini@gmail.com,
	Zhang Cen <rollkingzzc@gmail.com>
Subject: [PATCH v4] Bluetooth: bnep: reject short frames before parsing
Date: Thu, 21 May 2026 13:26:11 +0800
Message-Id: <20260521052611.1815693-1-rollkingzzc@gmail.com>
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
Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
---
 net/bluetooth/bnep/core.c | 51 ++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 853c8d764..156cd3026 100644
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
@@ -325,23 +337,22 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 		/* Verify and pull ctrl message since it's already processed */
 		switch (ctrl_type) {
 		case BNEP_SETUP_CONN_REQ:
-			/* Pull: ctrl type (1 b), len (1 b), data (len bytes) */
-			if (!skb_pull(skb, 2 + *(u8 *)(skb->data + 1) * 2))
+			/* Pull: len (1 b), data (len * 2 bytes) */
+			data = skb_pull_data(skb, 1);
+			if (!data)
+				goto badframe;
+			if (!skb_pull(skb, *data * 2))
 				goto badframe;
 			break;
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

