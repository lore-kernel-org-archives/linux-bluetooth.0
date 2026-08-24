Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCE543713E
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581728; cv=pass; b=L0xaBQaA52XKdPUtX+kJln1Qtj4RzQEth2NxXYFXESaVVsK3eo67n9IcBk8yZxz/GDi+foWAlA1A22zmg01wTpJ7yrfbaxFNK60Mdi7K0hI6yeD4ZshQmCWIQIkInbnt36+xH/VXCatDlZxT8GKsC4w146NLpRi1OeXr57qR3Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581728; c=relaxed/simple;
	bh=jXSal8mmPLMLYM3sucEZPr6s4xK+MWEBsNqwtDllzlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eir/oqUQcjQ8Z8JaGkTXr3m2afS5Cdaj1YwRCadIdI2G/26dezXwSs12WfndXhrvA0YxoGGbrVqCFqtU6l0vvffDgm7dmy04sLLyRXHx2hbM6JAml2Tf0UPDfjVQ0XVH7LDLOnySH3XNpLitt9m/pWT4Yu8wCTiEalKTeIQMDxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pOWwZcin; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOWwZcin"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66c7e3a2332so2305251d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 07:28:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787581725; cv=none;
        d=google.com; s=arc-20260327;
        b=Hi4G3WStAzTFpKL+xRDdgrQj0VF1fUUL1NxYbf+UEkKyNvtYeqvyspER5GpUOHOq08
         Xr1zTZGiHyUE66HwT76LtDAZMokpM9RGNASLzhx/sx5D+iCPqAbHuJgkLoOMwONMbmI+
         EuOvyW8hupvOFZtQxNOBtVjtPYp0KKThEVNMYyMO05g7MMqS8m1ng0PklIeAFXfL021d
         inPzDGE5JtEYUmPzfNLMRaJ8CuTvAjH6QkTENDOqhl0O5d3HIEUz0MWTU8O1Lhlu6+Q/
         LtXI+oRbiaXvRKmVwZDQ3L7GJtLio3Z6HHl3DuH2ibDCQpy0rZKdm2dkyJFhkpXz8HLW
         mDPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CQ5UQMtAkeiSiALFgG4dHFcznmeucSwr2O+KBNTV3xw=;
        fh=Ihq42f0kMl9s0ceeGl3E/JgQh2K3IBhapAZ/zO/4CPk=;
        b=pmZFNwjPcNURwY5LeIHlzONaNiClV1D5TtXDr88IRy35qVtzBcZUEZ/UGLRQoUX/pW
         zcwY74Sk8JIgMchgWHOKrqgoUdvpvgIhMcSzcntMtJ3RznYBv719YC6/pCnTTlLltNz4
         k9zIhLEXvWtzP9bafOiriiT1N3YHkhD74COQwsqsqHzmg6BHJR90/gAuFZt9GO+xDS1G
         TXX/+caMwxH6jctFZin7Rwkl2/UFq9XlqNOOfHvePRPg/4l0o1yOwHRbqihLiEYmb+lq
         Cbi4D+xPhdpyfhcCmdYm9gpsVXUXphUE5ojVE6xAX6qPSKvZKFrcazvEWh+R0MSR3mgG
         pmqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787581725; x=1788186525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CQ5UQMtAkeiSiALFgG4dHFcznmeucSwr2O+KBNTV3xw=;
        b=pOWwZcinI363Px96KWrOTgCAOwAYrap3suD/bIY5ImUcR99LmaO9BvkZbAnav10QVz
         XJGxUZ+qnbwKkm3obkLwlNULCYFIJhwDb2AWs5x11dqXp74u58kpZTBsO5OBtd6cqRuv
         ot6ILeVEFskt/xq/tjiFIWpd0ku1+Pe5/SOGsicmdAroTLmlS553sN1Hdyx5uaaSVooP
         JvMfE467OYlFayUKBWy5MhX7alOVPsX1wjkxh08hVf8vIZVE57LwaklkJcIypB+xfZkP
         hpU9+7q1k8I8i0QpM9zPOJgbGM+j2h76GfIrb8oAWciByo2cYGzhI8GmUs80c3ZgXj8a
         AgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581725; x=1788186525;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CQ5UQMtAkeiSiALFgG4dHFcznmeucSwr2O+KBNTV3xw=;
        b=gletZV1Z0kMqIEmF1yiCqWifonjg2IKEp8OSjOdug2oIrmIDLjGXqMH7CJsv6D6Keo
         zDJjzIkF38kn8qa1t3uBeWadSY+IfnQBu2CkcEW/ZuwuLgGx5P1cPhpJRnGlTsT/UqDj
         CI6q1K6jUJkwIiboCMGS0v6H/2kONMyY4hbfklnb5tjrQtvPaoZEyrCf/FTBWpnbAy9B
         dVn67ByfCxxoP5i2lYur1bNMz1odzsNIs7lGnVR/Zs1KxFfqfYWgXwZOl+HauZCwT/XS
         A1SkToqhF6LmD3srbou2k7iM3CFS/ucTkQKQ+ee8U8OAKf4fMpCtdMlb3vbFbFjYJnNs
         DQCQ==
X-Gm-Message-State: AFuF++nA2rLKxTxxL/T/YK6luVDbRhY849EGlDCDNceMVWHQUhtCQ3W9
	uDSVX2ODWI+fX+BS/bqEaaFEOG0NMVT6PiaGjU9CaFakeBdsH1MpJLvYBFrWp6K7hC+GG54zVp0
	IlhGE9xteCT/OmINL/HnNLKuZbSFxuLs=
X-Gm-Gg: AR+sD13FtP4oZH0RRlEmQKlU3KvnXCC9xPNMtOwRohyIV7geXJijoAtwZPP773fUjfu
	8j+bXCOGQSGlRjXbCLXmnpCSDuEW9wtslFpdHsKIOPcWq0kwF534QxZXPLAqnCDC1twrJo43ktj
	c7Kqi6ycUZSSbHrzv4pH8AoJGHALeyUlPZkwfMENGGK54wYhSUU6x3tPSO7zU75kCAyLadYHs1K
	Ltl9gRwCHarfPAK/Nate3r+2j9wvvO9KddT/xXrOY1o6f3w6MWUjwhleh84ZEsv3TNgq2DrMiGC
	DngvgYe2mmBdRXzwQ05gQP1uADVAUH1NsQEGADJnRAgQGL2H82C/4gUsTIkgBWiLwL5BK7jxwwd
	8zz4nqnldHESl/lqkM1uyMFon6FDz
X-Received: by 2002:a53:b851:0:b0:667:e855:eccb with SMTP id
 956f58d0204a3-66ce4a63badmr6512693d50.20.1787581724681; Mon, 24 Aug 2026
 07:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823161638.32348-1-acharyalaxman8848@gmail.com>
In-Reply-To: <20260823161638.32348-1-acharyalaxman8848@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 24 Aug 2026 10:28:33 -0400
X-Gm-Features: AcwNN1X92HK-jWCscnHRPBBP8bYoNeBGWBlJBbzIRxHgThuSAl_NogVENm2OBlU
Message-ID: <CABBYNZ+h-m9YQCim5Zm2_sgARZh+jM=POFYX_zTQ=xYUdxz-vw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_codec: validate vendor codec count length
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Laxman,

On Sun, Aug 23, 2026 at 12:16=E2=80=AFPM Laxman Acharya Padhya
<acharyalaxman8848@gmail.com> wrote:
>
> The Read Local Supported Codecs parsers consume the variable-sized
> standard codec array before parsing the vendor codec count.  Although the
> initial reply-size check includes a vendor count byte in the fixed layout=
,
> it does not guarantee that the byte remains after the standard codec arra=
y.
>
> If a controller reply ends immediately after that array, calculating the
> vendor codec array size reads vnd_codecs->num beyond the skb data.  Requi=
re
> the vendor codec header to be present before using its count in both
> command variants.
>
> Fixes: 8961987f3f5f ("Bluetooth: Enumerate local supported codec and cach=
e details")
> Fixes: 9ae664028a9e ("Bluetooth: Add support for Read Local Supported Cod=
ecs V2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
> ---
>  net/bluetooth/hci_codec.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
> index 5bc5003c387c..99394a3348c7 100644
> --- a/net/bluetooth/hci_codec.c
> +++ b/net/bluetooth/hci_codec.c
> @@ -165,6 +165,8 @@ void hci_read_supported_codecs(struct hci_dev *hdev)
>                  + sizeof(std_codecs->num));
>
>         vnd_codecs =3D (void *)skb->data;
> +       if (skb->len < sizeof(*vnd_codecs))
> +               goto error;

If Im not mistake the following code already validates skb->len:

/* validate vendor codecs length before accessing */
if (skb->len <
   flex_array_size(vnd_codecs, codec, vnd_codecs->num)
   + sizeof(vnd_codecs->num))
goto error;

sizeof(vnd_codecs->num) is equivalent to what you are proposing with
sizeof(*vnd_codecs), so this doesn't fix anything it just duplicates
the testing for the minimal size.

>         /* validate vendor codecs length before accessing */
>         if (skb->len <
> @@ -233,6 +235,8 @@ void hci_read_supported_codecs_v2(struct hci_dev *hde=
v)
>                  + sizeof(std_codecs->num));
>
>         vnd_codecs =3D (void *)skb->data;
> +       if (skb->len < sizeof(*vnd_codecs))
> +               goto error;
>
>         /* check for payload data length before accessing */
>         if (skb->len <
> --
> 2.50.1



--=20
Luiz Augusto von Dentz
