Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44968347BB5
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968936; cv=none; b=GjX7OumfDgpk+0vlnsxwxV+9Ps89GuNrEpLX0MN+CihQbgedbjUWarVznbrq+6/d/zFg3y9du2rEllDU2lpjS5NUdjSAcsG6B35K/2Cd5KH0hayLuM7HDHA94PAs+AFIjOyoqCCuOILQ670l4I34Oos/cxBGY0vlVSK3KQ+LOpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968936; c=relaxed/simple;
	bh=WSiM5qPiBy3UG1DWehpvfL97HK/0uxhVIoze0myy9fY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUJ/tE5jIyYsqXw+tHl2IWy4dAH77xIrvOT2vE1ZIusOxg/plXLxVgIEjO6E3KkXf1HU/lQ1N0T2zXKisSU1Q88MpyMUUEg6XeNLZCFdhQMtbKlqKFTSuhH140FZGMpX4toPKcIisWljht1rsiWndkPkYKCHJNP9E15vmVqzBSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2CmU2MA; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2CmU2MA"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3761e5287c9so7557921fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 09:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762968933; x=1763573733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSiM5qPiBy3UG1DWehpvfL97HK/0uxhVIoze0myy9fY=;
        b=D2CmU2MAebwp+AGb1hO9GeqqdyqFuBX92c0e34BxV9tNqtxsI12OsMvRGq62XkHaor
         cfqQXMZ4gPXHyoB1gCdtr5kG/mQLEAwF7lLAVFX7+/tV1XEQy98J4QxEO1FYN9/HzTa3
         H3v2qG000TGc0gjXUv5VwAjmr/pBKVNkLFnc22vGzRsZdL6mWYLZwHduGw+BTJPGdXXz
         7Hi0MRE58wgE77066kdf3h8nveILGVjkb8gttt3+St/Jg+X24uqoP/+b2me2lxW5d9Z0
         v1M3AcqTH0mHvF5jmcavNCV8UNan+dt7wRSE6tAB1QQ6wTlN33k6sZiDsBXpcSzqgP23
         roLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762968933; x=1763573733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WSiM5qPiBy3UG1DWehpvfL97HK/0uxhVIoze0myy9fY=;
        b=HItt8ovezTtUlmyIgCITPx4W0QElTT1cmb2zsXWFKLKbEWe1NmeWrKFHPVnFQmoOo3
         tGZN3LzwUWdurqHkr3JZSIJX0/ClVwbk0wM9hCGGUMimBQO0HVdldsbcGzBpSWgB0f+9
         YjYUxOCz3xVzkpmvOqR0InmQNbA+yw+wrh2efiyyfbd9+gn5FsC90MoLR8SO7AZfKVXB
         qLAYALH9Tt9CIx1os9HBu/z6Ax10zz2+479deAq7+fF7W0mrGaVBpS8wedLezZtdb6GI
         QWR/x6bgl1aeoumHpwAdbxdiNcgTf4CKn6rOcinxH4jEB/qfM+k8HXAH3NKT7gR+UZ1o
         cscQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+t6koSVIGERriwTj67ennfXSNSHnP1KsgY4ZB1zWwo7EuY2qDOCSUyBb9ziA+f0BpPDwg0Xt1DJyIj1YtCUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqfnJ5fmqDKuzvffBBBG94p5H5KQz3Orvu1hBvsDNcwW5d8J2d
	N10YSyyAzEv9W+dO4CZFnjxlKTGKVm0+LyiK5OMVzn3PzNN2+Q65LgON71Vgb1zm74Si9QQZei6
	hsR+i5tH/I4W+oX8RL3UyVsYsgEy7gdiW9w==
X-Gm-Gg: ASbGncubEmwfoWsZxCh05lwzwtnT/9dWEWiFXKLUtE8K1Jh6WG+/kEggKenI73v3Vri
	zKxoul2ilj9uxtl9jC+hRQ2TG232ObTfoFN0/k8Mce6aR42raESJpJmk8GW/cFkYXEs2gJ1yyjL
	OfVqXKPj3fLqabhd1tmf15ORjg6abzhMI87BXySI0gSqPFe+w09lWu3ZxGrfu1lOR2orgxBIkcI
	12xPstrB6UeeJiHBD8bhJhbptE2b5FWASs4Vc/J+4SjZwvrVaehR7D1jDEutWLMryGLcQ==
X-Google-Smtp-Source: AGHT+IExXj4Vn7Re85iDbO4M4DDAVaVu8au8UCPFYlTiSjgYyA8eFz96NfhIw3FnkwumDfYWDjbh3dR7/NMhxKMixrU=
X-Received: by 2002:a2e:2ac4:0:b0:37b:986c:a4e5 with SMTP id
 38308e7fff4ca-37b986ca79fmr3107731fa.25.1762968933074; Wed, 12 Nov 2025
 09:35:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105132414.82057-1-r.smirnov@omp.ru> <5d3f39aff71b4ab1aafb8bd5e0f2a890358371bc.camel@hadess.net>
In-Reply-To: <5d3f39aff71b4ab1aafb8bd5e0f2a890358371bc.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 12 Nov 2025 12:35:19 -0500
X-Gm-Features: AWmQ_bk7proEoZQQwxosNCEB_OROgSENBXN2kHyds45YpiYBbCS1TIz40mj2U_8
Message-ID: <CABBYNZJmhvKPC6n7R6ahH+qW8noYFJBzK+dJ4_Xqeqq+Nx_dcA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v6 1/2] shared/battery: improve the display of the
 charge level
To: Bastien Nocera <hadess@hadess.net>
Cc: Roman Smirnov <r.smirnov@omp.ru>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 12, 2025 at 12:25=E2=80=AFPM Bastien Nocera <hadess@hadess.net>=
 wrote:
>
> Only thing I'm not convinced of is the name of that function.

Yeah, the name is not really matching its intention, so we have to
find a better term instead of filter, maybe just call it push, or
perhaps charge since that is what we use internally.

> On Wed, 2025-11-05 at 16:23 +0300, Roman Smirnov wrote:
> > +uint8_t bt_battery_filter(struct bt_battery *battery, uint8_t
> > percentage);
>
> Looks fine to me otherwise.
>


--=20
Luiz Augusto von Dentz
