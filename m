Return-Path: <SRS0=rjyd=EB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FB5C4363A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 20:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F215121D7B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 20:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjnvDNVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbgJZUWr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Oct 2020 16:22:47 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44305 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731295AbgJZUWr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Oct 2020 16:22:47 -0400
Received: by mail-qk1-f193.google.com with SMTP id s14so9658809qkg.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2020 13:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cc1haQlhTLIyFK9W3NbEfDsoUiZi0HRdoUxR9yNCzIY=;
        b=fjnvDNVz4VWlBag1DgSradR6RkE7Yo7JXHhep6owgE0X04oL7oloJOnPu7Di4P1ANK
         Joi2K1+tYcHtMz8sjze5ZSCdaqiknHOYCg3ZfCnIpwALy5NjyhconLFn79Zf0K8PMT9H
         xUNJISmStE1HN2MbMtcXgG+MoJYgEzbCA9pe0kdU/dIA43pBNWLpbp0jUZmUOxmlOwjp
         3k4k7QMt8nhZcXaYR3W7JnW7hxJ9sgquy+jcpTRxV7ZfSkLGVNUpFHrX1BL2BLld2JII
         eDfgm1i2DIOk3LXWS2Kfsa/3Vpz9WRBgUojYwkT+VMCOsuEpkxn0t338Qdk1ISQye5c5
         yY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cc1haQlhTLIyFK9W3NbEfDsoUiZi0HRdoUxR9yNCzIY=;
        b=pXFBREVkhZoiqQvvKnvM0QOEoYJb9TY0oOXEb4xddYU2Tcj/6GhsJ66bl/nBtq5hCD
         v/OZY8AMm4B80DtOl0xKz25Acn0b5o06H/0LmOCyXI1aoJy3fEx4K9rMzQuOvC29LkPm
         pSvm7bGYG1M/G7T9B91BZW7ry2Qs6jCBQnTDPvB9f/SFn+0y0jxfR69zS4D5SCZkkZkh
         jlGO2MXH+9/5NZhj4lczncD2kuHlryIAbH+KvfGn+5I0y9VEzQddhKTkLmqu3IxFB7Cx
         aUllmixtI4pmxEdL5lAssvxLDO663aMXPHB/PRiVBTs8GNaIV33dR3ZwH+i9GtNG+Vlf
         znQA==
X-Gm-Message-State: AOAM532/rtBNjOAjo7TxnUgB95kkDiUIDywgIwEAnJSA5w7jZeAC7DP4
        qIHiuFJgPo1Hxfji2fa11cBb1V2H2LUUcxplFFPI7GZuMos=
X-Google-Smtp-Source: ABdhPJx4A1SX9jVefI5Zg9BNmy3PxxcgYfuMTT67nnxLRxSQEaDwqVYeD8FyQE9G9MR/bEtHZ47LkTun+Y2MWLwJelQ=
X-Received: by 2002:a05:620a:2202:: with SMTP id m2mr16721774qkh.58.1603743764751;
 Mon, 26 Oct 2020 13:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201025162730.47247-1-marijns95@gmail.com> <CABBYNZKxYFQ8iodcHZsKHq3JCuC10EOmBykU4ZsS8ECACQ5ktQ@mail.gmail.com>
In-Reply-To: <CABBYNZKxYFQ8iodcHZsKHq3JCuC10EOmBykU4ZsS8ECACQ5ktQ@mail.gmail.com>
From:   Marijn Suijten <marijns95@gmail.com>
Date:   Mon, 26 Oct 2020 21:22:33 +0100
Message-ID: <CANX-K3s41y=w8=Ho_+=ZZ=Brv=6-62Or7v+AL64ThDE_u582YQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio/a2dp: a2dp_channel should have a refcount on
 avdtp session
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Mon, 26 Oct 2020 at 21:15, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Marijn,
>
> On Sun, Oct 25, 2020 at 9:27 AM Marijn Suijten <marijns95@gmail.com> wrote:
> >
> > a2dp_channel keeps a reference to an avdtp session without incrementing
> > its refcount.  Not only does this appear wrong, it causes unexpected
> > disconnections when the remote SEP responds with rejections.
> >
> > During testing with an audio application disconnections are observed
> > when a codec config change through MediaEndpoint1.SetConfiguration
> > fails.  As soon as BlueZ receives this failure from the peer the
> > corresponding a2dp_setup object is cleaned up which holds the last
> > refcount to an avdtp session, in turn starting the disconnect process.
> > An eventual open sink/source and transport have already closed by that
> > time and released their refcounts.
> >
> > Adding refcounting semantics around a2dp_channel resolves the
> > disconnections and allows future calls on MediaEndpoint1 to safely
> > access the sesion stored within this channel.
> > ---
> >  profiles/audio/a2dp.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > index cc4866b5b..0eac0135f 100644
> > --- a/profiles/audio/a2dp.c
> > +++ b/profiles/audio/a2dp.c
> > @@ -1507,6 +1507,9 @@ static void channel_free(void *data)
> >
> >         avdtp_remove_state_cb(chan->state_id);
> >
> > +       if (chan->session)
> > +               avdtp_unref(chan->session);
> > +
> >         queue_destroy(chan->seps, remove_remote_sep);
> >         free(chan->last_used);
> >         g_free(chan);
> > @@ -2065,7 +2068,7 @@ static void avdtp_state_cb(struct btd_device *dev, struct avdtp *session,
> >                 break;
> >         case AVDTP_SESSION_STATE_CONNECTED:
> >                 if (!chan->session)
> > -                       chan->session = session;
> > +                       chan->session = avdtp_ref(session);
>
> Afaik this was done on purpose since we only need a weak reference as
> taking a reference would prevent the session to be disconnected when
> there is no setup in place, so I pretty sure this will cause
> regressions, instead we should probably add a reference when
> reconfiguring is in place and have a grace period for switching to
> another codec.

Allright, so it's either an in-progress setup or ongoing transport
keeping the session alive, nothing else?  I guess this is as simple as
setting a higher dc_timeout when calling set_disconnect_timer in
avdtp_unref?

>
> >                 load_remote_seps(chan);
> >                 break;
> >         }
> > @@ -2145,6 +2148,7 @@ found:
> >                 channel_remove(chan);
> >                 return NULL;
> >         }
> > +       avdtp_ref(chan->session);
> >
> >         return avdtp_ref(chan->session);
> >  }
> > @@ -2165,6 +2169,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
> >                         error("Unable to create AVDTP session");
> >                         goto fail;
> >                 }
> > +               avdtp_ref(chan->session);
> >         }
> >
> >         g_io_channel_unref(chan->io);
> > --
> > 2.29.1
> >
> > Marijn Suijten
>
>
>
> --
> Luiz Augusto von Dentz

Marijn Suijten
