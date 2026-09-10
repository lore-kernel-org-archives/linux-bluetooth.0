Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBFD367B8F
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789072281; cv=pass; b=ubucMQxO4syxdYCaF3qOWWG7/lHr4kCbR34oq72ouZWLYqi6PbR/wMlcQe6dP/GNnY5RGyJ1tiyZCNXbvBktVow7UhW+EIZ6KvL9rsdd3taaOnTIAGpI2y0CZxoF+ejJ4QpR0OREDz3PevkG0G4zXp+gVARXstZ+BoT9nso1PuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789072281; c=relaxed/simple;
	bh=HnpGtnRbnZM4AM/ENNwGiaWU5/n9HHmzlea3vnt2Eao=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=Yr8kBetCB9FFmKv2uMOEvjLtAMzRGKJrn7IoCmu85+36aiQCQupN98ElmzD7sjO5sfSdSG9ndDdUjUgnGtdWg3//TUViTbPCnFIMKZuvX+VcffCC8Bwgbgxd3uTFQch0OCG0O6MMXsiRQJs9d3fodwX2OZKQRe1R0+diBENQlCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=gWBo/ZXP; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="gWBo/ZXP"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-86b32af25f6so105129b3a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 13:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789072277; cv=none;
        d=google.com; s=arc-20260327;
        b=ZsEAHUhxYVwbBukQgvb+WCdIqJ3/IyOw8wvgcb7npKSJDQPgwo82fg4XbkOF4/wnzr
         Gu2ShZ+CeaGNl3olpupu7NL5qxgP7vky9QCLCZJSvSwncIilollrphcm0Co+BatogKIr
         78E1sRDOC72WVC2PHq38La2A2Da7jzXqyS501KuQH1dGZBX/FmF7aaoWSVfPm3n6WRcx
         VfDikWu4GgbwNuM2ZRqJYpjz9GQqMQPNkWCiU6fZOw+TP/0Z64R8mQ19D7bLLHTj6KAY
         C/Oe/gr4mko3BFsYfvOSFSF7w25az4h3IXTyja7cKCu6dvjIB71RPRymawPnHcEVSKCj
         Qkkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=maCUZCHQL/0Dung/jQglQrSJpIrbe49RGrAjwhWAl9E=;
        fh=CjqonSLD0bLsgnxZ2RT649oP+w6nuRMQFhTBJh8omtw=;
        b=lF+vP1fl+kWnM88YCNnqdrVrukb0v76u3rTwLbhZe1YBG8D+o7fzE/Fc1+rz3dvgFt
         3ruLXlqP2mNAILP+EBIIuxXJGJ47+9K4f7tLXBsNI0YSCj7vIgdV/V6/0/sP1Jx111CW
         CqhF9pQZtjcCmvgKCbw6rMyqsUmfGkj8cUFG9sP/vbLfZV9GiyYLOkKhooRayVzoTOQ+
         dT5/5idgF3UaElUs1ylwvPuJFoRvf4g21MF4A4h6rM/XMNxgV/EWZqjfwNFjzrapst6Y
         9iZGIQG93/Z3wyhq+wmy8tftRA18khvDXoqSeR4LX61PFhNrXGTH0r8W4kd2HLD6qJGW
         hxMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1789072277; x=1789677077; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=maCUZCHQL/0Dung/jQglQrSJpIrbe49RGrAjwhWAl9E=;
        b=gWBo/ZXPT4YZik/B+Jrmlb2U1l6J+wYXZZoaJDOG8Bn3Jgtf29X7Wyu43Adr3JDxrW
         veyxYkuPxigA0wYCWvFgvq1x9kg7uApW5OqFhijdUD/JNxROj6JZ+1FLUJS+HTOUQid6
         ke19X7blz4r5bqBC3IM41a8yXKRU2xlqMl0o/5SB7inuvrAu27CoXUCo6BP1kXXYh7zW
         x0JpnVCy20WRGC7GkoazdeuY/Mo2Y4b5EJlypHXHQyRE2mub+tE9qTwpNU6Pa8hgPUCs
         j3cNCEQL//dQnnCFSyXRsJ55hXPliYPCdeH6WDlXHKu9sUaALMSEJLpvmlfHD9+5inG/
         Xm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789072277; x=1789677077;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=maCUZCHQL/0Dung/jQglQrSJpIrbe49RGrAjwhWAl9E=;
        b=eq6Kv7BfmwJMlos3XYxQyfTT/Hz89wBhNj+QWo56SOWpJaJF9fSO2IptlmEO3N3wuA
         QCo2ZjQA9L4xlin3DAbxwaFNKz+mxxDEHIQcjgIaI6fcIO5SSpOa4tUxeOa320UcR3ZC
         KLpZFDMvjr7Dc1qaFaNgU0UvfpF0dR2yh70/q2NOjbWrqz9Y2KprLEWNYaQqKS0FTso9
         hikTx9DBquNa8p4u/xPVEQprYdE6ZoyxVwDGH/HBV/NSJHsSTDjZUJfJHaIhfFdmFmQJ
         7afH5dZdPs0VkUkJlhg8jU1IQUifC45N1TizrlVQ/0u3tNbxMEl8lu6GrZT1pjp5ZXIW
         aJMw==
X-Forwarded-Encrypted: i=1; AKwUvBzPzhdy3nGr9G8kmuM7/5z1wTTBkk7KObJPu6/Q9Il4BNnND2XHETuz5PAl6ro7lg0lZ8OZTPwknejrjGZ/a5s=@vger.kernel.org
X-Gm-Message-State: AFuF++lz2AsLN2S6jJY8knHtpKSWBdIHuEgUFFIoiLWRMzsMk0uCr9Jw
	MTSozct2Rrblln5w3M/O2nbvyMyBbmRahqtjKktRwE/xawcJXRobgePEk4oW+VGLmtDbWA2IcQw
	zjkWvnXwKpUwEqI7/W0nGZjORUCsbT6P5zwmDqrgP
X-Gm-Gg: AYBFou2ROwrLEA1kKPgHpJKxKU7ju38n6AAsRLydKXuMmbxxSQZ2CUBbVejery2EIas
	q2QRWDHZj3ptUV1R/3IZN8Gk1PuE4/5QrP3UB0L+2OG7A4dcZyRN+JH16K+dl65lbgG9gQGUV5S
	atXai8pzo3pzylYQzRpKx6aoYpCMpj32ruRreRhT53mPA6ENdS2t6MmdBfR7+mDicNukugbbxXa
	m78wxb10iJfu8FLZawVxu7eauc5ookkrIgIwFQo7J/RaBhEWmtjbH7Xiz7+A5EVAhPR7M9Xpn/P
	uiYAoUmJgut708l51pRwA4SodqRh98Gnw2urIlYGiLQyMUzftJkNYqfeKFTYX8fwDST+DJOvn0n
	kXx0DL8wF2/HyUQoNzBCYwRXKnyal9aLe2ffGaNNLLjQ=
X-Received: by 2002:a05:6a00:981:b0:861:2029:4f59 with SMTP id
 d2e1a72fcca58-86b2eaf0dd9mr981631b3a.3.1789072275873; Thu, 10 Sep 2026
 13:31:15 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 20:31:14 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 20:31:14 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 20:31:14 +0000
X-Gm-Features: AcwNN1VUXzs2Scd6J6vqkMNAsWPmubZx5Syf8DU19mCYgSWymDz_57w_RDyC_Fc
Message-ID: <CA+0ovCgMrVBnn+0d198i0th0bcr0EAwNZ=0juh1ug8DdJX5mPw@mail.gmail.com>
Subject: [PATCH] 6lowpan: do not compress headers that are not fully present
To: Alexander Aring <alex.aring@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Farhad Alemi <farhad.alemi@berkeley.edu>, falemi@asu.edu, 
	Simon Horman <horms@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

lowpan_header_compress() pays for the IPHC header it pushes by first
calling skb_pull(skb, sizeof(struct ipv6hdr)), but that pull is a no-op
when skb->len is shorter than an IPv6 header, so the unpaid skb_push() can
drive skb->data below skb->head and into skb_under_panic().
lowpan_nhc_check_compression() has the same missing length check,
committing to the next-header compression path without requiring the
nhc->nexthdrlen transport bytes that nhc->compress() reads and
lowpan_nhc_do_compression() then pulls.  Return -EINVAL from
lowpan_header_compress() when pskb_may_pull() cannot produce a full IPv6
header, and return -ENOENT from lowpan_nhc_check_compression() unless the
IPv6 header plus nhc->nexthdrlen bytes are present, so that the nexthdr
falls back to its inline encoding.

Closes: https://lore.kernel.org/all/CA+0ovCjTsygN76s2o=TZqPqW8v2gBhmRnz+q6G-NaB3Cq-YPqQ@mail.gmail.com/
Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>
---
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -1140,6 +1140,10 @@ int lowpan_header_compress(struct sk_buff *skb,
const struct net_device *dev,
 	if (skb->protocol != htons(ETH_P_IPV6))
 		return -EINVAL;

+	/* The IPHC header pushed below is paid for by pulling this header. */
+	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
+		return -EINVAL;
+
 	hdr = ipv6_hdr(skb);
 	hc_ptr = head + 2;

--- a/net/6lowpan/nhc.c
+++ b/net/6lowpan/nhc.c
@@ -47,7 +47,9 @@ int lowpan_nhc_check_compression(struct sk_buff *skb,
 	spin_lock_bh(&lowpan_nhc_lock);

 	nhc = lowpan_nexthdr_nhcs[hdr->nexthdr];
-	if (!(nhc && nhc->compress))
+	/* nhc->compress() reads and then pulls nexthdrlen transport bytes. */
+	if (!(nhc && nhc->compress) ||
+	    !pskb_may_pull(skb, sizeof(struct ipv6hdr) + nhc->nexthdrlen))
 		ret = -ENOENT;

 	spin_unlock_bh(&lowpan_nhc_lock);
