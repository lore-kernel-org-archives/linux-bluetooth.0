Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80009417BE5
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488202; cv=none; b=WinhSSIu2ZcTZfM0MTjZ3J07vuKRXXgFCCowC9JGYmfUIfx7q3eOubf1FK+rVOp+CCKfwx3sh20nGjuvzamULyvGXpCSuR9hjyGtkcNz58CwnXrIiLC3ATkgmAih5RS7RYP8JtYSki1B+j0awJ1f/cYRc/9zqpo+My5iBgKS/SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488202; c=relaxed/simple;
	bh=MDx1/NX+bEC+aezbHbNquhfyK8DKjxbfewpr5X2JZIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T9ulTfa6KaFzIOfZfE7g+pyuH3DFlTHjtYsEWr5OiZPDmmdYwxh1lcybyiVGFVyGIfwrB6OYAFmyjMowGWvrA7iKE8MXGCmYs7E5t3NIn/uiyG+J395z/McapvheDGbBSu1LEchb4uRNeeZapkzQXdK9qjdMyE09SVxyICqE8yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjuDeQ1B; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjuDeQ1B"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c8c0754so620970241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 09:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789488200; x=1790093000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=npO8t2qXgFPBX9kJDOsnq7lsoV93cjjCTUdlKsebcTA=;
        b=ZjuDeQ1B9YE9OjsIb+z8P3aEKa7MsWAxJ5gAaX+3hfqap3bxgPA8Nt+jCDbuGTchdg
         7E1fUtE7mSYTvqe9HF+rceqTa6YXet0d47upBvIxO6FRfyDbd4tlfsHaHGUygzPANnZG
         bQ4Wqv+DV0bEu/EYkVcsWj8M4w1f0YANGPGm3HWBiM0c+aTfwVIittocKp9SFsy1cFS9
         4s0hp1f3lgjW8SnaBPygw9iJulc7dH4RJ3BiXzQbMy8Mu9KBDNnlB5aloCMnZxabtPfw
         kXzlN8KdvMeyZWFIiBSDJ0LD9nO2kRcoKw2aHONWhUdnCVcjtwcynAITt+QFvAOdEIce
         ijOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488200; x=1790093000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=npO8t2qXgFPBX9kJDOsnq7lsoV93cjjCTUdlKsebcTA=;
        b=ce7DiLrbk9s3i8DmJRb8ufDuOEwWl8duHzwc7GSSkuIFgtT1R68UC4lje23fM4tCAU
         gcjnlm7YRUAiRO78RMvuiPNnMFriyXYItDd3mFG30vqYdUUxWxV5E87Lq3vPLsmM0W5g
         sFu7rpEZzFQRTquxA8ZWdCT9lVjBRbhPuv5VMIExsIMKSw9Fp+YM9i0GtJ+ZKtZ/d3o3
         JpbWYyWfd4dlgyjfIz2aouFDy2aMWwhdVwXDf18uHRXyy6JU5EbwDF0ggLFoc+26qwqf
         Z/PstsEPRw1eBRH+p9BZAjwJZKZwGvJzPtp7bOrvhZ6GHG2FC1kI75xM0z/ug19EmLB7
         HoRw==
X-Gm-Message-State: AFuF++mL9kg8c4rVO7fusep9HA/x/3cgdJiPXb68YMnXg1CgyLgFRK3D
	5W97MszcoNza4+cx/2eVx7s9XzYLJ7e9Zbs7yc4MhQoXUB9mtVdOGLF5
X-Gm-Gg: AYBFou2A30yvG+mWrgC2P1xEBaiWME9Lor/9JK22baF1HnPvb4wyEYfeBUWTbMcAPeD
	BbTOl8lzIFvA8cl4CCzPlAJkOWvTu8kPlGZJvkESxGvMI1k+EFHro+sugkqSlY+N7ShUpy8hgiW
	gMUc/xuzl6VHwu+MrG3Ap7SCyz6HWm8K2eymVJwQ0a9kl/bQ5wpYjKwslWOlD+h+ohs2H9I7uCk
	omqbIPJbL3K337bIWm3YpUGgGRq7bWHbxy+bk51KHp5zx4kaaFkMtFCnDxz++E3V7PowTx7yyXA
	kwkaglRmvvA2j3IwZddyqud2d5Ufil5iP5Y/6FKZwaHWXORxpcyh4snP/P5ZmZe7JVJD85WKbqT
	+VerQQ3ZLesQarpofxTH2x29HbhFxWoFo7yj7qYPjQbUn5hRcIc9o4VBFABzLR66N+Bgk9FHkRD
	cMhfvpqSb+5PwRL4fF9jfj4zdPo824iBpE7LSfk9rGMxL/jaS9PoZNrR3XJOflAhCZ
X-Received: by 2002:a05:6102:e0d:b0:786:a11e:484d with SMTP id ada2fe7eead31-79d253fbca6mr2368663137.6.1789488200228;
        Tue, 15 Sep 2026 09:03:20 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-79fb2fd68f7sm76158137.12.2026.09.15.09.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:03:20 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] Bluetooth: hci_sock: validate event length before filtering
Date: Tue, 15 Sep 2026 13:03:07 -0300
Message-ID: <20260915160307.3106955-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

is_filtered_packet() reads the event code from skb->data[0] without first
checking that the skb is nonempty. When an opcode filter is configured,
it also reads the command opcode at offsets 3 or 4 without checking that
a Command Complete or Command Status event is long enough.

hci_send_to_sock() invokes the filter before hci_event_packet() validates
the event header. A malformed event supplied by a controller or a vhci
device can therefore cause an out-of-bounds read.

Keep the unmasked event code for the opcode checks. The masked value is
needed for the 64-bit event bitmap, but using it to identify command events
aliases event codes above 0x3f. In particular, Synchronous Train Complete
(0x4f) was treated as Command Status (0x0f) even though its payload has no
opcode.

Reject actual command events that are too short for the field being
inspected. A truncated command event cannot match a configured opcode.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 net/bluetooth/hci_sock.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 070ca388f..f6406dcec 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -164,6 +164,7 @@ static bool is_filtered_packet(struct sock *sk, struct sk_buff *skb)
 {
 	struct hci_filter *flt;
 	int flt_type, flt_event;
+	u8 event;
 
 	/* Apply filter */
 	flt = &hci_pi(sk)->filter;
@@ -177,7 +178,11 @@ static bool is_filtered_packet(struct sock *sk, struct sk_buff *skb)
 	if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT)
 		return false;
 
-	flt_event = (*(__u8 *)skb->data & HCI_FLT_EVENT_BITS);
+	if (skb->len < 1)
+		return true;
+
+	event = *(__u8 *)skb->data;
+	flt_event = event & HCI_FLT_EVENT_BITS;
 
 	if (!hci_test_bit(flt_event, &flt->event_mask))
 		return true;
@@ -186,11 +191,17 @@ static bool is_filtered_packet(struct sock *sk, struct sk_buff *skb)
 	if (!flt->opcode)
 		return false;
 
-	if (flt_event == HCI_EV_CMD_COMPLETE &&
+	if (event == HCI_EV_CMD_COMPLETE && skb->len < 5)
+		return true;
+
+	if (event == HCI_EV_CMD_COMPLETE &&
 	    flt->opcode != get_unaligned((__le16 *)(skb->data + 3)))
 		return true;
 
-	if (flt_event == HCI_EV_CMD_STATUS &&
+	if (event == HCI_EV_CMD_STATUS && skb->len < 6)
+		return true;
+
+	if (event == HCI_EV_CMD_STATUS &&
 	    flt->opcode != get_unaligned((__le16 *)(skb->data + 4)))
 		return true;
 
-- 
2.43.0

