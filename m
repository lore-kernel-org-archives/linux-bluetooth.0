Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817CA1B268
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YprjqkNR"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cd1232a2c7so17319501fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jan 2024 07:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704296638; x=1704901438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0tn/Z0KMjnrbEx6LkTYHGyleOf6au7PDpneLCTAYEY=;
        b=YprjqkNROnwcVxfIvaDOtFHVmuIh8BGS1yd7OAcV7565gtvgKdkd2znB4jrc6pr8SR
         y4B3YsH1F1bG3ciyqQfbEmxHgiesW3takVZxnBGmIbCLbPBpwkzCTmlvdVkRxHIOCxoi
         7c7vYqVNUDovRmQZ//+tVtpuPdDe++afAYE6weaJF/2Lk/IXMcWro36gQ9En4z7vWptv
         iFejORQiNyLc/Hjj0OLBEFjy+UWzUfhoGcf61wUwKSE4i4QLaOql8wsM3Vofdpd+Nq1R
         c/CQnesyeBejfNUS0I0m1awv4O6gOPPHQ2WhvOV4umtYNrEfkpn/g6UHGQXbbDqg7+Cd
         uAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704296638; x=1704901438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0tn/Z0KMjnrbEx6LkTYHGyleOf6au7PDpneLCTAYEY=;
        b=jFBZYWvhfjhYgIAwVMNjucZvPfqfT02RnHS/zKu2dE63i2tmFlI8bKHSsjvN45yF66
         GBSlRczBJFNCaOWQKDkweydTIRLqBkxeBh7H+VijNm+tkzH/Ho4sv2rXHZzYoRSbYsbD
         qxdveagZzv5xnD6X1tiAhPnBfdmdjgtOef4HLQYmRosH+pWZyKyJ16RVBCTE0GyJrgOO
         JI4LSS7fkpLagqxyTYGD68LHwNwjH8J/TQBi8J4TgzFTfLcke8T/et7tt4WeNtsPE2SG
         lJ78DLnEQlvWomkrcabwkAtlCMhaikkXgoVVq4w+OJ9cB357mkEwMAUgqlLiO4ONUBrR
         O/XA==
X-Gm-Message-State: AOJu0Yxkw08r5bfA7tEbBPuK2ywcJgdGl/ze24c27kaVIYttaN1fz2/i
	MMB58Wxa1KMGsHyivfXmUNxRyLX85qyXHNRqNS0=
X-Google-Smtp-Source: AGHT+IE51DC5H5TqEo2Pz7bzD40MXG6hfYa3qooEJ5mK1FQyDKt4MqglRuyHgC4pqGUCzOjhHcA0cwQ4apPnZqS1p/8=
X-Received: by 2002:a2e:3017:0:b0:2cd:129b:2c07 with SMTP id
 w23-20020a2e3017000000b002cd129b2c07mr1052900ljw.37.1704296638089; Wed, 03
 Jan 2024 07:43:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103101328.1812899-1-clancy_shang@163.com>
In-Reply-To: <20240103101328.1812899-1-clancy_shang@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Jan 2024 10:43:43 -0500
Message-ID: <CABBYNZJj6gG1kbmFSON+PrjpLuswdOiqt8AkfmYN5jzpwc1+Lg@mail.gmail.com>
Subject: Re: [PATCH] [BlueZ] adapter: Fix airpod device pair fail
To: clancy_shang@163.com
Cc: linux-bluetooth@vger.kernel.org, zhongjun.yu@quectel.com, 
	Clancy Shang <clancy.shang@quectel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 3, 2024 at 5:14=E2=80=AFAM <clancy_shang@163.com> wrote:
>
> From: Clancy Shang <clancy.shang@quectel.com>
>
> Airpod is performing inquiry scans in BR/EDR and advertising in an
> unconnectable mode with the same public address at the same time.
> with this feature, when found airpod device, set the bredr support,
> fix it pairs fail bug.
>
> Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
> ---
>  src/adapter.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 022390f0d..71f7ed86d 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -7066,6 +7066,24 @@ static void adapter_msd_notify(struct btd_adapter =
*adapter,
>         }
>  }
>
> +#define APPLE_INC_VENDOR_ID 0x004c
> +
> +static bool eir_msd_is_apple_inc(GSList *msd_list)
> +{
> +       GSList *msd_l, *msd_next;
> +
> +       for (msd_l =3D msd_list; msd_l !=3D NULL; msd_l =3D msd_next) {
> +               const struct eir_msd *msd =3D msd_l->data;
> +
> +               msd_next =3D g_slist_next(msd_l);
> +
> +               if (msd->company =3D=3D APPLE_INC_VENDOR_ID)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  static bool is_filter_match(GSList *discovery_filter, struct eir_data *e=
ir_data,
>                                                                 int8_t rs=
si)
>  {
> @@ -7281,6 +7299,13 @@ void btd_adapter_device_found(struct btd_adapter *=
adapter,
>                 device_update_last_seen(dev, BDADDR_BREDR, !not_connectab=
le);
>         }
>
> +       if (eir_msd_is_apple_inc(eir_data.msd_list) &&
> +                                       (not_connectable =3D=3D true) &&
> +                                       (bdaddr_type =3D=3D BDADDR_LE_PUB=
LIC)) {
> +               device_set_bredr_support(dev);
> +               device_update_last_seen(dev, BDADDR_BREDR, true);
> +       }

NAK, we are not going to introduce device specific policy hardcoded in
the code like this, if you really want to update last seen then you
either need a dedicated driver that handles Apple UUID on its own
plugin, or make the policy plugin register a driver for it, that said
there is a flag for that indicates BR/EDR is supported not sure why
apple it no advertising using it?

>         if (eir_data.name !=3D NULL && eir_data.name_complete)
>                 device_store_cached_name(dev, eir_data.name);
>
> --
> 2.25.1
>
>


--=20
Luiz Augusto von Dentz
