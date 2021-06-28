Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246ABC11F64
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 17:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F233661C65
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 17:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbhF1Rfj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jun 2021 13:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbhF1Rfi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jun 2021 13:35:38 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4094AC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 10:33:11 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i4so19799582ybe.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GM9jsAlrYg2SRXzVRGphJEsMstnF14zXR2P0IoS3Uks=;
        b=p3ym1tBTILjcSZnia9PTd6/WGxLoqoJl6mMZD/Lpr6/tavfzVfgPuG2xh8MStopgdr
         pOi2GGBx3sVZkXbXFw1WhS1uC0HXZBmyghLVCV6QLIm/VEd4orQYqeTMfAUK7PN1VTYK
         v0Zni7hqR+fQHywe9ev0jEQF+IGiwTWmFWxGEEfoPxGWJXUzveSaVAqDICGDD0VrPvq8
         ZavRAuwN9/Z7o3TFHHAyPMNwha7ngF/HCFUIA5JMqJyccU5l4mIFLDOvPn7UgHyyEHbo
         S/lUNHNKgNIdoy4w5KRa2SdwbXLJ4BsuvFC+hoi2PdDT7IdPhW9khzUPRdeP2VnacCG9
         Zsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GM9jsAlrYg2SRXzVRGphJEsMstnF14zXR2P0IoS3Uks=;
        b=tjaahFDODUJE30iUK5KBUnEnwZ4BxTeJNPCvHX//UJBjAf/bNKSTx56/HtVsQEaL/L
         txtjyzKJhxUQrkblzXCBHwznVvDanvqPRznbXatu7o7zEJIXbEJR4XV4aa/8HW648sxh
         9FDMHpiny4ATHXlN1mh4xb7OCxsTKbT4xvYTK9PDYvDv+i8MmMwYkPvmFoFE537wp9cM
         TnaxiUf77MGkJpqo1ftXMLcxrD0fL/Ke0nD4B4CDf8U2C2LxdbAESUGeSnHEix8juf0T
         EBeptmXHkJkRj8PGzXgFKqhqaMV7hpKzlf9gL5rzooggJKdMLA1uD9cYBkht/Ku1/WsB
         Dndg==
X-Gm-Message-State: AOAM530tclBbwhIp3IYK0R/rF1QhalgFPbcMMq/n31T5YKCBy5t46Nk2
        QjytJ2wyewHBVIAvvwqw98gnQFi/najnalkNFn6+Vv3bZV0=
X-Google-Smtp-Source: ABdhPJxHwc5Kh5d6T8znMpfflqEIa+fp4R+FTLREYE/vGY/w1v2/GUneqFTq8T7boo4CaeiHPNWxrRPoXIByYLjgXtI=
X-Received: by 2002:a25:be02:: with SMTP id h2mr33507037ybk.91.1624901590426;
 Mon, 28 Jun 2021 10:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210623184355.3685859-1-luiz.dentz@gmail.com> <363a48e3df83590ad4f53383830ca447c71939d7.camel@hadess.net>
In-Reply-To: <363a48e3df83590ad4f53383830ca447c71939d7.camel@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 28 Jun 2021 10:32:59 -0700
Message-ID: <CABBYNZKaWn_6FEX8YOmDX5bDo6pe5yERDs1X+=76yH4X3sH0hw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] doc/agent-api: Add AuthenticationFailed method
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Mon, Jun 28, 2021 at 7:59 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Wed, 2021-06-23 at 11:43 -0700, Luiz Augusto von Dentz wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This introduces AuthenticationFailed method which is used to indicate
> > when there was an authentication failure with a remote device which is
> > recommended by the core spec:
> >
> > BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 3, Part C page 1314:
> >  '5.2.2.3 Simple Pairing after authentication failure
> >  When the link key is stored, subsequent connections to the same device
> >  will use authentication but this may fail if the remote device has
> >  deleted the link key. Table 5.2 defines what shall be done depending
> >  on the type of the link key and whether bonding was performed or not.'
> >
> > So following Table 5.2 recommendation the AuthenticationFailed method
> > would be called when authentication fails with a bonded device.
> > ---
> >  doc/agent-api.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/doc/agent-api.txt b/doc/agent-api.txt
> > index 0d9347cab..91d752b0a 100644
> > --- a/doc/agent-api.txt
> > +++ b/doc/agent-api.txt
> > @@ -183,3 +183,8 @@ Methods             void Release()
> >
> >                         This method gets called to indicate that the
> > agent
> >                         request failed before a reply was returned.
> > +
> > +               void AuthenticationFailed(object device, byte status)
> > +
> > +                       This method indicates that there was an
> > authentication
> > +                       failure with a remote device.
>
> Is there a way that we could have some persistent storage for when the
> last authentication error happened?
>
> This would allow showing a /!\ icon in the device list even though we
> don't have an agent running in the session, just when the settings are
> open, in GNOME.

I guess you are suggesting introducing a property to the device object
e.g. AuthenticationStatus or something like that, that way one can
figure out if the device needs repairing or not. Alternatively we
could just remove the device, after a few attempts, if there is no
agent of the agent don't implement the new method.

> This would also allow the settings to get this information in the first
> place, otherwise we'd need to have some side-channel to funnel that
> information from the "desktop-wide" agent to the settings agent.
>
> I've made the upstream bug[1] public now, can you reference it in the
> commit message?

Sure.

> Cheers
>
> [1]: https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/issues/91
>


-- 
Luiz Augusto von Dentz
