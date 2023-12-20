Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF78C2232F
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cL5pozO/"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cc843af59fso24708401fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 09:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703093675; x=1703698475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6im45HZzzqeFpfmnnHGcpBvlb4MdwY/HgacKGaZ0qX4=;
        b=cL5pozO/+KnWKvoTJEC/PTEJ2u1hgVl/1ISxu9zmtQoK4GLojj9x4You0NcGyYwSD5
         RWzG0rFQpQgWCiyedn3aYVMsyIPqVPsTERnKV0uAxS6LYPVDj/8+qSRT0nl9ZOfl+WHy
         0T5R7rHPo2VklYBP93D5OUVyqDtAk4me2dK3+NOQvA1yQVENhpFI1sRTZkatzSTpuNub
         Q/B6VQ6HACbUg2iGAB011zy4R7RoqeAyUtnZta8N0eVBkrnRd9NIHh0knYacg6Z5jsH0
         uS3lsHhVKqJkI8bRexin//C5HBkajnaZ/XmoZCnmvo8ZwgKsqOobObYI3U463mZEeFQT
         Z8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703093675; x=1703698475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6im45HZzzqeFpfmnnHGcpBvlb4MdwY/HgacKGaZ0qX4=;
        b=IQmEkJKl2arxQ0qSrFpHgouvwZmftP7eAJA4JaRvIUjTE8Tv/+vCRMKBF5wBuuiWbQ
         RnMvjnH5d28DbGFCZs6yav+Wm3QssWoc3eIUH8mkxCxUysIY6zhgjB1zaV33s6hd69QU
         JmYS6nNeQLSymn8fl+tsCnn6ANhAyriDhwmGXPMiAhTFWU57ThNxxA7lJ7fLzvKA3ZVB
         zNu7K2s5m9kjLP1dRg2KKDSvmA/QpSU1lOuW9BroLSo42fibZNo6CLdv1xxDXJHih3DB
         sKPPCqyG5+1BV/s5U5kfLorURs19nmdknpCLVbObJzZA9hKDwFsOfi4KRYI9o0ovze7f
         oM/A==
X-Gm-Message-State: AOJu0Ywex5+PNf3QdvM1eBijFlTHOsP6/YHZtSrXV5ABKXwagJ9ah2XK
	jc/Bkx7kTM2sqnCj8nhfOmdd7hHPV91Cux8FyRY=
X-Google-Smtp-Source: AGHT+IFksluPRPKJoos5SWXN6P48CobbRg+v23zMAt2O3YQ2CuHL1L0Xi717egfdh95t/HOL2joIc1TJH5lY+8lQrVY=
X-Received: by 2002:a2e:b0e6:0:b0:2cc:899e:aaa with SMTP id
 h6-20020a2eb0e6000000b002cc899e0aaamr1166532ljl.50.1703093674608; Wed, 20 Dec
 2023 09:34:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220173052.1617172-1-xiaokeqinhealth@126.com>
In-Reply-To: <20231220173052.1617172-1-xiaokeqinhealth@126.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 Dec 2023 12:34:21 -0500
Message-ID: <CABBYNZKU+iHedypune81X597ReL66Gn3genntas9u3t92Px2_w@mail.gmail.com>
Subject: Re: [PATCH v2] adapter: Fix link key address type for old kernels
To: Xiao Yao <xiaokeqinhealth@126.com>
Cc: linux-bluetooth@vger.kernel.org, antiz@archlinux.org, 
	Xiao Yao <xiaoyao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xiao,

On Wed, Dec 20, 2023 at 12:31=E2=80=AFPM Xiao Yao <xiaokeqinhealth@126.com>=
 wrote:
>
> From: Xiao Yao <xiaoyao@rock-chips.com>
>
> According to the Bluetooth specification, the address
> type of the link key is not fixed. However, the
> load_link_keys function in the old kernel code requires
> that the address type must be BDADDR_BREDR, so attempt
> it when the first load fails.
>
> Fixes: https://github.com/bluez/bluez/issues/686
>
> Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
> ---
> v1 -> v2
> Prioritize loading keys with standard address types,
> and switch to BREDR address types upon failure, as
> suggested by the maintainer.
> ---
>  src/adapter.c | 45 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 36 insertions(+), 9 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index ee70b00d2..e1b704ecc 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -168,6 +168,9 @@ static GSList *adapter_drivers =3D NULL;
>  static GSList *disconnect_list =3D NULL;
>  static GSList *conn_fail_list =3D NULL;
>
> +static GSList *link_keys =3D NULL;
> +static bool link_keys_brder =3D false;
> +
>  struct link_key_info {
>         bdaddr_t bdaddr;
>         uint8_t bdaddr_type;
> @@ -4284,23 +4287,45 @@ static int set_privacy(struct btd_adapter *adapte=
r, uint8_t privacy)
>         return -1;
>  }
>
> +static void load_link_keys(struct btd_adapter *adapter, GSList *keys,
> +                          bool debug_keys, bool link_key_bredr);
> +
>  static void load_link_keys_complete(uint8_t status, uint16_t length,
>                                         const void *param, void *user_dat=
a)
>  {
>         struct btd_adapter *adapter =3D user_data;
>
>         if (status !=3D MGMT_STATUS_SUCCESS) {
> +               /*
> +                * According to the Bluetooth specification, the address
> +                * type of the link key is not fixed. However, the
> +                * load_link_keys function in the old kernel code require=
s
> +                * that the address type must be BDADDR_BREDR, so attempt=
 it.
> +                */
> +               if (link_keys_brder =3D=3D false && status =3D=3D 0x0d) {
> +                       link_keys_brder =3D true;
> +                       load_link_keys(adapter, link_keys, btd_opts.debug=
_keys,
> +                                      link_keys_brder);
> +                       return;
> +               }
> +
>                 btd_error(adapter->dev_id,
>                         "Failed to load link keys for hci%u: %s (0x%02x)"=
,
>                                 adapter->dev_id, mgmt_errstr(status), sta=
tus);
> -               return;
> +
> +               goto free;
>         }
>
>         DBG("link keys loaded for hci%u", adapter->dev_id);
> +
> +free:
> +       g_slist_free_full(link_keys, g_free);
> +       link_keys =3D NULL;
> +       link_keys_brder =3D false;
>  }
>
>  static void load_link_keys(struct btd_adapter *adapter, GSList *keys,
> -                                                       bool debug_keys)
> +                          bool debug_keys, bool link_key_bredr)
>  {
>         struct mgmt_cp_load_link_keys *cp;
>         struct mgmt_link_key_info *key;
> @@ -4320,8 +4345,8 @@ static void load_link_keys(struct btd_adapter *adap=
ter, GSList *keys,
>
>         key_count =3D g_slist_length(keys);
>
> -       DBG("hci%u keys %zu debug_keys %d", adapter->dev_id, key_count,
> -                                                               debug_key=
s);
> +       DBG("hci%u keys %zu debug_keys %d (%s)", adapter->dev_id, key_cou=
nt,
> +                       debug_keys, link_key_bredr ? "force bredr" : "nor=
mal");
>
>         cp_size =3D sizeof(*cp) + (key_count * sizeof(*key));
>
> @@ -4347,7 +4372,10 @@ static void load_link_keys(struct btd_adapter *ada=
pter, GSList *keys,
>                 struct link_key_info *info =3D l->data;
>
>                 bacpy(&key->addr.bdaddr, &info->bdaddr);
> -               key->addr.type =3D info->bdaddr_type;
> +               if (link_key_bredr)
> +                       key->addr.type =3D BDADDR_BREDR;
> +               else
> +                       key->addr.type =3D info->bdaddr_type;
>                 key->type =3D info->type;
>                 memcpy(key->val, info->key, 16);
>                 key->pin_len =3D info->pin_len;
> @@ -4873,7 +4901,6 @@ done:
>  static void load_devices(struct btd_adapter *adapter)
>  {
>         char dirname[PATH_MAX];
> -       GSList *keys =3D NULL;
>         GSList *ltks =3D NULL;
>         GSList *irks =3D NULL;
>         GSList *params =3D NULL;
> @@ -4964,7 +4991,7 @@ static void load_devices(struct btd_adapter *adapte=
r)
>                 }
>
>                 if (key_info)
> -                       keys =3D g_slist_append(keys, key_info);
> +                       link_keys =3D g_slist_append(link_keys, key_info)=
;
>
>                 if (ltk_info)
>                         ltks =3D g_slist_append(ltks, ltk_info);
> @@ -5013,8 +5040,8 @@ free:
>
>         closedir(dir);
>
> -       load_link_keys(adapter, keys, btd_opts.debug_keys);
> -       g_slist_free_full(keys, g_free);
> +       load_link_keys(adapter, link_keys, btd_opts.debug_keys,
> +                       link_keys_brder);
>
>         load_ltks(adapter, ltks);
>         g_slist_free_full(ltks, g_free);
> --
> 2.34.1

Ive just sent a similar fix:

https://patchwork.kernel.org/project/bluetooth/patch/20231220172222.2333064=
-1-luiz.dentz@gmail.com/

>


--=20
Luiz Augusto von Dentz
