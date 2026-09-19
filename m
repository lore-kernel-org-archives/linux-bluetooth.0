Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D93472795
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789817119; cv=none; b=ASli4x1cKC0hHwW8FlTHxjtW364AZNAy6LRtlYhbSxxPJrSH7+vPWS80bL1XIpimovY9xWF6521E05ipBXWcRGb1A6ivCxjOIdkCJbyKIRdBWI/nHE49UMwxMmQ4Iaspb6WSfoK0vdRAI2anejmzsm/+l/mgTJFJn4EyiIAFYJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789817119; c=relaxed/simple;
	bh=dJJB6/BdV7/ypHadf92Y/zPWc61GpbUUbHljnw4SybU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCy/JYNZGb6dviNw6jBKDeYBAjMnywGombti9/DAll5RxJj+WF280ZKO63BLOXI7rtDjOTAAwHYQQhxvGax9e+9aRIucH20QR1LSTDm25h6I4gIi97mzaymjEw4Xpd3jqW2Y9YT0F3WkiK3Sk5IRfzNoGqq0Oz/kqPFhn66EaYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foSqugei; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foSqugei"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd78e6eso606728a91.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 04:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789817117; x=1790421917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jHGttpk3OiKS8m1dDVvKx2gO19FWdtH1Vw9wND10/ZI=;
        b=foSqugeixIsmafnl0j5O3dGNpNi12xdNls3J9bD40WCOZCrPvPArhKW/jhpWxI/AFi
         Yp4YO4EskLf3lGfmhpzv0D8xlk/iNztO+5d9ECwDMz0gj00XM/mEQfTIKr3GNQcu2W/j
         SrhKdfMQ+2uy5mLU6Wpxc3qRpZI+q4i/YvXOQSWvcO8tG4LVIOV9pF2e/Nd9Srt33OKP
         8pyWCAH1xRmZt3WZTF19PCecjW8rUaGua+DDqngVvBI0g19SakYufc0/Lde+ktcGBhkF
         QJshOsHGXgrIN9HyeDiXB90UtNxgalxl3pnKn2fTRiTdaQ0Q6KNENcnzd82J+SKGh5hc
         CZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789817117; x=1790421917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jHGttpk3OiKS8m1dDVvKx2gO19FWdtH1Vw9wND10/ZI=;
        b=L1nk5iO7qLuHuCV4H3ylZGtn6ibaEXJTTK6sGBSZafVkpARvoK8VDhFduSjCqX7c5U
         BjWIqFDfVw/gWu8E9+GXo1uBcy1V8VPR52eS5dAq1NZnx88YNcNbxMng9tqN04zsATrP
         oFH180ppfb1CZWoOFD0dsRwrEvPkbgz3cGtTA+efrrcBaPgA+2n2x5422KuffQUkMiLD
         PFGFliYw5in91rleDG7j6BpQUJ9EeYuC2rQXTewoxYC2G5wBW/FHAIab7foWT6wEwA1R
         Pt93S4fV4dhrgIkdG6XQ87cwnCf8nT2hOqgrexJZpnmXQeuNFwC2RbLLMkwV5llN2LNr
         kDDQ==
X-Gm-Message-State: AFuF++kJbCszvVkYoPP+A5GIH8PdRI6d3Rjg08tYt/RSMaOmmNbXBSkF
	4gQWSeGnouRyyQ4WLATmj9JWz8bagyZIt66aDDKIFVnjh5nKD5JzTyrf
X-Gm-Gg: AYBFou2neA+6M0GBY0j9vlZBBtTF1OsD5UM4eQIrf0gRpcLjg6R0PZoLNNl5jypt/fb
	pK0LiMhiioUPpJiYCscdDBtVV44/ugSAV4wcukJbdQ7wWg9NfAODie6lRpNU3NlY0oMetfTt+6o
	E0r6j8FRN8yP97P8rc6LOHDR8Jl1JHmPt8xj3N1dtqJZw0L/v6ZLiyfCeudgaFEvYx3OWpq319M
	V1e1uOH0wAJ6rcZm6xYfJzZPi8VH1hIPM+GfF4tMsR61X3bv/Gk1G1lnFMhu30rDu40GGpByk6S
	mYx2ExSMGO7tP+CCBrR+fdCjKr8Hi55lS9/B8Dv6W/oQee3JKRvqJsdkgBPDxphXOwm2S4G1SgR
	a3KBekXcK7QYoS99cR7SYBZ67vgN4W7gnnog+Ch7Nfr2TvOe1drbTprvBK1/pLF1VLcFRCs5kgn
	LrQRxBwjT8EiHYrL0InsCJ6KTxydc4V8DpLVYIA1vbuVF/R3/hRvSXh+wTy1zfXqrw62Sh36zx9
	7iCbJJZRB0mfcRCo8Q1ECkrup5NU3JvqK8kxQqj2BePi53ItHxTF0VQHyBrJ0glgu2SWshBnvjn
	VhNT+mTHVg==
X-Received: by 2002:a17:90b:57d0:b0:39e:4c7e:bc3 with SMTP id 98e67ed59e1d1-39e556e00c5mr5825456a91.17.1789817116925;
        Sat, 19 Sep 2026 04:25:16 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cb400c3sm4207228a91.17.2026.09.19.04.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 04:25:16 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: RFCOMM: Reject short EA=0 frames in rfcomm_recv_frame()
Date: Sat, 19 Sep 2026 11:25:14 +0000
Message-ID: <20260919112514.3871857-1-benquike@gmail.com>
In-Reply-To: <20260918075829.2203887-1-benquike@gmail.com>
References: <20260918075829.2203887-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While rfcomm_recv_frame() verifies that skb->len is at least
sizeof(*hdr) + 1 (4 bytes: 3-byte header + 1-byte FCS), an RFCOMM frame
with an extended 2-byte length field (!__test_ea(hdr->len)) has a 4-byte
header plus a 1-byte FCS (5 bytes minimum, sizeof(*hdr) + 2).

When a 4-byte RFCOMM frame with EA == 0 arrives:
1. The initial skb->len < sizeof(*hdr) + 1 check passes (4 < 4 is false).
2. Trimming the FCS byte decrements skb->len to 3.
3. If __check_fcs() succeeds, skb_pull(skb, 4) fails (4 > 3) and returns
   NULL without advancing skb->data.
4. Because the return value of skb_pull() is ignored, the un-pulled
   3-byte struct rfcomm_hdr remains at skb->data and is either queued as
   application payload via rfcomm_recv_data() or parsed as a multiplexer
   control command via rfcomm_recv_mcc() on DLCI 0.

Fix this by extending the length check in rfcomm_recv_frame() to also
require skb->len >= sizeof(*hdr) + 2 when !__test_ea(hdr->len).

Fixes: b230e5bf501c ("Bluetooth: RFCOMM: validate skb length in rfcomm_recv_frame")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
v2: Add a Fixes: tag, and add the Assisted-by: LLM tag that v1 was
missing - apologies, v1 predated my reading of
Documentation/process/coding-assistants.rst.

The tag points at b230e5bf501c ("Bluetooth: RFCOMM: validate skb length
in rfcomm_recv_frame"), which added the skb->len < sizeof(*hdr) + 1
bound that this patch widens. Its changelog justifies the bound as "the
minimum frame must have a 3-byte header and a 1-byte FCS", which holds
only for EA=1; an EA=0 frame has a 4-byte header plus the FCS.

To be upfront: b230e5bf501c is not where the underlying exposure began.
Before it there was no length check at all, so a 4-byte EA=0 frame
already reached skb_pull(skb, 4) with skb->len == 3 and the ignored
return value already left the un-pulled header to be parsed. That goes
back to the initial Bluetooth stack import, 1da177e4c3f4
("Linux-2.6.12-rc2"). I have tagged b230e5bf501c instead because it is
the commit that introduced the insufficient bound this patch corrects,
and because the single line of context this hunk relies on does not
exist in any tree older than v7.2 - pointing stable at 2.6.12 would be
actively unhelpful.

 net/bluetooth/rfcomm/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index f7463f092..d91e2a6ee 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1817,7 +1817,8 @@ static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 		return s;
 	}
 
-	if (skb->len < sizeof(*hdr) + 1) {
+	if (skb->len < sizeof(*hdr) + 1 ||
+	    (!__test_ea(hdr->len) && skb->len < sizeof(*hdr) + 2)) {
 		kfree_skb(skb);
 		return s;
 	}
-- 
2.55.0.1082.g2b9226bbc0-goog
