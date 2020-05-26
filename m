Return-Path: <SRS0=5fy2=7I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E52C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 May 2020 13:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9791207FB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 May 2020 13:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJG0Ttr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgEZNxf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 May 2020 09:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgEZNxe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 May 2020 09:53:34 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B4DC03E96D
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2020 06:53:34 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z13so14923462ljn.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2020 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V6/mS+t8KBNPrOLQOHLnB//9xrE4zPmgkwriRxnSerE=;
        b=EJG0Ttr1DQJngO5cTdn6kur6heaUn6MVBvBgDUsifrXqNjL09hV8D0jarQTIIItCTx
         sHaOj27fctgj3Hf4ETUvBWqCs72+qfS6iqRgNgOb7qS4kqyMu9PDaB7WoSjIL9giOGN5
         hcElkCEjK15XMzXSquiuqED6efsd4Uq6G2WxBACx+xCBHiWAafXBz7CRV2YM85NiqKp5
         yVurjdr6oPJSgsuyesliMmqUAeUOa+e3Exrh8+3n/cZ/JDNGhKNIzVspmxpJR8Qk04g8
         tLqal5I96l3Sf+mgbC2Zz+6hb1DMl46XyV3MUW2Wc3bO9UUw5bHS1e7ccJvZqNM84E/H
         7V7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V6/mS+t8KBNPrOLQOHLnB//9xrE4zPmgkwriRxnSerE=;
        b=YbZKAInXxdOrqPz4lRbJ0W8F7vsaZOJbsXzfBG92wEJVmUtsqUWGoPtLH5W6tzkGsy
         A/42OwT8Ot0vfbTRyHNS+9xVhpsqt+G26csuSPQunVdayilBC79Q+5pf6y6GQ3fCA97X
         iO9QpTP9QPFdrrYCFKpVDdexMMsB+1Lwl5J5NknpjZW6NhIazfofNuD9L6ZYmx/DgC61
         DjJWSSwxxV2AaAmlzPapei/9o1YUAbSk/yRtuAnBmL3x+InGKACzcUK47bxt4TSkvNH4
         lDLSQpme3rAxHkSXu1nl/aotFONo6tdzv4darYCZkMC3vrfrybkxUO4SCY7/oUzWE8o4
         h21g==
X-Gm-Message-State: AOAM532AeD3QPE0eTEIFUH1Y6Qwrnghy+09ekVoszAKWDRGRL/FLYta1
        Z4c4YX5HutC+RaSL5zgYjy+FgKtsHnMKhehsV++EZ05tgM4=
X-Google-Smtp-Source: ABdhPJwKRxcHgN5wX6Yi3na9ozoNLZbZPFaNKwhoUWVjVelf2jXprWaGH1VxAvTWc4KGdPVHwQ+ny4211fzA3aciXGo=
X-Received: by 2002:a2e:8006:: with SMTP id j6mr619347ljg.256.1590501212854;
 Tue, 26 May 2020 06:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200519202519.219335-1-luiz.dentz@gmail.com> <20200519202519.219335-2-luiz.dentz@gmail.com>
 <C478BA49-0BBF-4323-AC3A-30442F65D346@holtmann.org>
In-Reply-To: <C478BA49-0BBF-4323-AC3A-30442F65D346@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 26 May 2020 09:53:21 -0400
Message-ID: <CALWDO_UEPaAGyLFG93JzT41P=yGePB-N2Pbh5hioLBOXdh2YBw@mail.gmail.com>
Subject: Re: [PATCH 2/4] Bluetooth: Fix assuming EIR flags can result in SSP authentication
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel and Luiz,

Starting with the 2.1 specification, it is my interpretation that it
is not valid to support EIR but not SSP.  I understand that SSP may be
disabled from BlueZ's point of view, but this doesn't seem to be a
legitimate/qualifiable configuration.  Should we instead fail the
legacy pairing if EIR was received as an invalid condition?

Thanks,
Alain

On Wed, May 20, 2020 at 10:35 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > EIR flags should just hint if SSP may be supported but we shall verify
> > this with use of the actual features as the SSP bits may be disabled in
> > the lower layers which would result in legacy authentication to be
> > used.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > net/bluetooth/hci_conn.c | 2 --
> > 1 file changed, 2 deletions(-)
>
> patch has been applied to bluetooth-next tree.
>
> Regards
>
> Marcel
>
