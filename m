Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1260335175.2901.20.camel@violet>
References: <35c90d960912081950t135e3f10m8848e54fde1e596f@mail.gmail.com>
	<1260335175.2901.20.camel@violet>
From: Nick Pelly <npelly@google.com>
Date: Tue, 8 Dec 2009 21:26:38 -0800
Message-ID: <35c90d960912082126q23ddf2b3j6a7712d78d94ef67@mail.gmail.com>
Subject: Re: RFC: Allow Bluez to select flushable or non-flushable ACL packets
	with L2CAP_LM_RELIABLE
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=000e0cd59f887fdcb0047a44f058
List-ID: <linux-bluetooth.vger.kernel.org>

--000e0cd59f887fdcb0047a44f058
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Dec 8, 2009 at 9:06 PM, Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Nick,
>
> > Right now Bluez always requests flushable ACL packets (but does not
> > set a flush timeout, so effectively they are non-flushable):
> >
> > However it is desirable to use an ACL flush timeout on A2DP packets so
> > that if the ACL packets block for some reason then the LM can flush
> > them to make room for newer packets.
> >
> > Is it reasonable for Bluez to use the 0x00 ACL packet boundary flag by
> > default (non-flushable packet), and let userspace request flushable
> > packets on A2DP L2CAP sockets with the socket option
> > L2CAP_LM_RELIABLE.
>
> the reliable option has a different meaning. It comes back from the old
> Bluetooth 1.1 qualification days where we had to tests on L2CAP that had
> to confirm that we can detect malformed packets and report them. These
> days it is just fine to drop them.
>

Ok, how about introducing

#define L2CAP_LM_FLUSHABLE 0x0040

struct l2cap_pinfo {
   ...
   __u8 flushable;
}


> You can not just blindly use ACL_START_FLUSHABLE without proper version
> checking. This feature has been introduced later and will not work with
> all stacks out there. Please go through the different spec. versions to
> see the difference.
>

Will do.

Nick

--000e0cd59f887fdcb0047a44f058
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 8, 2009 at 9:06 PM, Marcel Holtmann <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:marcel@holtmann.org" target=3D"_blank">marcel@holtmann.org</a>=
&gt;</span> wrote:<br><div class=3D"gmail_quote"><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">


Hi Nick,<br>
<div><br>
&gt; Right now Bluez always requests flushable ACL packets (but does not<br=
>
&gt; set a flush timeout, so effectively they are non-flushable):<br>
&gt;<br>
&gt; However it is desirable to use an ACL flush timeout on A2DP packets so=
<br>
&gt; that if the ACL packets block for some reason then the LM can flush<br=
>
&gt; them to make room for newer packets.<br>
&gt;<br>
&gt; Is it reasonable for Bluez to use the 0x00 ACL packet boundary flag by=
<br>
&gt; default (non-flushable packet), and let userspace request flushable<br=
>
&gt; packets on A2DP L2CAP sockets with the socket option<br>
&gt; L2CAP_LM_RELIABLE.<br>
<br>
</div>the reliable option has a different meaning. It comes back from the o=
ld<br>
Bluetooth 1.1 qualification days where we had to tests on L2CAP that had<br=
>
to confirm that we can detect malformed packets and report them. These<br>
days it is just fine to drop them.<br></blockquote><div><br></div><div>Ok, =
how about introducing</div><div><br></div><div>#define L2CAP_LM_FLUSHABLE 0=
x0040</div><div><br></div><div>struct l2cap_pinfo {</div><div>=A0=A0 ...</d=
iv>


<div>=A0=A0 __u8 flushable;</div><div>}</div><div><br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
<br>
You can not just blindly use ACL_START_FLUSHABLE without proper version<br>
checking. This feature has been introduced later and will not work with<br>
all stacks out there. Please go through the different spec. versions to<br>
see the difference.<br></blockquote><div><br></div><div>Will do.</div><div>=
=A0</div><div>Nick</div></div><br>

--000e0cd59f887fdcb0047a44f058--
