Return-Path: <Maksim.Yevmenkin@cw.com>
Message-ID: <3E49385A.AD4DCF1B@cw.com>
Date: Tue, 11 Feb 2003 09:52:26 -0800
From: Maksim Yevmenkin <Maksim.Yevmenkin@cw.com>
MIME-Version: 1.0
To: Alexandros Karypidis <karypid@inf.uth.gr>
CC: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>, Max Krasnyansky <maxk@qualcomm.com>, bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: [Bluez-users] How do I obtain a free PSM
	automatically?
References: <200302081740.48000.karypid@inf.uth.gr>
	<5.1.0.14.2.20030210125138.04183f58@mail1.qualcomm.com>
	<1044964883.19214.46.camel@linux> <200302111926.14743.karypid@inf.uth.gr>
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

Alexandros Karypidis wrote:
> 
> On Tuesday 11 February 2003 14:01, Marcel Holtmann wrote:
> 
> > > Now if people really want dynamic PSMs. We could introduce something like
> > > bind(psm == 0xffff).
> >
> > I think this is not a good idea, because 0xffff is a valid PSM according
> > to the spec.
> 
> That is true. A simple problem that may arrise is that, suppose I write a
> program which binds to PSM 0xffff. This is my PSM of choice and I am not
> using BlueZ. However, if I try to port my program to a Linux architecture
> which uses BlueZ, my program may compile but will not run correctly. BlueZ
> would redirect it to another PSM ands clients would make connection attempts
> to 0xffff which would fail.
> 
> > But what about bind it with PSM 0 and the listen call assign a dynamic
> > PSM if it is bind with PSM 0 ?
> 
> That is what I was suggesting BUT: in IP, there is no way that a conneted
> socket will ever return port==0. This is why it may be used as a special
> value for bind().

there is a reason why clients use PSM 0. consider the following example:

1) servers listens on PSM "X"
2) *two* clients want to connect.
3) client1: creates socket and bind()s it to PSM "X" -> OK
4) client2: creates socket and bind()s it to PSM "X" -> EBUSY (or INUSE)

however in real life this is a valid scenario. you may have many
channels on the same PSM. PSM 0 means "any PSM", i think Bluetooth
spec even says so, when it discusses L2CAP connectionless traffic,
i.e. L2CA_Enable_Connectionless_Traffic.

> In BT however, there is no "illegal" PSM value. I do not know this, but Max
> mentioned that a client by default uses PSM zero if he does not specify one.
> Indeed, in the test I mentioned in previous e-mails, using getsockname() will
> return PSM 0 when you connect() without previously calling bind(). Plus, one
> may explicitly bind() to PSM==0 and then connect() on the basis of current
> behavior and instead get another PSM because of this change. Quoting Max:
> 
> "Currently psm zero means that socket doesn't have PSM assigned to it.
> bind(psm==0) means that application doesn't need PSM it's simply wants to
> bind it's socket to some BD address. Which is exactly what L2CAP clients need.
> So you proposing a change that will brake current bind() interface. Well I
> guess it won't really break it but it will allocated PSM for all client apps
> which doesn't make any sense."
> 
> An alternative which I may suggest is to define a socket option which may be
> set using setsockopt(), previously to calling bind(). Then, one might do this
> via:
> 
>         enable = 1;
>         s = socket (...);
>         setsockopt (s, SOL_SOCKET, BT_DYNAMIC_PSM, &enable, sizeof(enable));
>         bind (s, ... );

something like that probably will work. however i still do not see
why you need this. PSM stands for "Protocol/Service Multiplexor",
so think of it as "well known port". currently all clients look for
services they understand. so even if you write some service and
give it new PSM no existing client will ever look for it (because
existing clients do not know how to use it). bottom line: you have
to write both: server and client, and since you control both ends
it just plain easy to agree on PSM.

thanks,
max
