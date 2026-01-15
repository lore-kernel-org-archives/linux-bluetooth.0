Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4333ACF17
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768494576; cv=none; b=n5Cg28f0wMShsprM6GqY7iUn99aprpzXnWMSRAMb5iSxrj0rkJQBmEFQfF74Gx8riFrjt8Bf9Ji5sAzxjLOG5jBI2xtth7oKG9msg+pdiqwJxI+mgwOPntITqJJJb1/mvYbTnbw8rSFb2PP9frZH535qM4wA32mZ6l/8HH9akog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768494576; c=relaxed/simple;
	bh=EwfzmycdQwLhNX+zviZ4Dh62QcmsRvrQEdSR8fx0rLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qi5HOPo21Hk717BtikmGyqjVAe+i7ETUS8ScXBZT4/UPY09EMj7EuGc1lvBSEWFSNrqSkf8xD4/wb5RCgyB3yxQm05QKo1DTTbSrhAgNkpuoHW0GH7QoRz+7Ved7PxObUvOlF7PQMyWLdyJQ831RXDO/Jwj/Rf9ZwW216YB6XL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HX6cOXXY; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX6cOXXY"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-661106487f9so825480eaf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 08:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768494574; x=1769099374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwmmKum9EB8f129LIenGzXdPsZZNKQm8Ox5oYybYzIo=;
        b=HX6cOXXYEVWq0F4PuaaXCIBoDH389lFzcyWe23v2WnPlRC7Hb0ymhX5GDTV4lzlh/0
         mpUOLOiXms9ReFTp3GUsALpUT1xROiqnTn5nyoR7TPVPTs4fDIeWQbPUgUppjmyLMV8J
         InM3ywCE1G/l+3IzW0MY2AsgBotyZBBiLqdpdD9LUawaBjh8ZzNKb6RsPustb6+wTsa8
         6b3CUKiK/BT5RxShdaLKOdnOetJZpMkHiXPtC0wJh0kTNUS4QjnqLbMX3msnxuJLlyWD
         2FKM1N+CI60eTCUnOOLIDbZ+k622vVI9v2V6zTEnJ1mM1lKLuetjGU9o2DwWuDW02oLJ
         W3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768494574; x=1769099374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RwmmKum9EB8f129LIenGzXdPsZZNKQm8Ox5oYybYzIo=;
        b=LN9oT3we8ahZlaIloa7rmOVJnaYTSB6TY15Vg0+JIsSQYJWQ210yOAc0j76cJYQZmW
         iibw7iVClEhuqZmkHVF+1twBJLGwfdzqCyhHy7wyyZT9GR8ZMmnAJd0N4Are+93n7iNM
         F+xTvq4WR1EBGLS7WfyL3Q+abeI+C0rhoOk3FDMM/jnJL4ddelcc46nU9WKedNKs2M/8
         5GKcEFFaGyT8+afytmm+PNtMnvirYAdrFLoqLi9AmBIIp8+h/hL4atAuw44zhEeEzaC2
         8pNuMSeFWsnNMZ3Bjgs4QOEIncbtgfAIenWI5B1qOVJUamO8ay+ABwdjBITX4RuFa2qD
         RM0g==
X-Gm-Message-State: AOJu0Yy9hvOdxRzqeNnt3xW35fbKTl5rD5HWLBrArO8ZUgbozHBmVM/u
	0+ru3fjKRfvk86v8wE003uWYwS5PUDFY9uj8OxgJFKAyER+zauphhiI5FFxLAVqXtscrXM/Qh/6
	SvA9pZC/M/go+G0CfRifVSd6a46/a3u5Y7L8Q
X-Gm-Gg: AY/fxX77fMEADa1b4odvEoiz8YH7lDW8L2H5T3M24ZX3iseW5IFv91dZkjlat7UQBa/
	xQtUJQvTw8FY9TF2U4VDliv3FsO0jG5/4bvUCBHxn+pxy+52yl26ouAQvg/tsZgG4JeDtnF3UxB
	i2uDSSPmPh6R26hdTwe6mE8n+oS4RjJft0N5dziagnrPWtI01MPBQ+qPurchXh+67ZeXhn6q/YR
	KF9XAUQ6ibSkiH1/o/HdBqLAdMSxcXJJ+WL4Qol+hZqx9UTFpBqbvImft39/VaaCjqR9y5WBOYY
	S7dtS7Khv19sGEWF3kBc1hrwjEdiIaseZ2ris4sVex/ad3gql07tJyO+pw==
X-Received: by 2002:a05:6820:f010:b0:65f:6053:7551 with SMTP id
 006d021491bc7-66117a0969dmr100293eaf.68.1768494573794; Thu, 15 Jan 2026
 08:29:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113090128.244709-1-hadess@hadess.net> <815c465ba9f92718b92cd35391238a2948cbb994.camel@hadess.net>
In-Reply-To: <815c465ba9f92718b92cd35391238a2948cbb994.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 15 Jan 2026 11:29:22 -0500
X-Gm-Features: AZwV_QhrEQY-PkR_SvxR8I_MNJvxIJscfj4f_HzuI4bVhMRA8KAW3d74dxFxDBo
Message-ID: <CABBYNZJj1RuNgoNT1bFxFYSGnKDowC9To97w3DjyXK=B3UQQ7Q@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Use pm_ptr instead of #ifdef CONFIG_PM
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Tue, Jan 13, 2026 at 4:31=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> On Tue, 2026-01-13 at 10:01 +0100, Bastien Nocera wrote:
> > This increases build coverage and allows to drop an #ifdef.
> >
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
>
> I see v1 landed. What's the best course of action, revert v1 and apply
> v2, or should I send a "Fixes" patch?
>
> > ---
> > Changes since v1:
> > - Fixed build
> >
> >  drivers/bluetooth/btusb.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index ded09e94d296..67ee2b869852 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -4462,7 +4462,6 @@ static void btusb_disconnect(struct
> > usb_interface *intf)
> >       kfree(data);
> >  }
> >
> > -#ifdef CONFIG_PM
> >  static int btusb_suspend(struct usb_interface *intf, pm_message_t
> > message)
> >  {
> >       struct btusb_data *data =3D usb_get_intfdata(intf);
> > @@ -4616,7 +4615,6 @@ static int btusb_resume(struct usb_interface
> > *intf)
> >
> >       return err;
> >  }
> > -#endif
> >
> >  #ifdef CONFIG_DEV_COREDUMP
> >  static void btusb_coredump(struct device *dev)
> > @@ -4633,10 +4631,8 @@ static struct usb_driver btusb_driver =3D {
> >       .name           =3D "btusb",
> >       .probe          =3D btusb_probe,
> >       .disconnect     =3D btusb_disconnect,
> > -#ifdef CONFIG_PM
> > -     .suspend        =3D btusb_suspend,
> > -     .resume         =3D btusb_resume,
> > -#endif
> > +     .suspend        =3D pm_ptr(btusb_suspend),
> > +     .resume         =3D pm_ptr(btusb_resume),
> >       .id_table       =3D btusb_table,
> >       .supports_autosuspend =3D 1,
> >       .disable_hub_initiated_lpm =3D 1,

Ive amended the v1 with these changes and pushed.

--=20
Luiz Augusto von Dentz
