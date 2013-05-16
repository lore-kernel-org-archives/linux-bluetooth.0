Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130508074138.GA11502@x220>
References: <1360668097-28906-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <C4340FC6-1121-468E-B15D-68E2770AA07E@holtmann.org> <5135D965.8020604@tieto.com>
 <F00262C4-3552-438E-AF44-1D088CAB11A8@holtmann.org> <513703AA.2090206@tieto.com>
 <514021F5.1040005@tieto.com> <20130508074138.GA11502@x220>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Date: Thu, 16 May 2013 14:17:25 +0200
Message-ID: <CAHKzcENFNqJ3iyd1V7YBaE=7j5aUY8rkFUW8VdUz=oKiCfrUNg@mail.gmail.com>
Subject: Re: [RFC] bloodpressure: Add Blood Pressure API
To: Rymarkiewicz Waldemar <waldemar.rymarkiewicz@tieto.com>, Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/alternative; boundary=20cf301ee723cd3baf04dcd4dbe8
List-ID: <linux-bluetooth.vger.kernel.org>

--20cf301ee723cd3baf04dcd4dbe8
Content-Type: text/plain; charset=UTF-8

Hi Johan,

On 8 May 2013 09:41, Johan Hedberg <johan.hedberg@gmail.com> wrote:

> Are you still working on this? Seems this discussion was forgotten or
> just abandoned.
>

I've been focused on something else, but nice to see you are still
interested in.


> Apparently it was never a requirement to be able to enable/disable this
> an arbitrary amount of times during the watcher life time, and instead
> just leave it disabled or enabled until the watcher gets unregistered?
>
> Also, do you think there will be UIs that will refuse to work if a
> device does not support intermediate measurement or that any UI that is
> interested in intermediate measurement will forgive devices that do not
> support it and simply get on with working without it being enabled? If
> the latter ilds true then why not make an API which allows requesting
> "register watcher and enable intermediate measurement if it's
> supported". In such a case you wouldn't need a separate property and the
> registration would succeed even if intermediate measurement isn't
> supported. Thoughts?
>

Well, I believe any app will always be interested in getting intermediate
results if possible, but it would be nice to notify (property, signal) the
app if it's not possible.
Just to give a chance to handle user experience in nice way. It can take a
while between start of measurements and the final results event.

>From the other hand, the app by default can assume there is no intermediate
results ( (however API will not require that if there is no property)) and
can handle this time properly. In case, when it starts receiving
intermediate results it will start display it immediately.

Thanks,
/Waldek

--20cf301ee723cd3baf04dcd4dbe8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra">Hi Johan,<br></div><div cla=
ss=3D"gmail_extra"><br><div class=3D"gmail_quote">On 8 May 2013 09:41, Joha=
n Hedberg <span dir=3D"ltr">&lt;<a href=3D"mailto:johan.hedberg@gmail.com" =
target=3D"_blank">johan.hedberg@gmail.com</a>&gt;</span> wrote:<br>


<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">Are you still working on this? Seems this discussion was f=
orgotten or<br>


just abandoned.<br></blockquote><div><br></div><div>I&#39;ve been focused o=
n something else, but nice to see you are still interested in. <br></div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-lef=
t-style:solid;padding-left:1ex">

Apparently it was never a requirement to be able to enable/disable this<br>
an arbitrary amount of times during the watcher life time, and instead<br>
just leave it disabled or enabled until the watcher gets unregistered?<br>
<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-l=
eft-style:solid;padding-left:1ex">Also, do you think there will be UIs that=
 will refuse to work if a<br>


device does not support intermediate measurement or that any UI that is<br>
interested in intermediate measurement will forgive devices that do not<br>
support it and simply get on with working without it being enabled? If<br>
the latter ilds true then why not make an API which allows requesting<br>
&quot;register watcher and enable intermediate measurement if it&#39;s<br>
supported&quot;. In such a case you wouldn&#39;t need a separate property a=
nd the<br>
registration would succeed even if intermediate measurement isn&#39;t<br>
supported. Thoughts?<br></blockquote><div><br></div><div style>Well, I beli=
eve any app will always be interested in getting intermediate results if po=
ssible, but it would be nice to notify (property, signal) the app if it&#39=
;s not possible.</div>

<div style>Just to give a chance to handle user experience in nice way. It =
can take a while between start of measurements and the final results event.=
=C2=A0</div><div style><br></div><div style>From the other hand, the app by=
 default can assume there is no intermediate results (=C2=A0(however API wi=
ll not require that if there is no property)) and can handle this time prop=
erly. In case, when it starts receiving intermediate results it will start =
display it immediately.</div>

<div style><br></div><div style>Thanks,</div><div style>/Waldek=C2=A0<br></=
div><div style><br></div><div style>=C2=A0<br></div><div style><br></div><d=
iv style><br></div><div style><br></div><div>=C2=A0</div></div></div></div>

--20cf301ee723cd3baf04dcd4dbe8--
