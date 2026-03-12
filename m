Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18332D0606
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 20:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346968; cv=none; b=W869t0Z3h30N+16ehxs6wW20BeRhJDTMr9uTPhZmxRvwdn6OkcyQRQJYjX5EfcUNjqBXtqO/AQ8Lum8Ubi3mdz2eYjkNDslSVDbs3qYA+qEBLglnQFhzHV9OA1ysRV8PHBkms0DMXWDG9ijQMj316MVWMVG6AEtjYMc1QtO0uqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346968; c=relaxed/simple;
	bh=PALw+RsUvseFXK8bDSOvu3vRR43BIIQxuHBdh7jogkM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=noZKOScrh+lybDIBr7bJUUSGCzBuv8yTPHcBMJw031dPtVUNrkL0TJNjdHGcLkK1vAxZzy9m80GDAenTk3x74tzEkc077am8Hj9D5hN+IA4p10q3b+KXobVt/+ti/W+pxzjPrcz/pYN1NjzdpWzaXN7694gnx3pOgV1ZRju3qn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8wy830m; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8wy830m"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35a1cc6e478so517768a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 13:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773346967; x=1773951767; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k0ehV1Qoh9Yp06WNOEL1qOwM57CbfXDL/0ea1jm3g3U=;
        b=V8wy830mwBAhgeBgvZ7+wYmy6/IQbbLdINM8F4RkAWz3SzDCtFEs3MkP3Nn0z3EMnR
         RSynXpM52MhFxjkwSdPjnBjOwkK/OCbyystqlnEkd1HFsTLQxidhyUbQLwueVeFj9Wzf
         caks65LNvRQShXZlYqotgVSlOC6JOcAXUKx7iSziWHasSLpaFo5QNAHZi4kq0aV2+jKk
         YR8KhDze+xdDyaHQEiOJ6crnnTou+KkcpUBffEl3rYLbdbNgQmjLsnkmOhtAwQHCAQFq
         KuVhHtPv6tpVvqS/Vo+1vNYPnXpJqf0wd/NqEaoJ665IJ9sJPzjAj2iY7sGsiJAvIQ1W
         wM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773346967; x=1773951767;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0ehV1Qoh9Yp06WNOEL1qOwM57CbfXDL/0ea1jm3g3U=;
        b=FxTisXY3bhdgUz/143WmBrUBvbmz60+ZaadiRWIveIrTM9VK0Rau/g1rCes+SMgyIM
         +fCiLGqTZhqBy31rWBR66wvq4AoRcZVSzwtcr/Sye8GhMBjsogjDvpcReM9VyYcgtfXJ
         38HMEhVLCEx5KE8s3B2daPRN+nJuichcUG2kBsGilUNN1YYZOtOCOhk83+WwAZ+CHnue
         bvuwlwbmhhV7HFxwEDFkVNBSyiVVHI5nu2Cxrb0Oh9JhnwENW4rnMZ5sszMigIJTWRNN
         4DenwS2/f6L139p6dOpFUteuXKYZap3Stas8JAxWwcDbvLzM2L+Q94wJmyFsvDyXWfEL
         K02w==
X-Gm-Message-State: AOJu0YzUBviskf8xoS4qQvPjvb37VRk5bROEBc0dQbLvUy3sT+LrBNTn
	5HK+TLB3yDJ9+wb2tWyffZs37lTuvh3txNbaH9mgKdebKyk3vL1GwCxE
X-Gm-Gg: ATEYQzzx7BPoaGGDJqqsl8MOSCav2Xz00IyrhbRFlgZIizIyhv+SYu11gPIOx2EUKXn
	BjNzfPI3tzveZErdgKBbCgc8iHHMvc2VBsM05C8brY4dMABIKxiCjhX5DjsgZzDHlxLGI1DL+/4
	ZUrC99y+wFgQGNe3UX/ALw00RyZPGVOG7IOyVE8R1lLqmA950QZuyhGg1L/TbcsRzBP1/bN0V5n
	jnDDakJLtmOKZ4uSWe9eXs0WaPunJoxiBE7L4A0/BOqgMMFalo2dp9N+8krLgoJd/bcSzswuSTI
	pPYhmYERd8cJZ8TEw0BWYwqrkBdn8u7PcsTy0Uo4G+FzI3hwVDZLxEM8m0tdEDPcsBwXck2l/Ru
	Kd84lu6wnBwBO0GGHC/C/Nqj2eV9lOFwMjKAY3Z6zu7faoKY0mfsq07k+6rzAJ62gA5XZIot9mA
	8C5ELNYRT1p7TsBcqq+5c+tpRroj2vehyMtzZKsSYc3g==
X-Received: by 2002:a17:90b:1f8c:b0:359:8d70:c4e6 with SMTP id 98e67ed59e1d1-35a21e485e2mr782169a91.1.1773346967136;
        Thu, 12 Mar 2026 13:22:47 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359f05ee478sm10478230a91.2.2026.03.12.13.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 13:22:45 -0700 (PDT)
Date: Fri, 13 Mar 2026 05:22:39 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: marcel@holtmann.org, johan.hedberg@intel.com, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH] Bluetooth: L2CAP: Validate PDU length before reading SDU
 length in l2cap_ecred_data_rcv()
Message-ID: <abMgjwF9IdkNhmpF@v4bel>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

l2cap_ecred_data_rcv() reads the SDU length field from skb->data using
get_unaligned_le16() without first verifying that skb contains at least
L2CAP_SDULEN_SIZE (2) bytes. When skb->len is less than 2, this reads
past the valid data in the skb.

The ERTM reassembly path correctly calls pskb_may_pull() before reading
the SDU length (l2cap_reassemble_sdu, L2CAP_SAR_START case). Apply the
same validation to the Enhanced Credit Based Flow Control data path.

Fixes: aac23bf63659 ("Bluetooth: Implement LE L2CAP reassembly")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/bluetooth/l2cap_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ad98db9632fd..99e9aa104507 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6682,6 +6682,11 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 	if (!chan->sdu) {
 		u16 sdu_len;
 
+		if (!pskb_may_pull(skb, L2CAP_SDULEN_SIZE)) {
+			err = -EINVAL;
+			goto failed;
+		}
+
 		sdu_len = get_unaligned_le16(skb->data);
 		skb_pull(skb, L2CAP_SDULEN_SIZE);
 
-- 
2.43.0

