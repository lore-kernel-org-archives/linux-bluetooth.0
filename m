Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D32CC28CBC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 17:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7705920B1F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 17:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JepQFdlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgEFRSZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 13:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgEFRSY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 13:18:24 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283B1C061A0F
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2020 10:18:24 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g19so1997388otk.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2020 10:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+oPpI8WtB3+Ne5pQ6mtyjv6Ahl5JMZGDvc5gLgmToyE=;
        b=JepQFdlJGX2tfWowwYM05zzcZd26WPPdyzudZSMsvZ5SKuwLXdpqnHrjSHhYPELfKp
         xnquWYGmgSJSdBN1WF1U8n764f5Rx428Zjoe2FsS+YAT32TYiWxym/adRtiuD3a9PSVC
         AFMgzoO+ch104vcB8BVuLIExZO9FOE5OJb+c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+oPpI8WtB3+Ne5pQ6mtyjv6Ahl5JMZGDvc5gLgmToyE=;
        b=gBOWzMLmN3TETri+YtKHa/yAKzb/fQk+M7bL5GKIb8LZPZDpjpsEZMRKPadjMtxVCQ
         lOwRPu1m7oZoTXmsX5RyE3r/D7+Xqgngi0US2tnwPniCYWdfIKbclPyr5HAD50/4KVCd
         ESRtBcE4tCE2JyugEzVCG0Z1tVVs1BLUQIUPyiDUM9xduzPlFPk0a9kkMPTze4PQIUPa
         kwYNX/sGmMH/Jv2v/w1XrIKkowZqhL5SYFbWu4fKmWKq1zZ/OeG/evgDNnsK++4NW9s4
         tO7YnxDf/6w6PfqWt5dG4M5CUeMXfI6QM7AtO4zOx9oKREOeMO6NWcRDxjaZGjlAPlXP
         vbUg==
X-Gm-Message-State: AGi0PuYr6Pb6wPHq4Fl9l/0bRQECjIv0pieivavJKWLir68EQTo3aQiT
        +6A17cxQUNmPCvT1mEuBJykScpP3g8X0pOWAK2ObuQ==
X-Google-Smtp-Source: APiQypImST4PmHADK1DPl2vuZrR03ZXoEvWcmT8nXAwK20QsbQU8E9R8rP8zF9nj6GwYHz8vPVgIALgkMhnv97OOjhY=
X-Received: by 2002:a05:6830:1d9c:: with SMTP id y28mr7896292oti.280.1588785503519;
 Wed, 06 May 2020 10:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200501215352.23858-1-sonnysasaka@chromium.org>
 <4A9E7F0B-4AB8-4330-BB2B-1A0EAA4EFDE8@holtmann.org> <a4650a5e465c23915d951b296ca86de9f2d91b44.camel@hadess.net>
 <CABBYNZK2SwcOO0jdpvtcdyjHFzw=WNocRU-a37hRsK3=yJ+d3Q@mail.gmail.com> <CABBYNZJu7Jg2fjZaJpR8S7iN6JSy4FYKjKZ2FN5mtKvLwSJywQ@mail.gmail.com>
In-Reply-To: <CABBYNZJu7Jg2fjZaJpR8S7iN6JSy4FYKjKZ2FN5mtKvLwSJywQ@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Wed, 6 May 2020 10:18:11 -0700
Message-ID: <CAOxioN=LO3EsK0CPe8W+s-o-Xzs0xH6EfbTFLutUOsbJ5-uEkQ@mail.gmail.com>
Subject: Re: [PATCH] build: Add option to disable battery profile
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel/Luiz,

Thanks for the feedback. We in Chrome OS are going to re-evaluate the
need for this, so we can hold off the decision for now. Generally,
these are some aspects we want to consider:
* For Chrome OS, we already have a working code for battery indicator
via BlueZ's general GATT API, but it's much simpler to just use
BlueZ's internal battery service API for our battery indicator
feature. If we can migrate to this, we don't need this build option.
* For other platforms, I think it's good to have more control over
what profiles are handled internally by BlueZ, since they may want to
use the profile directly and they can't do that if BlueZ monopolizes
the profile. There may also be some needs to do this on Chrome OS
actually, since Web Bluetooth has some sample use cases to read
Battery Level (https://googlechrome.github.io/samples/web-bluetooth/battery=
-level.html).

We will discuss those and other factors first and let you know whether
we need this patch. Thanks again for the responses!

On Wed, May 6, 2020 at 9:44 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Wed, May 6, 2020 at 9:35 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Marcel, Bastien,
> >
> > On Wed, May 6, 2020 at 7:14 AM Bastien Nocera <hadess@hadess.net> wrote=
:
> > >
> > > On Wed, 2020-05-06 at 13:24 +0200, Marcel Holtmann wrote:
> > > > I have a little bit concern splitting this since battery service an=
d
> > > > HoG are kinda connected. Wouldn=E2=80=99t it be better we have a cl=
eaner
> > > > interface. Maybe we should actually integrate cleanly with
> > > > /dev/upower or similar.
> > >
> > > Wat?
> >
> > I guess Marcel was refering to something like uhid though Im not sure
> > that exists, or does it? That said one alternative would make uhid
> > integrate the battery status, but I guess devices can also expose this
> > over hid directly so I wonder if we can translate the Battery Service
> > status to hid power strength that way we don't need any communication
> > over D-Bus.
>
> Btw, Im fine with the option to disable building the battery plugin
> since platforms may not have a use for it, so except if there are some
> strong reason against it I will apply the patch.
>
> --
> Luiz Augusto von Dentz
