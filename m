Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5FEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 20:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23ED061A4F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 20:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347864AbhI3U1Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Sep 2021 16:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347637AbhI3U1P (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Sep 2021 16:27:15 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3FCC06176A
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 13:25:32 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id f2so8003310vsj.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 13:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QOPceUGEeuIJvDvIbcRkfR684gcTPL8DgeRkCI8isCw=;
        b=NPCFAIGpxl6qIZUh11c5JYala+jxmglh97eGB4iuVk5IWiVLsHOVcOl8qWtzrtYbFR
         BcjqVJCPJOehNWkY05Xi9lGPwjkZzEqNQwo/EuYnJHdjoedzozQJE8vb5LzxG11WCNYO
         lxgR5Np/pwNzpIcRrq0U55EMllo6xWzw+vBcfoSk5gTOjmDC/xZ7RtyROxypT93JOA/p
         FpRH/JGHMB0AhgdQtcNguFzpL61xvcsj1e2Syiu+d0QDYznEVdgNUmyxtl8THm2B1+BK
         7bF/7AYvVjLBcwWaoIrtXnfAe6BEkYEPK20GvkkliSF0yx7HcG64mp3To/avO+HSRaC2
         YNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QOPceUGEeuIJvDvIbcRkfR684gcTPL8DgeRkCI8isCw=;
        b=6L4U/jeM1dSfC9GvZadEBs8jiXnCsYnlhK9Ojn426bShMzTHmeOsqrD/JTRXJRTpiA
         +OihXYpOBQSLVheAcMY1t9WyjZn/M3+AXU3uh2lXP2iBxqzO30f8uDJ0gy+fNShOUTP2
         yt0ScJ4DPTKvq67fab7jswJZMmsYfCAjnd7ORUJwtJD+4tpkw0KO/wvGpFiXxPcJKuqX
         EDolRlniQDTt8GFTY3jNAdUq5fhHwfF/0ilK5vTJ+Cube66rTCQZeOEHD5caQ1fdwO2A
         wT7HjMY7p86iNrEhFYSYr6xgittP18hvo/gngsJU0fyB5fPCyKDa6DcMBByl9KL9Fm2Q
         Utdg==
X-Gm-Message-State: AOAM530uQ14/pipPCxDMwd5ULED8fH3gczoJbHhrrkZqMIwEYmtXyE3W
        UZsGbtqjhWIR3h55ocf8kzcFaJTVQUfXMA8XTRXLpfwYhaQ=
X-Google-Smtp-Source: ABdhPJzdU7Z6LLFoaqUKDIiB14AFnBDkzNYWiF9Q7aEN0UKcaFNl4QzNstXenOUjcdkliq2udNr9VQosMYw3QEJRGag=
X-Received: by 2002:a67:ea83:: with SMTP id f3mr1430285vso.39.1633033531448;
 Thu, 30 Sep 2021 13:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210930150819.34270-1-dmartinez@starry.com> <20210930150819.34270-2-dmartinez@starry.com>
In-Reply-To: <20210930150819.34270-2-dmartinez@starry.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 30 Sep 2021 13:25:20 -0700
Message-ID: <CABBYNZ+mqHC3=8HRoALCUiJrns0yeVwKy92w1gt6rsfx__oVPw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 1/2] gatt: Allow GATT server to dicate CCC permissions
To:     Dagan Martinez <dmartinez@starry.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dagan,

On Thu, Sep 30, 2021 at 8:24 AM Dagan Martinez <dmartinez@starry.com> wrote:
>
> Allow a GATT server to impose permissions/restrictions on a CCC by
> setting additional `X-notify` and `X-indicate` permissions on its
> associated characteristic.
>
> This allows a developer to require encryption/authentication in order
> for a GATT client to subscribe to server-initiated updates.
>
> Test procedure:
> Attempt to read/write with a "low" security level on an unprotected CCC
> using gatttool, and succeed
> Attempt to READ with a "low" security level on an protected CCC
> using gatttool, and succeed
> Attempt to WRITE with a "low" security level on an protected CCC
> using gatttool, and fail
> Attempt to read/write while paired on a protected CCC using
> `bluetoothctl`, and succeed
> ---
>  src/gatt-database.c    | 42 ++++++++++++++++++++++++++++++++++++++----
>  src/shared/att-types.h |  4 ++++
>  2 files changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 68f411ba4..fd4a39166 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -1060,17 +1060,33 @@ service_add_ccc(struct gatt_db_attribute *service,
>                                 struct btd_gatt_database *database,
>                                 btd_gatt_database_ccc_write_t write_callback,
>                                 void *user_data,
> +                               uint32_t parent_permissions,
>                                 btd_gatt_database_destroy_t destroy)
>  {
>         struct gatt_db_attribute *ccc;
>         struct ccc_cb_data *ccc_cb;
>         bt_uuid_t uuid;
> +       uint32_t permissions;
>
>         ccc_cb = new0(struct ccc_cb_data, 1);
>
> +       /*
> +        * Provide a way for the permissions on a characteristic to dictate
> +        * the permissions on the CCC
> +        */
> +       permissions = BT_ATT_PERM_READ | BT_ATT_PERM_WRITE;
> +
> +       if (parent_permissions & BT_ATT_PERM_SERVER_INITIATED_UPDATE_ENCRYPT)
> +               permissions |= BT_ATT_PERM_WRITE_ENCRYPT;
> +
> +       if (parent_permissions & BT_ATT_PERM_SERVER_INITIATED_UPDATE_AUTHEN)
> +               permissions |= BT_ATT_PERM_WRITE_AUTHEN;
> +
> +       if (parent_permissions & BT_ATT_PERM_SERVER_INITIATED_UPDATE_SECURE)
> +               permissions |= BT_ATT_PERM_WRITE_SECURE;
> +
>         bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
> -       ccc = gatt_db_service_add_descriptor(service, &uuid,
> -                               BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> +       ccc = gatt_db_service_add_descriptor(service, &uuid, permissions,
>                                 gatt_ccc_read_cb, gatt_ccc_write_cb, database);
>         if (!ccc) {
>                 error("Failed to create CCC entry in database");
> @@ -1227,7 +1243,7 @@ static void populate_gatt_service(struct btd_gatt_database *database)
>                                 NULL, NULL, database);
>
>         database->svc_chngd_ccc = service_add_ccc(service, database, NULL, NULL,
> -                                                                       NULL);
> +                                                                   0, NULL);
>
>         bt_uuid16_create(&uuid, GATT_CHARAC_CLI_FEAT);
>         database->cli_feat = gatt_db_service_add_characteristic(service,
> @@ -1690,6 +1706,24 @@ static bool parse_chrc_flags(DBusMessageIter *array, uint8_t *props,
>                         *perm |= BT_ATT_PERM_WRITE | BT_ATT_PERM_WRITE_SECURE;
>                 } else if (!strcmp("authorize", flag)) {
>                         *req_prep_authorization = true;
> +               } else if (!strcmp("encrypt-notify", flag)) {
> +                       *perm |= BT_ATT_PERM_SERVER_INITIATED_UPDATE_ENCRYPT;
> +                       *props |= BT_GATT_CHRC_PROP_NOTIFY;
> +               } else if (!strcmp("encrypt-authenticated-notify", flag)) {
> +                       *perm |= BT_ATT_PERM_SERVER_INITIATED_UPDATE_AUTHEN;
> +                       *props |= BT_GATT_CHRC_PROP_NOTIFY;
> +               } else if (!strcmp("secure-notify", flag)) {
> +                       *perm |= BT_ATT_PERM_SERVER_INITIATED_UPDATE_SECURE;
> +                       *props |= BT_GATT_CHRC_PROP_NOTIFY;
> +               } else if (!strcmp("encrypt-indicate", flag)) {
> +                       *perm |= BT_ATT_PERM_SERVER_INITIATED_UPDATE_ENCRYPT;
> +                       *props |= BT_GATT_CHRC_PROP_INDICATE;
> +               } else if (!strcmp("encrypt-authenticated-indicate", flag)) {
> +                       *perm |= BT_ATT_PERM_SERVER_INITIATED_UPDATE_AUTHEN;
> +                       *props |= BT_GATT_CHRC_PROP_INDICATE;
> +               } else if (!strcmp("secure-indicate", flag)) {
> +                       *perm |= BT_ATT_PERM_SERVER_INITIATED_UPDATE_SECURE;
> +                       *props |= BT_GATT_CHRC_PROP_INDICATE;
>                 } else {
>                         error("Invalid characteristic flag: %s", flag);
>                         return false;
> @@ -2796,7 +2830,7 @@ static bool database_add_ccc(struct external_service *service,
>                 return true;
>
>         chrc->ccc = service_add_ccc(service->attrib, service->app->database,
> -                                               ccc_write_cb, chrc, NULL);
> +                                       ccc_write_cb, chrc, chrc->perm, NULL);
>         if (!chrc->ccc) {
>                 error("Failed to create CCC entry for characteristic");
>                 return false;
> diff --git a/src/shared/att-types.h b/src/shared/att-types.h
> index a08b24155..eb5def503 100644
> --- a/src/shared/att-types.h
> +++ b/src/shared/att-types.h
> @@ -137,6 +137,10 @@ struct bt_att_pdu_error_rsp {
>                                         BT_ATT_PERM_WRITE_AUTHEN | \
>                                         BT_ATT_PERM_WRITE_ENCRYPT | \
>                                         BT_ATT_PERM_WRITE_SECURE)
> +/* Permissions to be applied to the CCC*/
> +#define BT_ATT_PERM_SERVER_INITIATED_UPDATE_ENCRYPT 0x0400
> +#define BT_ATT_PERM_SERVER_INITIATED_UPDATE_AUTHEN 0x0800
> +#define BT_ATT_PERM_SERVER_INITIATED_UPDATE_SECURE 0x1000

I don't think we really need these above, how about we do something
like the following:

https://gist.github.com/Vudentz/af6899625df3d83b62cfbc61bbd4b94b

That way we don't need to define more permissions since we can just
reuse the existing one which imo are easier to understand.

>  /* GATT Characteristic Properties Bitfield values */
>  #define BT_GATT_CHRC_PROP_BROADCAST                    0x01
> --
> 2.31.1

Btw, it would be great to have an example using the new flags in the
patch description, bluetoothctl> register-characteristic...


-- 
Luiz Augusto von Dentz
