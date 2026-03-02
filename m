Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5494A3E5562
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772479512; cv=pass; b=B9IDaafkN5mV04zhgZ97iPH6oiivI0xsSm8n/rs4Ra2rHU++RSDcgN8/M1wRLI5lKD5qXTRU8vUGy+IfVrmPkyIR7xdohHRdmWv+3GgA6VBMBl25pJ316E87AHrG/EjXqa3Jj5PVz1XrHrngZ9d0/3sNFn3Fc23QElykMFxa0VY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772479512; c=relaxed/simple;
	bh=Q7jLmGTIh923mkuBGHzsheSoBukdt3xyPV4+QvEniOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBR6rFIFBDAh9B3RYOL2ASVpR9nOTQXFRBEwcwO/lYDEgwJsEfxCA5HP3hYS3wKaMeaqcN+lr5hGodt+cH83YYLf2F8Oz45mco/6B3VaebxpKMvjMPtz05vN6YPB0yU4/lgLSPmh4zMNIQADzu+gLHul4lnUb05plk4uRvtXxwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gifdil1m; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gifdil1m"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64acd19e1dfso4289883d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2026 11:25:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772479501; cv=none;
        d=google.com; s=arc-20240605;
        b=DwViKOEOdWXSfTwNSAVNDn7pdu7wtd+E5G15OgmOIwT+k0UTSzYQ9hI9fBPMQmmuyg
         x1VCMQXdgedfjteoqt+5QU4tWrBERR3GdaHOhAMzUVW5+TCgt1i5xJSxGrLmY71OhAO+
         VYJp5KRRC2PU/RPq/iH2a2V6e3JDXp4GgfnvSSBOe0wYaCm57FwujhHgQuMF5lnAhSBR
         CQGGdS5SWfTEJg2D8CRy/jBAMbXipP5Ve7DU7RM2tyqopOCZ/edE2lqM1U/2ZKMLusmE
         hyQ1mS/uwz1L6d20KeNqtCBDU8aKhxh2VKMghPbggU2RzIyZxajVrP5+EvMK0mjgPHe2
         mRVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=grCy6W9yC5X/78KGGmw7s7WYm2DdyDWd8eCU5pSfKd8=;
        fh=9UNKjWguJk2zMzByhnLubr3yZOG8z5kNEOmP2hGwULM=;
        b=ZQ5cpuUbMfPr0dQxDJJrna85WtV/EV53krlVGD/mImnuza8m+4ECjamHOh0PEokG1m
         gicjtp+4YquICB7fMtUpddfgTchHlJDLfKBrCrjhu7VCAIzay3om/TIyqIAYbXsb+OjR
         E49FxKY4NMKDBc2nSwKYBKY5ob1xcypO8Gbo+F/Vi8f00DHEmmmOgaDCxzYStY15jEvp
         YcC7kbAejC/kzCByGtB8IDJnR13GpTg4NOpH5g76L+nxzgAhj1Clmm9m+9ClFWI5Y6yt
         NlTDbo9qLLuxU9lA3AC5nDDL9laqfiXxFYiQYRSGftbGlqYlcRk9wv3Y4xgLHo50SNl/
         W1pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772479501; x=1773084301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grCy6W9yC5X/78KGGmw7s7WYm2DdyDWd8eCU5pSfKd8=;
        b=gifdil1mC2+uTxWkSjaEZrCmjJTDEUcUDT2KGNJmSMVKuYeNLEUIFSG4mpxlI5XHBg
         ftoBLLIN4myhk43YkqW3KveJCNmnYqHFzCSM2mgj9s5J7S2F9Ck08qUU+XpZRYLaOAnL
         QFhGx9TxOJ4Phy4efe8MUgluZRSXvPFQnD0Zd22pK1f2+CupW5dLkv1hNiXIyj+xQiVq
         ZR7LpSPn5zS1QzhhBE2mz60wjEyZ3uRFCqSToCY9iz6S4vdtZ0DVU+Ebmm7ycYFcq2d1
         pp1v+dOIrP5yMYNZfAdXaHzuPu/UbsNMS8xlv62O23SbvL57d0wGkHhjEQo7wtIAShYH
         Pmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772479501; x=1773084301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=grCy6W9yC5X/78KGGmw7s7WYm2DdyDWd8eCU5pSfKd8=;
        b=IvD3jm6omZRdYBEAOsGODBUVMUfhWve4n9afhdO5hjNzqVBWzTJxNhpuYqYUnNSb0G
         sXrL4Qkw3vNwCUxpFLEv4M3FrqimuH9sanmOToyhaGXIJDEfkQGwa4i8AQkU7JK5fNa2
         UY/u9aMH6TeJ4d97wcyy6+MbQVfcmWhrUUmOi+PCJT0VyD+I/9kZ04eAghsPqdeOprGF
         dyK9GiCnhxQ0SS6ikNBv+HIiUw4yy1Sd2NsrylJDQhiCLql3ClK2HveMHcWndRYc/zyb
         ylqVa+LtfvJCCbfiSNlbb6J7LUhTrkbt50Jeu5JbHEiKn9oveSdX4jALvBVl8ZqrsTEX
         akpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8Voz41QEv3ed8j0dqSm58nVo1hSB5mAqnQguTj/XuFHlxfYfSJlGsfuWag5FatbLkKb5bDz6+gp6+Jz/yTo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIzP1zTs6LMjtX2uy7mbj9xWnysJF/HjdHhPiecRnO0hfZHYAV
	Ey5w+iDLewXql+eAtfGqdA0B75pMyDhCJYJNR62TSrHEVNSA+0kh7RhP8kHVqQ0MiftGY16czZ5
	dE/oY9PT89NC6uzIcrIjae5SP7JSKkKw=
X-Gm-Gg: ATEYQzyrQlLoU5CGBjSIbH7dBLZu/EA94DVIk+YxFE2AoC445m0hT9dDsyJPJzXrEzs
	DJ2g8bMHqkf14l8AhMSc60Wb4RoaEeMNSpN9VTHrMMr9+Y8ePcFyKCwYrdCDjt8NYnphFj+L6fl
	67DtT5yBp+Uy3JxGIymSkwRI0kOhggc9YffAY0NKg4ogfahFJGFI3zCWzwF184v7v8pGy4U++ks
	GL2+4078Rc0aTPVIvXNVM1+vQWbffkGom5F7+YUKjatbahNxlh5f7AnigF442e8a91p5gCB7Pc/
	cZCC5LaSYrYHtqyIkxEd8uTBrs0K4Xe8CFkNGgZrLaBO46xtbY7+l/CM/ExHaXUSy04=
X-Received: by 2002:a05:690e:4105:b0:64a:f285:e673 with SMTP id
 956f58d0204a3-64cc220ffdemr12304283d50.52.1772479500850; Mon, 02 Mar 2026
 11:25:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301152930.221472-1-martinbts@gmx.net> <20260301152930.221472-4-martinbts@gmx.net>
 <e4ef2b5dc4789347eb4f3f5005148bd68205b845.camel@hadess.net>
In-Reply-To: <e4ef2b5dc4789347eb4f3f5005148bd68205b845.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 2 Mar 2026 14:24:49 -0500
X-Gm-Features: AaiRm5166srAuwhc8BHjgUuUvxjZIYJeGIjKp9CPkzg4fd3uKjtejx7-CG1hQ_I
Message-ID: <CABBYNZJJSP9GC7gHZenjk6ZPSyG4xn-4kRuUC6zH89JHQJ2YFQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/5] device: Add btd_device_set_alias()
To: Bastien Nocera <hadess@hadess.net>
Cc: Martin BTS <martinbts@gmx.net>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Martin, Bastien,

On Mon, Mar 2, 2026 at 6:44=E2=80=AFAM Bastien Nocera <hadess@hadess.net> w=
rote:
>
> On Sun, 2026-03-01 at 16:29 +0100, Martin BTS wrote:
> > Add a function that lets plugins set the device alias
> > programmatically.  This is useful for devices whose Bluetooth name
> > is generic (e.g. a bare BD address) but whose identity is known to
> > the plugin after protocol-level interrogation.
> >
> > The function updates the in-memory alias, persists it via
> > store_device_info(), and emits a D-Bus PropertyChanged signal.
> > ---
> >  src/device.c | 14 ++++++++++++++
> >  src/device.h |  1 +
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/src/device.c b/src/device.c
> > index 3ea683667..39344579a 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -5105,6 +5105,20 @@ void btd_device_device_set_name(struct
> > btd_device *device, const char *name)
> >                                               DEVICE_INTERFACE,
> > "Alias");
> >  }
> >
> > +void btd_device_set_alias(struct btd_device *device, const char
> > *alias)
> > +{
> > +     if (g_strcmp0(device->alias, alias) =3D=3D 0)
> > +             return;
> > +
> > +     g_free(device->alias);
> > +     device->alias =3D (alias && *alias) ? g_strdup(alias) : NULL;
>
> g_strdup(NULL) is documented as returning NULL, so no need to consider
> alias being NULL:
> https://docs.gtk.org/glib/func.strdup.html
>
> More generally, is there any way to reduce code duplication with
> set_alias() as well?

Yeah, I would probably just rename set_alias to btd_device_set_alias,
remove the id and make it public so it can be reused by plugins, etc,
and internaly by the likes of dev_property_set_alias.

> > +
> > +     store_device_info(device);
> > +
> > +     g_dbus_emit_property_changed(dbus_conn, device->path,
> > +                                     DEVICE_INTERFACE, "Alias");
> > +}
> > +
> >  void device_get_name(struct btd_device *device, char *name, size_t
> > len)
> >  {
> >       if (name !=3D NULL && len > 0) {
> > diff --git a/src/device.h b/src/device.h
> > index c7b8b2a16..bb51bd2f5 100644
> > --- a/src/device.h
> > +++ b/src/device.h
> > @@ -22,6 +22,7 @@ char *btd_device_get_storage_path(struct btd_device
> > *device,
> >
> >
> >  void btd_device_device_set_name(struct btd_device *device, const
> > char *name);
> > +void btd_device_set_alias(struct btd_device *device, const char
> > *alias);
> >  void device_store_cached_name(struct btd_device *dev, const char
> > *name);
> >  void device_get_name(struct btd_device *device, char *name, size_t
> > len);
> >  bool device_name_known(struct btd_device *device);
>


--=20
Luiz Augusto von Dentz
