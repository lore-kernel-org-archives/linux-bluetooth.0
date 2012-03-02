Return-Path: <cyrus@holtmann.org>
Message-ID: <1330649319.3392.110.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Update MGMT and SMP timeout constants to use
 msecs_to_jiffies
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 01 Mar 2012 16:48:39 -0800
In-Reply-To: <CAJdJm_PHQOfstiuUfMfgtceWN=Ko37COLQNKkXb12Gc3CEOchw@mail.gmail.com>
References: <1330641157-32626-1-git-send-email-marcel@holtmann.org>
	 <CAJdJm_PHQOfstiuUfMfgtceWN=Ko37COLQNKkXb12Gc3CEOchw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> > The MGMT and SMP timeout constants are always used in form of jiffies. So
> > just include the conversion from msecs in the define itself. This has the
> > advantage of making the code where the timeout is used more readable.
> >
> > Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> > ---
> >  net/bluetooth/mgmt.c |    5 ++---
> >  net/bluetooth/smp.c  |    5 ++---
> >  2 files changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 7bd7d57..40b3da3 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -116,7 +116,7 @@ static const u16 mgmt_events[] = {
> >  #define INQUIRY_LEN_BREDR              0x08    /* TGAP(100) */
> >  #define INQUIRY_LEN_BREDR_LE           0x04    /* TGAP(100)/2 */
> >
> > -#define SERVICE_CACHE_TIMEOUT (5 * 1000)
> > +#define CACHE_TIMEOUT  msecs_to_jiffies(2 * 1000)
> 
> Was it intentional to change timeout from 5 seconds to 2 seconds on this commit?

the change was intentional, but unintentional I forgot to mention it in
the commit message.

Regards

Marcel
 

