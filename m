Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA633EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jul 2023 18:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjGXS1a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jul 2023 14:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjGXS13 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jul 2023 14:27:29 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02AF127
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jul 2023 11:27:27 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b933bbd3eeso68033741fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jul 2023 11:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690223246; x=1690828046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BoyKUsMpbwF4KyR+TkDwzP2KqObXCZp7Iv0he6kCls=;
        b=mXBQC2/fLJeyt+wVZPFchEms0wpOcInvoJSmox+44pA7LUsUcFesXjbcysoFf9Mh/h
         7G5hiYlx1vBIWj5wm6KmQqxgPLZHp6TUI/sG207isTNOlTpPU/uvVw0m1mVLo+lHw4n+
         SuYtaflkSF0esprOERFrWe8a+tapb5pz5MiJ+CS7DWuCejSuDgao9vnYa39AEeCpVJ4O
         stUD9OB6wRHzzatrlKD0n4yBYVPYM9J8HSfK1id4Jjwa9narAeWUIVwDTjkJGc3bS//F
         nCOWbNhKFFyZzquSfypIPxEZlvQPbuemYC7JwGHOWz33XDKrfFlcmAYpzzhlaz5Az707
         vgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690223246; x=1690828046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BoyKUsMpbwF4KyR+TkDwzP2KqObXCZp7Iv0he6kCls=;
        b=B2nf3L4CNc3XBRbNcX1c2bVfP7f8/In5b/V0vaQb8WvAuYJ24wt6k37Yltujv12u6u
         lEa3Pgn7siS6WWLgh2UyclBs87QGeQlnoiV8lIY3W2kajXqHBH3E9FfxIR62vDFJueii
         TkETW01ZAGkAYSprAy/HX81K2Zr1bRm8hn8gU6fbqeRTVOIWGj5jn38PhJ/rbegVFUqn
         3sl2X9Wlnzv94tFbjhTy0RzdKLRrEamgOrG638fS5PfFQvcqktcXMC5gAKh1drd5bM/K
         0hk9jhEuWKt+NEEeyxV7OliAOdXPUTJ3EPLMilvQA/gB+j/yzgP3asyMICdJV1mrrWKb
         djPg==
X-Gm-Message-State: ABy/qLbzC88LMAI1kJT5tt/RxkkeWz6CNdnrOblXsO+OozYSLYIZrTAJ
        yDkw1OQzAGopCpEHziU3CL+FhvrZIPMyMbXILL8=
X-Google-Smtp-Source: APBJJlGsymKhh31gg09xhW9WcnIAVlryWejtBVjCaLpdkqM55u0hMnzKRtJ8sjdVUk+SMmFqUkPKOqi0yqADEPaArRs=
X-Received: by 2002:a2e:95cc:0:b0:2b6:df71:cff1 with SMTP id
 y12-20020a2e95cc000000b002b6df71cff1mr7043105ljh.52.1690223245680; Mon, 24
 Jul 2023 11:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230724122908.42409-1-nitin.jadhav@nxp.com> <20230724122908.42409-2-nitin.jadhav@nxp.com>
In-Reply-To: <20230724122908.42409-2-nitin.jadhav@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 24 Jul 2023 11:27:13 -0700
Message-ID: <CABBYNZJWLEAaLvi0cuHZ+yPimOB=dZXv302xhh1UiuBhD1mZnw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/1] shared/vcp: Fixed the crash observed with VOCS
To:     Nitin Jadhav <nitin.jadhav@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com,
        pav@iki.fi, sathish.narasimman@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Nitin,

On Mon, Jul 24, 2023 at 5:29=E2=80=AFAM Nitin Jadhav <nitin.jadhav@nxp.com>=
 wrote:
>
> Root cause
> - There are two types of database- Remote and Local (rdb and ldb).
> - In client mode currently the code was written to access ldb.
>
> Fix
> - Correcting it, to access rdb has resolved the problem in VOCS.
> - Same correction is done for VCS.
>
> Reported-by: Pauli Virtanen <pav@iki.fi>
> ---
> v2: Fixed GitLint and ScanBuild warnings
> ---
>  src/shared/vcp.c | 52 +++++++++++++++++++++++++++---------------------
>  1 file changed, 29 insertions(+), 23 deletions(-)
>
> diff --git a/src/shared/vcp.c b/src/shared/vcp.c
> index 74bd01729..80d4dfcd4 100644
> --- a/src/shared/vcp.c
> +++ b/src/shared/vcp.c
> @@ -973,7 +973,7 @@ static void vocs_voaodec_read(struct gatt_db_attribut=
e *attrib,
>         struct bt_vocs *vocs =3D user_data;
>         struct iovec iov;
>
> -       iov.iov_base =3D &vocs->vocs_ao_dec;
> +       iov.iov_base =3D vocs->vocs_ao_dec;
>         iov.iov_len =3D strlen(vocs->vocs_ao_dec);
>
>         gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
> @@ -998,10 +998,12 @@ static struct bt_vcs *vcs_new(struct gatt_db *db, s=
truct bt_vcp_db *vdb)
>
>         /* Populate DB with VCS attributes */
>         bt_uuid16_create(&uuid, VCS_UUID);
> -       vcs->service =3D gatt_db_add_service(db, &uuid, true, 9);
> +
> +       vcs->service =3D gatt_db_add_service(db, &uuid, true, 10);

Not sure what this has to do with the crashes?

>         gatt_db_service_add_included(vcs->service, vdb->vocs->service);
>         gatt_db_service_set_active(vdb->vocs->service, true);
>
> +

Please remove the extra space above.

>         bt_uuid16_create(&uuid, VOL_STATE_CHRC_UUID);
>         vcs->vs =3D gatt_db_service_add_characteristic(vcs->service,
>                                         &uuid,
> @@ -1385,11 +1387,12 @@ static void read_vocs_audio_location(struct bt_vc=
p *vcp, bool success,
>                                      const uint8_t *value, uint16_t lengt=
h,
>                                      void *user_data)
>  {
> -       uint32_t *vocs_audio_loc;
> -       struct iovec iov =3D {
> -               .iov_base =3D (void *) value,
> -               .iov_len =3D length,
> -       };
> +       uint32_t vocs_audio_loc;
> +
> +       if (!value) {
> +               DBG(vcp, "Unable to get VOCS Audio Location");
> +               return;
> +       }
>
>         if (!success) {
>                 DBG(vcp, "Unable to read VOCS Audio Location: error 0x%02=
x",
> @@ -1397,26 +1400,22 @@ static void read_vocs_audio_location(struct bt_vc=
p *vcp, bool success,
>                 return;
>         }
>
> -       vocs_audio_loc =3D iov_pull_mem(&iov, sizeof(uint32_t));
> -       if (!*vocs_audio_loc) {
> -               DBG(vcp, "Unable to get VOCS Audio Location");
> -               return;
> -       }
> +       memcpy(&vocs_audio_loc, value, length);
>
> -       DBG(vcp, "VOCS Audio Loc:%x", *vocs_audio_loc);
> +       DBG(vcp, "VOCS Audio Loc:%x", vocs_audio_loc);

We should probably store the location within vcp, that said I don't
think this has anything to do with the crashes though.

>  }
>
> -
>  static void read_vocs_audio_descriptor(struct bt_vcp *vcp, bool success,
>                                        uint8_t att_ecode,
>                                        const uint8_t *value, uint16_t len=
gth,
>                                        void *user_data)
>  {
>         char *vocs_ao_dec_r;
> -       struct iovec iov =3D {
> -               .iov_base =3D (void *) value,
> -               .iov_len =3D length,
> -       };
> +
> +       if (!value) {
> +               DBG(vcp, "Unable to get VOCS Audio Descriptor");
> +               return;
> +       }
>
>         if (!success) {
>                 DBG(vcp, "Unable to read VOCS Audio Descriptor: error 0x%=
02x",
> @@ -1424,13 +1423,20 @@ static void read_vocs_audio_descriptor(struct bt_=
vcp *vcp, bool success,
>                 return;
>         }
>
> -       vocs_ao_dec_r =3D iov_pull_mem(&iov, length);
> -       if (!*vocs_ao_dec_r) {
> +       vocs_ao_dec_r =3D malloc(length+1);
> +       memset(vocs_ao_dec_r, 0, length+1);
> +
> +       memcpy(vocs_ao_dec_r, value, length);
> +
> +       if (!vocs_ao_dec_r) {
>                 DBG(vcp, "Unable to get VOCS Audio Descriptor");
>                 return;
>         }
>
> -       DBG(vcp, "VOCS Audio Descriptor:%s", *vocs_ao_dec_r);
> +       DBG(vcp, "VOCS Audio Descriptor: %s", vocs_ao_dec_r);
>
> +       free(vocs_ao_dec_r);
> +       vocs_ao_dec_r =3D NULL;

Ditto, not really sure what this has to do with the crashes, besides
allocating memory just to free it here sounds useless.

>  }
>
>  static void vcp_pending_destroy(void *data)
> @@ -1719,10 +1725,10 @@ bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_=
gatt_client *client)
>                 return false;
>
>         bt_uuid16_create(&uuid, VCS_UUID);
> -       gatt_db_foreach_service(vcp->ldb->db, &uuid, foreach_vcs_service,=
 vcp);
> +       gatt_db_foreach_service(vcp->rdb->db, &uuid, foreach_vcs_service,=
 vcp);
>
>         bt_uuid16_create(&uuid, VOL_OFFSET_CS_UUID);
> -       gatt_db_foreach_service(vcp->ldb->db, &uuid, foreach_vocs_service=
, vcp);
> +       gatt_db_foreach_service(vcp->rdb->db, &uuid, foreach_vocs_service=
, vcp);

These changes seem to be the actual problem, so I'd split them and if
you still want to introduce the other changes as well please create
proper commits describing why they are required.

>         return true;
>  }
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
