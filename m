Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20091223164841.7070e75d@strolchi.home.s3e.de>
References: <1260906227.4b27e6f39cc7c@www.fastmail.com.br>
	 <4B2A4B90.1040009@videam.com.br> <4B2BBF58.4030901@videam.com.br>
	 <1261173899.4041.96.camel@localhost.localdomain>
	 <1261176544.4b2c06e0e0eae@www.fastmail.com.br>
	 <1261177111.4041.99.camel@localhost.localdomain>
	 <20091223164841.7070e75d@strolchi.home.s3e.de>
Date: Wed, 23 Dec 2009 21:30:27 +0530
Message-ID: <53ea87da0912230800o25ac14bdv6bab60b22806dc36@mail.gmail.com>
Subject: Re: Long delay to (re)connect a bluetooth mouse
From: venu <vjosyula@gmail.com>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	"Daniel T. Cobra" <dcobra@videam.com.br>
Content-Type: multipart/alternative; boundary=0016e64b0ab0ce6cd0047b676bea
List-ID: <linux-bluetooth.vger.kernel.org>

--0016e64b0ab0ce6cd0047b676bea
Content-Type: text/plain; charset=ISO-8859-1

Hi Stefan,

Here is what happens with mouse,

1. When you use the mouse, they are in active mode, and after that they go
to sniff mode.
2. Now if continue not using mouse eventually it will disconnect (when it
disconnects depends on the sniff Interval, and sniff timeout).
3. When the mouse transitions to Sniff Mode from Active mode one would see
Mode change event along with Sniff Parameters which i told you about.
4. Now only after disconnect will you observe that the hid reconnects.

Please read section 8.7 in baseband specification of Bluetooth specs which
will throw more light into question which you are posing i.e. if you have
access to it.

Or else I can share it with you.

Cheers,
Venu

On Wed, Dec 23, 2009 at 9:18 PM, Stefan Seyfried <
stefan.seyfried@googlemail.com> wrote:

> On Fri, 18 Dec 2009 14:58:31 -0800
> Marcel Holtmann <marcel@holtmann.org> wrote:
>
> > even if I use Bluetooth on a daily basis, I don't use any mouse or
> > keyboard devices anymore. So I have no idea on how many people are
> > actually using these.
>
> I'm still using it occasionally at home (when not sitting on the sofa
> with my notebook ;) and for the last few years they worked fine
> (actually since we worked out the reconnect problem of the
> Logitech mx1000, which looked similar, but probably was not).
>
> My collection of two bluetooth mice still work fine and reconnect
> quickly IIRC, but I will check this evening.
>
> David, "every time I bring the mouse out of sleep mode", does this mean
> the mouse went to sleep, you click the button (or move the mouse) and
> it takes 5 seconds to reconnect? If so, could you try if it makes a
> difference if you switch off the mouse instead? (wait until it falls
> asleep, then switch off and on and check if it reconnects faster. Might
> not be easy if this is a mouse that wakes up on movement, then you
> probably need to lay it upside down until it sleeps).
>
> > wouldn't be of much help until I am back at home and have my device
> > library at my disposal (and bought new batteries).
>
> I can recommend eneloop rechargeables for BT HID devices ;)
> --
> Stefan Seyfried
>
> "Any ideas, John?"
> "Well, surrounding them's out."
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
- J. Venumadhav

--0016e64b0ab0ce6cd0047b676bea
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Stefan,<div><br></div><div>Here is what happens with mouse,</div><div><b=
r></div><div>1. When you use the mouse, they are in active mode, and after =
that they go to sniff mode.</div><div>2. Now if continue not using mouse ev=
entually it will disconnect (when it disconnects depends on the sniff Inter=
val, and sniff timeout).</div>
<div>3. When the mouse transitions to Sniff Mode from Active mode one would=
 see Mode change event along with Sniff Parameters which i told you about.<=
/div><div>4. Now only after disconnect will you observe that the hid reconn=
ects.</div>
<div><br></div><div>Please read section 8.7 in baseband specification of Bl=
uetooth specs which will throw more light into question which you are posin=
g i.e. if you have access to it.</div><div><br></div><div>Or else I can sha=
re it with you.</div>
<div><br></div><div>Cheers,</div><div>Venu<br><br><div class=3D"gmail_quote=
">On Wed, Dec 23, 2009 at 9:18 PM, Stefan Seyfried <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:stefan.seyfried@googlemail.com">stefan.seyfried@googlemail.=
com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On Fri, 18 Dec 2009 14:58=
:31 -0800<br>
Marcel Holtmann &lt;<a href=3D"mailto:marcel@holtmann.org">marcel@holtmann.=
org</a>&gt; wrote:<br><br>
&gt; even if I use Bluetooth on a daily basis, I don&#39;t use any mouse or=
<br>
&gt; keyboard devices anymore. So I have no idea on how many people are<br>
&gt; actually using these.<br>
<br>
</div>I&#39;m still using it occasionally at home (when not sitting on the =
sofa<br>
with my notebook ;) and for the last few years they worked fine<br>
(actually since we worked out the reconnect problem of the<br>
Logitech mx1000, which looked similar, but probably was not).<br>
<br>
My collection of two bluetooth mice still work fine and reconnect<br>
quickly IIRC, but I will check this evening.<br>
<br>
David, &quot;every time I bring the mouse out of sleep mode&quot;, does thi=
s mean<br>
the mouse went to sleep, you click the button (or move the mouse) and<br>
it takes 5 seconds to reconnect? If so, could you try if it makes a<br>
difference if you switch off the mouse instead? (wait until it falls<br>
asleep, then switch off and on and check if it reconnects faster. Might<br>
not be easy if this is a mouse that wakes up on movement, then you<br>
probably need to lay it upside down until it sleeps).<br>
<div class=3D"im"><br>
&gt; wouldn&#39;t be of much help until I am back at home and have my devic=
e<br>
&gt; library at my disposal (and bought new batteries).<br>
<br>
</div>I can recommend eneloop rechargeables for BT HID devices ;)<br>
<font color=3D"#888888">--<br>
Stefan Seyfried<br>
<br>
&quot;Any ideas, John?&quot;<br>
&quot;Well, surrounding them&#39;s out.&quot;<br>
</font><div><div></div><div class=3D"h5">--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-blueto=
oth&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>- J. Venuma=
dhav<br>
</div>

--0016e64b0ab0ce6cd0047b676bea--
