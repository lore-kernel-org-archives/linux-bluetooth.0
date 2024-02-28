Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFCD15959D
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140730; cv=none; b=u42C87xDFHBdbIabTZ6i0g5mhTpYbT0aVjqDlqLqVNc9P6XLgKuaQ9t8q6GXvA7MxEzdNOOEqsBmrc3Cu3ASdeMjy+F8bA6g8Pe1nMm5ImwieB7NTscw1gyFfNxuI/Nh3DtdEL/Ld2u2A3244n7okM7SMhT3IwuXVQdlsOlEMRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140730; c=relaxed/simple;
	bh=2HKvMexvKFoNQstf/71BaHmiEo2WU807DAkK3Kg+aE0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0bNUqdXaPczQ1t1zrsVFjvhsppNmmcykKU2uLrllDKH4ivazTTJVXY3z8xJdXi629+yP8ZSc1jQiub/CcftNyUY8zjRI2WhY/OdEqXw5CRt23ageEJhzia9FD/W+9wLS+K6abcQoqetybg1VCJPpokIuLjFkapRFzCP05NiD8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+x4NZPS; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+x4NZPS"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bbbc6e51d0so4269538b6e.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 09:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709140726; x=1709745526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7FdQ/F9u1vxZ6LbXnNQ7tOCZeaJWzRFvAytp5d8wUQ=;
        b=i+x4NZPSccU1VJyltzPjGJShFAHbqghcaX/qU+9O8fjLWXsiXn3wkg8dKfiKN2Mwi1
         cZEiQfXClwy+nGWFb7Yr+v30dMnYfTyWzFZbZ+Dfba1++kpzNVh+x/MN+hW+i0Iq7ECn
         9WGQ+7Q0ISfeEDKvvP8jNaG8CUifyMKr2QTqd82VXWQz7xh8K2LnGYVHq/3ENrcB9Pf0
         HBl93ZDBT7eA6QpnZ597ExWZ6ajlrzuwF5wAluBebH7wqhxYbmp+j2MDDs9lLTAmZ/or
         pGyQCkf+NL0m7JVnXpF1QJ2E/YPkJR44PlrKGrdMhhpEp3wGFXp9b0l7latLeDM6xVDB
         lTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709140726; x=1709745526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7FdQ/F9u1vxZ6LbXnNQ7tOCZeaJWzRFvAytp5d8wUQ=;
        b=F714DBf7lBqoG88Q9lKZgM85guO75gt4mJCQ4KvVQjz0VX2j8l1SIzLlfQ4dYgH6mE
         PVpUrmO2S7VqVuBIQ+PQ8+UIIaTd8+9quUJkGhPjfUvkq2ZQJ6bnZMSWUxKvpJ+QHCEL
         9m3h4OmcuGdafyOZmvlVp9iBxrlVGMybmnHPzGQsfK+tkeggNaMs+qdEQ7RxyGbopUmV
         GVOw5rbflbcGlGmr1e/x4xH2k36/qMplubKS/7UZ01jMVvfM6ntvGDvwbojWTGqwYay1
         YBMViA5si0oORFvxhq9Yf3ou8vyN/vfodrUewaCi0av2Y6z9ugKIZwcLlY7q2j4zcvnB
         tB7Q==
X-Gm-Message-State: AOJu0YxoFP8zywUit4/Cxxe/bCW7bN2uOzKIIQAnFqbkdRjDJumGFZhe
	lPETbxKteg1ZbbaJH/nRmhI5mtSyyyK6jBSmAUpzXlvMnmjEjLkJqZva6u6d
X-Google-Smtp-Source: AGHT+IEX8FT6rkbXtq5cQlXggUUW9A+ZEBpSSWQZ1O2lhfbkLJk37om62pMj8+uFF0V9IhulVfcQIw==
X-Received: by 2002:a05:6808:159d:b0:3c1:9519:1c19 with SMTP id t29-20020a056808159d00b003c195191c19mr6517641oiw.37.1709140726521;
        Wed, 28 Feb 2024 09:18:46 -0800 (PST)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id q15-20020a056130028f00b007da5ea1638asm1488240uac.1.2024.02.28.09.18.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:18:44 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 4/4] Bluetooth: bnep: Fix out-of-bound access
Date: Wed, 28 Feb 2024 12:18:38 -0500
Message-ID: <20240228171838.2414532-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228171838.2414532-1-luiz.dentz@gmail.com>
References: <20240228171838.2414532-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes attempting to access past ethhdr.h_source, although it seems
intentional to copy also the contents of h_proto this triggers
out-of-bound access problems with the likes of static analyzer, so this
instead just copy ETH_ALEN and then proceed to use put_unaligned to copy
h_proto separetely.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/bnep/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 5a6a49885ab6..a660c428e220 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -385,7 +385,8 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 
 	case BNEP_COMPRESSED_DST_ONLY:
 		__skb_put_data(nskb, skb_mac_header(skb), ETH_ALEN);
-		__skb_put_data(nskb, s->eh.h_source, ETH_ALEN + 2);
+		__skb_put_data(nskb, s->eh.h_source, ETH_ALEN);
+		put_unaligned(s->eh.h_proto, (__be16 *)__skb_put(nskb, 2));
 		break;
 
 	case BNEP_GENERAL:
-- 
2.43.0

