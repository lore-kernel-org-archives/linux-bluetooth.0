Return-Path: <SRS0=rjyd=EB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ABFC4363A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 20:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB9420809
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 20:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dExQ1nkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388639AbgJZUjE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Oct 2020 16:39:04 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46640 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732536AbgJZUjD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Oct 2020 16:39:03 -0400
Received: by mail-ot1-f66.google.com with SMTP id j21so4132395ota.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2020 13:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZDOTh05EEd9lP9sDJr3C4K6VHqYf8alDNGrl7HA4aPE=;
        b=dExQ1nkZPkURBQw5vMbdr8LuGQJDsdFLyH+TYHDcTF502qDmVP7tRFAb8yy8uJ84DN
         gfiTVxM6TQG1HS/KlH5dIzXgssc23R/a9aPqtz/V6nJsyw37Xc3jf7rBcFCTL9wcH86Z
         HTA5HfQs6NewzyXeoV+Cn6E9H6RrOx/5goPULGzXv67YYBJGnTU8j5B0YwtMKhAHdGXI
         S+Z4MHrhjgO9EBSU+BCGAF9qfWXxIppFxpmo+a+jmjui8b58QldgjxAQZcRUrpzJIPkH
         VT9a7uN521bhWY1k086I3tJU2dSzl4gZXlSak2pVwMWVOfGTHAvBK2vp4pKlmGjq8PQC
         sXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZDOTh05EEd9lP9sDJr3C4K6VHqYf8alDNGrl7HA4aPE=;
        b=tFwH9FxPxMdPBdKpR1+HPo6lnhbi1Lryhr8WYlR3HgZ4RBzotjqBrhjLkEJzG9ZKP0
         nNtvNYbCtVYg33C2JJfJ7IFJF5ZQ4UTjhGok/WTKMn8yOK8Q1oujFvbYwRSZsAVrjVuY
         ojlDGaVOByL+A+6G1e6Ee2ilK1WJYhhe1qxzYW/K1b/rJPsLM1SUiq+lWEgyNIQc1hun
         lH8r5e9oibMxhITP36UiFqwWMk+06BgVQB1fIDwgFtc5UX/pj41bEwhDl09MoMzrEBDK
         /TZBlYY+l+QHBs1a5zGt/GsBNeUheaCC+r7DV5Up4orhDl5pdYojC3XZYesut1V361m0
         liAA==
X-Gm-Message-State: AOAM531LSXkhIquNXWWLO3czVKJNEwrbv2zXqR7FzzcYYcFHDfO7LD82
        r5rgOPlUr/B+em9T++qeJBafJ6pBuwClyOFilSM=
X-Google-Smtp-Source: ABdhPJxPDTowBguW4CQWGLV3ZlYLyNUGf5OhE47Z3R+RVSUJ+Xl2UzY6yhHw/EVSCNMO4VwSdlvOuXKYR69YCOTkZcw=
X-Received: by 2002:a05:6830:400d:: with SMTP id h13mr16592019ots.371.1603744742433;
 Mon, 26 Oct 2020 13:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201025162730.47247-1-marijns95@gmail.com> <CABBYNZKxYFQ8iodcHZsKHq3JCuC10EOmBykU4ZsS8ECACQ5ktQ@mail.gmail.com>
 <CANX-K3s41y=w8=Ho_+=ZZ=Brv=6-62Or7v+AL64ThDE_u582YQ@mail.gmail.com>
In-Reply-To: <CANX-K3s41y=w8=Ho_+=ZZ=Brv=6-62Or7v+AL64ThDE_u582YQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 26 Oct 2020 13:38:51 -0700
Message-ID: <CABBYNZJ3=e5kFxn-o0_L8j5aKpLDk88CGx=gcKP0eaPjQchO=g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio/a2dp: a2dp_channel should have a refcount on
 avdtp session
To:     Marijn Suijten <marijns95@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

On Mon, Oct 26, 2020 at 1:22 PM Marijn Suijten <marijns95@gmail.com> wrote:
>
> Hi Luiz,
>
> On Mon, 26 Oct 2020 at 21:15, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Marijn,
> >
> > On Sun, Oct 25, 2020 at 9:27 AM Marijn Suijten <marijns95@gmail.com> wrote:
> > >
> > > a2dp_channel keeps a reference to an avdtp session without incrementing
> > > its refcount.  Not only does this appear wrong, it causes unexpected
> > > disconnections when the remote SEP responds with rejections.
> > >
> > > During testing with an audio application disconnections are observed
> > > when a codec config change through MediaEndpoint1.SetConfiguration
> > > fails.  As soon as BlueZ receives this failure from the peer the
> > > corresponding a2dp_setup object is cleaned up which holds the last
> > > refcount to an avdtp session, in turn starting the disconnect process.
> > > An eventual open sink/source and transport have already closed by that
> > > time and released their refcounts.
> > >
> > > Adding refcounting semantics around a2dp_channel resolves the
> > > disconnections and allows future calls on MediaEndpoint1 to safely
> > > access the sesion stored within this channel.
> > > ---
> > >  profiles/audio/a2dp.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > > index cc4866b5b..0eac0135f 100644
> > > --- a/profiles/audio/a2dp.c
> > > +++ b/profiles/audio/a2dp.c
> > > @@ -1507,6 +1507,9 @@ static void channel_free(void *data)
> > >
> > >         avdtp_remove_state_cb(chan->state_id);
> > >
> > > +       if (chan->session)
> > > +               avdtp_unref(chan->session);
> > > +
> > >         queue_destroy(chan->seps, remove_remote_sep);
> > >         free(chan->last_used);
> > >         g_free(chan);
> > > @@ -2065,7 +2068,7 @@ static void avdtp_state_cb(struct btd_device *dev, struct avdtp *session,
> > >                 break;
> > >         case AVDTP_SESSION_STATE_CONNECTED:
> > >                 if (!chan->session)
> > > -                       chan->session = session;
> > > +                       chan->session = avdtp_ref(session);
> >
> > Afaik this was done on purpose since we only need a weak reference as
> > taking a reference would prevent the session to be disconnected when
> > there is no setup in place, so I pretty sure this will cause
> > regressions, instead we should probably add a reference when
> > reconfiguring is in place and have a grace period for switching to
> > another codec.
>
> Allright, so it's either an in-progress setup or ongoing transport
> keeping the session alive, nothing else?  I guess this is as simple as
> setting a higher dc_timeout when calling set_disconnect_timer in
> avdtp_unref?

Yep, actually now that you mentioned the dc_timeout that should have
prevented us to disconnect immediately when reconfiguring as we should
have been in AVDTP_SESSION_STATE_CONNECTED state but I think the
problem is that we use avdtp_close to reconfigure which does set the
dc_timeout to 0 since that is normally used for cleaning up the
session, so I think we may need to restore the dc_timeout to
DISCONNECT_TIMEOUT if we attempt to set a configuration:

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index ae93fb26f..97b4d1b44 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3498,6 +3498,7 @@ int avdtp_set_configuration(struct avdtp *session,
                session->streams = g_slist_append(session->streams, new_stream);
                if (stream)
                        *stream = new_stream;
+               session->dc_timeout = DISCONNECT_TIMEOUT;
        }

        g_free(req);


> >
> > >                 load_remote_seps(chan);
> > >                 break;
> > >         }
> > > @@ -2145,6 +2148,7 @@ found:
> > >                 channel_remove(chan);
> > >                 return NULL;
> > >         }
> > > +       avdtp_ref(chan->session);
> > >
> > >         return avdtp_ref(chan->session);
> > >  }
> > > @@ -2165,6 +2169,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
> > >                         error("Unable to create AVDTP session");
> > >                         goto fail;
> > >                 }
> > > +               avdtp_ref(chan->session);
> > >         }
> > >
> > >         g_io_channel_unref(chan->io);
> > > --
> > > 2.29.1
> > >
> > > Marijn Suijten
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> Marijn Suijten



-- 
Luiz Augusto von Dentz
