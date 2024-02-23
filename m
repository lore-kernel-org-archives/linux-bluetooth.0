Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE70D128822
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710120; cv=none; b=LN9vNNZcZYoKfJdiBkZUdyo4AVloH08bhnmZ2KDKEeIV1suDQxqBurWa6fw8El8vIFqOyvTKq6FSOsZgjTjxAPTBOXVFU3Qrzjt4+TiafKL2DTxSMClG+b2jS0Z01M5ySoBRanjNJco95F7SwWZa1FDBcXUdWi5MtgCrwhKfr9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710120; c=relaxed/simple;
	bh=X6pQe7aR8rwHhqzW204nH35V9HhztDQzkIJNl+dBqt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKejWxGwGXxTRWv/ekFJ8eAT/w6JtPrZEh2PPwPq8okKOlPZWUn1x2AZPrhI1pQVc9yPuzb2r2ByX7IKzArDpzhQmxhV/Hjsf7ooZ7VvVmHa3x+FrHQTajbGCunwldHbUMTnSwZXH1B4f9OBp6iUWcHNlunj32XxGuv0g7i+1qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3dsw9wr; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3dsw9wr"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d2505352e6so12614571fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 09:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708710116; x=1709314916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRMrYm4dLpUzAECEZdPBMYvqYbIm7GzU/CvNrWfswqU=;
        b=h3dsw9wr4bYjM2LU/xjz7g0Y9V7Xe79wPiYjQX2DfHkgJ02/1Ajc7XaFWk7gDJM/dG
         jp5htYRoNWj/m2v/2IUdlD408r2mdaIEPmdOAYVgFfalmnwuiSsL9dLRUjc3IMK+Do4U
         E2JekV7QLnXMJnzxPs5bhFwYXNxl8jHNG/rsEBrxyRCVvCDpU6pfDQNmK4y+UC8UAcPm
         76J78Os6wzA5ELcwRoKi9YD4wH43dOVpAQSf0rBFNB+RwYhudoqpS3jlrWPsPvncQ3Re
         vlPuEGavu9S3mDdo3NZIfdvKcN9MTckuPeFKu4dSOOZWQMNs6xMX4gPTFZflSkuJDb4C
         FIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710116; x=1709314916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRMrYm4dLpUzAECEZdPBMYvqYbIm7GzU/CvNrWfswqU=;
        b=e2Ggy28y2YVdwh+7yoRKKz5dGNhBnV+4cqgWf08LIUBYDFOJib4uwWQwW0OnbbDRq8
         Wh9za/gBOC+wohhD5Mt2+LvvbWP1HZaAryDf5l95aJwRq93mDCt/cVUWaYRm7QLwQsFK
         nIVOXfwPNiweah6JsXV0H1rzjSdkA9MnnuD4E4bJrQZurNy4Z8XU6W+0rgpiXWAoG7yz
         yebK3q4knVvXyTsqsXcA16eNdXEh7fBKDsNFmMDjbbzXgLRzLj2scUZrQyRZ80qhQ/NI
         v80+6wUYm9f9i5VobANz5rST2qi8lhInS6cXaZStTYxEzd6etS8Km39G6WWL+LWKtaXJ
         klpw==
X-Gm-Message-State: AOJu0YxDHTsjH1Oqoh7jsZxYjWOvUms1Qblt8q8zwlSAjN+ILXf5hGt2
	94oRVlLmy5u6WUbzjZXmd1Wynp+r2IOIvcPaUo7fkrL9NGCB87InCBr5qbENT31YXYlvW+8OBPf
	h069gPIBsgGwDjvukwVuRQIr8gjAuBwsCH/A=
X-Google-Smtp-Source: AGHT+IHn4fL3GgLMJW4UrQjB/Q9ijIzBPND2phtf5+hEKLXhRBsw3nRulBZtxf62aabC3vzDkBIE7XJFrYf1s2heSAY=
X-Received: by 2002:a2e:9b08:0:b0:2d2:3b9c:6550 with SMTP id
 u8-20020a2e9b08000000b002d23b9c6550mr345490lji.38.1708710116121; Fri, 23 Feb
 2024 09:41:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223173819.973508-1-luiz.dentz@gmail.com>
In-Reply-To: <20240223173819.973508-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 23 Feb 2024 12:41:43 -0500
Message-ID: <CABBYNZJMvyDFjcXGMc80d_XSEpOefzvK+=T-r=OF5MhXZakhLA@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: Fixe build regression
To: linux-bluetooth@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Edward,


On Fri, Feb 23, 2024 at 12:38=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This fixes the following build regression:
>
> drivers-bluetooth-btintel.c-btintel_read_version()-warn:
> passing-zero-to-PTR_ERR
>
> Fixes: 36618e0d5a6d ("Bluetooth: btintel: Fix null ptr deref in btintel_r=
ead_version")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index a083c4b8621c..6ba7f5d1b837 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -435,13 +435,13 @@ int btintel_read_version(struct hci_dev *hdev, stru=
ct intel_version *ver)
>         struct sk_buff *skb;
>
>         skb =3D __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
> -       if (IS_ERR_OR_NULL(skb)) {
> +       if (IS_ERR(skb)) {
>                 bt_dev_err(hdev, "Reading Intel version information faile=
d (%ld)",
>                            PTR_ERR(skb));
>                 return PTR_ERR(skb);
>         }
>
> -       if (skb->len !=3D sizeof(*ver)) {
> +       if (!skb || skb->len !=3D sizeof(*ver)) {
>                 bt_dev_err(hdev, "Intel version event size mismatch");
>                 kfree_skb(skb);
>                 return -EILSEQ;
> --
> 2.43.0

Looks like your change 36618e0d5a6d ("Bluetooth: btintel: Fix null ptr
deref in btintel_read_version") caused this build regression thus Im
CCing you just to confirm that reverting it and checking alongside the
len shall resolve the initial problem you were trying to fix.

--=20
Luiz Augusto von Dentz
