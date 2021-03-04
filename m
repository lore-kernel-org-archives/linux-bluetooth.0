Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06F4C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 20:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C6B64F70
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 20:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238389AbhCDU2h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238973AbhCDU2e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 15:28:34 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D01C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Mar 2021 12:27:54 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id a12so8668105vsd.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Mar 2021 12:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IL6VjqYoi/nj8BeiIkzeJExj/2c4UyhnBcxNdGfxznc=;
        b=C9Mc2lNCMjdsB8P8gD8EOrR3Ol88IIZyJgYNRR6oU2Z4Rf8loBFzeWmpLuTDTfEXFk
         FEtLlX4bsMy4TeCeN4Y9WlwuIionCWVToU34lHTDeW0BA9D8xLVWfOdRxwDxjAx1f/Jy
         CrbZXvOdvRKvo/5rxHFufL9+PxpJCZWw8D4FAnb7aiUYsNiWPr3YF+sdwbkrjiw4lMVv
         gfl1WBHOnxy2rrMczxa8F4E9ty2z1C7zNfiZmspxRS3jkzZUdleE/7eHGXtKjtHvjwYF
         vhUByDn6EK/iOajPqa0Rvg9Pvpf731zLy1ek0534NwuuSu295fhqEsyRJiM/1Ca+y55O
         PgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IL6VjqYoi/nj8BeiIkzeJExj/2c4UyhnBcxNdGfxznc=;
        b=UM8Ccj8VURAOepdVPTMsU8uCut6etji8httPXZR6AJnhKpLT72uTwtcToxsq3qnkui
         DqCHvJNmCDPwNxQ5P1sg2NhpuNm+zkxKCiwNx9pJ6FjoSa8uSXKphyKSQ0ZWTXGd4gvE
         qPgM+Xd7B0YbWSy0TsO84xLCVCxJctOHUaLnIhhb0V/VVe+XoJYDfoWSRLMI3TKY+/Uw
         3b9XAG04r0XhAfFBKj0reS9luyErZKeL5GAm2Vm0NPFPZGLzqv2mVIF1qIUVjmSAJG5b
         A1MWHGu8MBlGnKLkLKL97gVaX1quuN7bZt9z9FVq81BNh8YTyUKfALR88+zVXNSVj5VZ
         PTBA==
X-Gm-Message-State: AOAM531r5tF+oChmPE6rYPrHunf9yvYziyZrDRBYNYsa4jmXHubLW2EJ
        RbEYaVkqIGBVKlNrQIAREKXGiyIHLAfP2+JopcB3JUl/55udig==
X-Google-Smtp-Source: ABdhPJxFDn27QuE+ShHQvjSJfzwsBQ85UpJykbICnpvybcGIeyGWgcEs45gesFiJuYU0m3c1IYWOXTwJRdT9IFm6yhU=
X-Received: by 2002:a67:8844:: with SMTP id k65mr4241832vsd.9.1614889673655;
 Thu, 04 Mar 2021 12:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20210303192012.1695032-1-danielwinkler@google.com>
 <20210303111817.Bluez.2.I45b896f4512038309cbeab7a01f51e503141edab@changeid> <CABBYNZ+NtxCwE5XWwKEGOXtyvgb4GUm0A4Pstwj2sOd9fVx8Gw@mail.gmail.com>
In-Reply-To: <CABBYNZ+NtxCwE5XWwKEGOXtyvgb4GUm0A4Pstwj2sOd9fVx8Gw@mail.gmail.com>
From:   Daniel Winkler <danielwinkler@google.com>
Date:   Thu, 4 Mar 2021 12:27:42 -0800
Message-ID: <CAP2xMbsX_+2F0-f51T7rnK+DrvdM9SF4a_QG16+4-8iiKO8SRA@mail.gmail.com>
Subject: Re: [Bluez PATCH 2/3] advertising: Create and use scannable adv param flag
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz,

Thank you for the catch and suggestion. I have just sent out a v2 to
address your recommendations.

Thanks!
Daniel


On Thu, Mar 4, 2021 at 10:59 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Daniel,
>
> On Wed, Mar 3, 2021 at 11:20 AM Daniel Winkler <danielwinkler@google.com> wrote:
> >
> > In order for the advertising parameters hci request to indicate that an
> > advertising set uses a scannable PDU, we pass a scannable flag along
> > with the initial parameters MGMT request.
> >
> > Without this patch, a broadcast advertisement with a scan response will
> > either be rejected by the controller, or will ignore the requested scan
> > response. The patch is tested by performing the above and confirming
> > that the scan response is retrievable from a peer as expected.
> >
> > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> >
> > ---
> >
> >  lib/mgmt.h        | 1 +
> >  src/advertising.c | 4 ++++
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/lib/mgmt.h b/lib/mgmt.h
> > index 76a03c9c2..7b1b9ab54 100644
> > --- a/lib/mgmt.h
> > +++ b/lib/mgmt.h
> > @@ -507,6 +507,7 @@ struct mgmt_rp_add_advertising {
> >  #define MGMT_ADV_PARAM_TIMEOUT         (1 << 13)
> >  #define MGMT_ADV_PARAM_INTERVALS       (1 << 14)
> >  #define MGMT_ADV_PARAM_TX_POWER                (1 << 15)
> > +#define MGMT_ADV_PARAM_SCAN_RSP                (1 << 16)
> >
> >  #define MGMT_OP_REMOVE_ADVERTISING     0x003F
> >  struct mgmt_cp_remove_advertising {
> > diff --git a/src/advertising.c b/src/advertising.c
> > index f3dc357a1..38cef565f 100644
> > --- a/src/advertising.c
> > +++ b/src/advertising.c
> > @@ -945,6 +945,10 @@ static int refresh_extended_adv(struct btd_adv_client *client,
> >                 return -EINVAL;
> >         }
> >
> > +       /* Indicate that this instance will be configured as scannable */
> > +       if (client->scan_rsp_len)
> > +               flags |= MGMT_ADV_PARAM_SCAN_RSP;
> > +
>
> Don't we need to check if the flag is actually supported by the kernel?
>
> >         cp.flags = htobl(flags);
>
> For new code it is prefered to use the function from src/shared/util.h
> (cpu_to_*).
>
> >         mgmt_ret = mgmt_send(client->manager->mgmt, MGMT_OP_ADD_EXT_ADV_PARAMS,
> > --
> > 2.30.1.766.gb4fecdf3b7-goog
> >
>
>
> --
> Luiz Augusto von Dentz
