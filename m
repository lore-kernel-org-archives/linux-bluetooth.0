Return-Path: <SRS0=HAk7=CK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07EBC433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 20:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 971AD2078B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 20:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJR2/3FX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgIAUsC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgIAUsB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Sep 2020 16:48:01 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8448C061244
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2020 13:47:59 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id r4so633115ooq.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2020 13:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+piYJczQ7XXBRW1tt3fXRcVGf81aOoZfrtVeQ3iSW4=;
        b=jJR2/3FXA0lpHWs0rJZRVkzpjykTtoiN50UofWgBGJKqQi0p5IhtxBudw/ce2EpjPn
         E71XvNfeinwBaBtZOW9H41kS7Ry7X8aCb5XUdFKveu+lBjFNvF+98Lml4tbxlCyKFvQ0
         bq7sAKMeIGxo8YgcOaDQmtICiOXIcXMrfyTYjHG2KB7jJcer5xYiCQmhUWoLMLg3wNjM
         QlQNen9/lJF6XMQYW9GM4pXVW8iCX5jaGGh/Zdahi8l++sIVImzcqYb+UdLf/grG1cmS
         rMr62axVfHJwR1HwU4zVVx0iYliEiWRKmtUlp9ek6kzRIZpCJ3Q/S+emMrUJVsvZ/Sep
         745Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+piYJczQ7XXBRW1tt3fXRcVGf81aOoZfrtVeQ3iSW4=;
        b=Tg6+d8w86b9OuxOi4pbRI+Tm1VNODZGEhj71LbUea9YwN6wNQ0B1mUgHtsYMde9cFy
         Kv8LF0Y77SL7UKgEec3T+QWTdTAzLYfyf8DjSJly5EJyiM1l4g3bhCOF7wSUoh9rZCbS
         M0xXViIjalJBkL1vWL3k8mMUNoX0SN5jlaMIkkPyUvvykvFB6dLaovsAqcd7jsd0CSOO
         TH0/HQM25qQkVLkiaMtQskMinzxyzi2Qm4u8LeOcfP/UAVjLORx5peHVakD8LIaUeojl
         3Hjq2xUMW+sR4HuhgPQPuHwBAiKnHA2PJUM5f2jDTvfASaiyYP09lU/Zv2V+g8YnGSxc
         ZR9Q==
X-Gm-Message-State: AOAM53195nWBp2CxztdI+74KIwkZKdKn5ngzeVCmJQk11jS284doECaO
        OR13tii7oMlzktxM3aSYXJd0RPvSKdyVPCBIxok=
X-Google-Smtp-Source: ABdhPJwbq+8vzYpaSoaGn81DZ6ko8klL2BYbl61UioCKYVAy/SUiZ2MDjGuQob0WKrILIss2AzW3+HDRZXvi9MieucY=
X-Received: by 2002:a4a:924b:: with SMTP id g11mr2819186ooh.9.1598993278960;
 Tue, 01 Sep 2020 13:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200817212554.3844965-1-yudiliu@google.com> <20200817142545.RFC.v2.1.Ibaa1dfd49179a141c19a651f3c2132a28b71b344@changeid>
 <CABBYNZLRqhB6d5Hm7_RqvUqCJo11D4+pgYLCeWj0j=8dZk0Bcg@mail.gmail.com>
 <CAHC-ybxshy5zmkAku6suicvjO0Ngofp0+gRyYLX_RXr9YhU94Q@mail.gmail.com>
 <CAHC-ybxFY_3HWrvnwF5DS-i-YJtYpUuR9K3-MSWJWo=C-CKQHA@mail.gmail.com>
 <CALWDO_Wsyx3s3SwBejAFdc6SFX=V29DnvPKmo48hd-yy9SqHSg@mail.gmail.com>
 <CABBYNZJxjYUvui7e-S4TGx21W2U9QvmXhyKNOaWg3RLR4jWg2A@mail.gmail.com> <CALWDO_XV+Hn-U+SgAe_tCcpST0NAo+UjRCBbdS8dzBQZuUCXEg@mail.gmail.com>
In-Reply-To: <CALWDO_XV+Hn-U+SgAe_tCcpST0NAo+UjRCBbdS8dzBQZuUCXEg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 1 Sep 2020 13:47:48 -0700
Message-ID: <CABBYNZJfCMxAKkNvnEUs3vH+XWQLYtyM6-Q9nrB1HPE+tDxKCw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] adapter - D-Bus API for querying the adapter's capabilities
To:     Alain Michaud <alainmichaud@google.com>
Cc:     Yu Liu <yudiliu@google.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Tue, Sep 1, 2020 at 12:00 PM Alain Michaud <alainmichaud@google.com> wrote:
>
> Hi Luiz,
>
>
> On Tue, Sep 1, 2020 at 1:47 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Alain,
> >
> > On Tue, Sep 1, 2020 at 8:43 AM Alain Michaud <alainmichaud@google.com> wrote:
> > >
> > > Hi Marcel/Luiz,
> > >
> > > I'd be particularly interested in seeing your opinion on whether this could be better described as some form of SCO socket property... even if this is indeed an adapter property.
> >
> > Yep, but wasn't that supposed to be what BT_PKT_STATUS is for? I mean
> > one can just attempt to read it with getsockopt and in case of returns
> > an error it means the controller does not support it, that said it
> > doesn't look like we do check the adapter features when using
> > BT_PKT_STATUS, should that be checking if HCI_WIDEBAND_SPEECH_ENABLED
> > is set?
> The problem here is that this will be after the connection is created
> and a packet is exchanged.  In this context, we'd like to know if the
> controller supports it ahead of creating a sco connection so we can
> choose to use the headset at all.  For example, there are devices and
> circumstances where using the device's built-in mic and A2DP will
> yield a better experience for the user so the platform may choose that
> as a default for the user rather than degrading down to narrow-band.

You can use get/setsockopt after bind, so I wonder if that is really a
problem here, in fact BT_VOICE wouldn't work if we couldn't use socket
options before the connection is made see how it is used in ofono for
instance:

https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/src/handsfree-audio.c#n105

Also in order to use WBS one will need to use BT_VOICE anyway,
actually that all you need for WBS with mSBC while BT_PKT_STATUS will
indicate the possibility to do PLC, not sure why we are mixing these
things together or does HFP mandates mSBC to implement PLC nowadays?

> >
> > Also it doesn't seem we have updated userspace to support
> > BT_PKT_STATUS, we should probably have something to test it via
> > isotest and perhaps create a iso-tester.c to validate all the options.
> >
> > > Thanks,
> > > Alain
> > >
> > > On Mon, Aug 31, 2020 at 5:44 PM Yu Liu <yudiliu@google.com> wrote:
> > >>
> > >> +Alain Michaud
> > >>
> > >> Hi Marcel,
> > >>
> > >> Can you please comment on the cl as well as Luiz's suggestion? Thanks.
> > >>
> > >> On Thu, Aug 20, 2020 at 10:20 AM Yu Liu <yudiliu@google.com> wrote:
> > >> >
> > >> > Friendly ping for comments from Marcel. Thanks.
> > >> >
> > >> >
> > >> > On Mon, Aug 17, 2020 at 4:17 PM Luiz Augusto von Dentz
> > >> > <luiz.dentz@gmail.com> wrote:
> > >> > >
> > >> > > Hi Marcel,
> > >> > >
> > >> > > On Mon, Aug 17, 2020 at 4:07 PM Yu Liu <yudiliu@google.com> wrote:
> > >> > > >
> > >> > > > From: Archie Pusaka <apusaka@chromium.org>
> > >> > > >
> > >> > > > Initially this is introduced to query whether WBS is supported by the adapter,
> > >> > > > the API is generic enough to be extended to support querying others in
> > >> > > > the future.
> > >> > > >
> > >> > > > Reviewed-by: sonnysasaka@chromium.org
> > >> > > >
> > >> > > > Signed-off-by: Yu Liu <yudiliu@google.com>
> > >> > > > ---
> > >> > > >
> > >> > > > Changes in v2:
> > >> > > > - Return an array of strings instead of a dict
> > >> > > >
> > >> > > > Changes in v1:
> > >> > > > - Initial change
> > >> > > >
> > >> > > >  doc/adapter-api.txt | 12 ++++++++++++
> > >> > > >  1 file changed, 12 insertions(+)
> > >> > > >
> > >> > > > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> > >> > > > index 1a7255750..8fbcadb54 100644
> > >> > > > --- a/doc/adapter-api.txt
> > >> > > > +++ b/doc/adapter-api.txt
> > >> > > > @@ -204,6 +204,18 @@ Methods            void StartDiscovery()
> > >> > > >                                          org.bluez.Error.NotReady
> > >> > > >                                          org.bluez.Error.Failed
> > >> > > >
> > >> > > > +               array{string} GetCapabilities()
> > >> > > > +
> > >> > > > +                       This method returns a list of supported
> > >> > > > +                       capabilities that is populated when the adapter
> > >> > > > +                       initiated.
> > >> > > > +
> > >> > > > +                       Possible values:
> > >> > > > +                               "wbs" - Wide band speech
> > >> > >
> > >> > > Btw, should we stick to use wbs terminology here, or we should
> > >> > > actually use the HCI feature/command, because wbs has actually to be
> > >> > > implemented by the HFP afaik this is only indicating that the
> > >> > > controller is able to notify packets drops, etc, with use of erroneous
> > >> > > command. Perhaps we should actually use the term PLC (Packet Loss
> > >> > > Concealment) instead since that seems to be the real capability here,
> > >> > > afaik WBS does not actually require PLC.
> > >> > >
> > >> > > > +
> > >> > > > +                       Possible errors: org.bluez.Error.NotReady
> > >> > > > +                                        org.bluez.Error.Failed
> > >> > > > +
> > >> > > >  Properties     string Address [readonly]
> > >> > > >
> > >> > > >                         The Bluetooth device address.
> > >> > > > --
> > >> > > > 2.28.0.220.ged08abb693-goog
> > >> > > >
> > >> > >
> > >> > >
> > >> > > --
> > >> > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
