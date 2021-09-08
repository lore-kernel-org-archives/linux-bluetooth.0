Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EA1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Sep 2021 17:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 712A661158
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Sep 2021 17:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhIHRTm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Sep 2021 13:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhIHRTm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Sep 2021 13:19:42 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08292C061575
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Sep 2021 10:18:34 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id o124so2700426vsc.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Sep 2021 10:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KBgIBYhNiuhRoAQwhL4+76fZcU+4oA2Ww+wpi6gpLPE=;
        b=DtM87flCRRGm4s5aHxj7CBDUPt7/rcN07S+A9o8B4/9O8H/RyASReCIXdIAy8q2a59
         8nK+tD8/gWcUa+COio97UYmyJofYCiKgQMZTLpA68KzwIrHAVdFRtGbOsQ+X68/Q2D8F
         W3tn44Ub550yYR24zSFNPrksWJYw7s5zkl7aAE0grrnFcwJmq/UgKNkRHxoh1R4mnw+r
         9Jy2clLegMigApGIp9r31gn4knMNzrzxr+sEw3+5NXvNXEyURyp+Zc1/awV3zbDOh2/x
         DEzCj9jdjHZrURYwpgOVSV3Ze7qCP2bFY/CHGPwkgXDSYJxY9zD9QQC3B7JwNqVldQDJ
         9qkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KBgIBYhNiuhRoAQwhL4+76fZcU+4oA2Ww+wpi6gpLPE=;
        b=nsrrhW+seSR/7NHR81haYuBBLjOWjvLvawy53EDGzKwzSwJ7RYWdv8DZjmoeTFNM5A
         OM6675BFaB87HmCOWuwilo/P/gyAI7v+xnxWIzc9sgzjmBxTiOKR5GMGlHMb+2Hq0raZ
         KBUN1NByN8H/VNk+j82XvM2OSnJ1sSVOJwtA7gWbzdQLrGvzqONQRpnrBzJtEZbq4Y8X
         HJSRbRoIo+DZbarXvmjYOLqA6rihK9j7kLcS8oiFu/767P3qaTnRG3FrIU3dwL3doBQk
         waU1kvhsEEJuK9EJZ1rNYsW04XyIQgVWHq2zcAuqR2yiN8zjwbIXFYOeHjdCbD3JJ8p5
         r56Q==
X-Gm-Message-State: AOAM5330HTpyAbuK/7cOEkRaUmKyL49UktIa9Y1ZkdMyTvoyFAtfQFHB
        LJlbU6vqF5jZXtR/AnHsp1V9vJjhHzIURPksAporvHda
X-Google-Smtp-Source: ABdhPJw8pc7nfIIgtbRghdjTmxEdRIII6HhIPYSffFlKtGB6EIjoo3552v1rKp+7FJdN0e2fUUYTBnMP8MAkfZq288c=
X-Received: by 2002:a05:6102:31a5:: with SMTP id d5mr3460211vsh.23.1631121513082;
 Wed, 08 Sep 2021 10:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210831163545.3646157-1-pab@pabigot.com> <3CBFA8E8-ABA1-495F-BFD4-A4E3CBC1E21B@holtmann.org>
 <c3b21654-8d46-4b12-7d9b-b3eeb12678f9@pabigot.com>
In-Reply-To: <c3b21654-8d46-4b12-7d9b-b3eeb12678f9@pabigot.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 8 Sep 2021 10:18:22 -0700
Message-ID: <CABBYNZJLU9nDMcpkZ4uZ+dspRRrHjBYH3jYf2LWKO-77G1m=aA@mail.gmail.com>
Subject: Re: [BlueZ PATCH] lib: fix variable-length array declarations in hci structures
To:     "Peter A. Bigot" <pab@pabigot.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Aug 31, 2021 at 2:54 PM Peter A. Bigot <pab@pabigot.com> wrote:
>
> On 8/31/21 2:23 PM, Marcel Holtmann wrote:
> > Hi Peter,
> >
> >> Use of zero as the size for arrays as the last element of a structure
> >> is a GNU C extension, which as of GCC 10 produces diagnostics when
> >> values in the extended array are referenced.  Switch to the C99
> >> standard idiom for flexible array members, already in use in a few
> >> other headers.
> >>
> >> Signed-off-by: Peter A. Bigot <pab@pabigot.com>
> >> ---
> >>
> >> No changes from previous submission except the BlueZ subject prefix
> >> that I hope will get this into bluez.
> >>
> >> lib/hci.h | 16 ++++++++--------
> >> 1 file changed, 8 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/lib/hci.h b/lib/hci.h
> >> index 3382b87bf..a61568bce 100644
> >> --- a/lib/hci.h
> >> +++ b/lib/hci.h
> >> @@ -729,7 +729,7 @@ typedef struct {
> >> typedef struct {
> >>      uint8_t         flt_type;
> >>      uint8_t         cond_type;
> >> -    uint8_t         condition[0];
> >> +    uint8_t         condition[];
> >> } __attribute__ ((packed)) set_event_flt_cp;
> >> #define SET_EVENT_FLT_CP_SIZE 2
> > does this break any API assumptions? Since as long as libbluetooth exists these headers are API.
>
> The size of the structure remains the same; there should be no API
> changes.  I've done this sort of change multiple times over the years
> and nobody's reported any problems.
>
> Peter

Looks like we also use [] in the kernel so I think it should be safe
to do this change on userspace as well.

-- 
Luiz Augusto von Dentz
