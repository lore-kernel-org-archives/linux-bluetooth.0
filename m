Return-Path: <SRS0=rjyd=EB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2869C4363A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 21:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D0D21655
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 21:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/b7FC9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389518AbgJZVhO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Oct 2020 17:37:14 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45356 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389424AbgJZVhO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Oct 2020 17:37:14 -0400
Received: by mail-qk1-f193.google.com with SMTP id 188so9867871qkk.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2020 14:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=krMi7GzhK2+exaqgboNbBVvzoktKWV0jo7W9b8tZRmI=;
        b=P/b7FC9edg/gIXGWO5DJUbhyvsE+MLFa/Yb1c0sq8Fjx1ZmWZyqITSCe3BuD/RAoQc
         rkEPy2iBX9XYvlDsLk3fe2NdUAsYYiDZJwNuh3DBClvJnHZRj5umms/7OP77dWVTGIer
         DX3mMngwc0xorYldva7+b9KwN+lEWnvb33L29HesNRgn3m3nNUWA6yJAu8BJUbfBu9pM
         5kJY0GXgFxjiSAiT5VdsE/6gfdwxUzazYO0X2cWTN/OlQWB+fZPW44ZdUvVs7BA6R3T0
         kO63aojZrZ/v0ZtYW8O1t42+uhPwSl3d8qjkRLMneUZLE2cvccMWI/jlzdzRSjJd9Ouy
         I4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=krMi7GzhK2+exaqgboNbBVvzoktKWV0jo7W9b8tZRmI=;
        b=SXNEHADY6Rwlsx00U2u+gb5GRPb3/lXIfp64i43eN/Y9cwZWOy1X7PPcsmrIZ8VmKN
         HyuH2+PLLsnLRRG9fIys5YsrpN4z/PnM4Iu+Hk+kZ3fk3qr79XM/POfN8v3Yaump0YdM
         hq6lVmLHNXDy+5Okjvs7GEPz7SOf75bw/KwAWystpX+odri50HUckuzjQAZ1mZeMf5uh
         rGXio8MmF2p3UJOhBPdEVWZ9hDOdOZrYbOUkswYk2TpfTAEFASDpPXtdhNBmeuDqupAb
         F6lFRThE+0MxslRc2yhc31ki9MVASpPqc2gepyag6h6U/QApL2D49gGRn3PLNyUehNSq
         0m3A==
X-Gm-Message-State: AOAM531OMPKgoyaJtTRWJSEGO+mE7e3l53c+0dAMdWpeKchPsZylEABz
        M9thPOI80SIyjerrP2RT7pUuBibyt35iiqPue4o=
X-Google-Smtp-Source: ABdhPJwn5dUHxvJk5PP951MsOIe7HpV7VGm0P1n5RL7wVvDNop8HbyWAUg6THyOUcKMrQjpmT//MkjnxOsobvG287Lk=
X-Received: by 2002:a37:d81:: with SMTP id 123mr16465372qkn.79.1603748232874;
 Mon, 26 Oct 2020 14:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201025162730.47247-1-marijns95@gmail.com> <CABBYNZKxYFQ8iodcHZsKHq3JCuC10EOmBykU4ZsS8ECACQ5ktQ@mail.gmail.com>
 <CANX-K3s41y=w8=Ho_+=ZZ=Brv=6-62Or7v+AL64ThDE_u582YQ@mail.gmail.com> <CABBYNZJ3=e5kFxn-o0_L8j5aKpLDk88CGx=gcKP0eaPjQchO=g@mail.gmail.com>
In-Reply-To: <CABBYNZJ3=e5kFxn-o0_L8j5aKpLDk88CGx=gcKP0eaPjQchO=g@mail.gmail.com>
From:   Marijn Suijten <marijns95@gmail.com>
Date:   Mon, 26 Oct 2020 22:37:00 +0100
Message-ID: <CANX-K3vn71GLYccbaeqEX4dUgXzUZ8tO9rJaUunpZMssx7b30Q@mail.gmail.com>
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

On Mon, 26 Oct 2020 at 21:39, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Marijn,
>
> On Mon, Oct 26, 2020 at 1:22 PM Marijn Suijten <marijns95@gmail.com> wrote:
> >
> > Hi Luiz,
> >
> > On Mon, 26 Oct 2020 at 21:15, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Marijn,
> > >
> > > On Sun, Oct 25, 2020 at 9:27 AM Marijn Suijten <marijns95@gmail.com> wrote:
> > > >
> > > > a2dp_channel keeps a reference to an avdtp session without incrementing
> > > > its refcount.  Not only does this appear wrong, it causes unexpected
> > > > disconnections when the remote SEP responds with rejections.
> > > >
> > > > During testing with an audio application disconnections are observed
> > > > when a codec config change through MediaEndpoint1.SetConfiguration
> > > > fails.  As soon as BlueZ receives this failure from the peer the
> > > > corresponding a2dp_setup object is cleaned up which holds the last
> > > > refcount to an avdtp session, in turn starting the disconnect process.
> > > > An eventual open sink/source and transport have already closed by that
> > > > time and released their refcounts.
> > > >
> > > > Adding refcounting semantics around a2dp_channel resolves the
> > > > disconnections and allows future calls on MediaEndpoint1 to safely
> > > > access the sesion stored within this channel.
> > > > ---
> > > >  profiles/audio/a2dp.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > > > index cc4866b5b..0eac0135f 100644
> > > > --- a/profiles/audio/a2dp.c
> > > > +++ b/profiles/audio/a2dp.c
> > > > @@ -1507,6 +1507,9 @@ static void channel_free(void *data)
> > > >
> > > >         avdtp_remove_state_cb(chan->state_id);
> > > >
> > > > +       if (chan->session)
> > > > +               avdtp_unref(chan->session);
> > > > +
> > > >         queue_destroy(chan->seps, remove_remote_sep);
> > > >         free(chan->last_used);
> > > >         g_free(chan);
> > > > @@ -2065,7 +2068,7 @@ static void avdtp_state_cb(struct btd_device *dev, struct avdtp *session,
> > > >                 break;
> > > >         case AVDTP_SESSION_STATE_CONNECTED:
> > > >                 if (!chan->session)
> > > > -                       chan->session = session;
> > > > +                       chan->session = avdtp_ref(session);
> > >
> > > Afaik this was done on purpose since we only need a weak reference as
> > > taking a reference would prevent the session to be disconnected when
> > > there is no setup in place, so I pretty sure this will cause
> > > regressions, instead we should probably add a reference when
> > > reconfiguring is in place and have a grace period for switching to
> > > another codec.
> >
> > Allright, so it's either an in-progress setup or ongoing transport
> > keeping the session alive, nothing else?  I guess this is as simple as
> > setting a higher dc_timeout when calling set_disconnect_timer in
> > avdtp_unref?
>
> Yep, actually now that you mentioned the dc_timeout that should have
> prevented us to disconnect immediately when reconfiguring as we should
> have been in AVDTP_SESSION_STATE_CONNECTED state but I think the
> problem is that we use avdtp_close to reconfigure which does set the
> dc_timeout to 0

Yep a2dp_reconfig calls that functionand sets it to 0.

> since that is normally used for cleaning up the
> session, so I think we may need to restore the dc_timeout to
> DISCONNECT_TIMEOUT if we attempt to set a configuration:

My thinking as well, assuming DISCONNECT_TIMEOUT is enough (1s).

> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index ae93fb26f..97b4d1b44 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -3498,6 +3498,7 @@ int avdtp_set_configuration(struct avdtp *session,
>                 session->streams = g_slist_append(session->streams, new_stream);
>                 if (stream)
>                         *stream = new_stream;
> +               session->dc_timeout = DISCONNECT_TIMEOUT;
>         }
>
>         g_free(req);
>
>

Thanks, works like a charm!

    profiles/audio/avdtp.c:avdtp_unref() 0x5565f10db6f0: ref=1
    profiles/audio/avdtp.c:avdtp_set_configuration() 0x5565f10db6f0:
int_seid=8, acp_seid=1
    profiles/audio/avdtp.c:session_cb()
    profiles/audio/avdtp.c:avdtp_parse_rej() SET_CONFIGURATION request
rejected: Configuration not supported (41)
    profiles/audio/a2dp.c:setconf_cfm() Source 0x5565f10fc620:
Set_Configuration_Cfm
    profiles/audio/a2dp.c:setup_ref() 0x5565f110d540: ref=2
    profiles/audio/a2dp.c:setup_unref() 0x5565f110d540: ref=1
    profiles/audio/a2dp.c:setup_unref() 0x5565f110d540: ref=0
    profiles/audio/a2dp.c:setup_free() 0x5565f110d540
    profiles/audio/avdtp.c:avdtp_unref() 0x5565f10db6f0: ref=0
    profiles/audio/avdtp.c:avdtp_ref() 0x5565f10db6f0: ref=1
    profiles/audio/avdtp.c:set_disconnect_timer() timeout 1
    profiles/audio/avdtp.c:avdtp_ref() 0x5565f10db6f0: ref=2
    profiles/audio/avdtp.c:avdtp_unref() 0x5565f10db6f0: ref=1
    profiles/audio/a2dp.c:setup_ref() 0x5565f110d540: ref=1
    profiles/audio/avdtp.c:avdtp_set_configuration() 0x5565f10db6f0:
int_seid=8, acp_seid=7
    profiles/audio/avdtp.c:session_cb()
    profiles/audio/avdtp.c:avdtp_parse_resp() SET_CONFIGURATION
request succeeded
    profiles/audio/a2dp.c:setconf_cfm() Source 0x5565f10fc620:
Set_Configuration_Cfm

Since you suggested this change I guess it's up to you to write a
commit around it and apply it or submit it for additional review, or
should I do it and combine it with the original message for a v2?

> > >
> > > >                 load_remote_seps(chan);
> > > >                 break;
> > > >         }
> > > > @@ -2145,6 +2148,7 @@ found:
> > > >                 channel_remove(chan);
> > > >                 return NULL;
> > > >         }
> > > > +       avdtp_ref(chan->session);
> > > >
> > > >         return avdtp_ref(chan->session);
> > > >  }
> > > > @@ -2165,6 +2169,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
> > > >                         error("Unable to create AVDTP session");
> > > >                         goto fail;
> > > >                 }
> > > > +               avdtp_ref(chan->session);
> > > >         }
> > > >
> > > >         g_io_channel_unref(chan->io);
> > > > --
> > > > 2.29.1
> > > >
> > > > Marijn Suijten
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> > Marijn Suijten
>
>
>
> --
> Luiz Augusto von Dentz

Marijn Suijten
