Return-Path: <SRS0=u3xs=74=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54430C433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 09:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D90B2065F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 09:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="YMFmdOj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgFOJse (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgFOJsd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 05:48:33 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F6CC061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 02:48:33 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g2so1528671lfb.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 02:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:organization:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mVj0FOxmN6qSzZwF0D8yFWm1/gWv6RuE/e+w/ay5bOo=;
        b=YMFmdOj5Q1+LaIGBL2uBeUdUGJVdTWiigw7BA4m/4mwJh5FLMbG6G0ikX7Gf37ASx6
         MlpkNqoVV+IZo38iu3S+PwpPlXrDhYxd6wsloOT3CKt7MsqneQ0eaU/BYTRc8HQhA0Uh
         2k0lZlddZ+OV8bnNcr1GyAEbKcJEeI66l4baRhjcNcL4eMBGHL+hJIPLtVcHY6QbA7bC
         bLGcmzhdtuJaJYCOg/MLIYWop0dtla2RGgfnPZFvz3lsk9oxhw6zFGZLWyH2VoMmUfWJ
         WGUMiWElxawvNDa7kvGt0LVCNcNY42VYXR+kH5ST6cg4Qp6JdaNIt9sC74o4CD4kecO2
         UpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mVj0FOxmN6qSzZwF0D8yFWm1/gWv6RuE/e+w/ay5bOo=;
        b=ZHOLEntoK3J4A1n0PwizlBC09GoKKGvNTgUv1zO5UG+W+HXbRbGU4hqufH7iRdbR8u
         QRtvBhdWayFaO6rDr7GgIaIrw6oLqX3P1LQRzmFFOlovfwb2t/uiozsDEyLylu/vD7s+
         +wOw1zHMHPrvbm5apU1O3ePqey0DTdUOcLrtZRJ9XJO1OgTSaqq0odeU5weR8zUOyI53
         2WQQhTmqaW5wNe+Utuzz1CEtmcJ0CouOoLxQYgrXzSsVWWYGUaMeaIrOlTDpQgOq/nYc
         GZTEUVAL60imFz3TlxYJgU2Lso2vSLgrgN8CNq1OQMqshaapb7gL1G8vEN1cLZKuaC4j
         ecTQ==
X-Gm-Message-State: AOAM530B7fZTpUEHlbol5faKAxhFSsZzUeS2mNusUSWYgaJtqenp1Zsw
        lbH9e4rg9N9FN83pWfi94rj6ebzqDDw=
X-Google-Smtp-Source: ABdhPJyZw8Fjv2Xan6sJd239KZENRaqPPyAYY4zGr3Y14MywSri+4QQ4k5/R2GBEyHdFP/s1J2BEYg==
X-Received: by 2002:ac2:521a:: with SMTP id a26mr197884lfl.192.1592214511219;
        Mon, 15 Jun 2020 02:48:31 -0700 (PDT)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id l14sm3727139lja.2.2020.06.15.02.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 02:48:30 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH] sap: Improve error messages
Date:   Mon, 15 Jun 2020 11:48:20 +0200
Message-ID: <4237143.LvFx2qVVIh@ix>
Organization: CODECOUP
In-Reply-To: <20200604232433.4951-1-pali@kernel.org>
References: <20200604232433.4951-1-pali@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Friday, 5 June 2020 01:24:33 CEST Pali Roh=E1r wrote:
> When bluetoohd daemon is starting, it prints following error messages:
>=20
> bluetoothd[19117]: profiles/sap/server.c:sap_server_register() Sap driver
> initialization failed. bluetoothd[19117]: sap-server: Operation not
> permitted (1)
>=20
> Initialization is failing because sap server is enabled only when
> bluetoothd daemon is started with --experimental option.
>=20
> And "Operation not permitted" is result of returning error code -1.
>=20
> This patch improves error messages. When --experimental option is not used
> then bluetoothd prints more explaining error message. And in case function
> sap_init() fails then -EOPNOTSUPP "Operation not supported" is returned
> instead of -EPERM (-1).
> ---
>  profiles/sap/server.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/profiles/sap/server.c b/profiles/sap/server.c
> index 5de682a33..99ff80297 100644
> --- a/profiles/sap/server.c
> +++ b/profiles/sap/server.c
> @@ -1353,9 +1353,14 @@ int sap_server_register(struct btd_adapter *adapte=
r)
>  	GIOChannel *io;
>  	struct sap_server *server;
>=20
> +	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
> +		error("Sap driver is disabled without --experimental=20
option");
> +		return -EOPNOTSUPP;
> +	}
> +

Maybe just make sap_init() fail if experimental is not enabled in sap-dummy=
=2Ec?

This driver is usable only for profile qualification tests and nothing more.
And TBH I'm not sure why distros are enabling SAP in first place...

>  	if (sap_init() < 0) {
>  		error("Sap driver initialization failed.");
> -		return -1;
> +		return -EOPNOTSUPP;
>  	}
>=20
>  	record =3D create_sap_record(SAP_SERVER_CHANNEL);


=2D-=20
pozdrawiam
Szymon Janc


