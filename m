Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40948C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 00:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A26B2065C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 00:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOuzAXA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgFEAOZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jun 2020 20:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgFEAOZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jun 2020 20:14:25 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A678C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2020 17:14:24 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id s21so6723878oic.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2020 17:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z27mTKx8psjVmbzl9dm6tDZauKBg+vj36uFSdDzHggU=;
        b=sOuzAXA+Z4QqaGyYYsS4N3JaXfcnv7WKwQel/Jr+95Ps7XhBRc270vuvz3YnEE0XGW
         Q2RrpeSN6clGEvrwflZKvDV2VdZQI2w+nK24ZVx0Nch8oVR1j/RRcgJXPVSVC2daNOzg
         h1LhWryvk0W0Qz/yERDJb4W9XVyjGIWRyUUEF+5EzxbAHHaJ/k6xUpXmebQgpqBFm3YD
         qA7ckx3H0lP/sLvxXGvPlCnm8fvkWtc/tJfeEhew/AUg1SFxxvsEeugulPh6zivfVhWk
         RFt1dTZQZjLdmBqnUYMQTylcz50rtb+QDlTL2XfMNEgY1TtBSP53n3I/teO75FLu7cdS
         00zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z27mTKx8psjVmbzl9dm6tDZauKBg+vj36uFSdDzHggU=;
        b=HCNL4G+ORpkC0VPWnPhLfTuahtxwRziixavAJJvP0PJa27rTrhrleY6IfiLhVmZzNT
         SlcGdY2soehPx4jn/ESwSz0JUjgXVAE/B4OG5+mi4w9L2Q+LxUeubSWESrXVp5qBBYEd
         f1keKsw14F9GYcs3zGWzVAhzsn1KRPqRcev21i/Gw//vCUrp/3+obV+0lWqAsZMMJPyh
         /Kg/5RtWIVZ6rF1ssw+Bcbb0ierHnvb/H3Y/k8E0lhRVHPlhhDuCXqAw47oz0wL9Z18d
         nTilO6htBa/+wdrWYLiBAC3r9juHn6Jgek0cRaSzHHry5HtlAxiSXbrVNPeFWzo4fHUp
         Acsw==
X-Gm-Message-State: AOAM533kQ5qLuoLb1TOXyEHonR7+86Zb8eLQ25jyj1Ikn7yEzolWUgXf
        sXjXldG3fMl+2NPqJ2YXAFpiEJ+9t8x3UG4rUlME1w==
X-Google-Smtp-Source: ABdhPJwlyHO80pMupWeOcPWtDeskGSJ8KohWpq1Qmni6YppPlMXsebtqxL2Syqzor3JeZsvOf8F80aUyn49tIwnu0U0=
X-Received: by 2002:aca:b1c5:: with SMTP id a188mr321929oif.110.1591316063625;
 Thu, 04 Jun 2020 17:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200604232433.4951-1-pali@kernel.org>
In-Reply-To: <20200604232433.4951-1-pali@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 5 Jun 2020 00:14:12 -0700
Message-ID: <CABBYNZ+J-4a1Vvk=8VGLkFzVub_P7bwjaskdeW7pXsePzAu58A@mail.gmail.com>
Subject: Re: [PATCH] sap: Improve error messages
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Thu, Jun 4, 2020 at 4:27 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> When bluetoohd daemon is starting, it prints following error messages:
>
> bluetoothd[19117]: profiles/sap/server.c:sap_server_register() Sap driver=
 initialization failed.
> bluetoothd[19117]: sap-server: Operation not permitted (1)
>
> Initialization is failing because sap server is enabled only when
> bluetoothd daemon is started with --experimental option.
>
> And "Operation not permitted" is result of returning error code -1.
>
> This patch improves error messages. When --experimental option is not use=
d
> then bluetoothd prints more explaining error message. And in case functio=
n
> sap_init() fails then -EOPNOTSUPP "Operation not supported" is returned
> instead of -EPERM (-1).
> ---
>  profiles/sap/server.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/sap/server.c b/profiles/sap/server.c
> index 5de682a33..99ff80297 100644
> --- a/profiles/sap/server.c
> +++ b/profiles/sap/server.c
> @@ -1353,9 +1353,14 @@ int sap_server_register(struct btd_adapter *adapte=
r)
>         GIOChannel *io;
>         struct sap_server *server;
>
> +       if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
> +               error("Sap driver is disabled without --experimental opti=
on");
> +               return -EOPNOTSUPP;
> +       }
> +
>         if (sap_init() < 0) {
>                 error("Sap driver initialization failed.");
> -               return -1;
> +               return -EOPNOTSUPP;
>         }
>
>         record =3D create_sap_record(SAP_SERVER_CHANNEL);
> --
> 2.20.1

We might as well introduce a experimental flag for the plugin so it
just don't load it if experimental flag is disabled.

--=20
Luiz Augusto von Dentz
