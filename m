Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <35c90d960908061103q4cba696dr89d21e4a14a9470c@mail.gmail.com>
References: <35c90d960905191820g4e3ee434hfd0060815540a4e0@mail.gmail.com>
	<1242787757.3147.13.camel@localhost.localdomain> <35c90d960905201457i508c678fqeb696cce32ae63be@mail.gmail.com>
	<35c90d960907061155t7349cc90p2e58a09a310b8926@mail.gmail.com>
	<35c90d960907091237o72228b0v57ad2556d77f4857@mail.gmail.com>
	<35c90d960907130846v2320de88pd6f34b8aabfdbb9e@mail.gmail.com>
	<2d5a2c100907131427x18f26f82g405a781cd8670b88@mail.gmail.com>
	<35c90d960907140915u71f20473x83b25579c4117a2d@mail.gmail.com>
	<35c90d960907151511u3a49f1d3obea010371a031cd2@mail.gmail.com>
	<35c90d960908061103q4cba696dr89d21e4a14a9470c@mail.gmail.com>
From: Nick Pelly <npelly@google.com>
Date: Tue, 2 Feb 2010 17:54:40 -0800
Message-ID: <35c90d961002021754w30de7c3bte703adafbbfabb57@mail.gmail.com>
Subject: Re: bug? kernel does not send HCI Create Connection Cancel Command on
	shutdown() or close() of a connecting rfcomm socket
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=0016364999ab8f7638047ea8819f
List-ID: <linux-bluetooth.vger.kernel.org>

--0016364999ab8f7638047ea8819f
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Aug 6, 2009 at 10:03 AM, Nick Pelly <npelly@google.com> wrote:

> On Wed, Jul 15, 2009 at 3:11 PM, Nick Pelly<npelly@google.com> wrote:
> > On Tue, Jul 14, 2009 at 9:15 AM, Nick Pelly<npelly@google.com> wrote:
> >> On Mon, Jul 13, 2009 at 2:27 PM, Luiz Augusto von
> >> Dentz<luiz.dentz@gmail.com> wrote:
> >>> Hi Nick,
> >>>
> >>> On Mon, Jul 13, 2009 at 12:46 PM, Nick Pelly<npelly@google.com> wrote:
> >>>> Any comments on this patch?
> >>>>
> >>>> It works for me, but my understanding of the RFCOMM state machine is
> naive.
> >>>>
> >>>
> >>> iirc BT_CONFIG(PN frame) means the DLC is being configured than we got
> >>> into connecting phase (BT_CONNECT) and send SABM frame. Only when
> >>> receiving UA frame DLC is consider connected (BT_CONNECTED), so your
> >>> patch seems good by assuming that we don't need to send a DISC for a
> >>> DLC not connected. But there is still a good use for it to cancel the
> >>> DLC connection attempt, so perhaps a better alternative would be to
> >>> use a much shorter timeout in those cases.
> >>
> >> Thanks for the advice.
> >>
> >> I have prepared a new patch which uses a very short timeout (10ms) on
> >> the DLC disconnect when in BT_CONFIG. I have tested this patch and it
> >> also resolves the issue. Patch attached.
> >
> > ping
> >
> > I will be offline for 2 weeks from tomorrow, so if there is further
> > testing or patches you would like me to try then I won't be able to
> > help after tomorrow.
>
> ping.
>
> Looking for 'yes this is ok, patch merged'
>
> or
>
> 'no this is not ok, because....'


Ping.

we've been running with this patch a while now.

Nick

--0016364999ab8f7638047ea8819f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2009 at 10:03 AM, Nick Pelly <span dir=3D"ltr">&lt;<a href=
=3D"mailto:npelly@google.com">npelly@google.com</a>&gt;</span> wrote:<br><d=
iv class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">

<div><div></div><div class=3D"h5">On Wed, Jul 15, 2009 at 3:11 PM, Nick Pel=
ly&lt;<a href=3D"mailto:npelly@google.com">npelly@google.com</a>&gt; wrote:=
<br>
&gt; On Tue, Jul 14, 2009 at 9:15 AM, Nick Pelly&lt;<a href=3D"mailto:npell=
y@google.com">npelly@google.com</a>&gt; wrote:<br>
&gt;&gt; On Mon, Jul 13, 2009 at 2:27 PM, Luiz Augusto von<br>
&gt;&gt; Dentz&lt;<a href=3D"mailto:luiz.dentz@gmail.com">luiz.dentz@gmail.=
com</a>&gt; wrote:<br>
&gt;&gt;&gt; Hi Nick,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Mon, Jul 13, 2009 at 12:46 PM, Nick Pelly&lt;<a href=3D"mai=
lto:npelly@google.com">npelly@google.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt; Any comments on this patch?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; It works for me, but my understanding of the RFCOMM state =
machine is naive.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; iirc BT_CONFIG(PN frame) means the DLC is being configured tha=
n we got<br>
&gt;&gt;&gt; into connecting phase (BT_CONNECT) and send SABM frame. Only w=
hen<br>
&gt;&gt;&gt; receiving UA frame DLC is consider connected (BT_CONNECTED), s=
o your<br>
&gt;&gt;&gt; patch seems good by assuming that we don&#39;t need to send a =
DISC for a<br>
&gt;&gt;&gt; DLC not connected. But there is still a good use for it to can=
cel the<br>
&gt;&gt;&gt; DLC connection attempt, so perhaps a better alternative would =
be to<br>
&gt;&gt;&gt; use a much shorter timeout in those cases.<br>
&gt;&gt;<br>
&gt;&gt; Thanks for the advice.<br>
&gt;&gt;<br>
&gt;&gt; I have prepared a new patch which uses a very short timeout (10ms)=
 on<br>
&gt;&gt; the DLC disconnect when in BT_CONFIG. I have tested this patch and=
 it<br>
&gt;&gt; also resolves the issue. Patch attached.<br>
&gt;<br>
&gt; ping<br>
&gt;<br>
&gt; I will be offline for 2 weeks from tomorrow, so if there is further<br=
>
&gt; testing or patches you would like me to try then I won&#39;t be able t=
o<br>
&gt; help after tomorrow.<br>
<br>
</div></div>ping.<br>
<br>
Looking for &#39;yes this is ok, patch merged&#39;<br>
<br>
or<br>
<br>
&#39;no this is not ok, because....&#39;</blockquote><div><br></div><div>Pi=
ng.</div><div><br></div><div>we&#39;ve been running with this patch a while=
 now.</div><div><br></div><div>Nick=A0</div></div>

--0016364999ab8f7638047ea8819f--
