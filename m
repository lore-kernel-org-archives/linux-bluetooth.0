Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793176008;
	b=fUC8oBoa7Qz8r8/DGAUnhIy3jmEz1irjRXvfIADZonAaNEkzB5zHpyPV3fMRVhHxmS/r
	 sp0HwFzzsyprqnAWMDHqVrtLw5UYYA/FMq8Lso6ihau1guXIJl6wBbM9fhG4zquRgOXzC
	 fEXWOzPjtODDpg2w5y+3szi4L/RJAgAW8RWvjxRTeBqc8ott9xvEKLnwQPj/6VkK/f6Z8
	 cUA9nVkBYXNxPuZ4bRQoOdlE5vQJFrUrNj8g5v21cnJ7lsoRtMVN+nD8pb6/PdWjny6mb
	 /MwC+B8tngx1iGXnphiXQt8S5MtK2Hx3j21MfoR+Okhd1gUZ7aNQuXvAmJI9h+D2utg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=kR+s/cTnFgpKpBHHg68gPTY1OQns7nctEtkTAYaHSXc=;
	b=YAdLtd1qHBQVpYlOhm4HzdMWcbVflVHafbRd4kslg9GRtnEhJyF504zRXwApUJ/q3MXe
	 H7qPOo50c9xYYDI0j617W2Xp9WBmikSieW8mm6m4X+gpY+sy5yIk6SvYJV8xok4B2LdNb
	 UsAfNSNQdVFX9nVCEbULl0iCQrHzki4BB2ZoHxY+FrUA8Zs3HyFwDpGIxjq9wE4YEDcuc
	 OAihTokSKKx5zuPAcHkcpOHeLgGQvSqQNCddToAmI/uie4lRd1fXIFj5gQ42Z8ea0RA2G
	 1AVJ0LVJvy3BnsD2i7OeYNJIPZtqX94KeqEiMcGeL4M3SFduK8a8kJBoBrKisHd97Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SvxPU0Vo;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9E4606A31F
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 08:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F9E4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SvxPU0Vo
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6dd059478dcso571006eaf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 01:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793176007; x=1793780807; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kR+s/cTnFgpKpBHHg68gPTY1OQns7nctEtkTAYaHSXc=;
        b=SvxPU0Vo6PrqPgLbJvTuWAB0+v+0cbxDqRpmax1reA95NOi92tJAO2Eh13xfArQWYn
         uSLb2OGytsHAAvkcwMqyI1d83IM6Em1AZ32NBiMdpVqhFWEaUS01jHTIbKa6MfdwDgL/
         1vkSK6jvCYyggRAlnzh1Uj5CQm3uA0vNb6vg4ClBv2Jf+rvueKDdK0uPGSOCQxMqwY6U
         2HApGvwGRQFXQm4YmfTLnhXWd6Ffr2dMQokJI/+Ea/mQakT1chh0t66qEsISL96v5+Pz
         0Fsl2zslImG9pPQoFnqPXiTEcfjajMTbBJ3TaINE6SO6eMn2RYBKOzm8hQyaVLxrUDGT
         bPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793176007; x=1793780807;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kR+s/cTnFgpKpBHHg68gPTY1OQns7nctEtkTAYaHSXc=;
        b=wnf5RMq7ahwjfgtiYGPXRXAgnJn9nUdb1VfqHc1IcQm1SmTOyXNTjFDgGhtNFWJqOT
         iFK13kFUbx69KSLzjmOVVJZwWNMbMVX+BHBnjaCq/yjcGCJBecNRNF41uyL2mxWR+fTx
         3DWLpalaBQ0bUUIUPUIFo5/fx01LmlRRNi2gmVeuGqIwsBWc6sGBe9Sc1cpZFxQJv1Dd
         8ZvzzGCBclYLPCHPhv/TJYxoxj6WSZ418wvPtB7ZsznD0ZFhsYDhceBkAN/OxNZ3qF90
         yMrM7dS3Ouz1pPGVSOuNRsQomw3Ubm/llClHOCPGe7M/5kBVCBRrHMm+KmhqKkvvJ+KP
         NcBg==
X-Gm-Message-State: AFq9FYJn7CycVzZCZj3VbKZuc3w6h/IJGJUmrUG6BEcALBKEalNeRyqI
	mb7811X5h0f2etFfFutuN2I/oituu+/014GcMzw9LRbrIBlOZ5i6JxCVODUHFA==
X-Gm-Gg: AYBFou16D4rUCvXt2Xti95R/wiw+RgvQp7DAxxQ1r+bw989TZ00fs+Ik4wO5ggCy3vl
	SwEbR8yIqguPJPkOJuUoSuYHSLxqS4D+7R6xJSJfTN1iA1YYZ/Il7fekCIHExcAJdTEPNyKZ4fs
	2zvWjvsZy5o1BUSHCg8JRDR/ORLTLsf0363jy2Rp4n5WQEMPAq4Tj/npwzNb4TtXh0ZkZ3NZHtT
	FEG7JITBVwN3KAhKxkbMpnxEFv2Di1EZuq7yXvzO/JxWQdl+xFE+2LIlGy+Y+Vc/xLn9xXoH8Qv
	P9BWwSvLbgYQnV+JqTjR9c127dqtInXOKBbtk6Dh2HpRH5XugkfP+35rIlGv/ECvSOEr9ia+WSd
	lPpsdacGFU/Uk6EVXI/1kGmc/YL/RjXf2s/hPV+X7eup2DI6UE1ES3MThLWgF9bJBAv5Oa857Nn
	qhkUeyR7dvQx7FqLu0dTNfw8haVn/fApgokd/MvI4i1YG9wxnXKficXsmYA9WnURD2/lev809kD
	8fs/h1x7E2MgCGH0FQUcE+mRX/L2o0U+s+d+uKE4S064FKhzwkczRmPGP5lKhf0Hg==
X-Received: by 2002:a05:6820:4812:b0:6d9:a810:9c3b with SMTP id 006d021491bc7-713ed6c1a79mr822265eaf.20.1793176007006;
        Wed, 28 Oct 2026 01:26:47 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.136.241])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7142bb765a3sm950611eaf.4.2026.10.28.01.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 01:26:46 -0700 (PDT)
Message-ID: <6ae1b1c6.3a67f976.21c646.a319@mx.google.com>
Date: Wed, 28 Oct 2026 01:26:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6033999913109712210=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC] asha: use robust streaming connection parameters
In-Reply-To: <20261013035111.522738-1-cochcoder@proton.me>
References: <20261013035111.522738-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6033999913109712210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [RFC] asha: use robust streaming connection parameters
   Pull Request: https://github.com/bluez/bluez/pull/2667
   Created:      2026-10-13 04:00:24+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============6033999913109712210==--
