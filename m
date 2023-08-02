Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5491C04A94
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 17:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjHBRj2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 13:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbjHBRjQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 13:39:16 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCE71FEE
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 10:38:42 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9338e4695so399851fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Aug 2023 10:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690997920; x=1691602720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A23ye/hWIzYOw6024PBTpyx4AHCHLcFsTJ2U6aQ9+Dw=;
        b=N+am8V5KJp+Xt0MelmxX56WRGrBI0IRoueyyw+D0bAi30yQ29qiGelMzKVDqoHHDxr
         t3VsCURZfk/t0i6VPOa5ftSSiuC6ZDeV9BN/bFl3+AsC11sydheaOCoME2vNaDF2ssdF
         wTLg0nS/RMDRO//bpqIHcszxygjwOqYDvRd9mLSYQASMUrYi+dCSy181YJIHDcxUfQue
         ZS0PK+OZx/6cX88EivKmAZjYmrM8XXhkrQEWU/b0H/gPCdTpMOcQ2TlzLHPxa5P6IDob
         ISuNJmEKhClNd9iHBaIE78YksuUzzwGzl9LFW+4rvCSsg/WXBO8K8SHMbU0YXGvmRCVl
         27KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690997920; x=1691602720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A23ye/hWIzYOw6024PBTpyx4AHCHLcFsTJ2U6aQ9+Dw=;
        b=jCzg8ebE/sDEkBDn/BBpnCWmZUzLqcumC+AWIvasm/BmKeV0ny5fq+dx11Z4Cvu4E3
         FKZjCHrru+YVk03ZYuxHpFCdZ3GuljryOVTXw/pZckdqLvnt1tLPbIdo6HrDLcIFwHj5
         zQvARR2hP/KhYIO+rgRADOR14HLLXVj+H+YzOqkPiLz7LMV6xycq2F3yLJNu5Xb7tbTw
         zaK30gUcUa7VDUB0/DnuvohBTE46ynJXMx995AvLZtW4BddPygwi4D9kUPfd/0BRbAEp
         Wlxt5DncsQ5r375GrFS4s05N/cVC/gj3QQNsoYCTsyfKuc6Vs347l+bod/sguPfZzA0J
         6ayQ==
X-Gm-Message-State: ABy/qLYrBb/OA9LldLUtmjGRZrW01Tb9y4VLnOXqAAYdD2VSlN289EZU
        5FPHJmtPqDmWnEsnnSwRGJekedMDF6GPwKYogXBSn7Lc
X-Google-Smtp-Source: APBJJlFNbv96lmTA7EN6HLn1nMpmQA9zZdZLZzmPFe69gBCpvGRBkReSXDbRCi4HOCDUdgZJvXndTYQ6Z0BblFK3iD0=
X-Received: by 2002:a05:651c:1029:b0:2b7:bb73:b6e5 with SMTP id
 w9-20020a05651c102900b002b7bb73b6e5mr5625338ljm.27.1690997919767; Wed, 02 Aug
 2023 10:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230802132355.4953-1-claudia.rosu@nxp.com> <20230802132355.4953-4-claudia.rosu@nxp.com>
In-Reply-To: <20230802132355.4953-4-claudia.rosu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 2 Aug 2023 10:38:27 -0700
Message-ID: <CABBYNZKqdf+R_P268Bi1adbfZ6vF3y=XqWQuH7ifvO=-jncm_A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 3/6] adapter: Broadcast source discovery
To:     Claudia Draghicescu <claudia.rosu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Claudia,

On Wed, Aug 2, 2023 at 6:49=E2=80=AFAM Claudia Draghicescu <claudia.rosu@nx=
p.com> wrote:
>
> This adds a new method in the adapter driver, device_resolved() called
> when a broadcast source that advertises the BCAA_UUID is discovered.
>
> ---
>  src/adapter.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  src/adapter.h |  2 ++
>  2 files changed, 50 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 491bd7031..29c6a576a 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -7029,6 +7029,45 @@ static bool is_filter_match(GSList *discovery_filt=
er, struct eir_data *eir_data,
>         return got_match;
>  }
>
> +static int find_baas(gconstpointer a, gconstpointer b)
> +{
> +       const struct eir_sd *sd =3D a;
> +       const char *baas_uuid =3D b;
> +
> +       return strcmp(sd->uuid, baas_uuid);
> +}
> +
> +static bool accept_bcast_adv(struct btd_adapter *adapter)
> +{
> +       if ((btd_adapter_has_settings(adapter, MGMT_SETTING_ISO_SYNC_RECE=
IVER)))
> +               return true;
> +
> +       return false;
> +}
> +
> +static bool is_bcast_source(struct eir_data *eir_data)
> +{
> +       if (!(eir_data->flags & (EIR_LIM_DISC | EIR_GEN_DISC))
> +               && (g_slist_find_custom(eir_data->sd_list,
> +                               BCAA_SERVICE_UUID, find_baas))) {
> +               return true;
> +       }
> +
> +       return false;
> +}
> +static void bcast_new_source(struct btd_adapter *adapter,
> +                                struct btd_device *device)
> +{
> +       GSList *l;
> +
> +       for (l =3D adapter->drivers; l; l =3D g_slist_next(l)) {
> +               struct btd_adapter_driver *driver =3D l->data;
> +
> +               if (!strcmp(driver->name, "bcast"))
> +                       driver->device_discovered(adapter, device);
> +       }
> +}

This code probably doesn't belong here, profile specific code like the
above shall be left to the plugin to handle.

>  static void filter_duplicate_data(void *data, void *user_data)
>  {
>         struct discovery_client *client =3D data;
> @@ -7152,12 +7191,21 @@ void btd_adapter_device_found(struct btd_adapter =
*adapter,
>                         return;
>                 }
>
> +               if (accept_bcast_adv(adapter) && is_bcast_source(&eir_dat=
a))
> +                       monitoring =3D true;
> +
>                 if (!discoverable && !monitoring && !eir_data.rsi) {
>                         eir_data_free(&eir_data);
>                         return;
>                 }
>
>                 dev =3D adapter_create_device(adapter, bdaddr, bdaddr_typ=
e);
> +
> +               if (dev && is_bcast_source(&eir_data)) {
> +                       bcast_new_source(adapter, dev);
> +                       btd_device_set_temporary(dev, false);
> +               }
> +
>         }
>
>         if (!dev) {
> diff --git a/src/adapter.h b/src/adapter.h
> index ca96c1f65..ee32f7110 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -125,6 +125,8 @@ struct btd_adapter_driver {
>                                                 struct btd_device *device=
);
>         void (*device_resolved)(struct btd_adapter *adapter,
>                                                 struct btd_device *device=
);
> +       void (*device_discovered)(struct btd_adapter *adapter,
> +                                               struct btd_device *device=
);

Let me figure out the driver interface since I think it is better to
use the btd_device_driver and then have a generic match by UUID.

>         /* Indicates the driver is experimental and shall only be registe=
red
>          * when experimental has been enabled (see: main.conf:Experimenta=
l).
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
