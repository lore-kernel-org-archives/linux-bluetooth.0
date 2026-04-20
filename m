Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC9E274FD0
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776718029; cv=pass; b=KlAwnruadWOnRxFIpyXiC3tWGlFJtEo4XCL7NnHl0jojb3ymxORV6DFtWyMYJ+3Y8L05r5+4FYbdyDSOvqwlIsLQcfPUGz1SvzIHwsntRCxaR/IQ2msnFQP9ZdF29L/Xcuk9ma8C/W4nnkD6vAZSRYorOtgj1g+kisTUsY2fDdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776718029; c=relaxed/simple;
	bh=EQ381gyFls4AWTGtbPx+Abo8y02DoEXmdw8t9bbWC4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNUMQNMj8J3uEVK2wLmvoZ5Dx1bWw83CtuIGV90ATJZqvSPv7rbnnIkKimwZECTSNOlXu59agN8sh1coJ+rWOK/GZ70YbuyDiKFmiJYVjnM0AvXIy44uid6e4Wr6028xnlae+RqLkAlaHNQYw2bQRmd1gN1bwWDvqKjqg2uIBpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rs1FErZj; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rs1FErZj"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-652fcd5a6d7so4009186d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 13:47:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776718027; cv=none;
        d=google.com; s=arc-20240605;
        b=GVrMGj0IzoczCJEbpiQEPzY4yDAM+u1yFGvVoCvFSLofRMFqts9iWQNqvnwOq4Dk2U
         iiwyiYcUhM3NETCamTrdJE5N6if0YakvMf47p6VW+rZ3C1nlVHW+rp6BX+jDEdFIb4VJ
         ZnxKLYtrCBgtV+QV5uNXhu9MYqss0ku3QswuiakXZrI+7uaafxlHz3JWKS3nvFStg0+h
         iowzbPdKan4QHc9IakpkK+1filp3pBIFnh8K+PH+gEMoqGhhg9ZBn1jy/QZqk4KninJp
         RiAYDR7mrIfRzJmFC5rXs42ugk6Qsvhw2hFhXuydsotpNC5aTBtBm5bOLdx/pB7vq/cF
         QXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EQ381gyFls4AWTGtbPx+Abo8y02DoEXmdw8t9bbWC4w=;
        fh=K5zQUEczby3O64dnPbfzyXjSLA+CB3FN6/ny9yikiNg=;
        b=drQ4Kx2sAxdxu36DrE5BmICMAKfobDyCioUd9/U5lrtr8ep9XFh4TKjs0h7KK5nmgh
         gTkaFheCLSAR50pzBBksygAljJwI2FuLrkEGP7oGm1sNsAaH7gR3AcLwzvfpkq6XcZrc
         DGNjdVUNGpp+a/mt7d0uDQsGcp12boWlQ0AygoVY7k+sojJO8H418Esn4gZvufiHy4oj
         m3G1Ntzuq+f7VKpRGTbxsvmAUM1T27hRvEHLU+YsyrcIxpX5MI66ONCTyaFsRMZ4bn8k
         maiVu49g6jwvx0L/IlJnP0SmidL2IONnpoD6gLlCImdFhWotvQuZ0FSG7TfDvyEXl7I8
         3OIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776718027; x=1777322827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQ381gyFls4AWTGtbPx+Abo8y02DoEXmdw8t9bbWC4w=;
        b=Rs1FErZjhllYj/zWS4WVS43ZHxW9+hPweM3fZm6XZprQfpZvSS4ZhNIM/j5VWF+GdQ
         B32kwXRa7FEj3O6Qyr84XDy3aocB3R3biyi4PKKft+LzMmeMnjn7wVX2FB9fLUB9si8h
         xKytzAaILhu4xym3bq46IHUcKIhmURBMjhHBcB/JX6KSqf2KYV3j8cigqWDLWljrc+ja
         PfdOiKi0s5NPgj/kMOqXyZFngFKFNKCagwnEnp8B7lez5dwLcueSPOqGbIazDovNqWv9
         lCjafUpjzczZXeJY32PnT0ci9+KLLu5H0jxOKW5aYblCR7yRJvBy8hmfyO6PLDHRKO4a
         yzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776718027; x=1777322827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EQ381gyFls4AWTGtbPx+Abo8y02DoEXmdw8t9bbWC4w=;
        b=Y76vtRziqMwb6DeTMQq7PeoJLWW3XK0OwJUCt+aupUlqPB/d6WCbZEsyBSXs5WjjZx
         blZty0VNKWmFr0ctd235bvE11N0aUwTpqi9aPbWpn/SNY9NTnCnS9OiCW4FQjXE9SzFl
         Oi8BqolrW+iynsIPTsKEMrziGSVnHvoEMAvY3Rmjhs5d9uDew2gty67f6hrX3rVQzYtI
         4UYzf2HIGMYpkkWypCUko3xxIEJD7b1ee6z91le8iMvFfyhjL1GFUDEA5mFw6s527xEg
         XsZvHAibH2Oa1iDCQ2OJPt/TeX98LSO0rNIxJn03Ia8SQkpLBuVhK0+R7PFJEr43PAeR
         1Eew==
X-Forwarded-Encrypted: i=1; AFNElJ9TXa9yt5ITEHuWC+46kR52iIjEC7ueGOiyDXRj8ceRxKtMlQd9YodGlP5t9XIaOYOpt+uUahi+Mv7NhorZSk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFSz52bTzC1CSFVVxIpBY7N+zt2DRxu9CNNabzUNgP9CxJjnIY
	apntAY/3D5TnzFtCgNlBSAH9VNoCfUAWjC19G4s8Iw7VpD88Jd/5+Zuy+6P3HhOnFRRyE1ffF7e
	3y2aDiVPP4zIQ28194lMALFVVKDWXEy0=
X-Gm-Gg: AeBDiesOoZT1ueCqhY41nMXFyuT0Oh0UymfaMkGoPVXZz8oTARXA4lTcbHkWNHWpD2g
	G3vT9jZ328s2AD6thBt6nEsY5LBkCFXEAfoP9FR/O8AX0wCoGcb3V/JbW77YyYkXms/wQfzeH7d
	JjzudnwKuLuDSQ3FhhXkhoZGeJ8sBjLITREkOipUH8p5EClIKFsFY2Ew/fPqpLPrlxz80V9inGH
	bvXDx29hb78GShBjAvK/+SaNG4825VEmqyzA0sVEOKJ83qgoxm/XD2ZyCQuc6AV9kAJYLYMiszg
	wRp1uNxy7Ode8KnDFM3vqSKuisBBw1QgR0ordRuHfc25j5OpQ/s1gkxfjHRdUzkHdVMS9Efik6T
	5x+Zy
X-Received: by 2002:a53:c049:0:20b0:651:ca41:3ce1 with SMTP id
 956f58d0204a3-65310870e0fmr11419676d50.26.1776718027650; Mon, 20 Apr 2026
 13:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
 <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
 <aeaMkfk_1t98e7SU@monoceros>
In-Reply-To: <aeaMkfk_1t98e7SU@monoceros>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Apr 2026 16:46:56 -0400
X-Gm-Features: AQROBzDn0VxgmPSE3vK5sUClFYZviCWKHJM6c6xPINx44xwN2GgHY3fLhlrfQ5s
Message-ID: <CABBYNZJzbEmYzTk2m+Y8SoHVouTMA6Gje_55iJsQ6cYtDLftbQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in sdio_driver_id
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Ulf Hansson <ulfh@kernel.org>, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, linux-mmc@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-mediatek@lists.infradead.org, Ping-Ke Shih <pkshih@realtek.com>, 
	linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Mon, Apr 20, 2026 at 4:31=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capable =
Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Fri, Apr 17, 2026 at 03:10:47PM +0200, Uwe Kleine-K=C3=B6nig (The Capa=
ble Hub) wrote:
> > On all current Linux architectures sizeof(long) =3D=3D sizeof(void *) a=
nd
> > this is used a lot through the kernel. For example it enables the usual
> > practice to store pointers in sdio_driver_id's .driver_data member.
> >
> > This works fine, but involves casting and thus isn't type-safe.
> > Additionally with the CHERI architecture extension there are machines
> > with sizeof(void *) > sizeof(long) for with the traditional approach of
> > storing a pointer in .driver_data doesn't work.
> >
> > By replacing the plain unsigned long .driver_data by an anonymous union=
,
> > most of the casting can be dropped and it yields a working solution for
> > CHERI.
> >
> > All users of struct sdio_driver_id are initialized in a way that is
> > compatible with the new definition, so no adaptions are needed there.
>
> sashiko.dev found s/sdio_driver_id/sdio_device_id/ twice in the commit
> log and once in the short log. If you consider applying this patch
> please adapt the commit message accordingly.

No problem I can fix them up once applying.

> Many thanks to those who created sashiko.dev!
>
> Best regards
> Uwe

We only received 1-3 of the 6:

https://patchwork.kernel.org/project/bluetooth/list/?series=3D1082520

Or is this on purpose, and we should consider the set complete?

--=20
Luiz Augusto von Dentz
