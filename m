Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF4DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 12:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiBPMf6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Feb 2022 07:35:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbiBPMft (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Feb 2022 07:35:49 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364351F8372
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 04:35:36 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so2263870ooi.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 04:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RfikGyRMnBokxsxD3WQuxACiXBTSyqC9oHv7Nd+/ooM=;
        b=DYD2p32An6WHz2D/3B36Q4/WUiqW/vmpmrKhJoa0+HIJyBw1qyaHixqTyDTRur8Zrz
         qtsiITPtQV9STIOWRv02EMIULxej+mw7NisT6Z/9KFpqc496g3yxNp8ocbBoTfTVvcJ6
         PJPnMEupQWqqzNVvae2FPCmwQYtnM0XA0dYo3xk8OjvZh8138VC1b/hOEk8jB0fw5gfG
         e0DiOXuavWs49gc71t4n3htsmzVNgaqgzAdMLA8Te3hp4fWnyx6ykQ8pt0w8Ke87AFYc
         dN4MJE5Cotss9s7bYxigjBRoq6LC/SsDsMitfN3JipLPwWnG+NavKovYpk7vEnUvfJrj
         6t6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RfikGyRMnBokxsxD3WQuxACiXBTSyqC9oHv7Nd+/ooM=;
        b=qGazrccKFAc9+PlWVowUx5AmgDR5+mfW0Rf+E9FyHmVqI3h4kbw3pdxRGpGXv4Hmeb
         0Hb7uWjjwMleUrfbnis3VO87XlrAPPTZLM3Csh7qefkVRAG8CAtpfnP4c3SJmfaFlNwW
         UpSALRpLRp/Z8O84I8SqASEkbgv/40m30VjyqwmeZ5OQ6WHu5FBc44b5QRryv6NR/Ev6
         Dh8yz7EKHSoPmguLZxNf5atLfGb8dQppTyJ+OTZ4Qhm2O+V0VpOzLItgCeCudsAo6dKR
         Iuj0CsdZWI5lIE33Sz3IGU7bdCyLxMkMxG3FgAXXvIG9hW4sZzM56fLiX7Cy/mvsOJcf
         zxEw==
X-Gm-Message-State: AOAM531K1tRSzfYVTjyl8FK80Eo0RvMMmXAMRmlzUZ/EI81uSj90syNO
        R+G8LLb7MYB0Q3Zo8PnPZZcTreGshcZzwUWs+BY=
X-Google-Smtp-Source: ABdhPJyrf414IRwov80DMfyg0pTxSOqPFwPtiwhPk7TNXehVO58j0Mamu1xyyA3/sSIDmRRahjRA4uOFpTpP5zaexK8=
X-Received: by 2002:a05:6870:4410:b0:d3:1505:36c8 with SMTP id
 u16-20020a056870441000b000d3150536c8mr383208oah.300.1645014931708; Wed, 16
 Feb 2022 04:35:31 -0800 (PST)
MIME-Version: 1.0
References: <20220215225015.3568246-1-fontaine.fabrice@gmail.com> <50-620ce680-7-4d762500@265872973>
In-Reply-To: <50-620ce680-7-4d762500@265872973>
From:   Fabrice Fontaine <fontaine.fabrice@gmail.com>
Date:   Wed, 16 Feb 2022 13:35:39 +0100
Message-ID: <CAPi7W83KzqekFAUAbfC_LFZTq+CeLJSLMhtjgBG2zp3zcYoXkw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] tools/mesh-cfgtest: include limits.h
To:     Michael Nosthoff <bluez@heine.tech>
Cc:     linux-bluetooth@vger.kernel.org,
        Michael Nosthoff <buildroot@heine.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Michael,

Le mer. 16 f=C3=A9vr. 2022 =C3=A0 12:57, Michael Nosthoff <bluez@heine.tech=
> a =C3=A9crit :
>
> Hi Fabrice,
>
> On Tuesday, February 15, 2022 23:50 CET, Fabrice Fontaine <fontaine.fabri=
ce@gmail.com> wrote:
>
> > ---
> > I'm sending back this patch as for an unknown reason, the patch sent by
> > Michael in July 2021 is set as superseded in patchwork:
> > https://patchwork.kernel.org/project/bluetooth/patch/20210722204923.297=
35-1-bluez@heine.tech
> >
> I had sent a v2 with an improved description. The buildbot didn't like th=
e Commit Msg because of the too long
> urls to the buildroot autobuilders. Maybe that's why it was marked as "ar=
chived" on patchwork?
>
> https://patchwork.kernel.org/project/bluetooth/patch/20210723081039.30396=
-1-bluez@heine.tech/

Thanks for pointing out v2, I missed it.
Would be great to merge one of the version of this patch so we can
drop it from buildroot.

>
> Regards,
> Michael
>
Best Regards,

Fabrice
