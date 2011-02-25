Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=HvRTfo84L_VwOVtVq5hfb1g+9ueH6SX8FWF2b@mail.gmail.com>
References: <1292584829-28279-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
	<201101061946.04790.arnd@arndb.de>
	<AANLkTikJMx2QxYwXS_TrKK5hcnD3G0MNvEiDO+xAZrpo@mail.gmail.com>
	<201101091955.05174.arnd@arndb.de>
	<AFCDDB4A3EA003429EEF1E7B211FDBBA334C0FB0E2@EXDCVYMBSTM005.EQ1STM.local>
	<AANLkTi=HvRTfo84L_VwOVtVq5hfb1g+9ueH6SX8FWF2b@mail.gmail.com>
Date: Fri, 25 Feb 2011 18:55:03 +0100
Message-ID: <AANLkTik3hiNj7=K+uE6eQW2CokZtCz7Zwvt-+6PkD_Mo@mail.gmail.com>
Subject: Re: [PATCH 00/11] mfd and bluetooth: Add CG2900 suppor
From: Vitaly Wool <vitalywool@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Par-Gunnar HJALMDAHL <par-gunnar.p.hjalmdahl@stericsson.com>,
	Samuel Ortiz <sameo@linux.intel.com>, Marcel Holtmann <marcel@holtmann.org>,
	Lee Jones <lee.jones@linaro.org>, Par-Gunnar Hjalmdahl <pghatwork@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>, Pavan Savoy <pavan_savoy@sify.com>
Content-Type: multipart/alternative; boundary=bcaec53f8f0d950b6e049d1f0773
List-ID: <linux-bluetooth.vger.kernel.org>

--bcaec53f8f0d950b6e049d1f0773
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry to say, but I have to disagree. This patchset represents
overcomplicated and unclear model, which may be misleading for developers
implementing similar solution for another platform.

Making hardware work is, if course, a valid point, but porting a windows
driver would do that as well, and it's not the reason to pull windows
drivers' ports into mainline.

Thanks,
   Vitaly
Den 25 feb 2011 18:08 skrev "Linus Walleij" <linus.walleij@linaro.org>:
> 2011/2/24 Par-Gunnar HJALMDAHL <par-gunnar.p.hjalmdahl@stericsson.com>:
>
>> I sent the mail below one month ago, but have still not received any
answers or further comments.
>> Has anyone of you who made comments on the CG2900 patches earlier, any
more comments or questions?
>
> I think I have provided
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> (or the earlier ST-Ericsson address, which is equal) for these patches.
> Else I do so now.
>
> FWIW: I think those who want another architectural solution
> can propose a refactoring patch any day they like, and if it's
> recieved like "ah, that's better" ACK from P=E4r-Gunnar et al, then
> it's no big deal.
>
> This makes the hardware work with 2.6.39 which is really most
> important IMO, Sam can you merge this as it stands?
>
> Yours,
> Linus Walleij

--bcaec53f8f0d950b6e049d1f0773
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Hi,</p>
<p>Sorry to say, but I have to disagree. This patchset represents overcompl=
icated and unclear model, which may be misleading for developers implementi=
ng similar solution for another platform. </p>
<p>Making hardware work is, if course, a valid point, but porting a windows=
 driver would do that as well, and it&#39;s not the reason to pull windows =
drivers&#39; ports into mainline.</p>
<p>Thanks,<br>
=A0=A0 Vitaly</p>
<div class=3D"gmail_quote">Den 25 feb 2011 18:08 skrev &quot;Linus Walleij&=
quot; &lt;<a href=3D"mailto:linus.walleij@linaro.org">linus.walleij@linaro.=
org</a>&gt;:<br type=3D"attribution">&gt; 2011/2/24 Par-Gunnar HJALMDAHL &l=
t;<a href=3D"mailto:par-gunnar.p.hjalmdahl@stericsson.com">par-gunnar.p.hja=
lmdahl@stericsson.com</a>&gt;:<br>
&gt; <br>&gt;&gt; I sent the mail below one month ago, but have still not r=
eceived any answers or further comments.<br>&gt;&gt; Has anyone of you who =
made comments on the CG2900 patches earlier, any more comments or questions=
?<br>
&gt; <br>&gt; I think I have provided<br>&gt; Acked-by: Linus Walleij &lt;<=
a href=3D"mailto:linus.walleij@linaro.org">linus.walleij@linaro.org</a>&gt;=
<br>&gt; (or the earlier ST-Ericsson address, which is equal) for these pat=
ches.<br>
&gt; Else I do so now.<br>&gt; <br>&gt; FWIW: I think those who want anothe=
r architectural solution<br>&gt; can propose a refactoring patch any day th=
ey like, and if it&#39;s<br>&gt; recieved like &quot;ah, that&#39;s better&=
quot; ACK from P=E4r-Gunnar et al, then<br>
&gt; it&#39;s no big deal.<br>&gt; <br>&gt; This makes the hardware work wi=
th 2.6.39 which is really most<br>&gt; important IMO, Sam can you merge thi=
s as it stands?<br>&gt; <br>&gt; Yours,<br>&gt; Linus Walleij<br></div>

--bcaec53f8f0d950b6e049d1f0773--
