Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEF628C869
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784383740; cv=none; b=QaM8dsTdjVlJAy1p+lEnDTeAsCjXK7fVCOsikaFPmroWw86NoxLF0bMKPc1r9hJfpLWuvVfrHDuqhFspG1D9ZNwdTQMePD8d41J7NQrHpbjnpigCcztYyaZWfn6R05B6qtQzULud75iSkbn0xaDHy/Kfbk8tIO8hCF9nLB35TLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784383740; c=relaxed/simple;
	bh=Dn4+/xgeieh1LHD6He5u6OXfezns/RApi+yaHTB7VZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOCRH1XqkJEpc5VFjuuYZ0qvcQms4nGoO0vKFuwFs9tBrAJ3D8sQZxABupMecG0lbl3NzHEE9H04LIwXr/au+a/gkvz8WJ5Vwd48dK/ifeuvV9FE6R+HiyQP8hSZAGy3KZQxC+VI/hLCSz1xLzxj7vlqNMKymHKnLLqGTN4VYEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=kubo9GHN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="kubo9GHN"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47df6a5202bso5994461f8f.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 07:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784383736; x=1784988536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dn4+/xgeieh1LHD6He5u6OXfezns/RApi+yaHTB7VZY=;
        b=kubo9GHN3kGUCFq6o5WzqWNM2Mo/p+WtK64mXaYU3mOgKewyb7gwcJQUwUUIxVGb/S
         Dl5N/svNwzhfwLrke3d6TErNTyuXOtAfYmeu2v+sINuwugBsSe3/7orzc32Q9VkR7+vO
         TTUXWD0XQunurdnRzqauuY3Hqoojxi+h5M6cdxlSb4Uqaw5N3akfswaWlf+tmr8qVjK9
         srDcJul371u299WQWrtqVUMTM+g5o63yjQ7ext10sQDdODEsCUSSELTXhWwQvut7rDal
         XChhaDkp2a2JdYdtJAmu0/zbyuHSbO43U82KCsvTi/UV9S8FB8hCTPafaKGWwipMHU4e
         v8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784383736; x=1784988536;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dn4+/xgeieh1LHD6He5u6OXfezns/RApi+yaHTB7VZY=;
        b=dwuJAh2N/hjBrCiCBsjcghFsBQ9JdamGKeRnqFmRScCfM0TMDAfTvYwDVfdj9g2lyu
         2K/8+wKQV5R+3dlZ/CS0yu7gg3B+3kJEbWyrgZVCjT6AxPmXCfkQwZ5GK7LPOIfywgXN
         L3jG+YBDgWy9xabR+vck1OSDnktTDHtbEA7x7/O9qJRLQqQa9967pVO3BjsihOu0MstJ
         l5vDiNcPdT2Q/KgwZ7hBcjEFFlOOYpL9c3bP1qvEaqk0Y2bTlH2Eod2GPcUMzw/wFWoA
         970nDZIHrpSMl9krHddNaXzStueyXqzVehIhUdGEOU2Q/GJW9vOUnkN3kAjMVEA9tIo8
         MzIQ==
X-Forwarded-Encrypted: i=1; AHgh+RoJlhC2l99oWjhSUvmxARqa8eu3hma31k0vI4toXUy5a6Z1ojSvKT01ZjW8kiCZ6VYLTvklGAWUnCgBL/HhhDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcNrhLwzYh2Xh9rGxdK3WBPDXUGfWIOcU+YWuc0bfdObZ510Wd
	7uNHtH4TN/Xw5cZbcQOghNQWRXINwHc7XX5wgKZbRILU6Xa4O6CbAZ2h2qb+ZPq2YaA=
X-Gm-Gg: AfdE7ckjgVYWgUDRledzfF+FxKYGTBlFxtpAsqxbdvFM1Ru0qqtR0PEcxUyyuQlismp
	7dJy10OjORP6oGnTJGE/ks7eTsk51FdPnFvG36nZ8KjjxEC8aFaOkxBa8moQ9emiAzv+//8Cqv7
	emMdqf4ahXAOlg7dqJuwQ4GTxFKPxIkkxymx2mVAVs+5wdbtPo3VtRsY3xX0pBq1ZCEItXrx8WI
	An85La5GL+ouNNXKpDombw4fJuhxBXPacf43STgz96Oo1C8e8RcKV8WMwGTnVQan1Ef3XkNknKt
	xtjT/n8zL0J91LdLow39u6venaQKSbYTjViTn50yvauASF+OVYNo3g8L+qxoFrLg9IbLOXMkjbY
	C5wK7CrcrD+Yo5VcTNPszVVNE+dhmcHSrKssQ3FtiAThrAeey4L2js4vYyx3DyGqjSwHdJSyLZl
	+1g6bHFNQ=
X-Received: by 2002:a5d:59c4:0:b0:479:37e8:44e7 with SMTP id ffacd0b85a97d-47f62330be5mr9388858f8f.40.1784383736446;
        Sat, 18 Jul 2026 07:08:56 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f63e49ce4sm13571967f8f.8.2026.07.18.07.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 07:08:55 -0700 (PDT)
Date: Sat, 18 Jul 2026 16:08:54 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Marcel Holtmann <marcel@holtmann.org>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_bcm4377: Use named initializers for
 pci_device_id array
Message-ID: <aluGI7g2BbOsrjoM@monoceros>
References: <20260504160940.2168650-2-u.kleine-koenig@baylibre.com>
 <aimXkX4FC4JVxt6q@monoceros>
 <CABBYNZKuOdtxa8ksEZM1FyjYJCQ22H6NzaX31t6LcZuvn0LMNg@mail.gmail.com>
 <ainSCcYroJUIAuwr@monoceros>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bwnxy7zgptzm7mmy"
Content-Disposition: inline
In-Reply-To: <ainSCcYroJUIAuwr@monoceros>


--bwnxy7zgptzm7mmy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Bluetooth: hci_bcm4377: Use named initializers for
 pci_device_id array
MIME-Version: 1.0

On Wed, Jun 10, 2026 at 11:08:49PM +0200, Uwe Kleine-K=C3=B6nig (The Capabl=
e Hub) wrote:
> Hello,
>=20
> On Wed, Jun 10, 2026 at 01:13:44PM -0400, Luiz Augusto von Dentz wrote:
> > On Wed, Jun 10, 2026 at 12:59=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Cap=
able Hub)
> > <u.kleine-koenig@baylibre.com> wrote:
> > >
> > > On Mon, May 04, 2026 at 06:09:40PM +0200, Uwe Kleine-K=C3=B6nig (The =
Capable Hub) wrote:
> > > > Initializing a struct using list initializers is hard to read, comp=
ared
> > > > to that using named initializers is more ideomatic. Convert the mac=
ro
> > > > used to assign values in the driver's pci_device_id array according=
ly.
> > > >
> > > > This change doesn't introduce any changes to the compiled array on =
an
> > > > x86 and an arm64 build.
> > > >
> > > > Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-ko=
enig@baylibre.com>
> > > > ---
> > > > Hello,
> > > >
> > > > this is a preparing change for making struct pci_device_id::driver_=
data an
> > > > anonymous union (similar to
> > > > https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@ba=
ylibre.com/).
> > > > This requires named initializers for .driver_data. But even without=
 that
> > > > this is a nice cleanup making the macro better readable.
> > > >
> > > > Gcc is happy with simplifying the assignment further using
> > > > PCI_VDEVICE(BROADCOM, BCM ## id ## _DEVICE_ID), but this is a bit f=
ishy
> > > > because PCI_VDEVICE also assigns .class and .class_mask (using list
> > > > initializers), so I didn't convert that.
> > >
> > > In the meantime I learned that doing that would break W=3D1 builds, s=
o it
> > > was a good choice to not go that path.
> > >
> > > > Once all pci_device_id use
> > > > named initializers, the two zeros can be dropped from PCI_VDEVICE a=
nd
> > > > this entry simplified accordingly.
> > >
> > > Is this patch still on someone's radar? Ideally for application in ti=
me
> > > for 7.2-rc1?
> >=20
> > It is no longer in patchwork so if you really want to get in please res=
end.
>=20
> Instead I unarchived the patch, so it appears in the patch list again. I
> hope this is easier for everyone (it is for me).

That didn't help, it is archived again. So I'll resend, but I still
wonder about the processes involved. Is there a bogous automation that
archives patches after a while? Or is someone archiving patches by hand
that look old? Both make patchwork as tracker somewhat useless ...

Best regards
Uwe

--bwnxy7zgptzm7mmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpbiPIACgkQj4D7WH0S
/k4c1wf+KcoE7dFmw403md8qqMbo0WQC/qoBEezSjlMwYrzakuDItdFVFoNFBiCw
3EObuzygqxIZE1BYccJoTvjRtkU/V4QVAYqS5pildQ4p7Vt09YDxPiUFxQO3Od6o
PyEDcKR7ILURIN4O6peARALntWYwQ4Nzk2NYS03yGSxfNXKc4LIIG6fgrVdcgw+n
HeSwcSRmqXFa16BTplVQTAMtsHC4TUC+HieWosDtJeg03LURbBNLamGWO33DrLBs
qbaU3zNaHSZvoxXUgEI0W2f2U2J0Gn4RhjRAtB1lOfO1Do1QWz/UWUYjgiiwA0xk
JK0AS0bg5Wz9FlvUWkIcrWyp2kTPKA==
=sRN4
-----END PGP SIGNATURE-----

--bwnxy7zgptzm7mmy--
