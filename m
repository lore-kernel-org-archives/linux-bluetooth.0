Return-Path: <michal.narajowski@codecoup.pl>
MIME-Version: 1.0
In-Reply-To: <CAJfb0nujHSMiwmuzRg7CyEddEx03uF61_joL08HPmDvtWprJzw@mail.gmail.com>
References: <1471419377-9522-1-git-send-email-michal.narajowski@codecoup.pl>
 <88A4E00C-20B0-47D6-A22A-16D632CE24F5@holtmann.org> <CAJfb0nujHSMiwmuzRg7CyEddEx03uF61_joL08HPmDvtWprJzw@mail.gmail.com>
From: =?UTF-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>
Date: Wed, 17 Aug 2016 10:05:15 +0200
Message-ID: <CAJfb0nt8QzeeVnHqLYLh_dHxCUQLJjXRzFtK1haZpcgKYDQhEA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3] client: Add better support for managing devices
 of multiple controllers
To: =?UTF-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a1133288cf3c10d053a3fecfc
List-ID: <linux-bluetooth.vger.kernel.org>

--001a1133288cf3c10d053a3fecfc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Added mailing list in CC.

2016-08-17 9:55 GMT+02:00 Micha=C5=82 Narajowski <michal.narajowski@codecou=
p.pl>:

> Hi Marcel,
>
> of course I should have used libshared-glib.la. Will fix that. I needed
> it for new0() by the way.
>
> Regards,
> Micha=C5=82 Narajowski
>
> 2016-08-17 9:45 GMT+02:00 Marcel Holtmann <marcel@holtmann.org>:
>
>> Hi Michal,
>>
>> > Previously devices list was cleared when selecting new default
>> > controller. Now devices list is preserverd allowing to list and sugges=
t
>> > devices for default controller even after changing the default
>> > controller.
>> > ---
>> > Makefile.tools |   2 +-
>> > client/main.c  | 262 ++++++++++++++++++++++++++++++
>> +++++++++++----------------
>> > 2 files changed, 189 insertions(+), 75 deletions(-)
>> >
>> > diff --git a/Makefile.tools b/Makefile.tools
>> > index 7706dc7..944c8e9 100644
>> > --- a/Makefile.tools
>> > +++ b/Makefile.tools
>> > @@ -10,7 +10,7 @@ client_bluetoothctl_SOURCES =3D client/main.c \
>> >                                       client/gatt.h client/gatt.c \
>> >                                       monitor/uuid.h monitor/uuid.c
>> > client_bluetoothctl_LDADD =3D gdbus/libgdbus-internal.la @GLIB_LIBS@
>> @DBUS_LIBS@ \
>> > -                             -lreadline
>> > +                             -lreadline src/libshared-mainloop.la
>>
>> I have no idea on how this is going to work. It would need to be
>> libshared-glib.la first of all, and second of all, what would you be
>> using in a D-Bus client that justifies using it.
>>
>> Regards
>>
>> Marcel
>>
>>
>

--001a1133288cf3c10d053a3fecfc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr" style=3D"font-size:12.8px">Added mailing =
list in CC.</div><div class=3D"" style=3D"font-size:12.8px"></div></div><di=
v class=3D"gmail_extra"><br><div class=3D"gmail_quote">2016-08-17 9:55 GMT+=
02:00 Micha=C5=82 Narajowski <span dir=3D"ltr">&lt;<a href=3D"mailto:michal=
.narajowski@codecoup.pl" target=3D"_blank">michal.narajowski@codecoup.pl</a=
>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi Marcel,=
<div><br></div><div>of course I should have used <a href=3D"http://libshare=
d-glib.la" target=3D"_blank">libshared-glib.la</a>. Will fix that. I needed=
 it for new0() by the way.</div><div><br></div><div>Regards,</div><div>Mich=
a=C5=82 Narajowski</div></div><div class=3D"HOEnZb"><div class=3D"h5"><div =
class=3D"gmail_extra"><br><div class=3D"gmail_quote">2016-08-17 9:45 GMT+02=
:00 Marcel Holtmann <span dir=3D"ltr">&lt;<a href=3D"mailto:marcel@holtmann=
.org" target=3D"_blank">marcel@holtmann.org</a>&gt;</span>:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">Hi Michal,<br>
<span><br>
&gt; Previously devices list was cleared when selecting new default<br>
&gt; controller. Now devices list is preserverd allowing to list and sugges=
t<br>
&gt; devices for default controller even after changing the default<br>
&gt; controller.<br>
&gt; ---<br>
&gt; Makefile.tools |=C2=A0 =C2=A02 +-<br>
&gt; client/main.c=C2=A0 | 262 ++++++++++++++++++++++++++++++<wbr>+++++++++=
++----------------<br>
&gt; 2 files changed, 189 insertions(+), 75 deletions(-)<br>
&gt;<br>
&gt; diff --git a/Makefile.tools b/Makefile.tools<br>
&gt; index 7706dc7..944c8e9 100644<br>
&gt; --- a/Makefile.tools<br>
&gt; +++ b/Makefile.tools<br>
&gt; @@ -10,7 +10,7 @@ client_bluetoothctl_SOURCES =3D client/main.c \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0client=
/gatt.h client/gatt.c \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0monito=
r/uuid.h monitor/uuid.c<br>
&gt; client_bluetoothctl_LDADD =3D gdbus/<a href=3D"http://libgdbus-interna=
l.la" rel=3D"noreferrer" target=3D"_blank">libgdbus-internal.la</a> @GLIB_L=
IBS@ @DBUS_LIBS@ \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-lreadline<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-lreadline src/<a href=3D"http://libshar=
ed-mainloop.la" rel=3D"noreferrer" target=3D"_blank">libshared-mainloop.la<=
/a><br>
<br>
</span>I have no idea on how this is going to work. It would need to be <a =
href=3D"http://libshared-glib.la" rel=3D"noreferrer" target=3D"_blank">libs=
hared-glib.la</a> first of all, and second of all, what would you be using =
in a D-Bus client that justifies using it.<br>
<br>
Regards<br>
<span><font color=3D"#888888"><br>
Marcel<br>
<br>
</font></span></blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--001a1133288cf3c10d053a3fecfc--
