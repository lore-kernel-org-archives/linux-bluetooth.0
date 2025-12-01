Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A23431A055
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Dec 2025 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764600233; cv=none; b=DiYN9ZQuiqHhipudxd96r0wM61ojd+8kcLE5H9uzhpxpNIg0OvCbboRJwJtBMubwyWBJCDg2mS0n63bbyioDhBgXrilvI1DDWycuTDDRRy2rM2Kl/hpUtCgWvjViTvRlhnzxNODJGFBqDSkR8y5RVypkiPaS8ryugp7dOKnCUjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764600233; c=relaxed/simple;
	bh=7sd2Yvc9A9hnkbie1tUR2L+M7gpIJ58Ms6eGsKhdbbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GP6Fl6UXBOJWFbdPbMoz/2eeAHFrRLRvn1ctbQQ9RcH3kQMFAYi1+VkakxwrNvjfDOkn1p1VUUTAQMclqtFZCk0dBOOzVg5BfO8QA1O97CVgINeG5zJjw/euYAJka7rNb0YmNSmXjB2cXDGje6CAq7AvahT7KArYL8qKWviLsQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqiloBb3; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqiloBb3"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37a33f49018so34917431fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Dec 2025 06:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764600230; x=1765205030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXm4XXNBHlK0zSa35e35lmG88ehQu8aU+FR755ovgjQ=;
        b=YqiloBb3dhjiPC2rxpp67qVqpKp7kzzaKv7AY12IiXzHo47LxxoflmJRD8fbLmWKyA
         SkNDApSoUZGAAVubNxFwzQgdB5sM44OFDEMMyG635xLefDgrqGLLbk2278goxWOQUpbd
         GiV+67XLKa0ze//hfwwABVUXt2Ji0JmEeh22Y0duTn49mD1Ca76bWcIY9hpOH7b8Id5d
         TSTgX7E7et3JKuvoXKkDouSzpzwr4DzMRaJ+0R2pFL0jXZeEQWAiyrt4m4C/q4vLOU4D
         yJfJKljsUkMy+bLFeeWJkyiSAHqbmWCli+Tv0gShpjnohC8MSxKWEtZzVitTvM+qJn3y
         Yafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764600230; x=1765205030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rXm4XXNBHlK0zSa35e35lmG88ehQu8aU+FR755ovgjQ=;
        b=BGgbi5Is+8Eejd8kGFDm1YGWHe4WrHH6s5LalSQK34ky0dVWIqv9heKdjFrgyLljr9
         oA+vcfVsYwk4RsXRMLhS1AK5EZloA1Jc4BhD642sFoJ0J7dJmdx4OTPF7wxzzRqwwehX
         VD7MmVNvhRsS776F8ITsYDGEKSNX/ONSOHLYfuBgv6RY3UsoAUhwVEM6FZxxDtHFphQL
         qA5KVLo9y+E8HO39HQ7n9CHO3Tb2oOg9MtUhV1e0f4z/A+JOen5m4n18umA/a8MmY9Fb
         L8TGmWYc96tMfaMD0XGpfno0L6aFoAExgCG+N3UMEFaIoLHgU4rOEyqWbF6UTkiwmXxF
         EO8g==
X-Gm-Message-State: AOJu0YxJCN/fIYTdifHGDSGOdxhROU24jYhdwC5JDaiiryz8Ldrjol2C
	86M8dxpmzJ9/BK1/weriFGTZN1I760bv1A1MU0wvkh7AF1705kwTKVpdGrBrdvfssK0nlFBv87k
	rxS/BSRvHjjDGjdSKXNGyC/55TvHq6L+w2w==
X-Gm-Gg: ASbGncuoZz/2nzEvgVGTbWwfVs2OjW1erlyUmwRPB4mRNSXs3XuO+ciwwaMRP4NV4Zj
	EEuzK2Szkq4yl08ei68RTz5Z3uPHaUHPbs14mkhpDlD8cxgTwAw7ZkCugFEtgAcJggqM+6ze2gU
	NHl92MGNBH9GHiRpZTP5g8pqfTN1phZ5b+Tkg6fKwSiVJM5FUCxo1wEOmIC3mEHiXiM/6FghUvP
	5NhM3jVR+YXoF60oavqHixbRN46pjlgtcwPzXMhEP5i5AY/XFmAm9NZ/myEBqEY6q+GSA==
X-Google-Smtp-Source: AGHT+IEHIISZYWOj+1ThhVlJpdOsbZqXO3EMNOSbNWLYNjEqMCzRvy069doyojEWCCeecFckXK1CihQV4hIqy2Ef2wA=
X-Received: by 2002:a2e:80d4:0:b0:37b:9b58:dcfb with SMTP id
 38308e7fff4ca-37cd91641femr91795921fa.7.1764600230021; Mon, 01 Dec 2025
 06:43:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1764360140.git.pav@iki.fi>
In-Reply-To: <cover.1764360140.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 1 Dec 2025 09:43:37 -0500
X-Gm-Features: AWmQ_bm9pQOFCrJIlWYPkvjGmQlW7r09cscwgrJwZGloGZAMPCnKNlpQWzIAR2I
Message-ID: <CABBYNZ+sSTsK3dtyhCd3khpnDNOyYr9q+Vfb+6YL5f=8rrL8PQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/9] Add TMAP & GMAP information services
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Fri, Nov 28, 2025 at 3:02=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add support for TMAP and GMAP services. They contain only device
> audio capability bitmasks.
>
> v2:
> - Rework the service wait to be general mechanism that also determines
>   the service autoconnect order.
>
>   This is now slightly more involved, but this sort of "soft" ordering
>   dependency must know which services the autoconnect mechanism is going
>   to start.
>
>   Sorting autoconnect services is one of the ways to do it, probably
>   makes sense also otherwise, and we could insert service conflict
>   handling at the same place.
>
> - Make org.bluez.MediaEndpoint::SupportedFeatures per-uuid dict
>
> ---
>
> Expose the values from remote devices in
> org.bluez.MediaEndpoint->SupportedFeatures
>
> This maybe could also be org.bluez.Device->SupportedFeatures instead,
> but MediaEndpoint looks OK too.

This is definitely too specialized to be in the Device interface, so I
think it being in MediaEndpoint is actually the proper place.

> Sound server can use theses to determine which mandatory capabilities
> devices have.
>
> TODO (maybe later): add way to configure advertised local service
> values, e.g.  via config file.

For the local SupportedFeatures Id expect the application registering
the MediaEndpoint to populate what they support, even though these
features are considered device wide, not per PACS, production system
will probably stick with a single entity registering endpoints (e.g.
pipewire), so it seems a lot simpler to have them adds its features
via MediaEndpoint.SupportedFeatures thus making the API symmetric with
remote.

> Pauli Virtanen (9):
>   shared/gmap: add GMAP Service
>   test-gmap: add test for GMAP Service
>   gmap: Add GMAP profile
>   doc: org.bluez.MediaEndpoint: add SupportedFeatures
>   bap: add SupportedFeatures for MediaEndpoints
>   profile: add after_uuids for ordering profile startup
>   device: use after_uuids in service autoconnect and sort also GATT
>   service: add btd_profile::ready callback when after_uuids ready
>   bap: have unicast client wait for VCS & TMAS & GMAP
>
>  .gitignore                      |   1 +
>  Makefile.am                     |   7 +
>  Makefile.plugins                |   5 +
>  configure.ac                    |   7 +
>  doc/org.bluez.MediaEndpoint.rst | 108 +++++++
>  lib/bluetooth/uuid.h            |   8 +
>  profiles/audio/bap.c            | 163 ++++++++++-
>  profiles/audio/gmap.c           | 200 +++++++++++++
>  src/device.c                    |  74 ++++-
>  src/profile.c                   |  89 ++++++
>  src/profile.h                   |  16 ++
>  src/service.c                   | 100 +++++++
>  src/shared/gmap.c               | 401 ++++++++++++++++++++++++++
>  src/shared/gmap.h               |  70 +++++
>  unit/test-gmap.c                | 496 ++++++++++++++++++++++++++++++++
>  15 files changed, 1730 insertions(+), 15 deletions(-)
>  create mode 100644 profiles/audio/gmap.c
>  create mode 100644 src/shared/gmap.c
>  create mode 100644 src/shared/gmap.h
>  create mode 100644 unit/test-gmap.c
>
> --
> 2.51.1
>
>


--=20
Luiz Augusto von Dentz
