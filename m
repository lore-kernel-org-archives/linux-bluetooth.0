Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F295C34750D
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111638; cv=pass; b=mtojcM3+pJNNtsBcR1fyA6rjhyzTdcT2vqpcKVwLuast+zkTJIBgj5WDWodzrset9KGl6I96CGzhPGXb5+9ICXZcABtx9iANJwX7q8FP3m0b4hgcgUXQwd+EEsK3fxi9Qz2OIuqYNAas0OWTPEwRVQpo1OzB0e0Dk6fTLvhW15g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111638; c=relaxed/simple;
	bh=RErhEsQs2Hc6r2DUSHczI57A2dhYKImKPCppGHJn1s8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRUUw2f+NzQ30R3U15xeG3+8KvvN6MrlIHy5qbNNKLsOyco7PKdpz4Yq1vKdHFDZRgZovuPJWOqIvqpA4RyN7bogHssvCut/tFOSXVPeoXK+2Q7uQOoepJ4NfWq/lohkWIf4Pc1dJKC/Wz/GCT3+6hstMtt9NeKXInQ//+EnnxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVGAIsjl; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVGAIsjl"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66043ecf6b3so7000615d50.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 10:13:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781111636; cv=none;
        d=google.com; s=arc-20240605;
        b=DZ5EIckXlL5ad/cAreQR18T3xgyrKHjddu69e98G/Ch0yYqW0DDPD5noKXStKTFXfc
         scMQHntiWjecY1ksnztDbFfg7hQtJ99RYX7nB4qAtD7MjYnM/4VY+4YumGljMfK1skxB
         XxsrbGUvF9BIzNhXFTaAG3kuckQi43ZV1PPgVv63Xnt6+8nhDyYCtTVP+yBVIhhdO1/u
         9TTZUSF+arNYTe2t54HxseIn352lZB0Ewip9RXNGYTydb5DbQbGshUaSjAzVUdXj4k6L
         dbY0N1c56JwOL8UhuSzHTmub/e6qEIYryEYBJ4SXkwCaBOi/rwpMk+qQ5GvpAgu+/rpg
         KoCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RErhEsQs2Hc6r2DUSHczI57A2dhYKImKPCppGHJn1s8=;
        fh=fb11OuhMthBbKBoYkAhNsDKxC103sX96pumkRxYxpXo=;
        b=kMhs0m9fwY6PI+XjUaBQFx241I513i0ztBNS2Wm4hAFr1N2WwMZYhEXQmWopZQP9yl
         hKXd7DxB3l4fuGfMaWYhYqJ9NUF6OYpzGrbSj8ruyxiupF5a8Shr/WKUacy7362REIeW
         6mcM35uQQAjvuUTXN1k6Xhx0ucwK8PW1T9SZ9fCs+cJ1zfdZUQ3lNY2gSGzDO90/bZVU
         XxBMuxBX+x3NRweSKqjp6BxwtnY5QzdizI0PGMqna6C8DAk1r+0hEuHQUMwS7OY7YWNY
         F//2+wrCpqrNiOd+uUhuyQkAMx5qchAuXrVRK2tGLxipS+ynaHeqwV5DUwiONGBWNR6+
         sueA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781111636; x=1781716436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RErhEsQs2Hc6r2DUSHczI57A2dhYKImKPCppGHJn1s8=;
        b=BVGAIsjlt0uV3Fhc0oIbT+RRf2/nrHTxhoLSoGkhM2HTmF0N9M1UJPawPEPtos5ne8
         i+AHRjpamCo36ex6JXy99lodzSR86ynFGdMuwOkqRy3B1mHEv2Ufw0/zxdPyh4Ki8T27
         8AkCNPLztuOKRXTCyvTIULsmFRonE+/Z+gMo2vclvXtkdTkmq9e2wnhc8sZ6GtwjivMX
         V+5F4rsjiiAjotxmVqv+nU+51/v/PnWgjTCHZJLrlxtx0y62/YRcO1FLIsDCvdnQXhn4
         w4E/HjHEq4THaAozDy1jN6GDIqJlxZLF+aW6TkOC6TW6jIaD/Gy4ZM4IainE9+h8XOyg
         dMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781111636; x=1781716436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RErhEsQs2Hc6r2DUSHczI57A2dhYKImKPCppGHJn1s8=;
        b=Y2W8b35JNFA+xpGlA3Gn1jEmZzFRWd+XvEO7PL8ru7UgvLshowtLiCaZJcOq2XWkAU
         kenXDSGQoRFhqoU8v96rHMEeAaxUrIWQo6lCpXspNoQ5W2ShZtZ8qWdTao/0j3rAqJgL
         Q/EiZicCrJCayWjO+PluMg4Bt/FsNRKlroCsIyQEFqs/NfrwNttmc5OkHBLmtzKm2/Xz
         32xXBNygH0nR8XdMWja+kA4HUD+m379UnYDImbKQsUNDWzPds0283OV7AVLT8wmfEb/5
         XvlzmfCp/CKZf7HziXVvgvMn2HD4Qn7J5nBV8UVeHb8YeWdZclitm+gvRK6RTTEQHaix
         VaNA==
X-Forwarded-Encrypted: i=1; AFNElJ9uBi6NloTPP2KGMyttqnbu6ooo6XoJyV1sXbekI95q0uMS+Uud9vvX5g42V6GX7sJ9SIUOrNCmgBZ4iKCIWjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpOfUfvNcfrBCnSDk1336gkDM3Jzc1WfoiEHLfyfkrpR80tk+o
	ap/arhmLRhNyi+HN22pvxbrYzL2kj6w/e8z2WxkoaJj2/uaLn5DLespdLD2XdDxnFHboratvhW1
	1MSiL/8YuYWNtj7wBdyWDOuXt1r68UOg=
X-Gm-Gg: Acq92OHss5uxTm+WwqCr5E1s1BrSOVvg2P9PP6hadeaoGSRcvZuR/MNRIcUqXqV1Alq
	OZDLx8PQLfEEQgkAE0UX4nI+AiunAdufSLXYvYvC6yX+2L/1tFRqXtaD3U79dK3dt+CB9DNfjW9
	Cg4kvjvOMyhYCN4haFgxPcZUUK9k/+Gr9GGubs+MttnZB/emqnfPlbVH5oSq/6YL1pxLDakRFES
	uDputGdIX/PQ3ffZ4bwmv0s804zTEcqdXsj4cmkwdu+DmXrmrtvCq3L9Rd8MfYy5jFNYI7vob8J
	hSTR2Pvdnvrlkh3XoZcuNgkGoO7U1U2tT9etb1jZ7aeJaMvgA3qV0uXBb7eJP7Ty8pPZ/2ia8i6
	Hc0q9j9696z56AAw=
X-Received: by 2002:a53:b88d:0:b0:660:82b0:d38e with SMTP id
 956f58d0204a3-66106f8de18mr18309309d50.52.1781111635941; Wed, 10 Jun 2026
 10:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504160940.2168650-2-u.kleine-koenig@baylibre.com> <aimXkX4FC4JVxt6q@monoceros>
In-Reply-To: <aimXkX4FC4JVxt6q@monoceros>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 10 Jun 2026 13:13:44 -0400
X-Gm-Features: AVVi8Cc2yCwPpJgRGZEngfFOksAG5gfPPMtu7ftS2bMAppzj9N6wERU4TkZ0QcY
Message-ID: <CABBYNZKuOdtxa8ksEZM1FyjYJCQ22H6NzaX31t6LcZuvn0LMNg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm4377: Use named initializers for
 pci_device_id array
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Marcel Holtmann <marcel@holtmann.org>, Markus Schneider-Pargmann <msp@baylibre.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Wed, Jun 10, 2026 at 12:59=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capable=
 Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
> On Mon, May 04, 2026 at 06:09:40PM +0200, Uwe Kleine-K=C3=B6nig (The Capa=
ble Hub) wrote:
> > Initializing a struct using list initializers is hard to read, compared
> > to that using named initializers is more ideomatic. Convert the macro
> > used to assign values in the driver's pci_device_id array accordingly.
> >
> > This change doesn't introduce any changes to the compiled array on an
> > x86 and an arm64 build.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig=
@baylibre.com>
> > ---
> > Hello,
> >
> > this is a preparing change for making struct pci_device_id::driver_data=
 an
> > anonymous union (similar to
> > https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylib=
re.com/).
> > This requires named initializers for .driver_data. But even without tha=
t
> > this is a nice cleanup making the macro better readable.
> >
> > Gcc is happy with simplifying the assignment further using
> > PCI_VDEVICE(BROADCOM, BCM ## id ## _DEVICE_ID), but this is a bit fishy
> > because PCI_VDEVICE also assigns .class and .class_mask (using list
> > initializers), so I didn't convert that.
>
> In the meantime I learned that doing that would break W=3D1 builds, so it
> was a good choice to not go that path.
>
> > Once all pci_device_id use
> > named initializers, the two zeros can be dropped from PCI_VDEVICE and
> > this entry simplified accordingly.
>
> Is this patch still on someone's radar? Ideally for application in time
> for 7.2-rc1?

It is no longer in patchwork so if you really want to get in please resend.

> Best regards
> Uwe



--=20
Luiz Augusto von Dentz
