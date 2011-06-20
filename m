Return-Path: <cyrus@holtmann.org>
From: Hendrik Sattler <post@hendrik-sattler.de>
To: openobex-users@lists.sourceforge.net
Subject: Re: [openobex-users] [PATCH openobex 1/3] Add transport format member in fdobex_data struct. Support STREAM and SEQPACKET transport format.
Date: Mon, 20 Jun 2011 22:43:54 +0200
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Nami <nami.li@atheros.com>,
 haijun@qca.qualcomm.com,
 linux-bluetooth@vger.kernel.org
References: <1308548849-11615-1-git-send-email-nami.li@atheros.com> <201106202028.43470.post@hendrik-sattler.de> <1308599113.2196.46.camel@aeonflux>
In-Reply-To: <1308599113.2196.46.camel@aeonflux>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201106202243.54514.post@hendrik-sattler.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Am Montag, 20. Juni 2011, 21:45:11 schrieb Marcel Holtmann:
> > > >  include/openobex/obex_const.h |    4 ++++
> > > >  lib/fdobex.h                  |    1 +
> > > >  2 files changed, 5 insertions(+), 0 deletions(-)
> > > > 
> > > > diff --git a/include/openobex/obex_const.h
> > > > b/include/openobex/obex_const.h index cb7afeb..8acee91 100644
> > > > --- a/include/openobex/obex_const.h
> > > > +++ b/include/openobex/obex_const.h
> > > > @@ -302,6 +302,10 @@ enum obex_rsp_mode {
> > > > 
> > > >    OBEX_RSP_MODE_SINGLE = 1, /**< single response mode (SRM) */
> > > >  
> > > >  };
> > > > 
> > > > +enum fdobex_transport_format{
> > > > +	 FDOBEX_MT_STREAM ,
> > > > +	 FDOBEX_MT_SEQPACKET
> > > > +};
> > > 
> > > can I ask again why we should be doing this. Especially for the FdOBEX
> > > transport this is pointless. You are getting a file descriptor in the
> > > first place. It does not have to be a socket.
> > > 
> > > And in the case this is really a socket, then you can just use SO_TYPE
> > > to read the current type of the socket.
> > > 
> > > If it is not a socket, then it needs to treated as stream anyway.
> > 
> > No. Ever tried that on the linux USB gadget implementation in Linux? If a
> > FD is not pointing to a socket, it can still point to a device file of
> > whatever kind. You SO_TYPE won't completely help here. You can try any
> > amount of guessing but isn't it easier if the application just tells
> > you? OTOH, the application could just use a custom transport, then.
> 
> problem is that either we introduce a new abstraction or we figure this
> out magically. Breaking the API like this is not a good idea.
> 
> So if we go for FdPacketOBEX or something it might be a possible option,
> but breaking FdOBEX API is not an option.

How about a new function:
void FdOBEX_SetTransportFormat(obex_t *self, enum fdobex_transport_format 
fmt);

Should not break anything :)

HS
