Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3D02B219753AD44CBDDDE484323B1774112D143D@SHSMSX104.ccr.corp.intel.com>
References: <1405986034-29122-1-git-send-email-armansito@chromium.org>
	<20140722085507.GA29664@t440s.lan>
	<CAHrH25SR83cXq-xGQz4x7axjcW=CUL_VCcAfhny_RyZ+t0oZ-g@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112D121F@SHSMSX104.ccr.corp.intel.com>
	<CAHrH25RpdMCS=eizPUa5S-y0qBHyWQk6co1sJcwAQO9iC0xL=Q@mail.gmail.com>
	<D03CCCE3-51B5-4B3F-AB2D-AA9D766DCCCC@holtmann.org>
	<3D02B219753AD44CBDDDE484323B1774112D143D@SHSMSX104.ccr.corp.intel.com>
Date: Thu, 24 Jul 2014 10:58:48 +0300
Message-ID: <CABBYNZJb_UyNTkrO1qFTk2Uevv9UKnVWrU5rGy_-DPcKUWJY4w@mail.gmail.com>
Subject: Re: [RFC v1 0/1] doc/gatt-api: New API properties and methods for the
 GATT D-Bus API.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Gu, Chao Jie" <chao.jie.gu@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: multipart/alternative; boundary=001a11337ec8a9db9a04feebd37d
List-ID: <linux-bluetooth.vger.kernel.org>

--001a11337ec8a9db9a04feebd37d
Content-Type: text/plain; charset=UTF-8

Hi Arman,


On Thu, Jul 24, 2014 at 7:11 AM, Gu, Chao Jie <chao.jie.gu@intel.com> wrote:

> Hi Arman,
>
> > Explain to me how, using only the InterfacesAdded signal, an
> > application can know that all characteristic objects under a service
> > hierarchy have been added? The only way is if the external application
> > already knows about service it's interacting with, which is not the
> > case if you're building a generic application API on top of
> > bluetoothd. Without what I'm proposing, you can't build a generic GATT
> > application API without requiring cumbersome event handling for each
> > service, characteristic, and descriptor object as they get added and
> > have only partial access to these objects in the handlers as the
> > objects are getting processed. This might be fine for low-level
> > applications that interact with D-Bus directly, but for higher level
> > app developers this is a real issue that we want to handle properly
> > and make their lives easier.
>

Im just wondering why we did not use variant type instead of array of bytes
for value, imo it seems a better fit since it can be extended with
different types in host byte order.


> You are right, we work on Tizen Bluetooth-frwk which is low-level
> service/application in system . Bluetooth-frwk can take a role to handle
> D-Bus informaiton and give defined API to application such as
> characteristic discovery method, so we refer to different level application
> indeed.
> From your aspect, I understood that you consider that high level app
> developer how to get characteristic array directly from bluetoothd. .
>

>
Tizen has to follow BlueZ design, you can offer a C binding for it exposing
the exact same (or a subset) of the D-Bus API, anything other than that
will cause a maintenance burden in your end.

-- 
Luiz Augusto von Dentz

--001a11337ec8a9db9a04feebd37d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Arman,<div class=3D"gmail_extra"><br><br><div class=3D"=
gmail_quote">On Thu, Jul 24, 2014 at 7:11 AM, Gu, Chao Jie <span dir=3D"ltr=
">&lt;<a href=3D"mailto:chao.jie.gu@intel.com" target=3D"_blank">chao.jie.g=
u@intel.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">Hi Arman,<br>
<div class=3D""><br>
&gt; Explain to me how, using only the InterfacesAdded signal, an<br>
&gt; application can know that all characteristic objects under a service<b=
r>
&gt; hierarchy have been added? The only way is if the external application=
<br>
&gt; already knows about service it&#39;s interacting with, which is not th=
e<br>
&gt; case if you&#39;re building a generic application API on top of<br>
&gt; bluetoothd. Without what I&#39;m proposing, you can&#39;t build a gene=
ric GATT<br>
&gt; application API without requiring cumbersome event handling for each<b=
r>
&gt; service, characteristic, and descriptor object as they get added and<b=
r>
&gt; have only partial access to these objects in the handlers as the<br>
&gt; objects are getting processed. This might be fine for low-level<br>
&gt; applications that interact with D-Bus directly, but for higher level<b=
r>
&gt; app developers this is a real issue that we want to handle properly<br=
>
&gt; and make their lives easier.<br></div></blockquote><div>=C2=A0</div><d=
iv>Im just wondering why we did not use variant type instead of array of by=
tes for value, imo it seems a better fit since it can be extended with diff=
erent types in host byte order.<br>
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bo=
rder-left-style:solid;padding-left:1ex"><div class=3D"">
</div>You are right, we work on Tizen Bluetooth-frwk which is low-level ser=
vice/application in system . Bluetooth-frwk can take a role to handle D-Bus=
 informaiton and give defined API to application such as characteristic dis=
covery method, so we refer to different level application indeed.<br>

>From your aspect, I understood that you consider that high level app develo=
per how to get characteristic array directly from bluetoothd. .<br></blockq=
uote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:so=
lid;padding-left:1ex">
<div class=3D""><div class=3D"h5"><br>
</div></div></blockquote></div><br>Tizen has to follow BlueZ design, you ca=
n offer a C binding for it exposing the exact same (or a subset) of the D-B=
us API, anything other than that will cause a maintenance burden in your en=
d.=C2=A0<br clear=3D"all">
<div><br></div>-- <br>Luiz Augusto von Dentz
</div></div>

--001a11337ec8a9db9a04feebd37d--
