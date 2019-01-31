Return-Path: <SRS0=4ALD=QH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85BAC282D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 12:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D096218AC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 12:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cx7LAO2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfAaMSN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:18:13 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46806 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfAaMSM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Jan 2019 07:18:12 -0500
Received: by mail-oi1-f194.google.com with SMTP id x202so2485498oif.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jan 2019 04:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Ldoec4TbMWNZR7MsZcJzpGMCUDqtlmEAUQY0sOuTLec=;
        b=Cx7LAO2I3fVthqmfonDs7dsbny8mg6ukXu4hE2jYWMISs2yd2BRwtXIzhiN1/OD4qk
         59aRbUHvL4aJwJiIoh/fLn4XYi9MhsLlIMv+ZhX4TsczPrttBFndntvoleOJsMC2KiVH
         eSpX4aTFjRkzdq58QlKavqZ376X+liEALSZmi9PATRfJ/RbWhqWPsEmCLgD8ZYQAwVOu
         NDFFxAzqYDd39Y/w3w5QORdkGG4tDfBuNGi3PKGd/GxXUjH0lSZdkvuS6PdBtmgxZPrQ
         G8WD5nMc7kpHPk1VEl0mffb+lw7s3EIIxVmxMAlQV3O80YF9hL7IfIESKDuTDVUJe7fE
         Rjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Ldoec4TbMWNZR7MsZcJzpGMCUDqtlmEAUQY0sOuTLec=;
        b=LrYZw4kipHRuuNobpBuwl065jDiIxS6eX3ESWWwwYoT37K0sQeRt/jn3o3+TQ38TPp
         p3KqfhUczzsbIhYiA5bBRVaKhv7Ol74S++S97JHa8TDOw9EFAnc7CXbvgZjsyqOaR97n
         cU51x1ZrgXpIJI8v/1iGsM0V1oSfUTRs8JzeGqMj6J9DW3UCk8iCnaiE32p53UPzIsWW
         5A0u+P1Fop2NfmScsVincqrsDeYPxnhYzXybwGQd2lQrE7mKhvljbkTQPrY5trC2tBu0
         OAMpUv8b7FX1CiJC/xfMuFnTuSlTfENsBEXgxDMzv8QT6XGBZ7nljKMBRpl1oSBqICu9
         NY1w==
X-Gm-Message-State: AJcUukdgflHqJd8dnBDkC8viR5bscyJtES2rQlCQb+/ecbim5bXJsG+8
        7C4Qps2zm/resY3gRe1r0n2yViFG3U+nWbc+SZ5k6Q==
X-Google-Smtp-Source: AHgI3IZk7zkS/IH+NLKQzwlRwtsuP273eTV2KYm4fFvTMiHOyT8brX0QxNhPsn5XhyjMSm1qmUaDRAYry+FMaGFh2d0=
X-Received: by 2002:aca:47c6:: with SMTP id u189mr15544827oia.250.1548937091142;
 Thu, 31 Jan 2019 04:18:11 -0800 (PST)
MIME-Version: 1.0
References: <20190130135424.2091-1-luiz.dentz@gmail.com>
In-Reply-To: <20190130135424.2091-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 31 Jan 2019 14:17:58 +0200
Message-ID: <CABBYNZ+ygRJJmc+4ckU32xQzxwKxRXy2PoVds6LbczuwK3mZjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] doc/gatt-api: Add Handle property
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
On Wed, Jan 30, 2019 at 3:54 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> When acting as server it is useful to select where to allocate the
> handle for an attribute so it can be restored in the same position when
> restarting the daemon or rebooting the system.
>
> In order to do that the application also needs to know in which handle
> the attribute is allocated the very first time it is registered, this
> also allows for a better integration with PTS and tools like auto-pts
> which needs to know the handles where the attributes have been
> allocated.
> ---
>  v2: Fixes inserting characteristics and descriptors with handle 0x0000,
>  add a patch to enable list-attribute to list with local attributes and
>  print changes to attribute Handle property.
>
>  doc/gatt-api.txt | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> index 8dda60b8a..491eb026a 100644
> --- a/doc/gatt-api.txt
> +++ b/doc/gatt-api.txt
> @@ -50,6 +50,14 @@ Properties   string UUID [read-only]
>                         Array of object paths representing the included
>                         services of this service.
>
> +               uint16 Handle [read-write, optional] (Server Only)
> +
> +                       Service handle. When available in the server it
> +                       would attempt to use to allocate into the database
> +                       which may fail, to auto allocate the value 0x0000
> +                       shall be used which will cause the allocated handle to
> +                       be set once registered.
> +
>
>  Characteristic hierarchy
>  ========================
> @@ -257,6 +265,14 @@ Properties string UUID [read-only]
>                                 "secure-write" (Server only)
>                                 "authorize"
>
> +               uint16 Handle [read-write, optional] (Server Only)
> +
> +                       Characteristic handle. When available in the server it
> +                       would attempt to use to allocate into the database
> +                       which may fail, to auto allocate the value 0x0000
> +                       shall be used which will cause the allocated handle to
> +                       be set once registered.
> +
>  Characteristic Descriptors hierarchy
>  ====================================
>
> @@ -332,6 +348,14 @@ Properties string UUID [read-only]
>                                 "secure-write" (Server Only)
>                                 "authorize"
>
> +               uint16 Handle [read-write, optional] (Server Only)
> +
> +                       Characteristic handle. When available in the server it
> +                       would attempt to use to allocate into the database
> +                       which may fail, to auto allocate the value 0x0000
> +                       shall be used which will cause the allocated handle to
> +                       be set once registered.
> +
>  GATT Profile hierarchy
>  =====================
>
> --
> 2.17.2

Applied.

-- 
Luiz Augusto von Dentz
