Return-Path: <SRS0=PQ2f=6Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F89C47255
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 May 2020 13:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB00206B8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 May 2020 13:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="uVbClvNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgEKN30 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 May 2020 09:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726013AbgEKN30 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 May 2020 09:29:26 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05801C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2020 06:29:26 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 8so4797576lfp.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2020 06:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9cc8H5Zx2HvvjN5kr+c1/D9dKj92x5FUvPHEEDebnOQ=;
        b=uVbClvNFTFPq7Od7m8ue38PovU+JWSpbU+jWyoeqxthZw2mzVzctmemoeckir29suO
         48pp3LhfBOFf34BRYpUEudFRJLowLLgORKVChUYGTtVPhMp3hu8HY+rrxnV88RORbwj8
         QI17nMO95JaItnnTTHjTGaJnLkHDmcZD7+zNCl2rlD8+QNzfR1k9Z2L6R5KmivRHyfF9
         m0td9HafLSoJE18VY8dzGV/c4+istSmzvbEWwBJIIgscvC8FZQX8XOTg+KQDNJS0OHTd
         BKaZ1vJAe2whkcccTPJ7abLI2kV5hm7JfpgKTcP+8dhDQ0+HjDi/Pp4wsy+Chgf0+k3y
         kmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9cc8H5Zx2HvvjN5kr+c1/D9dKj92x5FUvPHEEDebnOQ=;
        b=VLYhD7PEMOax2oX/ieQEy2IUvBdqoRzM/KrZzb544LJBY8kdSPvhXVyIj/MwORkkYY
         x/X9oYx4+oeoglfZq84FDTu5rVyWUacaWMsTziH89ljahEJDyjzrwSsreKrO8WAYmx//
         DK8KMFXS2ASiTA8LZIIcBmWAuH4gYw7DZGcBpFtsVoVi3Ti1sH7CXQUW3Aa1/iUBflVF
         vT35xqHDuqclqo9c1C9w/i5QZv6J76cx8+EdG/Tt9x9feD+/ikODYTyd52+rhxm+2+Xi
         D7rcCm2iX6ozgMMZWNI/yUUc9eFujYfqpQAw6dubSlAoufdO/o0UyYC46iadH6UvGXuH
         wKsg==
X-Gm-Message-State: AOAM5331v4ULh091Mx46WPNIyK4E0nnBog0WITXc3dsmeEVjVQHZKL/e
        r8VWnbU69pmCqLyAWwPQHj0Dcb3lzJI=
X-Google-Smtp-Source: ABdhPJxIYpqOYrF/5lddoGN8Pt5q1Rwyr8dp9SYwUxOrYUxROFxje3FsoxcoPUZTbkt61QA9EWGwkQ==
X-Received: by 2002:ac2:59ce:: with SMTP id x14mr11042168lfn.183.1589203764164;
        Mon, 11 May 2020 06:29:24 -0700 (PDT)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id h6sm10322750ljj.29.2020.05.11.06.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:29:22 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org,
        =?utf-8?B?xYF1a2Fzeg==?= Rymanowski 
        <lukasz.rymanowski@codecoup.pl>
Cc:     =?utf-8?B?xYF1a2Fzeg==?= Rymanowski 
        <lukasz.rymanowski@codecoup.pl>
Subject: Re: [PATCH BlueZ] client: Fix possible stack corruption
Date:   Mon, 11 May 2020 15:29:21 +0200
Message-ID: <5352738.DvuYhMxLoT@ix>
Organization: CODECOUP
In-Reply-To: <20200507214537.4504-1-lukasz.rymanowski@codecoup.pl>
References: <20200507214537.4504-1-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi =C5=81ukasz,

On Thursday, 7 May 2020 23:45:37 CEST =C5=81ukasz Rymanowski wrote:
> DBUS_TYPE_BOOLEAN is 'int', which does not have to be the same size as
> 'bool'.
> On architecture where bool is smaller than in, getting prepare-authorize
> will corrupt the stack
> ---
>  client/gatt.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/client/gatt.c b/client/gatt.c
> index 416eda953..9d35b54fa 100644
> --- a/client/gatt.c
> +++ b/client/gatt.c
> @@ -1860,9 +1860,12 @@ static int parse_options(DBusMessageIter *iter,
> uint16_t *offset, uint16_t *mtu, } else if (strcasecmp(key,
> "prepare-authorize") =3D=3D 0) {
>  			if (var !=3D DBUS_TYPE_BOOLEAN)
>  				return -EINVAL;
> -			if (prep_authorize)
> -				dbus_message_iter_get_basic(&value,
> -							=09
prep_authorize);
> +			if (prep_authorize) {
> +				int tmp;
> +
> +				dbus_message_iter_get_basic(&value,=20
&tmp);
> +				*prep_authorize =3D !!tmp;
> +			}
>  		}
>=20
>  		dbus_message_iter_next(&dict);

Applied, thanks.

=2D-=20
pozdrawiam
Szymon Janc


