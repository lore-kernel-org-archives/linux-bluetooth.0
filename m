Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 02/13] Add Bluetooth address type definition
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20110504060357.GA3711@jh-x301>
References: <1304030229-6672-3-git-send-email-claudio.takahasi@openbossa.org>
	 <1304458357-21571-1-git-send-email-claudio.takahasi@openbossa.org>
	 <20110504060357.GA3711@jh-x301>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 11 May 2011 18:20:28 -0700
Message-ID: <1305163228.15916.163.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > Values defined to LE(public and random) are defined in the Bluetooth
> > Core Specification. For basic rate, there isn't address type concept.
> > The constants introduced by this commit will be used to identify the
> > remote address type, basically to distinguish LE/BR devices before
> > to request the L2CAP connection.
> > ---
> >  lib/bluetooth.h |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> > 
> > diff --git a/lib/bluetooth.h b/lib/bluetooth.h
> > index 738e07a..98b8f1c 100644
> > --- a/lib/bluetooth.h
> > +++ b/lib/bluetooth.h
> > @@ -130,6 +130,10 @@ typedef struct {
> >  #define BDADDR_ALL   (&(bdaddr_t) {{0xff, 0xff, 0xff, 0xff, 0xff, 0xff}})
> >  #define BDADDR_LOCAL (&(bdaddr_t) {{0, 0, 0, 0xff, 0xff, 0xff}})
> >  
> > +#define BDADDR_TYPE_LE_PUBLIC	0x00
> > +#define BRADDR_TYPE_LE_RANDOM	0x01
> > +#define BDADDR_TYPE_BR		0xff
> 
> Firstly this still needs Marcel's blessing (though I don't really see
> any other solution than an address type with three possible values).
> Secondly, if this is ever going to be added to the L2CAP socket address
> you'd have to have 0x00 as BDADDR_TYPE_BR for backwards compatibility.

I am still not 100% convinced, but yes, the default 0x00 then needs to
be BDADDR_TYPE_BREDR. Otherwise we break APIs.

Regards

Marcel


