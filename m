Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] avdtp: Fix crash on connection lost
Date: Wed, 17 Oct 2012 09:28:39 +0200
Message-ID: <15890511.ludKIz2NbJ@uw000953>
In-Reply-To: <CABBYNZLbX__mxzwvZMOd3noCeoJTRrXshFTEovM9Tco4bziLRg@mail.gmail.com>
References: <1350391036-29997-1-git-send-email-szymon.janc@tieto.com> <CABBYNZLbX__mxzwvZMOd3noCeoJTRrXshFTEovM9Tco4bziLRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 16 of October 2012 20:34:47 Luiz Augusto von Dentz wrote:
> Hi Szymon,

Hi Luiz,

> >         if (session->io) {
> >                 g_io_channel_shutdown(session->io, FALSE, NULL);
> > @@ -1173,8 +1172,6 @@ static void connection_lost(struct avdtp *session, int err)
> >                 session->io = NULL;
> >         }
> >
> > -       avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
> 
> This is actually the one that we need in case we got disconnect by
> remote after discovery completes. avctp.c has a similar structure to
> handler such states, but without the refcounting all is much simpler.

OK

> 
> >         if (session->io_id) {
> >                 g_source_remove(session->io_id);
> >                 session->io_id = 0;
> > @@ -1221,9 +1218,6 @@ void avdtp_unref(struct avdtp *session)
> >
> >                 if (session->io)
> >                         set_disconnect_timer(session);
> > -               else if (!session->free_lock) /* Drop the local ref if we
> > -                                                aren't connected */
> > -                       session->ref--;
> >         }
> >
> >         if (session->ref > 0)
> > --
> > 1.7.9.5
> 
> We should probably get rid of the free_lock as well.

Well, this is what this patch does, doesn't it?:)

-- 
BR
Szymon Janc
