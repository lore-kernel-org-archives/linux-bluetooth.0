Return-Path: <jerome.debretagne@gmail.com>
MIME-Version: 1.0
In-Reply-To: <7D06FCA8-A64C-4437-BEE2-5BA0D1C2F030@holtmann.org>
References: <CA+kEDGFm2jko+bC+DuPK1qQx5OXJZTXUj=aWdk+rm9RC8DDCOA@mail.gmail.com>
 <72B34103-D15B-463B-B63B-8DD3CE99D712@holtmann.org> <1473111620.4063.29.camel@gmail.com>
 <7D06FCA8-A64C-4437-BEE2-5BA0D1C2F030@holtmann.org>
From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>
Date: Tue, 6 Sep 2016 23:35:21 +0200
Message-ID: <CA+kEDGHGKwb3EX2Tt0E_inmz5bFa9tKe0o9BZOJxsdzHQs7aNQ@mail.gmail.com>
Subject: Re: btattach: auto triggering at boot time by Linux distributions
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a11446b90f271b1053bdd92f2
List-ID: <linux-bluetooth.vger.kernel.org>

--001a11446b90f271b1053bdd92f2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> >> the real evolution would be that we get a serial bus (as discussed a
> >> few weeks ago) which then the UART kernel drivers can enumerate its
> >> devices on.
> >
> > If I understood correctly, you would like to stop exposing /dev/ttyX
> > for Bluetooth UART drivers in the long run. Would it mean that the
> > user-space btattach will then be deprecated and the firmware loading
> > will be moved into the kernel itself? Or another approach instead?
>
> firmware loading is already in the kernel. At least for Broadcom and
> Intel based devices.

I wanted to mean: moving the firmware loading *triggering* all in kernel,
with the future UART device enumeration. Or do you still see a benefit to
keep the "attach" step in user space, to cover some specific use cases
maybe?

I'll keep following the serial bus discussions, this is a every interesting
evolution.

Thanks again,
J=C3=A9r=C3=B4me

--001a11446b90f271b1053bdd92f2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Hi Marcel,</p>
<p dir=3D"ltr">&gt; &gt;&gt; the real evolution would be that we get a seri=
al bus (as discussed a<br>
&gt; &gt;&gt; few weeks ago) which then the UART kernel drivers can enumera=
te its<br>
&gt; &gt;&gt; devices on.<br>
&gt; &gt;<br>
&gt; &gt; If I understood correctly, you would like to stop exposing /dev/t=
tyX<br>
&gt; &gt; for Bluetooth UART drivers in the long run. Would it mean that th=
e<br>
&gt; &gt; user-space btattach will then be deprecated and the firmware load=
ing<br>
&gt; &gt; will be moved into the kernel itself? Or another approach instead=
?<br>
&gt;<br>
&gt; firmware loading is already in the kernel. At least for Broadcom and<b=
r>
&gt; Intel based devices.</p>
<p dir=3D"ltr">I wanted to mean: moving the firmware loading *triggering* a=
ll in kernel, with the future UART device enumeration. Or do you still see =
a benefit to keep the &quot;attach&quot; step in user space, to cover some =
specific use cases maybe?</p>
<p dir=3D"ltr">I&#39;ll keep following the serial bus discussions, this is =
a every interesting evolution.</p>
<p dir=3D"ltr">Thanks again,<br>
J=C3=A9r=C3=B4me<br>
</p>

--001a11446b90f271b1053bdd92f2--
