Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANq1E4ReR544EGPGVV++dH4eWsEL1Hu0rS3v2QDmZHv_fqnJ1w@mail.gmail.com>
References: <1327448862-21964-1-git-send-email-scott@netsplit.com>
	<1327952977.1955.160.camel@aeonflux>
	<1327953929.2400.80.camel@novo.hadess.net>
	<CA+bD78jkORzLP-M+bGqFMkp9vHmBXW+LgLnFGhLczn92Rk2XXA@mail.gmail.com>
	<1327962821.2125.4.camel@sirocco.config>
	<CA+bD78hQcBm5-94RHNSPXUsM1kAD8pYJ5Yu=-jPv8T=iedr6bA@mail.gmail.com>
	<1327964619.2125.14.camel@sirocco.config>
	<CA+bD78hTvaf92zy0t2xSMO2uoM+xL73XopxrvGbR5uW+6Uc3pw@mail.gmail.com>
	<CANq1E4ReR544EGPGVV++dH4eWsEL1Hu0rS3v2QDmZHv_fqnJ1w@mail.gmail.com>
Date: Wed, 15 Feb 2012 11:18:06 -0800
Message-ID: <CA+bD78jdW8MRLUyUooBPt=F++w-M=2dMDExqg6pH1EqrhE13UA@mail.gmail.com>
Subject: Re: [RFC PATCHv2] autopair: add autopair plugin
From: Scott James Remnant <scott@netsplit.com>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Bastien Nocera <hadess@hadess.net>, Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Content-Type: multipart/alternative; boundary=f46d0408d67341af1904b90592b8
List-ID: <linux-bluetooth.vger.kernel.org>

--f46d0408d67341af1904b90592b8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

No update just yet,

Project cycles what they are, the rough first draft of this plugin is
sufficient for our testing needs right now, and I'm working on the rough
first draft of the integration with the rest of the system.

I'll be coming back to clean this up in a few weeks :) if you want to do
any work on it in the mean time, please do, multiple people working on a
patch is always a good thing!

Scott

On Wed, Feb 15, 2012 at 9:57 AM, David Herrmann
<dh.herrmann@googlemail.com>wrote:

> Hi Scott
>
> On Tue, Jan 31, 2012 at 12:10 AM, Scott James Remnant
> <scott@netsplit.com> wrote:
> > On Mon, Jan 30, 2012 at 3:03 PM, Bastien Nocera <hadess@hadess.net>
> wrote:
> >> Em Mon, 2012-01-30 =E0s 14:35 -0800, Scott James Remnant escreveu:
> >>> On Mon, Jan 30, 2012 at 2:33 PM, Bastien Nocera <hadess@hadess.net>
> wrote:
> >>> > Em Mon, 2012-01-30 =E0s 13:42 -0800, Scott James Remnant escreveu:
> >>> >> > The PIN length hint is also ignored in the current code:
> >>> >> > +       <device type=3D"audio" oui=3D"00:1A:80:" name=3D"CMT-DH5=
BT"
> >>> >> pin=3D"max:4"/>
> >>> >> >
> >>> >> Because that's a UI restriction, no?
> >>> >>
> >>> >> I didn't put any PIN-generation code here, because I'm not entirel=
y
> >>> >> sure what the UI for "generate random PIN' should look like or whi=
ch
> >>> >> spec you're following.
> >>> >
> >>> > It means that a generated PIN shouldn't have more than 4 digits for
> it
> >>> > to work with this device.
> >>> >
> >>> What generated PIN? Which spec/profile says you have to generate a PI=
N
> >>> for this device?
> >>
> >> It's recommended that the UIs try to generate PINs for the users, rath=
er
> >> than relying on them entering random numbers.
> >>
> > Recommended where? Can you point at least at the correct document?
> >
> > The only recommendation I'm aware of is in the HID profile, which
> > would not apply here, and strangely you don't use this max: form for
> > keyboards which would be the only devices they applied to.
> >
> >
> > The description matches the HID profile behavior I've sumitted as a
> > separate set of CLs.
> >
>
> Any update on this plugin? It would make the wiimote plugin obsolete
> and allow us to select PINs based on device-names.
>
> If you do not intend to continue your work here I will try fixing the
> stuff and resubmit it.
>
> Regards
> David
>



--=20
Have you ever, ever felt like this?
Had strange things happen?  Are you going round the twist?

--f46d0408d67341af1904b90592b8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

No update just yet,<div><br></div><div>Project cycles what they are, the ro=
ugh first draft of this plugin is sufficient for our testing needs right no=
w, and I&#39;m working on the rough first draft of the integration with the=
 rest of the system.</div>
<div><br></div><div>I&#39;ll be coming back to clean this up in a few weeks=
 :) if you want to do any work on it in the mean time, please do, multiple =
people working on a patch is always a good thing!</div><div><br></div><div>
Scott<br><br><div class=3D"gmail_quote">On Wed, Feb 15, 2012 at 9:57 AM, Da=
vid Herrmann <span dir=3D"ltr">&lt;<a href=3D"mailto:dh.herrmann@googlemail=
.com">dh.herrmann@googlemail.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
Hi Scott<br>
<div><div class=3D"h5"><br>
On Tue, Jan 31, 2012 at 12:10 AM, Scott James Remnant<br>
&lt;<a href=3D"mailto:scott@netsplit.com">scott@netsplit.com</a>&gt; wrote:=
<br>
&gt; On Mon, Jan 30, 2012 at 3:03 PM, Bastien Nocera &lt;<a href=3D"mailto:=
hadess@hadess.net">hadess@hadess.net</a>&gt; wrote:<br>
&gt;&gt; Em Mon, 2012-01-30 =E0s 14:35 -0800, Scott James Remnant escreveu:=
<br>
&gt;&gt;&gt; On Mon, Jan 30, 2012 at 2:33 PM, Bastien Nocera &lt;<a href=3D=
"mailto:hadess@hadess.net">hadess@hadess.net</a>&gt; wrote:<br>
&gt;&gt;&gt; &gt; Em Mon, 2012-01-30 =E0s 13:42 -0800, Scott James Remnant =
escreveu:<br>
&gt;&gt;&gt; &gt;&gt; &gt; The PIN length hint is also ignored in the curre=
nt code:<br>
&gt;&gt;&gt; &gt;&gt; &gt; + =A0 =A0 =A0 &lt;device type=3D&quot;audio&quot=
; oui=3D&quot;00:1A:80:&quot; name=3D&quot;CMT-DH5BT&quot;<br>
&gt;&gt;&gt; &gt;&gt; pin=3D&quot;max:4&quot;/&gt;<br>
&gt;&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;&gt; Because that&#39;s a UI restriction, no?<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; I didn&#39;t put any PIN-generation code here, becaus=
e I&#39;m not entirely<br>
&gt;&gt;&gt; &gt;&gt; sure what the UI for &quot;generate random PIN&#39; s=
hould look like or which<br>
&gt;&gt;&gt; &gt;&gt; spec you&#39;re following.<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; It means that a generated PIN shouldn&#39;t have more tha=
n 4 digits for it<br>
&gt;&gt;&gt; &gt; to work with this device.<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; What generated PIN? Which spec/profile says you have to genera=
te a PIN<br>
&gt;&gt;&gt; for this device?<br>
&gt;&gt;<br>
&gt;&gt; It&#39;s recommended that the UIs try to generate PINs for the use=
rs, rather<br>
&gt;&gt; than relying on them entering random numbers.<br>
&gt;&gt;<br>
&gt; Recommended where? Can you point at least at the correct document?<br>
&gt;<br>
&gt; The only recommendation I&#39;m aware of is in the HID profile, which<=
br>
&gt; would not apply here, and strangely you don&#39;t use this max: form f=
or<br>
&gt; keyboards which would be the only devices they applied to.<br>
&gt;<br>
&gt;<br>
&gt; The description matches the HID profile behavior I&#39;ve sumitted as =
a<br>
&gt; separate set of CLs.<br>
&gt;<br>
<br>
</div></div>Any update on this plugin? It would make the wiimote plugin obs=
olete<br>
and allow us to select PINs based on device-names.<br>
<br>
If you do not intend to continue your work here I will try fixing the<br>
stuff and resubmit it.<br>
<br>
Regards<br>
<span class=3D"HOEnZb"><font color=3D"#888888">David<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div>Have you ever, ever felt like this?</div><div>Had strange things hap=
pen? =A0Are you going round the twist?</div><div><br></div><br>
</div>

--f46d0408d67341af1904b90592b8--
