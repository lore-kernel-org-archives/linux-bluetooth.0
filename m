Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D187F2DC331
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979052; cv=pass; b=kYhJWimzMNsbRKRCI83SCBhpMSrkXYZY0gE+gqLBR7isEMX8o/ZElluKcAnNEYhSEghlkW2wmtoTzevVnFp+X/JaxWLh0AZ/QvoU6isFi8alrgvhSPfwJq7ZwysG2iKw80U2vFgMVpFbNwaVsmI4HfbKxMU7q9z3mAXuVNn3MAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979052; c=relaxed/simple;
	bh=yeSMktEr+h6gzRZeDaGKdc+6aCExhluNrP0Ri7r2WWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rnb+y5bTRAeLLS50DIQewydeRHVN4ul/q6329m1reGhqf5lgDWIkmRpwTOfQZYErD/Vs1xCLSEKbRYDUYpFKfKKF7BUWd7X977vqmUYy2fAcYa68dAbLm82m6lNZndr8laKAaq3P4/bN5Sij6sz7JbIr5y0FGtX9VJ1VNeshrwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lb6PAE+7; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lb6PAE+7"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81ed2a06b9eso29467067b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 08:04:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786979049; cv=none;
        d=google.com; s=arc-20260327;
        b=br5vPnNizF7rnuc1R5Q7JV6sBolSL+tSi3NWAlEXMcWXSBw9sa+ycdRhTCQH6xGAlj
         fupT56tvmEno9NYxNWd9TO6f1FbFAFf7xt11SC2tsJRvx3Ukwl99bUP3EEBvbIJDxxju
         cGeXpaA5e0SjQAW564uvxgLyDyRQivCWsNEjj48cDUELiduwqmFUCwztrrZ8Xajx9+8a
         a2A9CAJZ3j35K4PY7WfcRrmWs8jvQhk/DqzNihgKnMHxzJ1CVHIcgWV43ct7avHqJESp
         9yHM9PkzRLPYDo26IljyctBwEKpQv50crE3qiEtrRUAspRCI/LVGBpbHiru74rU73xeQ
         4K8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UYxbMwrFj0YllMJlVb2TOCPcrFM7uSVrAKSqvUmgR0c=;
        fh=9NTKsbmd7P/xP7Zbw45MISfxJcO6205B+SGjyDeQN4g=;
        b=meMjBvs0gnRxpdZvgMKOaCPJrHyYSzPFXzHzunCL8tRo8BPqZps/UDlog/I3Rhut5D
         Wq401kxIi5gQfzRMb7gpgI4OYE+e5fXooQGfzwb0g+0lnCtCesO692U5TyiYvMPlgmdX
         lWxqJV+4bRcI6mKByr8c0iBtlZsPFipGPF+wRJrNglODqfRXpGPIPX67LfxmIrnzMj8D
         CE80TzWL8G2k70Rp0bDpHPUVzyGVKCG9hp35mshzson7L/pGszqngYKhXHH7UgPRJnUc
         ykcRdyT8PFxWNal3uviBwbupUdrJuZiKsV/rLs8ZM5gO35acNlYB9PRU0Djpkiw/k6ls
         K9Gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786979049; x=1787583849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UYxbMwrFj0YllMJlVb2TOCPcrFM7uSVrAKSqvUmgR0c=;
        b=Lb6PAE+7GfparUUwT231N8Wfu0nuVNJNaUd7hdLKjnOP2qTRtbWGwL8EPwak5SuKBF
         zGS0xxmmTaHj8LRbYr7X5rV00MMtjQ69PbjuynvYKKQKFBpdhe8Socdm2t1xHlReByUp
         Yqbs3/fjvsR0iaLMmZagfeF8J2DBPxNPZYo+CXRGdHdcxfEsRxijWotNizddxZZy+AD1
         gn3BgGOxz5iLAWNiJn7wU9NkdJe1oTLdWcqU0O21caNRVL1uliEI3+yas8TiPgFBhGfO
         gxJCA5edCTs8+GX+tLmXfzGR+ooL8zaPDVkkv7DdMAzUERtCDxezpHI0eryZzOe3rgj+
         wqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786979049; x=1787583849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UYxbMwrFj0YllMJlVb2TOCPcrFM7uSVrAKSqvUmgR0c=;
        b=Hu8Wh7pG60THILGr5oLrh7yMXM0dz9QsRHiOCVFTfJu7XEulzyHnVCU//YBueFJ/9V
         rbyZQNYGFQIucDiim5Ku+ZngkDgOIDRQxZ1erSAu5MQ44dvfL2Y180UcahNpO2N4XVs9
         7pu6sUWHhHT6sU0i1mGw1/XAo8qlGvTZw3s/Yid65b+WatqblE0N8tFHLbuF3JJemJXR
         yCkpqZ+oOFfuwo8rVfsQZcK3DcOtbKpUtd0GjXgy+mo74p8/fIN58Izsf881igwQCwjx
         CanAY2Ffgl6oTcOTaosQXOal78OChDq0ru4VHn8Q679jQx7cLbRBKsEH/hHDjJNQkVv7
         xk1w==
X-Forwarded-Encrypted: i=1; AHgh+RpYw1eo41rvxso87caEhOG0OtN7jhNeAYvQTsQBwEWz8xpH9MNWww8JxnqO4wvW2SXwr0phYb3XnFcsiIIRhrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSKt7qYJ2YrRoX8Z7mFzYmVk+DQ+5Fi0w4AUQZpg566XFDaSxK
	j58tKdzQOvw+K55YNUGTAv50vqSB41WV8TK1+SVLGfmHViux/jcaoFR78LebyvW9eHDguqYVkZj
	4KxUYvJVb61BaONlMHJKdJJRrSfXP2yc=
X-Gm-Gg: AR+sD13XlE05XlIB23jDMw7YdNmoPP7EffAxiuiqzwav9Wb087SxUt8rQn8/6SMda56
	c4Rxg/KPq140zt9veZxBk9V1P7iAyqCfnV92eDB+pcbvi0F/GsbTu42nPvLQ+YYvX82OYJnlgID
	M6yRnoRFFOwl8Dn1vNXgCEAQtpWUSD2ZxWWwjqEG8VClDVK/F77F32VPdHko3cJpwDEjPODO3y4
	2ZtJ1JQM/ptSCerYwFn//Dm6Tq8imlJJOcxewqbEaLb+LtF5fHwnn6dfqLgWOi0zEtPgtf0v200
	uWbxw09MSy368OdIJUgC9159AM/SQOc6O1CYwal/FFbhhaBKagK1Glik5s2jcqIh2c8Iu5pSDHB
	PnNgu32qQKf1QvaRoY0DnP0OMDg9H
X-Received: by 2002:a05:690c:e68d:10b0:80c:ebd4:762 with SMTP id
 00721157ae682-8370ce2c2femr63658857b3.7.1786979049393; Mon, 17 Aug 2026
 08:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <abwS8q6yvVAGI-ci@v4bel>
In-Reply-To: <abwS8q6yvVAGI-ci@v4bel>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Aug 2026 11:03:57 -0400
X-Gm-Features: AcwNN1VvrafkESkdmYIbXt-LpMAv3S-N7JNuFOOrLgmXYHHjqEwkJDA2h8ul0ek
Message-ID: <CABBYNZKpKCedSeLt2ZWg279z3nLF_0=s5rEjGX0dRsNXc4-8=w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: RFCOMM: Validate MTU in rfcomm_apply_pn() to
 prevent infinite loop
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hyunwoo,

On Thu, Mar 19, 2026 at 11:15=E2=80=AFAM Hyunwoo Kim <imv4bel@gmail.com> wr=
ote:
>
> rfcomm_apply_pn() accepts the MTU value from a remote PN (Parameter
> Negotiation) frame without checking for zero. When the remote peer
> sends an MTU of zero, d->mtu is set to 0. This causes the sendmsg
> path to enter an infinite loop when fragmenting data, as each fragment
> has size =3D=3D min_t(size_t, len, 0) =3D=3D 0, so the remaining length n=
ever
> decreases. The infinite allocation of zero-length skbs exhausts all
> system memory.
>
> Fix by clamping d->mtu to RFCOMM_DEFAULT_MTU when the negotiated
> value is zero, consistent with the initial value assigned in
> rfcomm_dlc_alloc().
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/bluetooth/rfcomm/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index 611a9a94151e..f9b428b1f1c8 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1423,6 +1423,10 @@ static int rfcomm_apply_pn(struct rfcomm_dlc *d, i=
nt cr, struct rfcomm_pn *pn)
>
>         d->mtu =3D __le16_to_cpu(pn->mtu);
>
> +       /* MTU 0 causes an infinite loop when fragmenting in sendmsg */
> +       if (!d->mtu)
> +               d->mtu =3D RFCOMM_DEFAULT_MTU;
> +
>         if (cr && d->mtu > s->mtu)
>                 d->mtu =3D s->mtu;
>
> --
> 2.43.0

Looks like we never processed this one, that said I actually wonder if
pn->mtu of 0 is actually valid and perhaps we should probably
reject/disconnect.

--=20
Luiz Augusto von Dentz
