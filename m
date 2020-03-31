Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA80C43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 17:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0193020BED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 17:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JWPpiWZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgCaRWt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:22:49 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46646 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgCaRWt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 13:22:49 -0400
Received: by mail-oi1-f193.google.com with SMTP id q204so19556100oia.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2020 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AkFweVO6+fKbQ/CR3A2jIG2D72GQfDQ97HnpjS5ITLc=;
        b=JWPpiWZXez24hu+a7A0dvLaFWBpSmMn/dAmRXBYfHG1q6PFKE78Vhc1SL4XM+TMXYi
         R99+xb9BfjWzDLo53Pe47Oj7T9XU4jsKWFc6qUwnrQe0hL20MaLakyD9xZyf6AMH6j8T
         KdMaUOkoOh3EHai6FNFPmCLPyyM/G6jfEzE+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AkFweVO6+fKbQ/CR3A2jIG2D72GQfDQ97HnpjS5ITLc=;
        b=muc2tTM2mX7quqScSMxtT+GOyrNExRHXA2uAulRF4B1mIrvLWzdSdCzHUC5i2kN/x3
         x9fbYJfJ9C+XY1II1DsjUJ3R/l4AQszi9+y4nRKwkNubBP+O9ZLb41Qhtb+s3jHDB4IE
         CmB2QWFxrrw+ewuWuB3lgNTCjfoSx9xPjz+j4CUsD5OzM5JqPm5ZUr4/XaPLw6SH+EN9
         paeHtG8HEFYXDf+sIKBIiHGRTMeEC2eLn7Z/OIVOu6uC6jSlHiUMcwDQdalRjvWy35Qa
         wLgcnQSd3mtJM6WMtAB3eWXW+QqR+xDTq1ebH0ppR3yvsbxT8P34u9xvzBx0EP2Co2iH
         LG9w==
X-Gm-Message-State: ANhLgQ2ROhlbbSts/R7WeKvRCBxOW/WIZorumS6fTtFPmoh81nwsKhQw
        xgjYD/gtmgnurPBUw2ODPEtyMVP9q3jgkG6p01esvA==
X-Google-Smtp-Source: ADFU+vutqA5kJa7KaR+nI4ZPf4qYUDEu0bA7fcVs0qomNCgjyjDkiBDqdtFUh2Ji/TUed3wzHriYkR+pwEbQDXhBI3k=
X-Received: by 2002:aca:dd55:: with SMTP id u82mr2864806oig.27.1585675368666;
 Tue, 31 Mar 2020 10:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200328003318.13937-1-sonnysasaka@chromium.org> <CABBYNZK=DSrS7MwrUm9LSPGwUmMzX7KJkf0r80hfduwoDC5KEA@mail.gmail.com>
In-Reply-To: <CABBYNZK=DSrS7MwrUm9LSPGwUmMzX7KJkf0r80hfduwoDC5KEA@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Tue, 31 Mar 2020 10:22:36 -0700
Message-ID: <CAOxioNnOj-MQQGZeesgJ3ozChO-4FZDXKdT9g9nkXO5kxwL7qQ@mail.gmail.com>
Subject: Re: [PATCH] core/device: Handle Just-Works auto-accept
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks, Luiz.

On Mon, Mar 30, 2020 at 11:30 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Fri, Mar 27, 2020 at 5:36 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > The kernel starts to always request confirmation to BlueZ daemon for
> > Just-Works pairing. In this patch the daemon does auto-accept if the
> > client has clearly indicated a pairing intent by calling the Pair()
> > D-Bus API.
> > ---
> >  src/device.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/src/device.c b/src/device.c
> > index 69f98e488..db14cc129 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -6168,12 +6168,22 @@ int device_confirm_passkey(struct btd_device *device, uint8_t type,
> >
> >         auth->passkey = passkey;
> >
> > -       if (confirm_hint)
> > +       if (confirm_hint) {
> > +               if (device->bonding != NULL) {
> > +                       /* We know the client has indicated the intent to pair
> > +                        * with the peer device, so we can auto-accept. */
> > +                       btd_adapter_confirm_reply(device->adapter,
> > +                                                 &device->bdaddr,
> > +                                                 type, TRUE);
> > +                       return 0;
> > +               }
> > +
> >                 err = agent_request_authorization(auth->agent, device,
> >                                                 confirm_cb, auth, NULL);
> > -       else
> > +       } else {
> >                 err = agent_request_confirmation(auth->agent, device, passkey,
> >                                                 confirm_cb, auth, NULL);
> > +       }
> >
> >         if (err < 0) {
> >                 if (err == -EINPROGRESS) {
> > --
> > 2.17.1
> >
> Applied.
>
> --
> Luiz Augusto von Dentz
