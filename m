Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <EC65C3CE-3B41-4398-832B-18F8EFDE663C@holtmann.org>
References: <CAEZxfGPDdgjcSwS6vK46Q4tMwdoD=SjV-te8chiERM-wnEP00w@mail.gmail.com>
 <CABBYNZ+GMyT8z8ujGGu3oMK1ffkdAuX21ZRu7Cf7eFpqS0jHuw@mail.gmail.com>
 <CAEZxfGMY5L=gcDczjUoM6Yg3m9z+LObByFgnAy0u7duyu+v-tg@mail.gmail.com>
 <CABBYNZL_DjeOGbbFKmavUY1QRMNb1V2KrBbNHZ2bH=hZ6q5vNg@mail.gmail.com>
 <CAEZxfGMNJKc3kW+isa8LofrLCuWFBaPvyAiiw5X_0ZBLsrTDgQ@mail.gmail.com> <EC65C3CE-3B41-4398-832B-18F8EFDE663C@holtmann.org>
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Mon, 5 Oct 2015 13:23:15 +0200
Message-ID: <CAEZxfGPsASYSonc5Pc4t15Jm02540SJKsom70GULTFWNp-8V0w@mail.gmail.com>
Subject: Re: Disabling deviceinfo plugin on chromebooks?
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/alternative; boundary=001a113f21522829a9052159be9e
List-ID: <linux-bluetooth.vger.kernel.org>

--001a113f21522829a9052159be9e
Content-Type: text/plain; charset=UTF-8

On Sat, Oct 3, 2015 at 7:11 PM, Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Francois,
>
> >>> Thanks for your answer Luiz!
> >>
> >> Please comment inline in the ml.
> >>
> >>> From what I can see, Android and iOS Bluetooth Stack libraries don't
> >>> claim the device_information service.
> >>> Could it be possible to make it so that the plugin doesn't block other
> >>> clients (such as the Web Bluetooth API) from interacting with that
> >>> service.
> >>
> >> That probably a bad behavior in their own because it can only cause
> >> more traffic as this information can be cached and made available
> >> without causing any extra traffic, as I said I think we just need to
> >> expose the extra information over the device API, so we just have to
> >> add them here:
> >>
> >> https://webbluetoothcg.github.io/web-bluetooth/#bluetoothdevice (note
> >> that it already contains part of device information)
> >>
> >
> > As these characteristics might not be useful to everyone, I'm not sure
> > about the benefit of caching all these device_information service
> > characteristics in Bluez and exposing them to the bluetooth device
> > object.
> > From a web developer point of view, I think I want to get back as
> > quick as possible the bluetooth device object and get characteristics
> > afterwards when I need to.
>
> I am actually fine if we let Device Info services be read by any client.
> However it is a bit trickier since that means an exception in our code.
>
>
That would be awesome actually!


Also only Device Info will fall ever into this category where you have a
> system service reading it and where it might be useful for non-system
> clients. When bluetoothd implement the profile side then we can not have
> another client trying to mess around with it. Especially when it is
> security sensitive like HID.
>
>
That makes sense. Thank you Marcel!



> Regards
>
> Marcel
>
>

--001a113f21522829a9052159be9e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Sat, Oct 3, 2015 at 7:11 PM, Marcel Holtmann <span dir=3D"ltr">&lt;<=
a href=3D"mailto:marcel@holtmann.org" target=3D"_blank">marcel@holtmann.org=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204)=
;border-left-style:solid;padding-left:1ex">Hi Francois,<br>
<span class=3D""><br>
&gt;&gt;&gt; Thanks for your answer Luiz!<br>
&gt;&gt;<br>
&gt;&gt; Please comment inline in the ml.<br>
&gt;&gt;<br>
&gt;&gt;&gt; From what I can see, Android and iOS Bluetooth Stack libraries=
 don&#39;t<br>
&gt;&gt;&gt; claim the device_information service.<br>
&gt;&gt;&gt; Could it be possible to make it so that the plugin doesn&#39;t=
 block other<br>
&gt;&gt;&gt; clients (such as the Web Bluetooth API) from interacting with =
that<br>
&gt;&gt;&gt; service.<br>
&gt;&gt;<br>
&gt;&gt; That probably a bad behavior in their own because it can only caus=
e<br>
&gt;&gt; more traffic as this information can be cached and made available<=
br>
&gt;&gt; without causing any extra traffic, as I said I think we just need =
to<br>
&gt;&gt; expose the extra information over the device API, so we just have =
to<br>
&gt;&gt; add them here:<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://webbluetoothcg.github.io/web-bluetooth/#bluetoo=
thdevice" rel=3D"noreferrer" target=3D"_blank">https://webbluetoothcg.githu=
b.io/web-bluetooth/#bluetoothdevice</a> (note<br>
&gt;&gt; that it already contains part of device information)<br>
&gt;&gt;<br>
&gt;<br>
&gt; As these characteristics might not be useful to everyone, I&#39;m not =
sure<br>
&gt; about the benefit of caching all these device_information service<br>
&gt; characteristics in Bluez and exposing them to the bluetooth device<br>
&gt; object.<br>
&gt; From a web developer point of view, I think I want to get back as<br>
&gt; quick as possible the bluetooth device object and get characteristics<=
br>
&gt; afterwards when I need to.<br>
<br>
</span>I am actually fine if we let Device Info services be read by any cli=
ent. However it is a bit trickier since that means an exception in our code=
.<br>
<br></blockquote><div>=C2=A0</div><div>That would be awesome actually!</div=
><div>=C2=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,2=
04,204);border-left-style:solid;padding-left:1ex">
Also only Device Info will fall ever into this category where you have a sy=
stem service reading it and where it might be useful for non-system clients=
. When bluetoothd implement the profile side then we can not have another c=
lient trying to mess around with it. Especially when it is security sensiti=
ve like HID.<br>
<br></blockquote><div><br></div><div>That makes sense. Thank you Marcel!=C2=
=A0<br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-col=
or:rgb(204,204,204);border-left-style:solid;padding-left:1ex">
Regards<br>
<span class=3D""><font color=3D"#888888"><br>
Marcel<br>
<br>
</font></span></blockquote></div><br></div></div>

--001a113f21522829a9052159be9e--
