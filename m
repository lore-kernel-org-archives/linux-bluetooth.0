Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601A92248A8
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Feb 2026 21:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770155492; cv=pass; b=F2yCsxrcY0THbz3h2F/YJ53Qtz5MrQoFaPSYysJAaHMFH2OWWxhlr1qAV+sBXPF6Q6pBFdvh96bbQdG0jRIac9BnLVkRyvwv44fnE2W7p2s0/eJDJ0UyTQyEiALX9Ps/RuD2zufh7J3IyM73jwWT6JQMRb1BoWJwEf8SPpGCIPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770155492; c=relaxed/simple;
	bh=bxRffKj57rQQGwiTUZE1HVychdX2VjSre0yqxklMDXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFOHRDAiG+v4x8kGvMygc2JbQKyCESo6YPAuJSirKCO+cLJMOetw6NTGbVuWBdsbfAKQNdHYrc8bHplCZSVHnQHOtGgUwZdWhSJZGQMDmrOzsOF2Wx/zzcoCOdmTt255irwvmOm+4JkSLsOOXmZbr6xGQi/LutpkpMPsSpHetFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/FIsDlp; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/FIsDlp"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-790992528f6so57797707b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Feb 2026 13:51:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770155490; cv=none;
        d=google.com; s=arc-20240605;
        b=KUd+43eSBrwsnRTV/AZqV3AIUwID5qKWzfIBe6A+gsz16dyK/IQMa+ZuBoPHnBgH8L
         PTfyj1prt1EGs2+FWMYVuk9physVJIqe9WKRSdKGpEEJ6pM0mco9ebgSlN6Ns8etQgoN
         AH+6PwvQl54P2TJf8rhKsc1hvgNR/xl3hAYMSBI/KetNLq0OGmetv/1Pxy052FcWOylv
         Y0bklMCtiKEBEBx9RrQaMkxSkl3MiVhRQ/9upQD0UajqH5cXhJXpL127z2O25iYkOIY8
         IzVmgrNwKgn4NH/zew2C63+rljGYlFgixAcXc8SBp3FwJPG3nyEDwQzyEERwC6moUsPX
         YdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YNiwPD3zBg9/PvJxLVbJJwqFhM43ejXbGLwW2ZCVri0=;
        fh=kozjLXD1Z7+be3UnEc2ow5AG08GHoptStM2SXXZeAv8=;
        b=c4M00ofAOQchhu+vbfUDMd9K45hcJZ+oG8errFLTgXhPr3nWH8rpmYBq8H/lXLxSHR
         9aVCwAt4GqQxuSiDJsWhW8cE6Z9S9GHI+iU53MKkJmv73/nYtbTnOhprVV7dOE2C0+2j
         tedTXfNmmrwHD3Rt11wGuCYZ7AZxcdiDzFr1tqW2TJQ/a2ALmw7Zv681EgFDiWWRsOd7
         vngFHBCtRUS7XsKOHddyGK6Z5+w4CDaNV+8nl1X9piNCiO8LndJolC4HyyL90lb9JcMz
         bccFI07yVGHbRDklmQGsrzsiMBO8r1IpY2RX8JFoJTtFowId0w7DGJSgapMaW/qPWFp6
         iTEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770155490; x=1770760290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNiwPD3zBg9/PvJxLVbJJwqFhM43ejXbGLwW2ZCVri0=;
        b=P/FIsDlpu66Hx1hdtgeFzXJaCih2dO4Bjj0nWFM0XmHGGbLYSwaMlbgkIZdRRfGoeO
         EzK2juDLbTWoQ4fJCynv9dGOrbOh4qylmzC4uXv8cXZBtl4zu2CJxyuqKlf7QM4wrwUY
         was0A+lJPM/yo/l/89jBaZBM1wU0ibWCRmRUVFTuLAiPnjPnlGK6fvWbzwjDivwzpbS8
         Q7KyLFs/KcQDJ2yc5uv0ZiAfRRgseJGdHhOwqT1lzh11Mpnzzr4TGRkJ3gPivfSo+Ubt
         PEuuPhVSqmjomiajkgMhfKstAvLFL8U/MsnhqdFOIz4cMFVPuWo68vFl1c4JrZGAEogn
         MKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770155490; x=1770760290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YNiwPD3zBg9/PvJxLVbJJwqFhM43ejXbGLwW2ZCVri0=;
        b=MEgbr7DhYy5l7X2ow5hX3zRYRPMAoOxPd0XUps4LE93KF4kCz6KcqxQPNKHOF+g7fU
         y9M6PPt2IiC8b6al077RINq3gUXI7xOL+WnluLMbTF7O2y8ZbkkIczQ15nRHFp0YHKL/
         NMMnGrG53FDqbnnjY1MPZSKa5pHxLIyvHtJgGXufjiXKqXZTQZeGQv/VmWBpQ77lN8pz
         5Yz15WjHj8/75TDjDYNwsi+lEyb77zG1vM5YWyUrJFH77VtZhmMq5bgUeVORhAZWG2m5
         vE/GXiYPsOY5ytlJYlaR+PTsCaqJgLJk46kfx5B94KtUbhe3hpcsbFTWhEuQDmNfBxc3
         FoMg==
X-Gm-Message-State: AOJu0YzXGCls36ts0hDKiciZ4Ewt4ESlWUbunexWgzLqMINbey0BWVHx
	PWsc4o6sqI6aRyEFC1kpLC879Lv9lqJPQSBreqwFf4qqkSt24r3FfPtR+5TE+X2jwk/acN6WgZR
	GLtbPZ3AFVTedWoJ8DLJbHUUhhnNXIFWosw==
X-Gm-Gg: AZuq6aIQwW5peZWSSfWv0MeYiyg6D8W5SQ0G9ClxLeClYQGX8O6jVcWGjr5cHW2ZeEs
	gB+TCzkU+Yd4l9LtPCwCWa7T9vfHFTyT2kdWgewZacQtjR5YvogiRsk8IKi46Xdfet+NbSVf4yz
	pOiN2pkpClMwZFzJtLkUtGD/TKGjvpwC2NdiI4Pj1vZNVzxpf5fUNiKqR2qYDfXc8k+YLTSL5zN
	xt5BAGVA5BiZRJXfR0qCZWEsIjAEfn+WT5th8rObTw1GphNXU5Q1YlPOtSk0vlE3uf4V5J2QBad
	VWnXYpIXugUyGerZeMoKiqQNg56jsihQM4RLnsXchgPW5WgbWq/agDOSyQ==
X-Received: by 2002:a05:690c:112:b0:794:c01a:18e6 with SMTP id
 00721157ae682-794fe7b47bfmr10704307b3.47.1770155490151; Tue, 03 Feb 2026
 13:51:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201084655.73566-1-github.rtron18@gmail.com>
In-Reply-To: <20260201084655.73566-1-github.rtron18@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 3 Feb 2026 16:51:18 -0500
X-Gm-Features: AZwV_QgomI5BTOF9Q9MeENa5ZabuHtjZNFGFcQb8_t56cecv_RQXJ60QLXZ7jEI
Message-ID: <CABBYNZ+cON0hQBhe5Ci=5ZxesQuvCBLmSmVE0Fa8jganzXmtMg@mail.gmail.com>
Subject: Re: [PATCH] Add Null Pointer Checks
To: Roushan Kumar Singh <github.rtron18@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roushan,

Could please add the backtrace so we can check this actually
reproducible, afaik the likes of service_create are only called with
non-NULL profile, but maybe this is the result of the service being
removed or something that resets service->profile to NULL but in that
case the service should be invalidate as well and removed from the
list of services.

On Sun, Feb 1, 2026 at 3:55=E2=80=AFAM Roushan Kumar Singh
<github.rtron18@gmail.com> wrote:
>
> ---
>  src/device.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index af8df5f29..c0b95d09c 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -380,6 +380,9 @@ static GSList *find_service_with_uuid(GSList *list, c=
har *uuid)
>                 struct btd_service *service =3D l->data;
>                 struct btd_profile *profile =3D btd_service_get_profile(s=
ervice);
>
> +               if (!profile || !profile->remote_uuid)
> +                       continue;
> +
>                 if (bt_uuid_strcmp(profile->remote_uuid, uuid) =3D=3D 0)
>                         return l;
>         }
> @@ -2540,7 +2543,7 @@ static struct btd_service *find_connectable_service=
(struct btd_device *dev,
>                 struct btd_service *service =3D l->data;
>                 struct btd_profile *p =3D btd_service_get_profile(service=
);
>
> -               if (!p->connect || !p->remote_uuid)
> +               if (!p || !p->connect || !p->remote_uuid)
>                         continue;
>
>                 if (strcasecmp(uuid, p->remote_uuid) =3D=3D 0)
> @@ -2594,6 +2597,9 @@ void btd_device_update_allowed_services(struct btd_=
device *dev)
>                 service =3D l->data;
>                 profile =3D btd_service_get_profile(service);
>
> +               if (!profile || !profile->remote_uuid)
> +                       continue;
> +
>                 is_allowed =3D btd_adapter_is_uuid_allowed(adapter,
>                                                         profile->remote_u=
uid);
>                 btd_service_set_allowed(service, is_allowed);
> @@ -2629,11 +2635,12 @@ static GSList *create_pending_list(struct btd_dev=
ice *dev, const char *uuid)
>                 service =3D l->data;
>                 p =3D btd_service_get_profile(service);
>
> -               if (!p->auto_connect)
> +               if (!p || !p->auto_connect)
>                         continue;
>
>                 if (!btd_service_is_allowed(service)) {
> -                       info("service %s is blocked", p->remote_uuid);
> +                       if (p->remote_uuid)
> +                               info("service %s is blocked", p->remote_u=
uid);
>                         continue;
>                 }
>
> @@ -6173,8 +6180,8 @@ static void disconnect_gatt_service(gpointer data, =
gpointer user_data)
>         struct btd_service *service =3D data;
>         struct btd_profile *profile =3D btd_service_get_profile(service);
>
> -       /* Ignore if profile cannot accept connections */
> -       if (!profile->accept)
> +       /* Ignore if profile is NULL or cannot accept connections */
> +       if (!profile || !profile->accept)
>                 return;
>
>         btd_service_disconnect(service);
> --
> 2.51.0
>
>


--=20
Luiz Augusto von Dentz
