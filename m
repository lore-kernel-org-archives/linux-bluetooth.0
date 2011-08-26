Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Fri, 26 Aug 2011 15:16:15 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: Add support to Disconnect fd passing
 connections
Message-ID: <20110826181614.GB3512@joana>
References: <1314033585-22244-2-git-send-email-padovan@profusion.mobi>
 <1314116296.3373.213.camel@aeonflux>
 <20110823162822.GA26522@joana>
 <1314117006.3373.214.camel@aeonflux>
 <20110823164501.GB26522@joana>
 <CABBYNZLLGijC1A2MfuOKYqfiNQB=UuKsQ+awE804AkHZLfoZ4g@mail.gmail.com>
 <1314129089.3373.218.camel@aeonflux>
 <CABBYNZJx4-ciwfoXeFsiDvBN4hszTE_imqq=Cb-ssoBsdx+UQg@mail.gmail.com>
 <20110825145508.GD25269@joana>
 <CABBYNZJZJPvr78b847Ch4EfPYJiVuPg7n7J0PKJMQ2Q+3tV4XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZJZJPvr78b847Ch4EfPYJiVuPg7n7J0PKJMQ2Q+3tV4XA@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-08-26 10:22:42 +0300]:

> Hi Gustavo,
> 
> On Thu, Aug 25, 2011 at 5:55 PM, Gustavo Padovan <padovan@profusion.mobi> wrote:
> > Hi Luiz,
> >
> > * Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-08-24 13:43:47 +0300]:
> >
> >> Hi Marcel,
> >>
> >> On Tue, Aug 23, 2011 at 10:51 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> >> > Hi Luiz,
> >> >
> >> >> > This already fails today. Our code doesn't allow us to call twice the Connect
> >> >> > method, so we can't have two of the same UUID connected.
> >> >>
> >> >> Well with RFCOMM you can't really connect multiple times to the same
> >> >> channel/UUID and if we return the same fd clients will probably have
> >> >> conflicts.
> >> >
> >> > you can not connect the same channel twice (except in the other
> >> > direction), that is true, but you can connect to a different channel
> >> > with a different UUID. That is the reason why we also allow connection
> >> > by handles. Or at least we should.
> >>
> >> You mean record handle? Currently we support connecting by UUID,
> >> friendly name or channel.
> >>
> >> > So even if we would make this limitation of 1 connection per UUID, the
> >> > API is a fully asymmetric then. You are suppose to disconnect with the
> >> > result of the connect call. I do not like that at all. It is bad API
> >> > design and we are trying to squeeze this in the wrong way.
> >>
> >> Currently we support disconnecting by UUID, friendly name, channel and
> >> dev node. As you mentioned it doesn't really work for fd since it is
> >> only unique per process, in the other hand the parameter is a pattern.
> >>
> >> Perhaps what we should be doing is to return a object path in
> >> Serial.Connect e.g. [variable
> >> prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serialXX then Disconnect
> >> just get it as parameter, the drawback is that this does not return
> >> the tty/fd immediately so we need another round-trip or return
> >> multiple values to Connect.
> >
> > Then we would need some sort of agent. Don't you think that add a agent and
> > one more round trip here is too much?
> 
> I wouldn't consider it an agent since the client doesn't have to
> implement the object returned by ConnectFD, bluetoothd does. The the
> extra round trips can be a problem though.

So how do wanna to implement this extra round trip? I thought it would a
NewConnection-like method to be called in the agent interface. That would be
my idea, but I think it's too much to simple Serial Connections process.

> 
> > I would just add a handle to the Connect reply besides the fd, Disconnect
> > then use this handle as parameter to Disconnect.
> > If we want to disconnect before Connect replies we use the pattern as
> > parameter like we with the current API. Is that bad?
> 
> Well that doesn't change much my proposal does it, I mean returning an
> object or a handle is kind of the same idea and has almost the same
> problems, actually with handle is worse because it doesn't return
> anything meaningful so in that case we must have multiple values in
> the return e.g handle + fd.

Yeah, you right. You proposal works for this case.

	Gustavo
