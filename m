Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4E01A5B9D
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609257; cv=pass; b=ihubN8d23xI8k/wBghWQDQkhlWYqyJIxLdFjM2/33YqUXpM3MU9Z+CmbXLXtBYdQ9hd4ct2n67ev2o5p9JgDXV40YaLH16R1FAd5tlVjzFNwN8O3JPDv/rFLrbpGi7w3Z7UGxeNCw7Uo/SQUC8voF3pLbAkS7RREviYlqc3nwcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609257; c=relaxed/simple;
	bh=Gh36mILOASXV6LA36W3sLI403GIwRYF5BosVhLxBkzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akItquJcCjKy599tgA9v1NSZ/yCmMuUeVyHiQg+aTvZuI5IyI45CgGVnc+7YG0mNgPObdVLUqhBbsqFB+lOyfjG2QN2/NNXIVJR/blDcJug3nRNtwwheSCUopxqizzEWgP6Y6RGlFk8mEawvteB7fOLpGuAxxtIbFMNC5cusxFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsU8J3CF; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsU8J3CF"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6676fc59e59so2572451d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 08:00:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783609255; cv=none;
        d=google.com; s=arc-20260327;
        b=LVHn3X+Ak2myKVH02+gljMFtzq5s7QELQ01lpQ65Txh9KjZPsX3G6zJGMO0Z3sWGav
         W9opPQthEjbV2YZLDLLb0i0/8wopYL8CCSsiJoOEu2mW1Zy+9NbFrFWM1J+wvI1btZbi
         IW9k9ojfe/2Hm4pqGBAX2Xa1SkBYKzjBS/tlz4QveeYfKjzjHcz8ga/Z7Ik40kwS2y7x
         hJ4xQcbAlcV8CLj6qJ00UNf37A56C9Dsc98lJvl72Ukl28fElFuPrP3EfgDuM41xvSK5
         QnOX6HjWK6bWI9dsOlC5L7udLz/YZUwTdTbqO5waDwNl/QlYa1/2o81jmimCmMIhb87T
         FlQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6c3eujtSr631p5+GWcqA1PdQZxfj6ifF4RrOkSRJnaA=;
        fh=p9kDSW8o60kfdT7dwsI+0eiTIdADq0bATQI1Ga882wI=;
        b=Bj51xPWcdULiX3KXkN7eJccD9tTRtXM2F44jDn7jUd7f96UoIsnrNXV2Tg94SwKYAg
         l65HGS1rxikuClvRZXYket2ru9Hsn3IE5rbp3OOwgbX00gl8zoCiulaEo3OCjE6BZftK
         xTjBv9NgSqXHFmtxxg/c90rysFM+QHiwfLaouaf0KemFtxRViPxnlo3I7b6aTv4mJVt3
         306+LhPbISZmaOFk1z0o9wx/Dk+mNju7Q2uJSJVamBpsLTJF3Whp8uP4s6E2x91zgi7Z
         LRPfAZnMFFk/DmGTKkOMyyE93XC/B6uhN5bUBJbV70L20iGyr0pespL5e+TFGN539QJs
         y2mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783609255; x=1784214055; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6c3eujtSr631p5+GWcqA1PdQZxfj6ifF4RrOkSRJnaA=;
        b=RsU8J3CFqxUqmZsZQqfZG0BVyacztGFQKF7b/4iKaAs8CG/1AfF/b4Ix6B5qHv0nf3
         E3b++XPKfYWJgH/ChQJ4ikfEyD4B0m1QIvDfkYOMcATmIwawYQZh2UdBRKpTjBTYOewJ
         CugPpPF0nRVMixmSxlgOP6ILyzv1Op82jNNzIej422CuW0OqnN+TG/e+MRgY5ks1kdSb
         TKkTJGWK3Iffwh58gYjbExJm2DmcPGppun9pLHeekreQRYjYxv0ZwjSASJmCVTGBUwFg
         S/FyNiccAJ7iwaHTyXLfO42GR/5iVREtSOpZLbJFJnuDRG2AGT74yR21pUTqyTZmxYml
         diHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783609255; x=1784214055;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6c3eujtSr631p5+GWcqA1PdQZxfj6ifF4RrOkSRJnaA=;
        b=CWINTlqYf0mUitdxEeBFzvJNfyF8wAe3HouLBe3KDE7lYwVqu6yKzAD9mAR8OOq2yf
         nw2N6VoGXjf+w4q6gIOWRLDrI55Yfj7L+EJ4q5b5m4LVZcKjlKlozVkOEJRK38r1XRK/
         A3SwIlAExVBn54AS4reTZgwxZXNBVZz40GFHkAaTC+mZy5OYdOThbjpINa4ITBJOKsDj
         4lWZQ6raApNIKR+0NCsU9t2CkNdM00YFyRYtkHfrS8iEwFpbxsDwomIOdYZH+PMqqgjh
         h2nXH3TcFCxwQr3s1tHwrqqFNlrCZij3KGfqP/o3ifAVNDafM9Iwe+mSTRRnpdfVSJFs
         ia+w==
X-Forwarded-Encrypted: i=1; AHgh+RqRQ92PSpK5xUnSO56NsPKDAgYlhniW5eL5qFNkb0xGw5NaiQ/fSeTUf1UMjCNyvIWLphqnRQU4W1CINm3Qwko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhxSosV/hrds8Rotu9l367rxo2SfVhGE5zmNEwyE1FQZdDUoMp
	bq0smIukHFKAsc4iYoICjw5oVyRvSqHGQLjprSruCnYkxVd/1FFto8UiexuBbri8MPZ5bfLQAPr
	GL1hErInCE6XyOYecWCCxGXdSJyDWUcIsTK05xhk=
X-Gm-Gg: AfdE7cnGRE5HqfrZhfPKEDkoH5HFJfhrdL995UzL0BZt5Ac2q3cEsUPe6SgoFJEjPu0
	/0cQW3+0s6yOWQWPlVTyuB306IwGOJGtBYVk+bp0iH4kzm2PQJZhuT4leofxpApe87kBbE2F9/b
	kjFJNDlpDB5Clr+kzV2rZpNGKwjEngn+bi2Md0UvLoP6rhGzAQ6pw8ri5opb38hh0j7E0zEK2o+
	q9kcEU6qJHZlt43e8S0Wgg4WumYFWj1yXTnWKiwz7Ef6bqvaKLkBuUobLGTPtDBqzE43GJeKT6v
	GpjvJX4g2q1C+0jjW9r1WZvYdJyIX+fGwvB+tKGgVygF2jv5Mi/vUJ89
X-Received: by 2002:a05:690e:1598:20b0:667:6066:e0e8 with SMTP id
 956f58d0204a3-6679f153235mr4520695d50.65.1783609254987; Thu, 09 Jul 2026
 08:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709122704.351232-1-tomcatshoek@zeelandnet.nl> <a2d7c978a97b5e55a05cb7000f4d20d8c8dc542e.camel@hadess.net>
In-Reply-To: <a2d7c978a97b5e55a05cb7000f4d20d8c8dc542e.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 9 Jul 2026 11:00:43 -0400
X-Gm-Features: AVVi8CfnOr0ahDb_VA43CEsrgwDNfOYCQzAMTbxkE_htNjAY-CcWiT6yvVq51dA
Message-ID: <CABBYNZKxGTT5609JUo+04edy3X7hiZmWfXB2cmVGYLTVBz0O3A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] adapter: Fix crash on UUID discovery filter match
To: Bastien Nocera <hadess@hadess.net>
Cc: Tom Catshoek <tomcatshoek@zeelandnet.nl>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Thu, Jul 9, 2026 at 10:39=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> On Thu, 2026-07-09 at 14:27 +0200, Tom Catshoek wrote:
> > is_filter_match() looks up each discovery-filter UUID in the queue of
> > services parsed from a device advertisement. When that services list
> > was
> > migrated from a GSList to a struct queue, the queue_find() call kept
> > GLib's g_slist_find_custom() argument order, passing the UUID string
> > where queue_find() expects a match function and the comparison
> > function
> > where it expects the match data.
> >
> > As a result queue_find() calls the UUID string as if it were a
> > function,
> > jumping into non-executable heap and crashing bluetoothd with SIGSEGV
> > as
> > soon as an advertisement matches a UUID filter configured via
> > SetDiscoveryFilter.
> >
> > Add a queue_match_func_t helper and pass the arguments in the correct
> > order.
>
> That'd be my fault, can you please add:
> Fixes: 91c340d359b7 ("shared: Remove glib dependency from src/shared/ad.c=
")
> to the commit mesage.
>
> I checked the other queue_find() change in the same commit, and the
> args were reordered correctly.
>
> I don't understand why we need match_uuid() though, does it fix a
> warning? If so, it might be nice to do in a separate commit (fix the
> order first, fix the warning second).

That is probably needed since the callback signature/return doesn't
match the likes of strcmp.

> >
> > Fixes: https://github.com/bluez/bluez/issues/2282
> > ---
> >  src/adapter.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 210225243..4ffa32a52 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -7184,6 +7184,14 @@ static void adapter_msd_notify(struct
> > btd_adapter *adapter,
> >       }
> >  }
> >
> > +static bool match_uuid(const void *data, const void *match_data)
> > +{
> > +     const char *uuid =3D data;
> > +     const char *match =3D match_data;
> > +
> > +     return strcmp(uuid, match) =3D=3D 0;
> > +}
> > +
> >  static bool is_filter_match(GSList *discovery_filter, struct
> > eir_data *eir_data,
> >                                                               int8
> > _t rssi)
> >  {
> > @@ -7216,8 +7224,7 @@ static bool is_filter_match(GSList
> > *discovery_filter, struct eir_data *eir_data,
> >                                * uuid.
> >                                */
> >                               if (queue_find(eir_data->services,
> > -                                                     m->data,
> > -                                                     g_strcmp) !=3D
> > NULL)
> > +                                                     match_uuid,
> > m->data))
> >                                       got_match =3D true;
> >                       }
> >               }
>


--=20
Luiz Augusto von Dentz
