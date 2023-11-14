Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D477F2FC42
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 23:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BckzkMVi"
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4326BE0
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 15:38:40 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c6ed1b9a1cso75357391fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 15:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700005118; x=1700609918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sMoUii1eFG1+P6MFxwfNr3LNCw+QRtRvTtrEzkHlbM=;
        b=BckzkMVieKT5yRc8VzGEPiUWgw9umaV4GMAnUf2Bn9KNisWIQUerSIruzTZy8DtbYc
         kfHql1dTld0eXdM5UiDbf5kG3LZfA/lqSqWWaI0NW1wc2XatS4j8GpqmmO6450qqzikF
         XjhRX3MiDg5buyyR4dETpjxr2R6Qz3FU0xTqlcDmcuYqfvMDViX7XqU2QSBOfGCc1P4J
         onZfcscLEWv2fobPWx5okP9m6C0A5i5qUEHsRdiXuUZcRHjHrv1QDuSBUVyQNcbKFAlS
         uYwmivCNxSmH7SPiKHo3XdgJZL4gLW5jWvJzhCM8Bp+OFXnCsNx37Gx25ny8/5gmdHpq
         x4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700005118; x=1700609918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3sMoUii1eFG1+P6MFxwfNr3LNCw+QRtRvTtrEzkHlbM=;
        b=XFhaDqGA81iwVAKUKB5kRMo1cVSZmdZ1OH1ZdHPh1JLvEUBUNIb/KYUcGYiv5spwEr
         76eNtjQP1ujVLBl5YCeTJkb0mqNofyz7egI8Rciiqdx6JX0Bg3WEMkrsGQ+d8n3TRDl8
         0lsrKPb8yjmV8ROgHPVI79FhmwbFge4wPiyMmiZIWBP41vb4qqxH36vkVzTmomGnTtXp
         cMOZaopU0dysgqVdLBhw16UWn1RNymZChN2nk2Z8dyMxqdVgSzDBB1t+xaF76zVViiBX
         LlegboPWHihY0j2vMwEVcbp3YtHddhG4FYo1E0Kv2Ut8N845TQn8Lt2ONznbleZrCKu3
         QuWQ==
X-Gm-Message-State: AOJu0YzASvgdYglvLib6BtSlQHD5+be2wvVsXe6PPQ3AmAL3uykQygpu
	OrRN2Gh/LM/F7pCJZsrk4n3kRs7aBvgZ5TVEY29vAuS17cUHyw==
X-Google-Smtp-Source: AGHT+IHGdK2+uxBLZfa2I5wDKQkMecG/bzA+sy52TTnGHdmt1KF/Z/mNcPu8r1WTjh/jhTh0aMPa7nsaLNv64FytftE=
X-Received: by 2002:a2e:9f49:0:b0:2b6:df71:cff1 with SMTP id
 v9-20020a2e9f49000000b002b6df71cff1mr2868612ljk.52.1700005117980; Tue, 14 Nov
 2023 15:38:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102155827.4219-1-silviu.barbulescu@nxp.com> <20231102155827.4219-3-silviu.barbulescu@nxp.com>
In-Reply-To: <20231102155827.4219-3-silviu.barbulescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 14 Nov 2023 18:38:25 -0500
Message-ID: <CABBYNZKePeybTbV3a9ihh7D5iKGsudAyR1qrie9NDjJAwJg9_A@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] bap: Fix source+sink endpoint registration
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com, 
	andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Silviu,

On Thu, Nov 2, 2023 at 11:58=E2=80=AFAM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> From: Claudia Draghicescu <claudia.rosu@nxp.com>
>
> When registering both sink and source endpoints,
> the register endpoint method call results in 2 remote endpoints for each
> scanned broadcast source

There seems to be 2 patches with the same subject?

> ---
>  profiles/audio/bap.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index b74498c4c..a84181e1a 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -1050,7 +1050,7 @@ static struct bap_ep *ep_register_bcast(struct bap_=
data *data,
>         const char *suffix;
>         struct match_ep match =3D { lpac, rpac };
>
> -       switch (bt_bap_pac_get_type(rpac)) {
> +       switch (bt_bap_pac_get_type(lpac)) {
>         case BT_BAP_BCAST_SOURCE:
>         case BT_BAP_BCAST_SINK:
>                 queue =3D data->bcast;
> @@ -1073,13 +1073,13 @@ static struct bap_ep *ep_register_bcast(struct ba=
p_data *data,
>         if (device)
>                 ep->data->device =3D device;
>
> -       switch (bt_bap_pac_get_type(rpac)) {
> -       case BT_BAP_BCAST_SINK:
> +       switch (bt_bap_pac_get_type(lpac)) {
> +       case BT_BAP_BCAST_SOURCE:
>                 err =3D asprintf(&ep->path, "%s/pac_%s%d",
>                                 adapter_get_path(adapter), suffix, i);
>                 ep->base =3D new0(struct iovec, 1);
>                 break;
> -       case BT_BAP_BCAST_SOURCE:
> +       case BT_BAP_BCAST_SINK:
>                 err =3D asprintf(&ep->path, "%s/pac_%s%d",
>                                 device_get_path(device), suffix, i);
>                 ep->base =3D new0(struct iovec, 1);
> @@ -1101,7 +1101,10 @@ static struct bap_ep *ep_register_bcast(struct bap=
_data *data,
>                 ep_free(ep);
>                 return NULL;
>         }
> -       bt_bap_pac_set_user_data(rpac, ep->path);
> +       if (rpac)
> +               bt_bap_pac_set_user_data(rpac, ep->path);
> +       else
> +               bt_bap_pac_set_user_data(lpac, ep->path);

It is probably a good idea to add comment here why it is necessary to
check if rpac is set.

>         DBG("ep %p lpac %p rpac %p path %s", ep, ep->lpac, ep->rpac, ep->=
path);
>
> @@ -1792,7 +1795,7 @@ static void bap_listen_io_broadcast(struct bap_data=
 *data, struct bap_ep *ep,
>                 error("%s", err->message);
>                 g_error_free(err);
>         }
> -
> +       ep->io =3D io;
>         ep->data->listen_io =3D io;
>
>  }
> @@ -1958,12 +1961,12 @@ static void pac_added_broadcast(struct bt_bap_pac=
 *pac, void *user_data)
>  {
>         struct bap_data *data =3D user_data;
>
> -       if (bt_bap_pac_get_type(pac) =3D=3D BT_BAP_BCAST_SOURCE)
> -               bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SOURCE,
> -                                               pac_found_bcast, data);
> -       else if (bt_bap_pac_get_type(pac) =3D=3D BT_BAP_BCAST_SINK)
> -               bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SINK,
> -                                               pac_found_bcast, data);
> +       if (bt_bap_pac_bcast_is_local(data->bap, pac) &&
> +               (bt_bap_pac_get_type(pac) =3D=3D BT_BAP_BCAST_SOURCE))
> +               pac_found_bcast(pac, NULL, user_data);

Im not really sure we need bt_bap_pac_bcast_is_local, can't we just
assume it based on BT_BAP_BCAST_SOURCE?

> +       else
> +               bt_bap_foreach_pac(data->bap, bt_bap_pac_get_type(pac),
> +                                       pac_found_bcast, data);
>  }
>
>  static bool ep_match_pac(const void *data, const void *match_data)
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
