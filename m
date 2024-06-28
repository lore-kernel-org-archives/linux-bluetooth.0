Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB74154434;
	Fri, 28 Jun 2024 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719581353; cv=none; b=OlWerCTJBbe0Q7QPTIpKYaZ7Q5SCvC6+QoMxkY3IYl/Qzhqgjloij9PszAhhBBtD9yvdkP7PAStzsxFuCIF7QZi6DyMfDpDG+Ec3JfWk18sJUSWKDOCk6gooJRIt+RbpB9XMuS5Okda0pKWnLYMdDl45yWiSKSjoKjwl869i0Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719581353; c=relaxed/simple;
	bh=Lc6l2/suYh/8owAfwDc3cf7pFTnDrHUk9tT9n0HgEPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4Ueu3G+oqog42lbDHEQ3LEY2LsX9Add+Yzcw0UiIZEmqjYZm5a8qp8q4aXfad8Q7KYdIz+zFqa1lJKuZKCaTkm0XJfZ7Ku0cUqWP1IVXhoBCin9zzqsTCKlwzCmfHz2cdMEHNIyV9tb/TfGiUwDA0Lj+fI6VM1EgG5MfwRq5pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gr6Iykrv; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr6Iykrv"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ec61eeed8eso7145151fa.0;
        Fri, 28 Jun 2024 06:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719581350; x=1720186150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoLep4S3UcvnGp6wqXMtpI5TwIz2e/ZcFj9ydxYz5G8=;
        b=gr6IykrvqLL5XB2s7R3fX+ReMtiQYJDxqzeLMmjUIJlt/51ZgiSkLsg6pc8C9LHOUq
         c3I0SYJADcpEjeZqP3ez0bKeS48b2MbgF3xYq27PcKXz9ArxGwjI89y1Hyv+PQPoQJM7
         CEzWncV6dHYPglOlCHwwRozzBX/mK8TIjzZzwnZr1JkOcAwlazpspRi68uo9ObtBDwtl
         UafDjMP7/zUMdTsJKQQbfkw5y2CF0k6XcnbfUQwXFeyxWPH1KEN6aJ9nXsa1OYbWCQk/
         AHr7++KsogQCYRYPwCT9vU5rq0FfvDIrfgd+DNuJb25DTl1RXtfhF2S7U79Ft8f0mAEG
         l28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719581350; x=1720186150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoLep4S3UcvnGp6wqXMtpI5TwIz2e/ZcFj9ydxYz5G8=;
        b=C1gVM9OxJPdb7giro8kpVLuZOYwjD1ol88cQL35ED94c3qTDyCzGbhj+MgC5jHBEWz
         0rN11syhVpReoMrUB7pIVUY3AYclzKhsGcLys62ZpiiRClNOFyTeCeebcpaulpTHWR/I
         kzpSiuhJCNjOwfqbZoHe71tYgsQS7vj13Yr6noalOdVgGKmCv6cm6RJNLWxAAdNviF13
         /xZy6mVRWj9KIuRi/kS+Eij7JJ9LsfZcwODTAOe6pcXAu+d3nCQQEpp7lDSMn2rTSvCL
         9+/pk0VAO+XaDHZm0G2v18OaV3aCFGK7JK8MdmiLO+hSjx83Sc+UReebECXipYhOaG1g
         tWRw==
X-Forwarded-Encrypted: i=1; AJvYcCULTulA8Dh+cO76lVKDahKSldRTL/ek8qq+Xt4unx1VwthlWULbTffP0tGpi29VfMcFKmZ58MiSXIs6GjUe3LFdCE0IIb00UnY7aXknEBfHqqFK/OEFdhkTPmWu/8qcNI6Ohx8hZQQwyT0LSYzq
X-Gm-Message-State: AOJu0Yxh/V5141OvRn+lcm/3SnHNfzatTh5tlgCc3pIavZkNRfqOJ51H
	BM9FA1+m40MITNbWLP1V2xdeQ1QGPthqJBK0xcNR5D9LV/G8LvOhrhscBfSifOlSTnDC+/t9YOv
	Ml1ASSpGisfxGQFDsyoDeYqPXhEBXaw==
X-Google-Smtp-Source: AGHT+IG7MmmejUEBrt5++vrrPtZziSncIEJp2cy0JvgDXcibMqrZN4iMHcblJqmq+Leke7USKmRXFj4Rv/xnCQk/toA=
X-Received: by 2002:a05:651c:1581:b0:2ee:493f:d5be with SMTP id
 38308e7fff4ca-2ee493fd616mr44273101fa.3.1719581349725; Fri, 28 Jun 2024
 06:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524013127.434500-1-nobuaki.tsunashima@infineon.com>
 <CABBYNZ+yvQL0KBagUXtzrBUFmFxp-ek_5aFDJNVyUKsA-xJ-Zg@mail.gmail.com> <f7a5e281c48b4232a4ba74022dd3f83a@infineon.com>
In-Reply-To: <f7a5e281c48b4232a4ba74022dd3f83a@infineon.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 28 Jun 2024 09:28:57 -0400
Message-ID: <CABBYNZKjUY2XVf2yu95ECggZb1xJ0SAneKqMNSnAGGfgRTs02g@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: btbcm: Apply HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER
 to CYW4373
To: Nobuaki.Tsunashima@infineon.com
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 26, 2024 at 9:59=E2=80=AFPM <Nobuaki.Tsunashima@infineon.com> w=
rote:
>
> Hi Luiz,
>
> Thanks for your review.
>
> >>  static int btbcm_read_info(struct hci_dev *hdev)  {
> >>         struct sk_buff *skb;
> >> +       u8 chip_id;
> >> +       u16 baseline;
> >>
> >>         /* Read Verbose Config Version Info */
> >>         skb =3D btbcm_read_verbose_config(hdev);
> >>         if (IS_ERR(skb))
> >>                 return PTR_ERR(skb);
> >> -
> >> +       chip_id =3D skb->data[1];
> >> +       baseline =3D skb->data[3] | (skb->data[4] << 8);
> >
> >This is not really safe, you shouldn't attempt to access skb->data witho=
ut first checking skb->len, actually it would be much better that >you woul=
d use skb_pull_data which does skb->len check before pulling data.
>
> I think it could be safe because its length is checked inside btbcm_read_=
verbose_config() as below.
> Please let me know if further checking is needed.
>
> >>>
> static struct sk_buff *btbcm_read_verbose_config(struct hci_dev *hdev)
> {
>         struct sk_buff *skb;
>
>         skb =3D __hci_cmd_sync(hdev, 0xfc79, 0, NULL, HCI_INIT_TIMEOUT);
>         if (IS_ERR(skb)) {
>                 bt_dev_err(hdev, "BCM: Read verbose config info failed (%=
ld)",
>                            PTR_ERR(skb));
>                 return skb;
>         }
>
>         if (skb->len !=3D 7) {
>                 bt_dev_err(hdev, "BCM: Verbose config length mismatch");
>                 kfree_skb(skb);
>                 return ERR_PTR(-EIO);
>         }
>
>         return skb;
> }
> <<<

Ok, but I still consider reworking these to use skb_pull_data.

> Best Regards,
> Nobuaki Tsunashima
>


--=20
Luiz Augusto von Dentz
