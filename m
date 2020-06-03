Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F9AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 21:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B2F82077D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 21:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSboKP2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgFCVGu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 17:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgFCVGu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 17:06:50 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67318C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 14:06:50 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h7so3091204otr.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 14:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=qT1ast9mZcvMuGYOdF6uM6XOpEO/sRBjQe8eMUq7+3g=;
        b=OSboKP2utfMtm1RlcKAm1QRpCcEx1s6k5wXrJ4zX5S1tHEMSup3TUPFnkX9+UjeTgb
         1IMMHNK/9I6SD2r47KgwS+Xvb5gFozDxTo4Eu8SDPff6URMvYh/3aGtALR2Nop5mBJWx
         Mffu3tVRdUDVR2CbXSmoxT/XnZ8RtxHJq6V7SO53lgIjafEVlqE5tAg1TVpG4juOUJOj
         s/k2CDnCIjEiZ9/WpWiu7uJqBxlFBHCyannRWcPB6oRQ10O7ZQZoonznSHnHtwCi+FOt
         UbUWC7+O2HTWBhmPIb6bugxlgoO2T+RU6g2VHZMvoJCRQFEFwvdn4X4laEDtB9y2JtQN
         z23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=qT1ast9mZcvMuGYOdF6uM6XOpEO/sRBjQe8eMUq7+3g=;
        b=Ig/untlt2JalN3YK53SARIHXtcDGTTkJ5FEcskt4Pwem6VIs3J6lgM544DlPo5bFyT
         BKxQt5AZKMhYi4bxWMgcfqJjeawlZ/JzQewy+yDxYZZiCgB9RNdhGeFusolb65L9V8Et
         IwsMu5L3AXl/biuEMq8bQbyw/42bN7UV4diLdvLm7DUUoPNtjhPhwzvs4dML/CM7Rs/e
         Nyl0JFTFwGkRdx4E0rPrpYAUPodl3ZB5Jg4ElyNrJVdlQW2cg62XB3l6PlblL2qg+O0w
         g6mwJoy5pTjPezjY1X5O/rynhq7cXs/9V3bS5lpipIdT2jTEm509htiwDfR/hF1dOJmm
         C5Yg==
X-Gm-Message-State: AOAM530eEJX1VcmH5sfpzND9uJZX7gf0ArutTTHu8GSTH5Wvy5WZW1YW
        /uWoUKFREUqMaiwL010rX8DMCKJCpybWAg3p9ItVng==
X-Google-Smtp-Source: ABdhPJzt0gGMb8ezemudJxnw5AcD5ob1tZaAvF2qG2p/H0AX1gCBnMDeNB72KllSV4ml3MSUVmcdOTyyMrSwGhEvFZk=
X-Received: by 2002:a05:6830:310c:: with SMTP id b12mr1428012ots.11.1591218409353;
 Wed, 03 Jun 2020 14:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200603173519.559897-1-luiz.dentz@gmail.com>
In-Reply-To: <20200603173519.559897-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 3 Jun 2020 14:06:38 -0700
Message-ID: <CABBYNZLYozG9sTy0x0i8yLU5dX-77eCevsLr9r5a3kA58BLM-w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt: Fix possible crash when unable to generate hash
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Jun 3, 2020 at 10:35 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> gatt_db_get_hash actually depends on crypto so platforms that don't
> have it enabled shall not register GATT_CHARAC_DB_HASH as otherwise it
> would cause a crash due to hash being NULL.
> ---
>  src/gatt-database.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 8cbe09bae..d717bbcde 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -1211,10 +1211,14 @@ static void populate_gatt_service(struct btd_gatt_database *database)
>                                 cli_feat_read_cb, cli_feat_write_cb,
>                                 database);
>
> -       bt_uuid16_create(&uuid, GATT_CHARAC_DB_HASH);
> -       database->db_hash = gatt_db_service_add_characteristic(service,
> +
> +       /* Only expose database hash chrc if supported */
> +       if (gatt_db_get_hash(database->db)) {
> +               bt_uuid16_create(&uuid, GATT_CHARAC_DB_HASH);
> +               database->db_hash = gatt_db_service_add_characteristic(service,
>                                 &uuid, BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_READ,
>                                 db_hash_read_cb, NULL, database);
> +       }
>
>         /* Only enable EATT if there is a socket listening */
>         if (database->eatt_io) {
> --
> 2.25.3

Push.

-- 
Luiz Augusto von Dentz
