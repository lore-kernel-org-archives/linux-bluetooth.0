Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514592DC776
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 02:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604679; cv=none; b=OCT8dk4n36BXc7/HU223SCkoUBHDuLGlZpbMk+wVjRx2aU3oShEQY1htwLO9jGa68i+9vU0WBIXkY3fvVVAVExiewoc4GsrT4sxltICxJAPUxUvUUPjDJKoo8g8wtdnH16RLiML1EII/tqvlbhL0ynW+0hpj5kxVywAf6bfMoNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604679; c=relaxed/simple;
	bh=m/t0JipUvu61Lp9A1bNicjXVL42+ezMKUrjSPtwtcJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HcOprR7ETPIRGWiJ6U3dW0E/Uk0rYZXuNDv3rz2WN05rZyAoyCWXSYfzWpaaLQ/7sfPP1faM9iK6hiJ/AB1ycwjjiapLFG1h3ArRU9rEKoGBMw0Nj4qobCG6OJ/KippwbfUrWAOkL2aabzsmjE8QEKDWpfJt520TmA+1TOezIOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJwm+fI1; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJwm+fI1"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-297d4a56f97so5841305ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 18:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763604674; x=1764209474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTFNVmbRzXGZbT/LGhFHixBDUze2+iDNyRytGw9mv0o=;
        b=jJwm+fI1PkiQDnDB/vQ6inxM8wqI0wWHkWzch4Fi/aWxaFHb6NIEy2viNrIjLENQFK
         AJLcMysKNbvBic8zZ2Xf0ydQSWhyJFMDekgCppgA+0HY+CR4KdyVeDzyPs5LtlUW94eZ
         miTg07qRFp4ZBHsRns+YL7q1tvNy4PwqWtsNKYEhUFhWpybhA6vjPYUt0Bg5O6t8sKAZ
         Wi1UlJhCTRhTlGsjaN4XqyCgIYppKW8L/biZZmmN6bWcDpIEJTghLNFyjLATNteCked/
         t7wWYiNRdPZNBEXC+w1nW0NJZZEkYs0BLswp8mLN4LEUH+63vaFq0RVSFgYsuNDWchgk
         itBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763604674; x=1764209474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pTFNVmbRzXGZbT/LGhFHixBDUze2+iDNyRytGw9mv0o=;
        b=khaFvYZgRFNXktD9BJys4E5bkmknwMzxHEbh427IsGfdgVc+RnLiUTDR1O96EcfeSU
         I5E278A26Lyxi8mWZkEDP+ds20jrW+D7LyrbCbKpHbclWMdyXSq1EmE8htS+lBn/UJi+
         RPtSoP+870z5I5rHkzPsg7M5mm8JwMocRDt+6Z8AfmQsuh/4Z/iM0OWMeA2Aqsom3Pr9
         VaBfUTQJZ5eyRIA51+ze7js31I+czhOqm5aZbSurzXYjMYYt/zC2B8rnedd0qjuQCccj
         sQNcsNcLy0ASUiEf77qnUkErcv3B1Aa0Rda7RDu1ZpOIgqEaBKmsuJw2ln4/86WYwsEA
         8v7g==
X-Forwarded-Encrypted: i=1; AJvYcCW5TCoTqqKEBpNXAilTl9HqRJN6y+E+KvFuifezed9ypYWFPuhWfze7w553hBVJPfB62LIRqFolCpKwPYb29eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnHfvYTUMbt7A221/E391Rz4OjUsUJV5gXhbpjzztqwuqqOfNB
	4Iqf4acm9tZn7wk11LwpGsicPXi1evjMNWvYhjLSeFQEyc3nv/OvzIqc
X-Gm-Gg: ASbGncsqjYNjPTVm6GcU9v0ggN2TucTGzl76SU32qLA8s2dsZv69dt+5vPf5x5pq2Ev
	6JWwLdfoLexQ+Y/oKU2Dmh7zqsi2wa7ftyIj1cqdh/Lh8QZ5+9x3xhwV4jfLLFHn1t9k0FVjxdZ
	B7vKnisI/uZk88AKxm7b5EGzTb/pZqtGXyXgt4wH/OvxSQlj0m5CnZuyfdJ9Yz0DfeEetPKXAs/
	YLvsXF2+uwNUqyQuk+szhDdKmWFhVP0VlURCd1gskJ+9xckrtxyDSOdeVcX6e+M/A8PzA2XNYXJ
	RAuSsqSnMZ8dS4H4sR+gcIAPdma3VarOQnxvWhDveN75jlDJvvHxqV4/WISE072mAPJcu8jG1xj
	kkxIWkcpvLPHjYoy0lRLd9eNPQepEP5tM36GesOzm40yPRGNHm5Oo1tpl2/fJTXvURq8Fhhgasi
	PVnOmlXGjr9yvoIAXmgl/zZw==
X-Google-Smtp-Source: AGHT+IGJI/oKAsUQ7D64r7YwPy+QegsmPvmtzc+SJksMMBWokoHdWjKxouE6QVbTqg1qQ+RNiAulBQ==
X-Received: by 2002:a17:902:f650:b0:295:54cb:16ac with SMTP id d9443c01a7336-29b5b088815mr20802785ad.18.1763604674349;
        Wed, 19 Nov 2025 18:11:14 -0800 (PST)
Received: from Incog ([2404:7c00:42:f150:fd7c:4ceb:3809:3323])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25defasm7635325ad.49.2025.11.19.18.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 18:11:13 -0800 (PST)
From: Incog <incogcyberpunk@gmail.com>
To: dianders@chromium.org
Cc: angelogioacchino.delregno@collabora.com,
	incogcyberpunk@proton.me,
	johan.hedberg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	matthias.bgg@gmail.com,
	regressions@leemhuis.info,
	regressions@lists.linux.dev,
	sean.wang@mediatek.com
Subject: Re: [PATCH] Bluetooth: btusb: mediatek: Avoid btusb_mtk_claim_iso_intf() NULL deref
Date: Thu, 20 Nov 2025 07:57:17 +0545
Message-ID: <20251120021217.87602-1-incogcyberpunk@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251119085354.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
References: <20251119085354.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: IncogCyberpunk <incogcyberpunk@proton.me>

On  Wed, 19 Nov 2025 08:53:55 -0800 , Douglas Anderson <dianders@chromium.org> wrote:

> In btusb_mtk_setup(), we set `btmtk_data->isopkt_intf` to:
>   usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM)
> 
> That function can return NULL in some cases. Even when it returns
> NULL, though, we still go on to call btusb_mtk_claim_iso_intf().
> 
> As of commit e9087e828827 ("Bluetooth: btusb: mediatek: Add locks for
> usb_driver_claim_interface()"), calling btusb_mtk_claim_iso_intf()
> when `btmtk_data->isopkt_intf` is NULL will cause a crash because
> we'll end up passing a bad pointer to device_lock(). Prior to that
> commit we'd pass the NULL pointer directly to
> usb_driver_claim_interface() which would detect it and return an
> error, which was handled.
> 
> Resolve the crash in btusb_mtk_claim_iso_intf() by adding a NULL check
> at the start of the function. This makes the code handle a NULL
> `btmtk_data->isopkt_intf` the same way it did before the problematic
> commit (just with a slight change to the error message printed).


Proposed patch:

> index a722446ec73d..1466e0f1865d 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2714,6 +2714,11 @@ static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
>  	struct btmtk_data *btmtk_data = hci_get_priv(data->hdev);
>  	int err;
>  
> +	if (!btmtk_data->isopkt_intf) {
> +		bt_dev_err(data->hdev, "Can't claim NULL iso interface");
> +		return;
> +	}
> +
>  	/*
>  	 * The function usb_driver_claim_interface() is documented to need
>  	 * locks held if it's not called from a probe routine. The code here


I tested this patch by manually updating the drivers/bluetooth/btusb.c file with the proposed patches as above ; which solves a REGRESSION issue `bluetooth adapter provided by btusb not being recognized and hence bluetooth not working` since kernel version 6.13.2 .
This REGRESSION issue has been present in both the stable and the mainline kernels since 6.13.2 release due to the below mentioned commit in v6.13.2 :

Troublesome Commit Details:
- Title: Bluetooth: btusb: mediatek: Add locks for usb_driver_claim_interface()
- commit id: 4194766ec8756f4f654d595ae49962acbac49490
- [ Upstream commit e9087e828827e5a5c85e124ce77503f2b81c3491 ]
- Author: Douglas Anderson <dianders@chromium.org>
- Date:   Wed Jan 15 19:36:36 2025 -0800

Tested-by: IncogCyberpunk <incogcyberpunk@proton.me>

Regards,
IncogCyberpunk
