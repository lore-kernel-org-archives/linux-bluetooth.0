Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C263655D7
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782920786; cv=pass; b=tIh8xY/dZzLE346sV1xJKYTu0mNPUQL6BpxvnYpvgsymNqtrfQzip1M/OTX7U8jN0Z3gY8q4Lr76aNuC9erBRO52BI6PYsVzJ96Q0uNAozHzxAb+oUJ8ijW9xhQbpI5asV+LVL6Yp2wCja87pXLVyaQd46lUq+phpZI1aq8omSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782920786; c=relaxed/simple;
	bh=IdvlWxzLSyCmmiNVrgOcVBZm7GxfkEGRv/qtB8kmcJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcYLkq9z4ux3tB4xZZAUpo1E7ia4+lchj8x4TpdJnHpTyUU4TDuWj79GwzEFnsVc6Q2HymjIQnGNXP3GY0ENA/Y97x660V7p921P2O3UBOYV25CYAZAsM6hSwP7WY54k6o43jSRiO/eoj6QkGRVf6wPpreIVZv1qWXUWefOMjH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERL0j2ne; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERL0j2ne"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c0868ca8738so123988666b.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 08:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782920783; cv=none;
        d=google.com; s=arc-20260327;
        b=NLVsFq66X2K3n/YPJEb9QjSAsr+HYjrHw0P2Dbd20/yGE9NOe0nZ51Fh1xz7+2W86g
         QlUQYe5/y+9yH53jwEVhLj4XGD5Z527olGzE7s2pbuZvobJNwkgMQB6GjZm80wOAxaLQ
         VJNPBfWSEeW9IAcvzmU4MeG2qAwoOdAVXFpWO95DKhWAO7H0/JTkTjGilzby+fYowhrn
         xwbP5nMuwhSgGwzuBRaWFooutwlyhuZwshdccLP8z5iC9Ey206iJKjIU8JSSDNCixztR
         3AL7+KLn/EAJ5T2kpKhnZe5rqdRmePjTtqUQgOw7maqeJhG2MNiY+Msrd6ZYKlzBQnpV
         XS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0kFw9R1ZbfaPCaaggAFMFuoySSMPKD1esRwXbXvRECI=;
        fh=58ND/5HQeBrDun6eFwGGgFUkITndtCV9MnOCQXqBCJI=;
        b=NnBDwyq0CXqZFsiVnauzVaeWaGxAsStUiK/gAEUzWCH98naypATvjQOGvj5OwQ1hst
         dDFxx7aSq6tbZvbwisrPXuLBpt0a3GPswxFlABD9UVsdws6tlu1RPvP8GkLGoRWg5rBX
         /PPQtxGi1l1hsUvwyG0+3pZwIOpX2YpD75S+D6G5+D/CbyGc4SpCY+UbIuZUaEsBxEdO
         bkMqyQSw+y/97QY2PE+MD7fU8EYMaz8sD+zCPdZo8jCQHXPMRyweSkLmsxC/TSwgpfOF
         j4R77du1VTvqHfRP3y1kIUZd3MijTE8DHn87rRXTtSUDsjuoIPcylyChDjk8XXWfn5BP
         H9hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782920783; x=1783525583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kFw9R1ZbfaPCaaggAFMFuoySSMPKD1esRwXbXvRECI=;
        b=ERL0j2neAzix0SVBmFpTQvQFpkEj6ykVngfI6WK6QoWVs0jLxkajFDLpXtHNqvqFHL
         Hu2Xvt5yBADConR1DD22Lds1C4nvCmgcpQbtbSnm2a+fE97AFdwS8xU+jfTxOkCCrxhh
         OsNRDiKVmkI+9+fWOEDAR9R0YWkHZzhZoVrxUESJ0fj4fwO/m8abBkmBXoLmEM8mpMU4
         nqj6ueITVhU/pr5ZEX/fXdWZab0+olE8HwHfLMaMQKa3c8R4tO/X2fag+nC0Dfa8MJ2E
         xInqEgdQMQKzsvC0bB7w2s8f3AthG8Z3PfR84WOTl4T5TtizuiZdzMoWuKV665hErMey
         MDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782920783; x=1783525583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0kFw9R1ZbfaPCaaggAFMFuoySSMPKD1esRwXbXvRECI=;
        b=SLNJW/3kXJGCeDvSEqnUa94wsHA+NpN+rSuz/3oOfzjMV+rj1l7DQ7Qrq0tMkqYCMx
         IL/o6XD3XH2QzEpg9yNGgrZDJU/zc8ZSER/YUZP/LxP0mB7CBj+kkxdNhpwgY23zifcN
         AwYYjR1GJctcM4vHMNwBIxavk5UsEOWZuYtxiB/auGUckjzztH3GtEJ3roQfASlVgUAz
         QnfbEFpZ/qN6myTQtSL8NeorFnMF+TtkS7DsyyOzeyei1EZ0Lu94e1xXfOD2vKGOd52+
         +HngMoKPjpmLns4Qa5uCkAP3ai9WVbbYP6FYfbhYB3yjKkl3wI+8g+FDsEBHO/Zau51U
         KGBQ==
X-Forwarded-Encrypted: i=1; AHgh+RoxDefXBxI5LOgn6zErRsa/osqQ36HfjpFgYRRwx10DnYEZ2uPpOWO5Wwipe+1LfSd8jTHp8ZNimYBSUncPhE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2dO7f97GHgkAjvx6tz+NKjqsagR76/zertocU1NS9qEtv7Ujj
	WFjhw+AZCKk96T0F++WDKVOHyzOdUXePURbjjmu2wNVeKr5X/lGDpwjBQX/pH/S2op6QcilLYM/
	LHgVOe3ZRcmyJ1EvbGjHHJsqpy3a+32Q=
X-Gm-Gg: AfdE7ckWBQ4Ex4aPg6jN/NJl3DUfZVa6V3hzZMUOUvLXIFBZIzhJE7P+a2ZU4JuA5u8
	MRKN9RoOFj+lMdyX29Het7itSxbdjFytE6Mbg3ahG0C5AjdSm6EQY6mw3ApUZxKsMP+vdJX9EMu
	0Fp1rHWhuHUvYC+6XE/nfgxRuZy/TtkOGwB6bV5gHPQN2GOc2JkOQxxhx6wAIudzlOB1ZMfaj/H
	llfmyGy+UsQfflXna0xa3ULlgPhj+jPfkwDb1+Gg4ybkCjmTb8k6BFpu68gESSyxntbcNu2AyiT
	zIWIIUrTp+lcx8YEY4Oovu1s2qtN
X-Received: by 2002:a17:907:9453:b0:c12:5c08:279 with SMTP id
 a640c23a62f3a-c12a9d37e1amr110460166b.1.1782920782844; Wed, 01 Jul 2026
 08:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630062759.2769059-3-bestswngs@gmail.com> <54780f64cf658a0ef53b7116076cb4406a0f666c.camel@iki.fi>
In-Reply-To: <54780f64cf658a0ef53b7116076cb4406a0f666c.camel@iki.fi>
From: Weiming Shi <bestswngs@gmail.com>
Date: Wed, 1 Jul 2026 23:45:45 +0800
X-Gm-Features: AVVi8Cfny_4ado9NVhzukJGaTjzZBtx2c_l6zGjdRtRRbgnJbFIdOjegHOCpuOk
Message-ID: <CANgPUi2VjHtxey3SqCWiJ4mtcX+EESSMg_xyZqsYZNWxT2S2-g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: bpa10x: check response length in bpa10x_setup()
To: Pauli Virtanen <pav@iki.fi>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Johan Hedberg <johan.hedberg@intel.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Pauli Virtanen <pav@iki.fi> =E4=BA=8E2026=E5=B9=B47=E6=9C=881=E6=97=A5=E5=
=91=A8=E4=B8=89 03:04=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> ma, 2026-06-29 kello 23:28 -0700, Weiming Shi kirjoitti:
> > bpa10x_setup() sends the vendor command 0xfc0e and passes the response
> > to bt_dev_info() and hci_set_fw_info() as a "%s" string starting at
> > skb->data + 1, without checking the length:
> >
> >       bt_dev_info(hdev, "%s", (char *)(skb->data + 1));
> >       hci_set_fw_info(hdev, "%s", skb->data + 1);
> >
> > A device that returns a one-byte response (status only) leaves
> > skb->data + 1 past the end of the data, and the %s walk reads adjacent
> > slab memory until it meets a NUL. The same happens when the payload is
> > not NUL-terminated within skb->len. The out-of-bounds bytes end up in
> > the kernel log and the firmware-info debugfs file.
> >
> > Bail out if the response is too short or not NUL-terminated.
> >
> > Fixes: ddd68ec8f484 ("Bluetooth: bpa10x: Read revision information in s=
etup stage")
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> >  drivers/bluetooth/bpa10x.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
> > index 2ae38a321c4b..07c6ed6f18ac 100644
> > --- a/drivers/bluetooth/bpa10x.c
> > +++ b/drivers/bluetooth/bpa10x.c
> > @@ -255,6 +255,12 @@ static int bpa10x_setup(struct hci_dev *hdev)
> >       if (IS_ERR(skb))
> >               return PTR_ERR(skb);
> >
> > +     /* Reject a short or non-terminated response before the %s reads.=
 */
> > +     if (skb->len < 2 || skb->data[skb->len - 1] !=3D '\0') {
> > +             kfree_skb(skb);
> > +             return -EILSEQ;
> > +     }
>
> Was this tested on real hardware?
>
> With an out-of-bounds access fix like the above in btmtk some weeks
> ago, it turned out HW actually was sending truncated data, and it was
> found only later in production use that the driver was broken by the
> fix.
>
> > +
> >       bt_dev_info(hdev, "%s", (char *)(skb->data + 1));
> >
> >       hci_set_fw_info(hdev, "%s", skb->data + 1);
>
> --
> Pauli Virtanen

Right, -EILSEQ is too aggressive. It would break a device that sends a
short or unterminated response. v2 uses "%.*s" bounded to skb->len - 1
and drops the error return.

No real hardware here. Tested with dummy_hcd + raw-gadget .

Thanks.
