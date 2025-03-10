Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793804437C
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 19:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636023; cv=none; b=Jn581Q/h6/VwsYHBGY6CoOZAILWyU4C4j63+Lu3mfzOqVxG3THcNdjsRch14szztD1Jzu2tKuulrfsY8c1J+P0rSvsqVFHKhwHINjqLXNOA8eWKq367CH9Gby+/pkJMjqXnAje9zK/E7qwfBP6W274O8j/RhwQMHvWWXYs6INRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636023; c=relaxed/simple;
	bh=aiqYQfMgtVBoT+W6uheJpa+d5vkkhkEs8dbJPBMcziM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZF34uBmiVcahgxoPIEWqOgvBlNiwLV+P/4XQb9qjvw0ufTvW5xJqC+yZH8JNPWzCGmtOqLKx3x1W8blquLzlgyzj9ZzWrsKNdm8n2ftfoT0W3xstRStHGQHXLoFg2Mt71oqV/99P5/Q0kJk10wkcQ0xumhdb40FzQOUwtbAoD78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=meYFYdQ9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="meYFYdQ9"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so8000555e9.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 12:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741636020; x=1742240820; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=231CPUYYKEzM9Mehgd894YWLVMFUlImKftBC8hnTO+c=;
        b=meYFYdQ9rJBDRae16AWGHs5pJSwvkIN5PBx9pbCsS4JeYL7MbsxGDoJkcsqu1PowMw
         PDNcCUJkmydel7A+v1bErYoqdVm0aC8WGID0mVYOgaw4dd4Zqbq3xG/ZLEz5xpJp1EMo
         Q90FAz1buHU/Mf+2VdfJJy4YiZ77ZmPUbFfjor51ZDWGCDCiFGdesCuoE96tvupo5hwJ
         F1u20cVR8zZQwRpAe6RrLdsZGm3OjSliOtwsVwJMm9HfcNXeHNHpyzIiwqs8UdpBICdr
         vnFeCflHCuVWrtelSrIv4mvfQ9JBZ6LwDYcc7H7bGD3dT7OC/kPpsRdO1n4oo55P1+5H
         ZUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741636020; x=1742240820;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=231CPUYYKEzM9Mehgd894YWLVMFUlImKftBC8hnTO+c=;
        b=wRAhlTFSpcwws++vBgVRphO/gjgm7/KU94pJaSs7WiSZizUAkPXURuEHWnWxW+604M
         Ikc8as2kDnvLfb6K/ErhUJtUeo+42XjsZftVNGgbjOd+GoiabVM6NiAjqXKV5oiwMhMV
         ntbv+UONkOyBDuCLs5STZuRgjUkaffptFDc1tswt+R5RGVlZI82mkdlrFEw0dA6ux+ZK
         qdmwJNgpJejinBPV4V8z5daRO1vFMpClNE76NSpNeR9IQP0JpsxHT08OtD6CBVhOeemR
         3xbR0FT34y8DpVXORaWOD4//2qe3eQRfUca6mNoNQmrkQt+gwDaQsfqtDZqe1dDyXT4/
         R9uA==
X-Forwarded-Encrypted: i=1; AJvYcCVdZNWrsMdHvNV4mEesZHwAMmcwBAANYYLpZuNECJUQnt0AmSV6U+CEJ7XXTrfnaPIQl4QhR1CMWidsY6CspkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrMEmM8YlJsuhH1tq5ffA/DdIVk272M41kQ140qMSSxVFBKdMS
	iGrZnCCOjAGDzk+z1vhRvmSqWK8bdOtbOn+PehkV1wsgZGVGeMt3bDdJs13toos=
X-Gm-Gg: ASbGncsrhQAHieu678nE8JiVddKQnifPUB+v0ZqHRYNK9x6/LCfJ+wHsOnkJHndTVqt
	RbnLWFTz2bE0eShZHiubUwyxYT+mBBzKZpAmdn7y+n6GVYDb9DjhkE2jWFO4NL1xvC036DjHOJr
	nc1Zh8fTPAqyCV04vhKBhioDyIOnf94qayzcLtRHtTLmiS7ehF8+6ZmJ5dnQCT3CqgypwBLUjS9
	O4+3O9pd4qaEAmhL1zWV15f+9NnBU1H/2MKxyH7/o1AkUkWNO/Ub3aoNZTzNUbQe/vAMxPyxlb0
	11d0xqaQLSrpeo5mGbKZqGiYC7HJlR4lX3MrMF4afaOG4j8MKA==
X-Google-Smtp-Source: AGHT+IENOj/L+kmWW9WOCu07BV/iNTaznn7bJD1hHiIqNCa8h3p/cdYsNQAG/D5Kuu+UjabTbgrN0g==
X-Received: by 2002:a05:600c:4708:b0:43b:c6a7:ac60 with SMTP id 5b1f17b1804b1-43d01d322f1mr10018445e9.10.1741636019918;
        Mon, 10 Mar 2025 12:46:59 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43ce8a493d0sm94209265e9.1.2025.03.10.12.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 12:46:59 -0700 (PDT)
Date: Mon, 10 Mar 2025 22:46:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix error code in chan_alloc_skb_cb()
Message-ID: <2144b990-e584-4f77-a3be-5987b56d051a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The chan_alloc_skb_cb() function is supposed to return error pointers on
error.  Returning NULL will lead to a NULL dereference.

Fixes: 6b8d4a6a0314 ("Bluetooth: 6LoWPAN: Use connected oriented channel instead of fixed one")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/bluetooth/6lowpan.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 50cfec8ccac4..3c29778171c5 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -825,11 +825,16 @@ static struct sk_buff *chan_alloc_skb_cb(struct l2cap_chan *chan,
 					 unsigned long hdr_len,
 					 unsigned long len, int nb)
 {
+	struct sk_buff *skb;
+
 	/* Note that we must allocate using GFP_ATOMIC here as
 	 * this function is called originally from netdev hard xmit
 	 * function in atomic context.
 	 */
-	return bt_skb_alloc(hdr_len + len, GFP_ATOMIC);
+	skb = bt_skb_alloc(hdr_len + len, GFP_ATOMIC);
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+	return skb;
 }
 
 static void chan_suspend_cb(struct l2cap_chan *chan)
-- 
2.47.2

