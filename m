Return-Path: <cyrus@holtmann.org>
Subject: Re: RFC: Allow Bluez to select flushable or non-flushable ACL
 packets  with L2CAP_LM_RELIABLE
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <35c90d960912181900y42baaefdp6cecb0459ee63fe1@mail.gmail.com>
References: <35c90d960912081950t135e3f10m8848e54fde1e596f@mail.gmail.com>
	 <1261006596.4041.39.camel@localhost.localdomain>
	 <35c90d960912161548p6cdcc1f0i7d74b31a4bc145b6@mail.gmail.com>
	 <1261177540.4041.106.camel@localhost.localdomain>
	 <35c90d960912181523n1067f87cw1d585a17ba57475a@mail.gmail.com>
	 <1261180228.4041.111.camel@localhost.localdomain>
	 <35c90d960912181612x494c5626r8cd01168e4991e7@mail.gmail.com>
	 <1261182368.4041.114.camel@localhost.localdomain>
	 <35c90d960912181750g6f82c3c1tf89df6aec2ae97cf@mail.gmail.com>
	 <1261188322.4041.127.camel@localhost.localdomain>
	 <35c90d960912181900y42baaefdp6cecb0459ee63fe1@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 18 Dec 2009 19:27:37 -0800
Message-Id: <1261193257.4041.138.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

> >> >>         > > > >> >> >> Right now Bluez always requests flushable ACL
> >> >>         packets (but does not
> >> >>         > > > >> >> >> set a flush timeout, so effectively they are
> >> >>         non-flushable):
> >> >>         > > > >> >> >>
> >> >>         > > > >> >> >> However it is desirable to use an ACL flush
> >> >>         timeout on A2DP packets so
> >> >>         > > > >> >> >> that if the ACL packets block for some reason
> >> >>         then the LM can flush
> >> >>         > > > >> >> >> them to make room for newer packets.
> >> >>         > > > >> >> >>
> >> >>         > > > >> >> >> Is it reasonable for Bluez to use the 0x00 ACL
> >> >>         packet boundary flag by
> >> >>         > > > >> >> >> default (non-flushable packet), and let
> >> >>         userspace request flushable
> >> >>         > > > >> >> >> packets on A2DP L2CAP sockets with the socket
> >> >>         option
> >> >>         > > > >> >> >> L2CAP_LM_RELIABLE.
> >> >>         > > > >> >> >
> >> >>         > > > >> >> > the reliable option has a different meaning. It
> >> >>         comes back from the old
> >> >>         > > > >> >> > Bluetooth 1.1 qualification days where we had to
> >> >>         tests on L2CAP that had
> >> >>         > > > >> >> > to confirm that we can detect malformed packets
> >> >>         and report them. These
> >> >>         > > > >> >> > days it is just fine to drop them.
> >> >>         > > > >> >>
> >> >>         > > > >> >> Got it, how about introducing
> >> >>         > > > >> >>
> >> >>         > > > >> >> #define L2CAP_LM_FLUSHABLE 0x0040
> >> >>         > > > >> >
> >> >>         > > > >> > that l2cap_sock_setsockopt_old() sets this didn't
> >> >>         give you a hint that
> >> >>         > > > >> > we might wanna deprecate this socket options ;)
> >> >>         > > > >> >
> >> >>         > > > >> > I need to read up on the flushable stuff, but in
> >> >>         the end it deserves its
> >> >>         > > > >> > own socket option. Also an ioctl() to actually
> >> >>         trigger Enhanced flush
> >> >>         > > > >> > might be needed.
> >> >>         > > > >> >
> >> >>         > > > >> >> struct l2cap_pinfo {
> >> >>         > > > >> >>    ...
> >> >>         > > > >> >>    __u8 flushable;
> >> >>         > > > >> >> }
> >> >>         > > > >> >
> >> >>         > > > >> > Sure. In the long run we need to turn this into a
> >> >>         bitmask. We are just
> >> >>         > > > >> > wasting memory here.
> >> >>         > > > >>
> >> >>         > > > >> Attached is an updated patch, that checks the LMP
> >> >>         features bitmask
> >> >>         > > > >> before using the new non-flushable packet type.
> >> >>         > > > >>
> >> >>         > > > >> I am still using L2CAP_LM_FLUSHABLE socket option in
> >> >>         > > > >> l2cap_sock_setsockopt_old(), which I don't think you
> >> >>         are happy with.
> >> >>         > > > >> So how about a new option:
> >> >>         > > > >>
> >> >>         > > > >> SOL_L2CAP, L2CAP_ACL_FLUSH
> >> >>         > > > >> which has a default value of 0, and can be set to 1
> >> >>         to make the ACL
> >> >>         > > > >> data sent by this L2CAP socket flushable.
> >> >>         > > >
> >> >>         > > > Was this proposal ok?
> >> >>         > >
> >> >>         > > Even SOL_L2CAP goes away. Use SOL_BLUETOOTH for this.
> >> >>         > >
> >> >>         > > > >> In a later commit we would then add
> >> >>         > > > >> SOL_ACL, ACL_FLUSH_TIMEOUT
> >> >>         > > > >> That is used to set an automatic flush timeout for
> >> >>         the ACL link on a
> >> >>         > > > >> L2CAP socket. Note that SOL_ACL is new.
> >> >>         > > > >
> >> >>         > > > > can I stop you right here (without even looking at the
> >> >>         patch). We do
> >> >>         > > > > have the generic SOL_BLUETOOTH that you should be
> >> >>         using. So adding
> >> >>         > > > > SOL_ACL is not a viable option at all.
> >> >>         > > >
> >> >>         > > > This would be in a later patch, and SOL_BLUETOOTH,
> >> >>         ACL_FLUSH_TIMEOUT
> >> >>         > > > is fine too, or whatever you prefer.
> >> >>         > >
> >> >>         > > Why not just use BT_FLUSHABLE and have it always take a
> >> >>         timeout option
> >> >>         > > and then 0 means not flushable. And advantage of having it
> >> >>         separated?
> >> >>         >
> >> >>         > I think keeping them separate makes it clear that the flush
> >> >>         timeout is
> >> >>         > global for a given ACL link, whereas the
> >> >>         flushable/non-flushable
> >> >>         > boolean is specific to a L2CAP channel. (Which is why I
> >> >>         suggested
> >> >>         > introducing a new level SOL_ACL for the ACL_FLUSH_TIMEOUT
> >> >>         option -
> >> >>         > since this option applies at the ACL level in the stack).
> >> >>         >
> >> >>         > A specific advantage of this is that flushable packets can
> >> >>         be enabled
> >> >>         > without over-writing a previous flush timeout that was set
> >> >>         on a
> >> >>         > different L2CAP socket on the same ACL link. I guess this
> >> >>         can also be
> >> >>         > achieved with getsockopt() but that is racy.
> >> >>
> >> >>
> >> >>         I am talking here about Enhanced Flush support and that would
> >> >>         happen on
> >> >>         a per ACL handle basis. So it actually almost applies on a per
> >> >>         L2CAP
> >> >>         socket level. Only exception is if you establish two or more
> >> >>         L2CAP
> >> >>         connections to the same remote device and set them all to
> >> >>         flushable.
> >> >>         Then of course all of them will be flushed. So strictly
> >> >>         speaking it
> >> >>         might be an ACL link feature, but we don't wanna use it that
> >> >>         way. And in
> >> >>         practice you won't have multiple concurrent flushable L2CAP
> >> >>         connections
> >> >>         to one remote device anyway.
> >> >>
> >> >>
> >> >> I agree that having 2 flush-able L2CAP channels to the same device
> >> >> would probably not be common. But who knows what new profiles the
> >> >> Bluetooth SIG will come up with that might also benefit from
> >> >> flush-able ACL data. And if a use-case comes up, then your proposed
> >> >> API will require programmers to write a racy getsockopt/setsockopt if
> >> >> they want to turn on flushing on one l2cap connection without
> >> >> affecting the ACL flush timeout set by another connection. Building
> >> >> race conditions into an API seems like a sub-optimal design choice.
> >> >
> >> > are you expecting to change this frequently and from different parts of
> >> > the code during the lifetime of a socket. I just don't see that
> >> > happening at all actually. Either you create a "flushable" socket or you
> >> > don't. Fill me in on how you wanna actually use this feature.
> >>
> >> My use case is just for A2DP. I turn on flushing with a timeout of say
> >> 160ms just before starting streaming of A2DP data, and turn it off
> >> when I finish. This is not a problem with either API proposal.
> >
> > I count this as creating socket, setting flushable and then using it.
> > Then closing it. And especially in A2DP case where the media socket is
> > brought up and taken down a lot that is a proper usage. However I do
> > expect that each socket should not change from flushable to
> > non-flushable in mid term usage. While potentially possible it don't see
> > its usage at all.
> >
> > So we could even force the flushable option into non-changeable after
> > the socket has been connected. Like changing the MTU afterwards makes no
> > sense.
> >
> >> Where it becomes a problem is if there is a reason to have two
> >> flush-able L2CAP connections to the same host. With your API proposal,
> >> the second connection has no way of turning on flushing without
> >> over-writing the flush timeout set by the first socket. You could
> >> implement another API to read the current flush timeout, and have the
> >> second socket read that API, but thats racy.
> >>
> >> If this is not a use-case you care about, then ok. But I just want to
> >> point out that this is a problem that will be baked into the API - and
> >> will require ugly workarounds in userspace as soon as someone requires
> >> 2 flushable L2CAP connections to one host. Given the rate at which
> >> Bluetooth changes and new profiles and use cases are added I would not
> >> be so quick to dismiss this use case.
> >
> > So my idea would actually be that every socket can has its own flush
> > timeout, but the core than picks the time to actually do the flushing of
> > packets. Also we can not have one socket change a socket option of
> > another one. It is a per socket option and not a global one.
> 
> I think you are confused. This patch does not implement HCI Enhance
> Flush Command. The flush timeout that I am referring to is passed to
> the Bluetooth Chipset with the HCI Write Automatic Flush Timeout
> command. Which is why it is global for the ACL link.

I was clearly talking about Enhanced Flush support and not the automatic
flush timeout. The automatic flush timeout should clearly not be a L2CAP
socket option. That would be just wrong. It would be great if they had a
default variant so we can just make this a main.conf option, but that is
out of the question.

So personally I think using the automatic flush timeout would be not a
really good choice for us. Just implemented Enhanced Flush would allow
us to achieve exactly the same with a lot of more control over what is
going on.

Regards

Marcel


