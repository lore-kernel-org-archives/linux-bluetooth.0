Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850433ED106
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765826; cv=pass; b=TqZs/SFwKFa5TqiXO+uWDcTioeJcySA7BgGKCfrq79ankatkguUJp9j8WkhJwCAM/dEKGDHQQOC03HVQsbSKVMN7bxZwVwzitz5N8pbYfjYWWrtjfWYaBThQ+d3PDHvzFzIF3Yj4RJbQN4VtDlGdBaOzuN0pK3yOUy5EGPOM374=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765826; c=relaxed/simple;
	bh=8fnJHjXpkABdL5/1MjJ3KKooea8aREeK/+GyDzoPgII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHtgObPGBfUHD7JJyeFTJShmTj7LeG5PbuHAhmhWUUob8YYwZTtMCLcLd5mwU0pfHyS+MeZ28cUAeMWB2JVB9wAAd8Hcg3wLTbTGoX3b3INateHYbLK5yAAkr/lQX6s4CMLO2xtkOUrtJarZD4KXjDHVGkDGuz9osgdfQBDFsTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOrW9VW5; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOrW9VW5"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64c9a6d6b70so5045435d50.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 09:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773765824; cv=none;
        d=google.com; s=arc-20240605;
        b=kqtcGnSTO2tdR2TwkY7GU5fUK9AF5L+yYwytsiMBuvHiJZsMe+DfftfxS853Uop6Wh
         HZ/jO/fnxTkh/MpAe9YWTGm0bq9eZj2C/RFo0b2pivwjFpyba6D8rrwDRwxLdhfOGew+
         jqTZ5FF2EWIP6lrcyf7p9Ygq/QJCMNgCcEYt5i5vDNcoURmsha+lArB/1Nvm1oS5n481
         c9ePAnlhSiIUC48QKj5wA66nJpOMyC7RsN4YNC2MhscYfsw1fa0IfkDxOrwMOrB8YpJ4
         ayKKNIgju2/NEuPV7FIvWtCI5wqjonZzINoWkxp+na3ejUzsWK9+TYQxVzo2AmOxfXIu
         JhBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xMZTgJouaf+5iuGjKEbwVckjeWr4kTn65pq2C0pS6lk=;
        fh=DBIRJP4DvnAE+M31BcQ50XI3CAn/idN52/MNTtsfw9E=;
        b=W6CrSJqx9NatG0yREAOh+NY4hNQH8ZT48ROzv+ZfHLZHQ3DSXJ5r+Ix4DJmCzRvdwp
         yQ1LnPuV3ullENPnd832WwpaC3WpOdR4Si/5VlaCkHtBeZIA5GVWIbv/jjoXGF5u5Jh3
         h5+ZoHRL1Lk5HRqmEz7/xFwZ1tFEb/j4uev3UlqxJgNq1fZotzHb9emtLLok+FWMkTJq
         58IwD4wrMwyTerJr1CG1Avn3ozSqwav3ueVmaTxlDxEsgY+SeFIo2PSC523SAl5oczFo
         awIDn5kqU0F3lz+Fd34gsIsOOnF6oEW41obaJCiotee54HfBSaD35b71KXoEBnsGCVsk
         cb7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773765824; x=1774370624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMZTgJouaf+5iuGjKEbwVckjeWr4kTn65pq2C0pS6lk=;
        b=KOrW9VW5q+ixH7LlnbAqrGc3FN/hpwFhy14eKjAd9wamauHRx64+F9ngNUhXUC4ul6
         vXGr2fIYRZfLQkHSVFEfALa+6xQlcPKZXcgfgKZRxfuooE2oXPyM0k+IVs1q1WiZMf8J
         hhhs9iyBhC5axDQxRhCVBPE8NSna9nlJBXDQ2NJDEAPsfAUsBhPFEZhx70+YJDVdwstK
         /lIN7bHiPj/L7cVmKAIirAbzziZNNoaZvILjMiA+pHuk6RkwsISJcbr78vs6E1lUI4au
         GP07hLsPzqtzUpRuv/mlu5Ykd4aiqsGjg7GQQQPy2MYR999jtlndCqPctOQeTzo6QhM8
         soFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773765824; x=1774370624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xMZTgJouaf+5iuGjKEbwVckjeWr4kTn65pq2C0pS6lk=;
        b=Y56GD8d+X/FvlWqgxaO/Ra8nKAIV/6fu3eVGE31vgIn7C6i02rC/CflhOPNpEewbjQ
         uBuEQZIrj9ERwQ5JGflOFAb56rsdpxVj4XH/FsEqCSPZJxb4mAo1EtkdlJAOHbPtEW/N
         rWMcxagLV2YlVoE9A2eHwKnnFFvCWNgAxvB7pPgxrb19dJKl5Fq3umCGcQCkj86cdhpF
         qs+dN68YZMgaSu595sMhTsAUaLtokwL5ca2V2C/NkF6IJ6qCmkn5p1Qaa7tcOno4vUH6
         omzDdAvzp4TG+Aa28qloiztVJui4GaUXNyjxZGmPCKcFUbLb8ilK+h5i8Nv5kGxzljkI
         hyAw==
X-Gm-Message-State: AOJu0Yy0ecP5A3L3a6Ed0fk/sts+64Nt5ooDOOrOUlaoU8vL0ilA313O
	GcqCVqgV1elXXBlFKgb3d9jzmgUA6OIlK7x0iZnB7LF249ijnva2CIGN6VxghsZgkC0qU5KHyaQ
	SphFetwsgGtuH9uf4U7gw2CvYwt90EF7A6g==
X-Gm-Gg: ATEYQzwcORSW6thEM2KfqE4vKy6fCfdhLmu/7fmrdiVf8yElIHPOYJAPBf3g2xkmvOE
	4Pkgtalf/WYb+2WinDcgi80IE3W9JN2CRwoUbSh/mSXlWVk4b8YIuEy+i3fR9Eg9MAw6r8eqlB1
	1IxU5Ji2A5XheRQlL1GBfMYJW6WmOloNcEsO8wbIT3LLlw0qVOEgKOA/qKizYLAMpbKPU2QG2Px
	h7s5hN5XcZwig53HolBPIEBmbag0bBlfNe+Ue+8SyjuS+bpJ/alWdYAtBO8K5twH9MroP8+SVgr
	TwIlWuCUaG0CdNX2SAVLcVG7ZL/Nx1lC7YmXyzrIR5osLrCGBgg+RgoW9hG7VdjvRutnVg==
X-Received: by 2002:a05:690e:2026:b0:64e:71d7:d2ef with SMTP id
 956f58d0204a3-64e915d797amr265300d50.69.1773765824376; Tue, 17 Mar 2026
 09:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316204320.57220-1-luiz.dentz@gmail.com> <9388604ecf44cfb629f68e25d2357a9772e86dd9.camel@hadess.net>
In-Reply-To: <9388604ecf44cfb629f68e25d2357a9772e86dd9.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 17 Mar 2026 12:43:33 -0400
X-Gm-Features: AaiRm50UxJ-L26kEcYv0jqkicTk9L96h9SyuDMmO0pjSuKNd9TqnxQrTYJytGY4
Message-ID: <CABBYNZ+zM5x+XJ+zqOxV_LjzjrrDhQXQv9dZ8nfhu6+sVPNQqg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1] shared/ad: Fix not checking length on ad_replace_name
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Tue, Mar 17, 2026 at 12:07=E2=80=AFPM Bastien Nocera <hadess@hadess.net>=
 wrote:
>
> On Mon, 2026-03-16 at 16:43 -0400, Luiz Augusto von Dentz wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > iov may carry move then HCI_MAX_NAME_LENGTH in which case it is
> > truncated so it doesn't overflow utf8_name.
> > ---
> >  src/shared/ad.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/shared/ad.c b/src/shared/ad.c
> > index ac238014bcea..b1d1b84611aa 100644
> > --- a/src/shared/ad.c
> > +++ b/src/shared/ad.c
> > @@ -278,7 +278,8 @@ static bool ad_replace_name(struct bt_ad *ad,
> > struct iovec *iov)
> >       char utf8_name[HCI_MAX_NAME_LENGTH + 2];
> >
> >       memset(utf8_name, 0, sizeof(utf8_name));
> > -     strncpy(utf8_name, (const char *)iov->iov_base, iov-
> > >iov_len);
> > +     strncpy(utf8_name, (const char *)iov->iov_base,
> > +                     MIN(iov->iov_len, HCI_MAX_NAME_LENGTH));
>
> As I mentioned in my review, utf8_name could also have been shrunk by
> one byte.

What review?

> >
> >       if (strisutf8(utf8_name, iov->iov_len))
> >               goto done;



--=20
Luiz Augusto von Dentz
