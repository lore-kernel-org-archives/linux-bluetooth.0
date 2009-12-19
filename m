Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1261180228.4041.111.camel@localhost.localdomain>
References: <35c90d960912081950t135e3f10m8848e54fde1e596f@mail.gmail.com>
	<1260335175.2901.20.camel@violet> <35c90d960912082213s26fb0ebse75ce85d43213d9@mail.gmail.com>
	<1260482634.2901.70.camel@violet> <35c90d960912161359u2b3f9b2fi875288896a7a8478@mail.gmail.com>
	<1261006596.4041.39.camel@localhost.localdomain> <35c90d960912161548p6cdcc1f0i7d74b31a4bc145b6@mail.gmail.com>
	<1261177540.4041.106.camel@localhost.localdomain> <35c90d960912181523n1067f87cw1d585a17ba57475a@mail.gmail.com>
	<1261180228.4041.111.camel@localhost.localdomain>
From: Nick Pelly <npelly@google.com>
Date: Fri, 18 Dec 2009 16:16:51 -0800
Message-ID: <35c90d960912181616r691fcecau1e1ca8322b2fc4f5@mail.gmail.com>
Subject: Re: RFC: Allow Bluez to select flushable or non-flushable ACL packets
	with L2CAP_LM_RELIABLE
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Dec 18, 2009 at 3:50 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Nick,
>
> > > > >> >> >> Right now Bluez always requests flushable ACL packets (but=
 does not
> > > > >> >> >> set a flush timeout, so effectively they are non-flushable=
):
> > > > >> >> >>
> > > > >> >> >> However it is desirable to use an ACL flush timeout on A2D=
P packets so
> > > > >> >> >> that if the ACL packets block for some reason then the LM =
can flush
> > > > >> >> >> them to make room for newer packets.
> > > > >> >> >>
> > > > >> >> >> Is it reasonable for Bluez to use the 0x00 ACL packet boun=
dary flag by
> > > > >> >> >> default (non-flushable packet), and let userspace request =
flushable
> > > > >> >> >> packets on A2DP L2CAP sockets with the socket option
> > > > >> >> >> L2CAP_LM_RELIABLE.
> > > > >> >> >
> > > > >> >> > the reliable option has a different meaning. It comes back =
from the old
> > > > >> >> > Bluetooth 1.1 qualification days where we had to tests on L=
2CAP that had
> > > > >> >> > to confirm that we can detect malformed packets and report =
them. These
> > > > >> >> > days it is just fine to drop them.
> > > > >> >>
> > > > >> >> Got it, how about introducing
> > > > >> >>
> > > > >> >> #define L2CAP_LM_FLUSHABLE 0x0040
> > > > >> >
> > > > >> > that l2cap_sock_setsockopt_old() sets this didn't give you a h=
int that
> > > > >> > we might wanna deprecate this socket options ;)
> > > > >> >
> > > > >> > I need to read up on the flushable stuff, but in the end it de=
serves its
> > > > >> > own socket option. Also an ioctl() to actually trigger Enhance=
d flush
> > > > >> > might be needed.
> > > > >> >
> > > > >> >> struct l2cap_pinfo {
> > > > >> >> =A0 =A0...
> > > > >> >> =A0 =A0__u8 flushable;
> > > > >> >> }
> > > > >> >
> > > > >> > Sure. In the long run we need to turn this into a bitmask. We =
are just
> > > > >> > wasting memory here.
> > > > >>
> > > > >> Attached is an updated patch, that checks the LMP features bitma=
sk
> > > > >> before using the new non-flushable packet type.
> > > > >>
> > > > >> I am still using L2CAP_LM_FLUSHABLE socket option in
> > > > >> l2cap_sock_setsockopt_old(), which I don't think you are happy w=
ith.
> > > > >> So how about a new option:
> > > > >>
> > > > >> SOL_L2CAP, L2CAP_ACL_FLUSH
> > > > >> which has a default value of 0, and can be set to 1 to make the =
ACL
> > > > >> data sent by this L2CAP socket flushable.
> > > >
> > > > Was this proposal ok?
> > >
> > > Even SOL_L2CAP goes away. Use SOL_BLUETOOTH for this.
> > >
> > > > >> In a later commit we would then add
> > > > >> SOL_ACL, ACL_FLUSH_TIMEOUT
> > > > >> That is used to set an automatic flush timeout for the ACL link =
on a
> > > > >> L2CAP socket. Note that SOL_ACL is new.
> > > > >
> > > > > can I stop you right here (without even looking at the patch). We=
 do
> > > > > have the generic SOL_BLUETOOTH that you should be using. So addin=
g
> > > > > SOL_ACL is not a viable option at all.
> > > >
> > > > This would be in a later patch, and SOL_BLUETOOTH, ACL_FLUSH_TIMEOU=
T
> > > > is fine too, or whatever you prefer.
> > >
> > > Why not just use BT_FLUSHABLE and have it always take a timeout optio=
n
> > > and then 0 means not flushable. And advantage of having it separated?
> >
> > I think keeping them separate makes it clear that the flush timeout is
> > global for a given ACL link, whereas the flushable/non-flushable
> > boolean is specific to a L2CAP channel. (Which is why I suggested
> > introducing a new level SOL_ACL for the ACL_FLUSH_TIMEOUT option -
> > since this option applies at the ACL level in the stack).
> >
> > A specific advantage of this is that flushable packets can be enabled
> > without over-writing a previous flush timeout that was set on a
> > different L2CAP socket on the same ACL link. I guess this can also be
> > achieved with getsockopt() but that is racy.
>
> I am talking here about Enhanced Flush support and that would happen on
> a per ACL handle basis. So it actually almost applies on a per L2CAP
> socket level. Only exception is if you establish two or more L2CAP
> connections to the same remote device and set them all to flushable.
> Then of course all of them will be flushed. So strictly speaking it
> might be an ACL link feature, but we don't wanna use it that way. And in
> practice you won't have multiple concurrent flushable L2CAP connections
> to one remote device anyway.
>

I agree that having 2=A0flush-able=A0L2CAP channels to the same device
would probably not be common. But who knows what new profiles the
Bluetooth SIG will come up with that might also benefit from
flush-able=A0ACL data. And when this happens, with your proposed API,
programmers will not be able to avoid a race condition between
getsockopt() then setsockopt() if they want to turn on flushing
without changing the ACL flush timeout.
But its not worth arguing over.=A0SOL_BLUETOOTH, BT_FLUSHABLE is fine
(or BT_FLUSH_TIMEOUT instead).

I won't be doing development for a few weeks over the holidays, so I
can not update this patch for a while.

Nick
