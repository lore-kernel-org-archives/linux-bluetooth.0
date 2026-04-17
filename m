Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C288F258CD7
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 22:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776464204; cv=none; b=N5/rrznKsKRQZ5sTgERmjkLjrcoEKqCOhcUqy2KPeReQVMprLb9I44yjHX+pnvEd/oq7sZbLQDgnNn1KBV52Ct/OuaxRCEdZ/Yne2M6Bw2clBPjGAysEnD2ioHUaCQRki1Oe72EV5CgTQme7NbNSK4G7MN5xoFNz57yu1b6uuxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776464204; c=relaxed/simple;
	bh=xncuZyFph/BnvwQs00+eKWPa35xDllq9CDcHH0DKUyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DV28O2E6Fmjv43/4FClSkWd+xUqqRi2TOWfAQ6lfRJleP2Zwxz0vR7BBAM7yg/LEgKa379lvbuxagYuzziKDdbxHD6kZCFqblNjg5NllUwXFnyo71e0AO4HTlGm/9RkLdv5EP0qvFGKAJu92ueqaTvkGMekjtm+Dai3MdipQoT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTsjPvYh; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTsjPvYh"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8a58057d7baso13495726d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 15:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776464202; x=1777069002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xCouuL44gA5wAk0ILhGdoV/0EZfXmLvvGfbf/4hMjUs=;
        b=HTsjPvYh2Sp7divS7SrvLAQlIplmUaxlgHmrwkh/D81PbbCbfSDs/kAS19SxguIFMx
         9crqCGz6QQvqFdM6owz3/DD994Yy7tqBeljgS3EWffOh+pxSuWAaiq6+Fu4jCIxW/fpA
         ZSHRT1gQk+mfqP68sDLAIL2BFSpEhG7DXHrlY97LSrf8/MYwOnDjl92m15QrbQvm150E
         OJBD6lQASW+MymPnLid2wYkpW5+KVNnRSzfEp2ziU1tw2mnaFQWozrDypB9Ab7jFHm5S
         qGuahaOwNu4vik417ouSsp38hjIOGTmtxEqfQP1UsuzGSBDWuNxIq/Y+wHwfsHz24ymz
         Devg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776464202; x=1777069002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCouuL44gA5wAk0ILhGdoV/0EZfXmLvvGfbf/4hMjUs=;
        b=lO/m8FLb9jVW7AZ87+eHXvaXcWGrcLsQSdTrD/BhyyZhIFEb3I5gkwruNiQ6DcH81L
         TS76GIypTvlhAITk3+sGKeIOUQN9ZVtKg1avaHzD5KCsRNJTOMMdlgrib7EcG/0+UFtv
         kOw+YAZOjEwqUBZSvs3ggKoJ92WkMojC8oik1gNGJLav2qyogZon0w9bwboLwIyk4EMU
         +3EGDcKNBlmwjDFWbhhLBrWdRDnjhBEhuyAOUD82sCUTn40GWYO/OvDrTTW93Bf4Pgsc
         ZOXGMtHlvbF0MgVkJwngWa37YOYHVTXSJqRc8a3nKb0PrfQ2+Wp4LCuyu6NmKGwWbFgr
         v+pA==
X-Forwarded-Encrypted: i=1; AFNElJ/P3kVJN5a6YizDJQAJdTQQg0INjO/1qLKxKfqbzVbau6uouJAb1GU429fyuAAblooQLoyUf9KC4dMaCbQkMJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Fu3JHA6f9GSAbxrQup2Sy7iAOUJS5YFxln+gymK0raopwKPa
	d1CmPrxggdfe/HiX2Nd3LnNXaMJ8OurfeVBLM8t36z/dDHH1jeyZszdWHeEJgdpv
X-Gm-Gg: AeBDiet4T073uzl3SDiQTs1Akd8hRhsLE2HM46gc1wRojj88Y+9FsfxWjtNxy5hTs7l
	nu/m43us3LVMZs4LOpc95iplMA883lK/5kgaKCMWm7gZrYyrIp/G6AlIEZeLHwftKmTfvoOmBWt
	qdoUnkKgbev7nIgv898+E8PY8iHTYGimWjgDoNhCb4Fo/XCBAN6w2TWnu26cZbkhGncfM81VjK/
	S4bBbsxUkGWUhEmFIQW+J6iNXcwucRljmkJFjukwt7i0l1YDWTYc2E2xPIQeC41psaEqREFpf1u
	Eo0s5c7zojpGouaBW2NmMvAMUZmsvhAsKX5TX0bRJWym6F0niT90YuFuhACtHVQdmM6xBDBiM1H
	6h347tEYIMkRA2K0Q/32dmEhL/imTWYTayDm6J54dvGGLmz13vRvLUZS56fMaf5I1GmFc0YpUIT
	g0bLB+K3AwvMdbkdZwcBpicfUjL2MUj8+WikTzVorimjOgXnabZdRSRx0ySP78992GnayKh/T2S
	83uL6nZ2QOJbTRfBy/lylWR6Ea9cfsmkpbzvDiJSbINuVzeCLkF9Q==
X-Received: by 2002:a05:6214:cc8:b0:8ac:b70c:8a9b with SMTP id 6a1803df08f44-8b028156a6amr80785566d6.44.1776464201715;
        Fri, 17 Apr 2026 15:16:41 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aec3a3bsm20754196d6.49.2026.04.17.15.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 15:16:41 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mat Martineau <martineau@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: handle zero txwin_size in ERTM RFC option
Date: Fri, 17 Apr 2026 18:16:28 -0400
Message-ID: <20260417221628.1674866-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bluetooth L2CAP ERTM configuration (RFC option, type 0x04) carries an
unsigned 8-bit txwin_size field.  Core Spec v5.3, Vol 3 Part A, section
5.4 specifies a valid range of 1..63 (or 1..0x3fff under the Extended
Window Size extension).  A peer-supplied value of zero is out of spec
but the current l2cap_parse_conf_req() path stores it into
chan->remote_tx_win unchanged whenever CONF_EWS_RECV is not set.

The zero then reaches l2cap_seq_list_init(size = 0), which computes
alloc_size = roundup_pow_of_two(size).  Per include/linux/log2.h the
result is undefined for size == 0.  The runtime behaviour is
architecture-dependent:

  * x86, arm64, RISC-V, MIPS, s390x, LoongArch: the ISA shift
    instruction masks the shift count by (word_bits - 1), so
    1UL << word_bits evaluates to 1 rather than 0.
    kmalloc_array(1, sizeof(u16)) returns a valid 2-byte slab
    allocation with seq_list->mask == 0.  ERTM retransmission
    silently collapses every reqseq onto slot 0 (correctness bug,
    no memory corruption).

  * ARMv7 (AArch32), PowerPC 32-bit (slw), PowerPC 64-bit (sld):
    the shift instruction returns 0 for shift counts >= word
    width.  1UL << word_bits therefore evaluates to 0,
    kmalloc_array(0, sizeof(u16)) returns ZERO_SIZE_PTR, and
    seq_list->mask becomes ULONG_MAX.  Any subsequent access to
    seq_list->list dereferences ZERO_SIZE_PTR (0x10), which is
    always an unmapped low-memory address, and the kernel Oopses.
    This is a remote kernel panic driven by a single peer-sent
    CONFIG_REQ; it is not a demonstrated code-execution primitive.

Verified on qemu-system-arm -M virt -cpu cortex-a15 (ARMv7-A, same
LSL register-shift semantics as the Cortex-A9 class still shipping
in automotive infotainment on NXP i.MX6 with long-term availability
through 2028).  A KASAN-inline kernel built from mainline panics in
l2cap_seq_list_init on the first peer CONFIG_REQ carrying
mode = L2CAP_MODE_ERTM and txwin_size = 0:

  Unable to handle kernel paging request at virtual address
  9f000002 when read
  Internal error: Oops: 5 [#1] SMP ARM
  PC is at l2cap_seq_list_init+0x140/0x28c
  r2 : 00000010   r1 : ffffffff
  Register r2 information: zero-size pointer
  Mode SVC_32  ISA ARM
  Call trace:
   l2cap_seq_list_init from l2cap_ertm_init+0x588/0x758
   l2cap_ertm_init    from l2cap_config_rsp+0xeac/0x1158
   l2cap_config_rsp   from l2cap_recv_frame+0x1260/0x8000
   l2cap_recv_frame   from l2cap_recv_acldata+0xb78/0xdb0
   l2cap_recv_acldata from hci_rx_work

r2 = 0x10 is ZERO_SIZE_PTR (the kernel's own decoder annotates it
as such).  r1 = 0xFFFFFFFF is seq_list->mask after the 0 - 1
underflow.  Faulting address 0x9f000002 is the KASAN shadow for
pointer 0x10 (shadow_offset 0x9f000000 + (0x10 >> 3)).

Trigger is one peer-supplied CONFIG_REQ on an L2CAP ERTM channel;
no local privileges required, no pairing required, no local
interaction beyond being within BR/EDR radio range of an affected
host.

Fix in two places:

  * l2cap_parse_conf_req(): when the peer sends txwin_size = 0 in
    the RFC option, clamp it up to L2CAP_DEFAULT_TX_WINDOW before
    the chan->remote_tx_win assignment.  This matches the existing
    clamp on the CONF_EWS_RECV branch in the same function and
    mirrors the shape of commit 25f420a0d4cf ("Bluetooth: L2CAP:
    Fix ERTM re-init and zero pdu_len infinite loop") for the
    sibling RFC max_pdu_size field.  This is the primary fix: it
    prevents zero from ever reaching l2cap_seq_list_init() on the
    normal config path.

  * l2cap_seq_list_init(): return -EINVAL on size == 0 as a
    defence-in-depth check for any current or future caller that
    might pass an unclamped value.  The existing error-propagation
    in l2cap_ertm_init() and its callers already tears the channel
    down on error, so the peer simply loses the ERTM channel
    rather than silently corrupting an unmapped ZERO_SIZE_PTR
    allocation.

Related but distinct from commit 25f420a0d4cf ("Bluetooth: L2CAP:
Fix ERTM re-init and zero pdu_len infinite loop") which addressed
the sibling zero-value issue on the RFC max_pdu_size field.

Fixes: 3c588192b5e5 ("Bluetooth: Add the l2cap_seq_list structure for tracking frames")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 net/bluetooth/l2cap_core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 95c65fece39b..b2fe094263ca 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -323,6 +323,17 @@ static int l2cap_seq_list_init(struct l2cap_seq_list *seq_list, u16 size)
 {
 	size_t alloc_size, i;

+	/*
+	 * A peer may send an ERTM RFC option with txwin_size = 0, which
+	 * propagates here as size = 0.  roundup_pow_of_two(0) is
+	 * documented UB (see include/linux/log2.h) and produces a
+	 * semantically broken seq_list that silently drops every
+	 * retransmission slot.  Reject size = 0 explicitly so the caller
+	 * (l2cap_ertm_init) tears the channel down cleanly instead.
+	 */
+	if (!size)
+		return -EINVAL;
+
 	/* Allocated size is a power of 2 to map sequence numbers
 	 * (which may be up to 14 bits) in to a smaller array that is
 	 * sized for the negotiated ERTM transmit windows.
@@ -3593,6 +3604,17 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 			break;

 		case L2CAP_MODE_ERTM:
+			/*
+			 * Peer-supplied RFC txwin_size = 0 is out of spec
+			 * (Core Spec v5.3 Vol 3 Part A 5.4: ERTM tx window
+			 * range is 1..63, or 1..0x3fff with EWS).  Clamp up
+			 * to the default window so the subsequent
+			 * l2cap_seq_list_init(remote_tx_win) does not
+			 * receive a zero size.
+			 */
+			if (!rfc.txwin_size)
+				rfc.txwin_size = L2CAP_DEFAULT_TX_WINDOW;
+
 			if (!test_bit(CONF_EWS_RECV, &chan->conf_state))
 				chan->remote_tx_win = rfc.txwin_size;
 			else
--
2.53.0

