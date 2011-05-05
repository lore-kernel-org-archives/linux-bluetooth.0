Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 May 2011 21:31:34 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 02/13] Add Bluetooth address type definition
Message-ID: <20110505003134.GA26302@piper>
References: <1304030229-6672-3-git-send-email-claudio.takahasi@openbossa.org>
 <1304458357-21571-1-git-send-email-claudio.takahasi@openbossa.org>
 <20110504060357.GA3711@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110504060357.GA3711@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 09:03 Wed 04 May, Johan Hedberg wrote:
> Hi Claudio,
> 
> On Tue, May 03, 2011, Claudio Takahasi wrote:
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
> 

As Claudio explained in an earlier email, we will need a way to get the
device type when the connection with that device starts 
(MGMT_EV_DEVICE_CONNECTED), with hciops we can infer the type if we receive
the LE Meta Event.

My question is: should the event have a bdaddr_type field or a type field?

> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
-- 
Vinicius
