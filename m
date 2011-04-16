Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC] Proposal to distinguish address device types
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
In-Reply-To: <20110415184728.GA2359@joana>
References: <1302892422-32206-1-git-send-email-claudio.takahasi@openbossa.org>
	 <20110415184728.GA2359@joana>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Apr 2011 18:03:10 -0700
Message-ID: <1302915790.2503.31.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

> > Device type is input to decide how to establish the L2CAP connection.
> > For LE devices fixed channel ID 4 is set, otherwise PSM should be set
> > for basic rate connections. LE public and random constants are misused
> > for discovery, however I don't see advantage of defining basic rate and
> > LE values only.
> > 
> > Based on jhe/master:
> > git://git.kernel.org/pub/scm/linux/kernel/git/jh/linux-2.6.git
> > 
> > Opinions?
> > ---
> >  include/net/bluetooth/bluetooth.h |    6 ++++++
> >  include/net/bluetooth/hci_core.h  |    4 ++--
> >  include/net/bluetooth/mgmt.h      |    1 +
> >  net/bluetooth/hci_event.c         |   16 ++++++++--------
> >  net/bluetooth/mgmt.c              |    5 +++--
> >  5 files changed, 20 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> > index 4375043..b91eec9 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -94,6 +94,12 @@ typedef struct {
> >  #define BDADDR_ANY   (&(bdaddr_t) {{0, 0, 0, 0, 0, 0}})
> >  #define BDADDR_LOCAL (&(bdaddr_t) {{0, 0, 0, 0xff, 0xff, 0xff}})
> >  
> > +enum {
> > +	BDADDR_TYPE_BR = 0,
> 
> As we going to differentiate this, can't we separate BR and BR/EDR?
> Or maybe not once most of the device today should be BR/EDR.

what is the difference between BR and BR/EDR exactly? I don't see one
and in general the specification calls this BR/EDR. So using BREDR seems
more correct.

> > +	BDADDR_TYPE_LE_PUBLIC,
> > +	BRADDR_TYPE_LE_RANDOM
> > +};

I am also not sure the we should have this BR/EDR differentiation since
the specification only talks about public and random addresses. And we
should follow the specification type value here. I am against
introducing our enum here.

Regards

Marcel


