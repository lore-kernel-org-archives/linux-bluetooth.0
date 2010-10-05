Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Tue, 5 Oct 2010 16:42:58 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: clean up rfcomm code
Message-ID: <20101005194258.GC3234@vigoh>
References: <1285923911-12902-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1286265236.17473.26.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286265236.17473.26.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Marcel Holtmann <marcel@holtmann.org> [2010-10-05 09:53:56 +0200]:

> Hi Andrei,
> 
> > Remove dead code and unused rfcomm thread events
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> > ---
> >  include/net/bluetooth/rfcomm.h |    5 -----
> >  net/bluetooth/rfcomm/core.c    |   29 ++++++++++++++---------------
> >  2 files changed, 14 insertions(+), 20 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
> > index a140847..71047bc 100644
> > --- a/include/net/bluetooth/rfcomm.h
> > +++ b/include/net/bluetooth/rfcomm.h
> > @@ -213,11 +213,6 @@ struct rfcomm_dlc {
> >  #define RFCOMM_DEFER_SETUP  8
> >  
> >  /* Scheduling flags and events */
> > -#define RFCOMM_SCHED_STATE  0
> > -#define RFCOMM_SCHED_RX     1
> > -#define RFCOMM_SCHED_TX     2
> > -#define RFCOMM_SCHED_TIMEO  3
> > -#define RFCOMM_SCHED_AUTH   4
> >  #define RFCOMM_SCHED_WAKEUP 31
> 
> we had some big ambition to use these, but never did in the end or
> realized that they are not needed. So I am fine with removing these.
> 
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

Patch has been applied. Thanks.


-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
