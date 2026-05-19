Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0677331A6E
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779190808; cv=none; b=VvoqYs2rwrPp8OvwYqWJ+Etyr6Djv44WqGhEvSyfyn9PLjtJeDHxliHm+l0W4cQwo27Zcvfs7Urw5d+1Vi6mhTVQC4bMKy8J7XgUdVJR0g+Sx2kqWmzylcXIyjCVybPntN7LhlZkXw8ulra9Z/Jscinme+jG2qB3XoqGp3fowIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779190808; c=relaxed/simple;
	bh=R6bzwjcPY7Dlop4izlpyAogJtn6NkwLAaPLqP8O5nN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W8aNl6j62eh1WFl97GFdpYlNJwHEwXBv2u9ieMooLoLhOvYiKHiR/WtpHNkXEgTkXVuPIj0+68CENO/0SJT3baSAeDMnjqbAc3tvzaifMT/jIJeLaQEt//+vdtOPCJKI1u/fn9XTjb0BC3vc32aSEjh/tSckTa0FOKwiyrzSSt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYCciwzz; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYCciwzz"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2ba4efedbeaso24639445ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 04:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779190806; x=1779795606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+OypCn+JO8PRm3jxeYI9/XzLV1zY0Bj5I0n+rdop0BA=;
        b=UYCciwzzyzByRDm/WRPbp/oSKel27VqxFvHmDHTzJY8Dw9cRjkx7vyHTUFIM72JriF
         S5zY+Ybr3Ek3hN03wCxgBnPr3OHmaJBA1B3AVmUj5TDMEAeZeHd9t22gXxJv7mOmxAV5
         lFJJXmoO3TNbcBgGTOw+lvWaDvQmOhiKb8W/SFDtKh3TA9Ie8qqLvXJATxqU+TbAbJzC
         FM5id9zL4PbW4cnACfLHBDV6WUDIwFM+ad+cPWy+SA5GqzrPO2VB6qX31Gp2YgwK7zZA
         2oFjxJEvfrag2gV54+B01DqJ7xwWe3ZzL85gBuH/ZL318/f+2ufXg5pIUAou32bccnwq
         kCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779190806; x=1779795606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OypCn+JO8PRm3jxeYI9/XzLV1zY0Bj5I0n+rdop0BA=;
        b=BRuwvQZG4uioRfwd9TGV+og0YjTYnLf5W5/4NXNmUdR2ZKY4j8hSl073S/uI2TW3DZ
         2MBozXbzWeHxeRsLcaf3FUkpkNwaO85ALlW4Y6GdLnkF8JtO1wsKBJzgUvoXshvL9/i7
         UTOLLkDMx9fwIDEHLhPq++jC3nxKYnI/tJLN5HqjtdhS5tH/WUP+dbuep4VxG1GHyuZO
         z5dwTJ4K0o4e9oKImf9uigP4JGpIw1LyFpOWlNEVOUGvWoaXuaxuSvuW89/2KObGBOoe
         lImHr2lgFCksUUqkv1QRdXAnvV0xKVygLBCTUeXlcfY7VrBI/A+a+0nrWF7e3l91ftHe
         CGMg==
X-Gm-Message-State: AOJu0YxhFaueMnkS8RvLlQpDEtp7BswOjoAPWzcP+nf0C6w/pX7+qcQL
	MOgh+DTIll32q6pkyAsbw0NdHdCP0WNNsUIqzgVpGv6FnS2u5GZNmpwQ
X-Gm-Gg: Acq92OFrReK3tJ5lZ1Xyy/qatKSpgiwHxb2BCE0kJc9LUZRsVlgiCq7Cxq18sNRxKYX
	AuF6FzxatYYnOzgVg2dBL4pfKgE0OzRt8d0QeQsDqMbUnTfpmxAINIIzQdgepL2WnHMnk6stuRZ
	CGULE0Omd1iEUWL54y5LfuKnnq8AdHH9Bf65ya0rmr0X8jRTDUR3wFls2irS/YpoLz3SnADxpO5
	7fGKvAJ4MFgsqvVTFmYeKJr5snI1Lwjppu5wVCXfAak2dnfTdG3a2fkvmZ7rE+cII/or0TUTaFv
	ORg9T8OPuN575wdDdIBvWSEuSv1aWT6z1r188KWD+wjFU3mlpXfgL+7Ws14sKTzLMWztq4j4ZTz
	Vbn000zG0L7KwRze8VhDBa2yQWC9b40lXLpQsw13qO1g6jsEWn0MZXiRMCmDCbeSNFyiCi3aRn2
	VlaeugMBiqmXjqmgAUQK3erWh718jIvy4=
X-Received: by 2002:a17:903:8cf:b0:2b0:4fb6:85ce with SMTP id d9443c01a7336-2bd7e8c570cmr135964455ad.21.1779190806059;
        Tue, 19 May 2026 04:40:06 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d235e04sm188907075ad.80.2026.05.19.04.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:40:05 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zerocling0077@gmail.com,
	2045gemini@gmail.com,
	Zhang Cen <rollkingzzc@gmail.com>
Subject: [PATCH v3] Bluetooth: bnep: reject short frames before parsing
Date: Tue, 19 May 2026 19:39:43 +0800
Message-Id: <20260519113943.3656062-1-rollkingzzc@gmail.com>
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

KASAN report as below:
BUG: KASAN: slab-out-of-bounds in bnep_rx_frame.isra.0+0x130c/0x1790
Read of size 1 at addr ffff88800c0f7909
The buggy address belongs to the object at ffff88800c0f7908 which belongs
to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of allocated 1-byte
region [ffff88800c0f7908, ffff88800c0f7909)
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
v3:
Use skb_pull_data() with NULL checks in bnep_rx_frame() instead of direct skb->len guards before fixed header dereferences.

 net/bluetooth/bnep/core.c | 51 ++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 853c8d7644b55..de9c872e2c9cb 100644
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
