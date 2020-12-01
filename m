Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FA5C71155
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 19:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBDC321741
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 19:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UM5cmYq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbgLATP6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Dec 2020 14:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730229AbgLATP5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Dec 2020 14:15:57 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723E4C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Dec 2020 11:15:17 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id f23so6479790ejt.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Dec 2020 11:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hGfjoc4Gq86fDKoTQFIv7ZlHkDfMOnYcGO62SfdlfA4=;
        b=UM5cmYq9KdfJtYVwHreM5kluKF9vXgydsmcZJBk+IiPO419+VhAS4NBcMm48dY65/1
         4vSFvjHCYxX0JNkREau3J51LgLs3jisO1E3stibFSx25czj3nhCkVpmy8isfB2EZMdMK
         3BhqIFXHJn850Z24PlqCiMOe4+lwaFIKPCJjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGfjoc4Gq86fDKoTQFIv7ZlHkDfMOnYcGO62SfdlfA4=;
        b=LltK6l9zpnBVwR8cZ5rJ15gLS8Os7DLmWTSem2fFJxDiI+jq4VpGFyZ18GpOocjRMr
         tjmw3FMD9CbGwsU+jZMOBWffRf1fSdWJnG/4T5o1CC8c/z7r65DAVQkweVNruK1rSSCy
         fjfWudG1RiRPEIlkolN4xTRIZPx7JWNWZtFkQx+ui7yZtrdmdZyEy3sqbPb2FnmrMFeY
         sceJarX8CETiR346CcnampjBYGLXEjm4GuGv6wH+VNSadbP5azhEzZcctzAqga5lXl3h
         ap5IoBIKoaAn16B/E5fFw4W9aihIVwwVeQsYtjDcZishbdLLSQKb4ET5NnkJxWBErFvm
         Au0g==
X-Gm-Message-State: AOAM530yPKY6c4NFHStb2FgsCYC0vjPNkAwuUpZTiC6y10TsGYF8a0Fm
        jOl6yJQ+YccvqleTaTYOmodpujD43fgDzQ==
X-Google-Smtp-Source: ABdhPJzbqk5ybOVmdhVS/2ouv94PCQK+uyIat1WgsxOmZP7qCK0m6p3EivVGAobDX/Haux+0y1aljA==
X-Received: by 2002:a17:906:ccc5:: with SMTP id ot5mr4515817ejb.248.1606850115831;
        Tue, 01 Dec 2020 11:15:15 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id e21sm327491edv.96.2020.12.01.11.15.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 11:15:14 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id u12so4469918wrt.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Dec 2020 11:15:14 -0800 (PST)
X-Received: by 2002:adf:a451:: with SMTP id e17mr5699071wra.99.1606850114053;
 Tue, 01 Dec 2020 11:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20201130215602.386545-1-sonnysasaka@chromium.org>
 <5fc5738c.1c69fb81.8e7df.5ba8@mx.google.com> <CABBYNZKGAujDpR3V4hRhsgSKO_UpYk9C1ge1w5rLg-jGFVc4pw@mail.gmail.com>
 <f2fbc270588a75ccebb8e14590b37b7c6bddab60.camel@hadess.net>
In-Reply-To: <f2fbc270588a75ccebb8e14590b37b7c6bddab60.camel@hadess.net>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Tue, 1 Dec 2020 11:15:02 -0800
X-Gmail-Original-Message-ID: <CAO271mmD+MbWOScUXiFc2x0r0qOY+2yQF-39hbco4mK92qdpyw@mail.gmail.com>
Message-ID: <CAO271mmD+MbWOScUXiFc2x0r0qOY+2yQF-39hbco4mK92qdpyw@mail.gmail.com>
Subject: Re: [BlueZ,v5,1/7] battery: Add the internal Battery API
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

I will send a separate patch to update the doc.

On Tue, Dec 1, 2020 at 8:29 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Mon, 2020-11-30 at 16:27 -0800, Luiz Augusto von Dentz wrote:
> > Hi Sonny,
> > <snip>
> > Applied, thanks.
>
> Missed it :/
> Any chance you could update the org.bluez.BatteryProvider1 docs as per
> my review?
>
> Cheers
>
