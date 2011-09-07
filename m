Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/2] serial: Add support to Disconnect fd passing
 connections
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <padovan@profusion.mobi>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Wed, 07 Sep 2011 13:54:47 +0200
In-Reply-To: <20110906051657.GB13617@joana>
References: <1314033585-22244-1-git-send-email-padovan@profusion.mobi>
	 <1314033585-22244-2-git-send-email-padovan@profusion.mobi>
	 <1314116296.3373.213.camel@aeonflux> <20110823162822.GA26522@joana>
	 <1314117006.3373.214.camel@aeonflux> <20110823164501.GB26522@joana>
	 <CABBYNZLLGijC1A2MfuOKYqfiNQB=UuKsQ+awE804AkHZLfoZ4g@mail.gmail.com>
	 <1314129089.3373.218.camel@aeonflux>
	 <CABBYNZJx4-ciwfoXeFsiDvBN4hszTE_imqq=Cb-ssoBsdx+UQg@mail.gmail.com>
	 <20110906051657.GB13617@joana>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315396489.1979.35.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> > >> > This already fails today. Our code doesn't allow us to call twice the Connect
> > >> > method, so we can't have two of the same UUID connected.
> > >>
> > >> Well with RFCOMM you can't really connect multiple times to the same
> > >> channel/UUID and if we return the same fd clients will probably have
> > >> conflicts.
> > >
> > > you can not connect the same channel twice (except in the other
> > > direction), that is true, but you can connect to a different channel
> > > with a different UUID. That is the reason why we also allow connection
> > > by handles. Or at least we should.
> > 
> > You mean record handle? Currently we support connecting by UUID,
> > friendly name or channel.
> > 
> > > So even if we would make this limitation of 1 connection per UUID, the
> > > API is a fully asymmetric then. You are suppose to disconnect with the
> > > result of the connect call. I do not like that at all. It is bad API
> > > design and we are trying to squeeze this in the wrong way.
> > 
> > Currently we support disconnecting by UUID, friendly name, channel and
> > dev node. As you mentioned it doesn't really work for fd since it is
> > only unique per process, in the other hand the parameter is a pattern.
> > 
> > Perhaps what we should be doing is to return a object path in
> > Serial.Connect e.g. [variable
> > prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serialXX then Disconnect
> > just get it as parameter, the drawback is that this does not return
> > the tty/fd immediately so we need another round-trip or return
> > multiple values to Connect.
> 
> I've been discussing this with Johan and we came to two possible solutions.
> The first one is the similar as this one, with three functions: 
> 
> 	handle, fd ConnectFD("pattern")
> 
> 	ConnectCancel(handle)
> 
> 	Disconnect(handle)
> 
> And other with only ConnectFD() (and maybe ConnectCancel method). Disconnect
> would be handled by the client with shutdown().
> 
> I'm tempted to go with this last approach, it's simpler and easier. What do
> you think?

I thin the last approach sounds a lot better. It is simpler for the
client and not really intrusive on the API level.

If you want the ConnectCancel method, then it would be with pattern as
parameter. Since of course ConnectFD would only return once the
connection establishment is complete. Hence calling ConnectCancel with a
handle would be rather pointless. And btw. CancelConnect would most like
fit better with our existing API semantics.

As a long term approach, I think we need to redesign this anyway and
make this fully generic for L2CAP and RFCOMM. Since with fd passing we
can be having socket type like interaction with D-Bus and allow
applications to connect to remote systems the way they choose.

The real interesting part could be here if we represent SDP service
records as object path and then allow a connect method on top of these
that will return a fd and also allows proper monitoring of that
connection and addition options. And same could be done for a generic
server over D-Bus. But this is future talk :)

Regards

Marcel


