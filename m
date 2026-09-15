Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18614499BB
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789501024; cv=pass; b=cmO0vQpjcDG6wjzBF0sAQurQdsK0jVWJUbDeN0H8js+IWoxzozIaK9G/h5qlrohw4ttchtHhiXf9xmYwIj8B8a2gPTLzwOVntrUDYUa2DxXOUJS6+gs4/V8/pdM514xn3xWP/SPCeD+60T4WgTDc6/w1OPxleBereTsqq/KqmxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789501024; c=relaxed/simple;
	bh=Z2f4FQ8va33TGvYyGtCEXC3YdwZgKCv0QJI6Otw6I1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLmG8qWttRLMnKItKgcRyJJD1Ec/4wF2Higl0JKsCcAOzfLGXHXmMarRfuUAm9NL3uc53G07XzXqFvs7NyAQFnf9p7E+Pu5qEhTbRs2CC82+Pan9P5L+rWquLcK6NtRsD7HDUuukbLz+XhyGBbeaCYGKM1Mls73XXFPbjcKkVOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKn2G4wd; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKn2G4wd"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85d46e4cdcbso581967b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 12:37:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789501021; cv=none;
        d=google.com; s=arc-20260327;
        b=K3zrYPOWVBeLhrbe1McmLasykb1KuYG9d6eYpzguitd0VcvqIF0D+75MGDseqxkV07
         Gkhnj4jxTCYgi/tmPchOJKGqAkQAgZMAfyzU5+iMXDqk2VQ047iemHbYLyMSNTKIzlWK
         7MXjq+9AWoxVne0as313gcQGLKcY4xEMcEkTjmD9knORNTVXIy6XouAOwZhqEoybQ18l
         d2sdZeEi3FQAUOlPkXyzsJyPFNVUfD6TMr+cwOpyVMl9W0nQNZbMQKUDfRjQFnZcRRxo
         FDVYZ6Zi+Ho1cggD2nX5UxGO3Son4I8cyaO5eP/BDMVdxQHyQ75eaiLIQ8Lqlq9t3M+h
         RfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NR8RlaqooEVk50qaakjuofXzFH4w/MxQZ1es9fZiI7M=;
        fh=zFl9by+mCxIXDc9cKDwTj11iC1Wd38grwlONRLT1ClQ=;
        b=gOIEg79HOwo570cxRxKbmeVRNg3frosAdBXjKaSUh737wMDwpOQ39uVHtL3RnS05t1
         888SlqnwzUgYDd5LwiWrWbkLgfzfP9mDTCd/F6H0JIfPUMvAS5Oiaf42kXtJOqxX7cy0
         VMd9Gfff5u9+BI3Xi+Rfs/b8Pm2efB47fpvnNADR9KvH1MEg08qw1AnCAte7iPPUCKed
         mKmMGYdFDgoKTsnD4B410cSaoJCB20Rj8MLOubYnk9s+xQ5+YMeeDo1gRN5zFaFCFFOX
         FaGx1TWDR6GcVCz0oErOE81a+WE9+YnmNLTMPWXGtM/vWhaXhvZmWJQEByg66vdyv6TY
         zq/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789501021; x=1790105821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NR8RlaqooEVk50qaakjuofXzFH4w/MxQZ1es9fZiI7M=;
        b=fKn2G4wd5oOdkktuabzRYBZDbglA+QrMTqjNscZoR/nO0hwyZDokFwRKLr1u5vEAVM
         VwVyxJ8Nfp0fvRVjtlfaZ004r2sfDffWNvoYN/CKNnfmDW/k/o9ghDGLWCSo3+dz4dNQ
         +vQ67dZdUwzvM38DEoliQNIgAFo+LMaN/wSCuUkzyEYdooAaFM41OaLlLmuNxXMQOZhY
         W17DBNuA9wDVrcRW5RTXx0V/VAZaRiSmG3532wCjfFh1VUqU27Lw0HSIK0lOuDMX75Lw
         5aMADngVIQA9WAZ7A7jY1zVQmpHSO8JatfArZUyh6FHgT12S0sAb0TK0iWuG68wuzczl
         IVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789501021; x=1790105821;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NR8RlaqooEVk50qaakjuofXzFH4w/MxQZ1es9fZiI7M=;
        b=GoOHXNjHe4L9vMtkYKV6AlJUi1cs5AKbGJRt3O7rVMRcDNTdeaXLs1LQTMaaRFtiS6
         rewSy9NPaPTw93Iw6fwxU9Vls1f/TD0L0YqCOmyHnYl9q5VoaXcSAAHQpM57P3XLMbLe
         rxYUhIkOBrrBOvs+eYYw/544y9qQX+YWDzpPfCbTagHBjlo44eFmZaISm/2XUtAyWZ+a
         Pfke+MoSfDqXsntViMJb1xcxIeM2czDxectYy4j/QpRMZB/szwsaF/JDYIr4cc3ZkV6Z
         Ii6b2Z3x9gcZIAAeA5Bx/KvgnGVqlMscjZYjRTFW/vWMRU8seT0bZK5btCBkdvp6pDXO
         XXsA==
X-Forwarded-Encrypted: i=1; AKwUvByUCMtFR0mjxRrxiYZWYIWfS2Pkjv0xjKdF74I/JenbstNO/mFhpoRzRAjZPh9hJiUx79b6PJxHS4UZBJLnE6A=@vger.kernel.org
X-Gm-Message-State: AFuF++mwmyIX/ttzrUix8CYZ5NKO+zCiIsiThZqzE1JvFHJ2VK6gRGDA
	DWaItOujSjNhygEQHE4qjiHM4u+F2XIYYFMXtWGLXEAv3anK00HA3u1Snjc4KxUTyCGlOfM9FxD
	O4P9IDWnKRYpD08yJHTbiXqkIABtA7tYQn/nx
X-Gm-Gg: AYBFou1Mjzc92DPgz9HqhsdLTb0yStLJCVmdZSJdkg/8xEWlhUyQ0pbxOt5HOknmVQ+
	WI5fPUApJyiZjHLCvUHgAsX9EWWqm6xKRds4rlyTtmGWBq3tawDD2PtgkR3jW6VuRoo5FDuvfoc
	+3kxewmW2fcR05+u1hd5QM8bwA6VQ3wZeE55l7cfgcTw9DtHwYyva7wg7uAD4OTpYM+/KvEpZAR
	cxK34Wwr/DAvYjedQEMRLqHMUQJFrw612/LeI0TBGELi50IXgwZ36uAHKPWqusI/YLl6R6R15aJ
	83Cil0f3pkf5oBAGlWxd/BZG65GajcR4JWnDZ4Qy0rSLLyUrq5RZmeATgs3y7PxtG6UK/Gh1xwW
	TwQnHlcoN8vwP/1I2lLbOu7bRPxUOljkVKoZpOTaMUg==
X-Received: by 2002:a05:690e:1685:b0:671:158a:ef96 with SMTP id
 956f58d0204a3-6714dfc87fbmr3560203d50.11.1789501021567; Tue, 15 Sep 2026
 12:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907172648.457103-1-luiz.dentz@gmail.com> <20260908135708.552fcead@kernel.org>
 <a0e8bc1e-c237-41fb-b448-9594bd484cfe@sirena.org.uk> <CABBYNZKrSve8b=Acj2qu0YBuEZ9u9xHJe-ffRb+78x5KPY8Ntw@mail.gmail.com>
 <d5676b70-f60b-4ce6-b6e6-de564d5c0a29@sirena.org.uk> <CABBYNZLKnQsypBR8Kbx4QFL9KfnVXRhO9_d5BHYQCabVZSY34g@mail.gmail.com>
 <064ec40d-66bb-4f69-ae1c-65cfed3581b4@sirena.org.uk>
In-Reply-To: <064ec40d-66bb-4f69-ae1c-65cfed3581b4@sirena.org.uk>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 15 Sep 2026 15:36:50 -0400
X-Gm-Features: AcwNN1WZSrhgKQi-A-4IUp8r81RK4e1x4QppNN_W4nJerIvw3znNgB3XikJm0fQ
Message-ID: <CABBYNZJWcrvkx=6DekHxZzcrGjHwiqmSuwXqzHNV1=7BctThGA@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-09-07
To: Mark Brown <broonie@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Tue, Sep 15, 2026 at 3:24=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, Sep 15, 2026 at 03:16:21PM -0400, Luiz Augusto von Dentz wrote:
> > On Tue, Sep 15, 2026 at 2:26=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > Given the issues caused by the unusual workflow for the tree I do sen=
d a
> > > lot of reports of issues in bluetooth.
>
> > Are you referring to the unusual workflow where fixes are merged to
> > bluetooth-next first, then to bluetooth (which changes its ID), and
> > finally merge to net? Changing the order to have Bluetooth first and
> > then bluetooth-next would require reworking the CI so it could
> > determine that it is a fix and then use Bluetooth as a base just to
> > avoid ID changes.
>
> Yes, the routine cherry picking is certainly part of it - it's not so
> much the fact that things get moved between branches as the fact that
> when you have the same commit is in multiple branches and then build on
> top of one or both of them this creates extra conflicts, often harder to
> understand, when the branches are merged.  The more normal thing would
> be to apply once to the right place, or the standard fallback from that
> would be to drop the commit from branch A at the time it is moved to
> branch B.

If I merge to bluetooth, then bluetooth-next won't contain the fixes
meant for stable/rc, so I will need to merge them back to
bluetooth-next immediately it order for our CI to stay current with
the fixes.

> You do seem to end up removing the cherry picked commits from their
> original branches at some point as part of your workflow (since there
> are hardly any duplicate bluetooth commits in mainline) so they do wind
> up being moves AFAICT but the duplicates get left sitting there for
> quite a while.

Yep, once before sending the pull request for net-next, bluetooth-next
is rebased on top of net-next which brings all the fixes already
merged back to bluetooth-next. Git is absolutely fine with that, I
don't think I ever run into a conflict doing this. Git detects the
fixes already present in net-next as duplicates and eliminates them,
so it really surprises me when you say you are finding conflicts, not
just duplicates.

--=20
Luiz Augusto von Dentz
