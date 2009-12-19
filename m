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
Date: Fri, 18 Dec 2009 16:12:27 -0800
Message-ID: <35c90d960912181612x494c5626r8cd01168e4991e7@mail.gmail.com>
Subject: Re: RFC: Allow Bluez to select flushable or non-flushable ACL packets
	with L2CAP_LM_RELIABLE
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=000e0cd70e0c52d42f047b09b742
List-ID: <linux-bluetooth.vger.kernel.org>

--000e0cd70e0c52d42f047b09b742
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Dec 18, 2009 at 3:50 PM, Marcel Holtmann <marcel@holtmann.org>wrote:

> Hi Nick,
>
> > > > >> >> >> Right now Bluez always requests flushable ACL packets (but
> does not
> > > > >> >> >> set a flush timeout, so effectively they are non-flushable):
> > > > >> >> >>
> > > > >> >> >> However it is desirable to use an ACL flush timeout on A2DP
> packets so
> > > > >> >> >> that if the ACL packets block for some reason then the LM
> can flush
> > > > >> >> >> them to make room for newer packets.
> > > > >> >> >>
> > > > >> >> >> Is it reasonable for Bluez to use the 0x00 ACL packet
> boundary flag by
> > > > >> >> >> default (non-flushable packet), and let userspace request
> flushable
> > > > >> >> >> packets on A2DP L2CAP sockets with the socket option
> > > > >> >> >> L2CAP_LM_RELIABLE.
> > > > >> >> >
> > > > >> >> > the reliable option has a different meaning. It comes back
> from the old
> > > > >> >> > Bluetooth 1.1 qualification days where we had to tests on
> L2CAP that had
> > > > >> >> > to confirm that we can detect malformed packets and report
> them. These
> > > > >> >> > days it is just fine to drop them.
> > > > >> >>
> > > > >> >> Got it, how about introducing
> > > > >> >>
> > > > >> >> #define L2CAP_LM_FLUSHABLE 0x0040
> > > > >> >
> > > > >> > that l2cap_sock_setsockopt_old() sets this didn't give you a
> hint that
> > > > >> > we might wanna deprecate this socket options ;)
> > > > >> >
> > > > >> > I need to read up on the flushable stuff, but in the end it
> deserves its
> > > > >> > own socket option. Also an ioctl() to actually trigger Enhanced
> flush
> > > > >> > might be needed.
> > > > >> >
> > > > >> >> struct l2cap_pinfo {
> > > > >> >>    ...
> > > > >> >>    __u8 flushable;
> > > > >> >> }
> > > > >> >
> > > > >> > Sure. In the long run we need to turn this into a bitmask. We
> are just
> > > > >> > wasting memory here.
> > > > >>
> > > > >> Attached is an updated patch, that checks the LMP features bitmask
> > > > >> before using the new non-flushable packet type.
> > > > >>
> > > > >> I am still using L2CAP_LM_FLUSHABLE socket option in
> > > > >> l2cap_sock_setsockopt_old(), which I don't think you are happy
> with.
> > > > >> So how about a new option:
> > > > >>
> > > > >> SOL_L2CAP, L2CAP_ACL_FLUSH
> > > > >> which has a default value of 0, and can be set to 1 to make the
> ACL
> > > > >> data sent by this L2CAP socket flushable.
> > > >
> > > > Was this proposal ok?
> > >
> > > Even SOL_L2CAP goes away. Use SOL_BLUETOOTH for this.
> > >
> > > > >> In a later commit we would then add
> > > > >> SOL_ACL, ACL_FLUSH_TIMEOUT
> > > > >> That is used to set an automatic flush timeout for the ACL link on
> a
> > > > >> L2CAP socket. Note that SOL_ACL is new.
> > > > >
> > > > > can I stop you right here (without even looking at the patch). We
> do
> > > > > have the generic SOL_BLUETOOTH that you should be using. So adding
> > > > > SOL_ACL is not a viable option at all.
> > > >
> > > > This would be in a later patch, and SOL_BLUETOOTH, ACL_FLUSH_TIMEOUT
> > > > is fine too, or whatever you prefer.
> > >
> > > Why not just use BT_FLUSHABLE and have it always take a timeout option
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

I agree that having 2 flush-able L2CAP channels to the same device would
probably not be common. But who knows what new profiles the Bluetooth SIG
will come up with that might also benefit from flush-able ACL data. And if a
use-case comes up, then your proposed API will require programmers to write
a racy getsockopt/setsockopt if they want to turn on flushing on one l2cap
connection without affecting the ACL flush timeout set by another
connection. Building race conditions into an API seems like a sub-optimal
design choice.

But its not worth arguing over. SOL_BLUETOOTH, BT_FLUSHABLE is fine (or
BT_FLUSH_TIMEOUT instead).

I won't be doing development for a few weeks over the holidays, so I can not
update this patch for a while.

Nick

--000e0cd70e0c52d42f047b09b742
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Dec 18, 2009 at 3:50 PM, Marcel =
Holtmann <span dir=3D"ltr">&lt;<a href=3D"mailto:marcel@holtmann.org">marce=
l@holtmann.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">

<div><div></div><div class=3D"h5">Hi Nick,<br>
<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt; &gt;&gt; Right now Bluez always requests f=
lushable ACL packets (but does not<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt; &gt;&gt; set a flush timeout, so effective=
ly they are non-flushable):<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt; &gt;&gt; However it is desirable to use an=
 ACL flush timeout on A2DP packets so<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt; &gt;&gt; that if the ACL packets block for=
 some reason then the LM can flush<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt; &gt;&gt; them to make room for newer packe=
ts.<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt; &gt;&gt; Is it reasonable for Bluez to use=
 the 0x00 ACL packet boundary flag by<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt; &gt;&gt; default (non-flushable packet), a=
nd let userspace request flushable<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt; &gt;&gt; packets on A2DP L2CAP sockets wit=
h the socket option<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt; &gt;&gt; L2CAP_LM_RELIABLE.<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt; &gt; the reliable option has a different m=
eaning. It comes back from the old<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt; &gt; Bluetooth 1.1 qualification days wher=
e we had to tests on L2CAP that had<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt; &gt; to confirm that we can detect malform=
ed packets and report them. These<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt; &gt; days it is just fine to drop them.<br=
>
&gt; &gt; &gt; &gt;&gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt; Got it, how about introducing<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt; #define L2CAP_LM_FLUSHABLE 0x0040<br>
&gt; &gt; &gt; &gt;&gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt; &gt; that l2cap_sock_setsockopt_old() sets this did=
n&#39;t give you a hint that<br>
&gt; &gt; &gt; &gt;&gt; &gt; we might wanna deprecate this socket options ;=
)<br>
&gt; &gt; &gt; &gt;&gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt; &gt; I need to read up on the flushable stuff, but =
in the end it deserves its<br>
&gt; &gt; &gt; &gt;&gt; &gt; own socket option. Also an ioctl() to actually=
 trigger Enhanced flush<br>
&gt; &gt; &gt; &gt;&gt; &gt; might be needed.<br>
&gt; &gt; &gt; &gt;&gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt; struct l2cap_pinfo {<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt; =A0 =A0...<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt; =A0 =A0__u8 flushable;<br>
&gt; &gt; &gt; &gt;&gt; &gt;&gt; }<br>
&gt; &gt; &gt; &gt;&gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt; &gt; Sure. In the long run we need to turn this int=
o a bitmask. We are just<br>
&gt; &gt; &gt; &gt;&gt; &gt; wasting memory here.<br>
&gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt; Attached is an updated patch, that checks the LMP f=
eatures bitmask<br>
&gt; &gt; &gt; &gt;&gt; before using the new non-flushable packet type.<br>
&gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt; I am still using L2CAP_LM_FLUSHABLE socket option i=
n<br>
&gt; &gt; &gt; &gt;&gt; l2cap_sock_setsockopt_old(), which I don&#39;t thin=
k you are happy with.<br>
&gt; &gt; &gt; &gt;&gt; So how about a new option:<br>
&gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt; SOL_L2CAP, L2CAP_ACL_FLUSH<br>
&gt; &gt; &gt; &gt;&gt; which has a default value of 0, and can be set to 1=
 to make the ACL<br>
&gt; &gt; &gt; &gt;&gt; data sent by this L2CAP socket flushable.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Was this proposal ok?<br>
&gt; &gt;<br>
&gt; &gt; Even SOL_L2CAP goes away. Use SOL_BLUETOOTH for this.<br>
&gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt; In a later commit we would then add<br>
&gt; &gt; &gt; &gt;&gt; SOL_ACL, ACL_FLUSH_TIMEOUT<br>
&gt; &gt; &gt; &gt;&gt; That is used to set an automatic flush timeout for =
the ACL link on a<br>
&gt; &gt; &gt; &gt;&gt; L2CAP socket. Note that SOL_ACL is new.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; can I stop you right here (without even looking at the =
patch). We do<br>
&gt; &gt; &gt; &gt; have the generic SOL_BLUETOOTH that you should be using=
. So adding<br>
&gt; &gt; &gt; &gt; SOL_ACL is not a viable option at all.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This would be in a later patch, and SOL_BLUETOOTH, ACL_FLUSH=
_TIMEOUT<br>
&gt; &gt; &gt; is fine too, or whatever you prefer.<br>
&gt; &gt;<br>
&gt; &gt; Why not just use BT_FLUSHABLE and have it always take a timeout o=
ption<br>
&gt; &gt; and then 0 means not flushable. And advantage of having it separa=
ted?<br>
&gt;<br>
&gt; I think keeping them separate makes it clear that the flush timeout is=
<br>
&gt; global for a given ACL link, whereas the flushable/non-flushable<br>
&gt; boolean is specific to a L2CAP channel. (Which is why I suggested<br>
&gt; introducing a new level SOL_ACL for the ACL_FLUSH_TIMEOUT option -<br>
&gt; since this option applies at the ACL level in the stack).<br>
&gt;<br>
&gt; A specific advantage of this is that flushable packets can be enabled<=
br>
&gt; without over-writing a previous flush timeout that was set on a<br>
&gt; different L2CAP socket on the same ACL link. I guess this can also be<=
br>
&gt; achieved with getsockopt() but that is racy.<br>
<br>
</div></div>I am talking here about Enhanced Flush support and that would h=
appen on<br>
a per ACL handle basis. So it actually almost applies on a per L2CAP<br>
socket level. Only exception is if you establish two or more L2CAP<br>
connections to the same remote device and set them all to flushable.<br>
Then of course all of them will be flushed. So strictly speaking it<br>
might be an ACL link feature, but we don&#39;t wanna use it that way. And i=
n<br>
practice you won&#39;t have multiple concurrent flushable L2CAP connections=
<br>
to one remote device anyway.<br></blockquote><div><br></div><div>I agree th=
at having 2=A0flush-able=A0L2CAP channels to the same device would probably=
 not be common. But who knows what new profiles the Bluetooth SIG will come=
 up with that might also benefit from=A0flush-able=A0ACL data. And if a use=
-case comes up, then your proposed API will require programmers to write a =
racy getsockopt/setsockopt if they want to=A0turn on flushing on one l2cap =
connection without affecting the ACL flush timeout set by another connectio=
n. Building race conditions into an API seems like a sub-optimal design cho=
ice.</div>

<div><br></div><div>But its not worth arguing over.=A0SOL_BLUETOOTH, BT_FLU=
SHABLE is fine (or BT_FLUSH_TIMEOUT instead).</div><div><br></div><div>I wo=
n&#39;t be doing development for a few weeks over the holidays, so I can no=
t update this patch for a while.</div>

<div><br></div><div>Nick</div></div>

--000e0cd70e0c52d42f047b09b742--
