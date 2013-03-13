Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <440C26C3-24C4-4A9B-8527-C94C75F850E5@holtmann.org>
References: <1363014350-16114-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
	<1363014350-16114-6-git-send-email-christian.fetzer@oss.bmw-carit.de>
	<72B23061-16D8-4949-AAB4-9537F6726FCB@holtmann.org>
	<51407D38.2080600@oss.bmw-carit.de>
	<440C26C3-24C4-4A9B-8527-C94C75F850E5@holtmann.org>
Date: Wed, 13 Mar 2013 16:57:51 -0300
Message-ID: <CABBYNZKcYCHg0oy2fr=uf0UwN8Mivi8jhfLfd4=jYjgzrwLWYQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] obexd: Add RegisterNotifications function
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/alternative; boundary=20cf307cfe0a3c859f04d7d3d2f6
List-ID: <linux-bluetooth.vger.kernel.org>

--20cf307cfe0a3c859f04d7d3d2f6
Content-Type: text/plain; charset=ISO-8859-1

Hi Christian,


On Wed, Mar 13, 2013 at 1:27 PM, Marcel Holtmann <marcel@holtmann.org>wrote:

> Hi Christian,
>
> >>> This allows applications to register for all different types
> >>> of MAP event reports.
> >>>
> >>> In response to this call, the MSE should connect to the local MNS
> >>> instance.
> >>> ---
> >>> doc/obex-api.txt   |  6 ++++
> >>> obexd/client/map.c | 86
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>> 2 files changed, 92 insertions(+)
> >> never ever intermix doc/ changes with actual code. You really need to
> learn on how to split patches properly. There is no reason at all that this
> are not two patches.
> >>
> >>
> >>> diff --git a/doc/obex-api.txt b/doc/obex-api.txt
> >>> index 759c4d8..ef5d85e 100644
> >>> --- a/doc/obex-api.txt
> >>> +++ b/doc/obex-api.txt
> >>> @@ -651,6 +651,12 @@ Methods                void SetFolder(string name)
> >>>                     Possible errors:
> org.bluez.obex.Error.InvalidArguments
> >>>                                      org.bluez.obex.Error.Failed
> >>>
> >>> +           void RegisterNotifications(boolean)
> >>> +
> >>> +                   Register / unregister reception of notifications.
> >>> +
> >>> +                   Possible errors:
> org.bluez.obex.Error.InvalidArguments
> >>> +                                    org.bluez.obex.Error.Failed
>

Why we are not doing this automatically? The application can opt out by not
connecting to signals, but I see no reason why not to be connected to
register the notification channel automatically when connecting the MAP
session if the remote support it.

-- 
Luiz Augusto von Dentz

--20cf307cfe0a3c859f04d7d3d2f6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Christian,<div class=3D"gmail_extra"><br><br><div class=
=3D"gmail_quote">On Wed, Mar 13, 2013 at 1:27 PM, Marcel Holtmann <span dir=
=3D"ltr">&lt;<a href=3D"mailto:marcel@holtmann.org" target=3D"_blank">marce=
l@holtmann.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">Hi C=
hristian,<br>
<br>
&gt;&gt;&gt; This allows applications to register for all different types<b=
r>
&gt;&gt;&gt; of MAP event reports.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; In response to this call, the MSE should connect to the local =
MNS<br>
&gt;&gt;&gt; instance.<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt; doc/obex-api.txt =A0 | =A06 ++++<br>
&gt;&gt;&gt; obexd/client/map.c | 86 ++++++++++++++++++++++++++++++++++++++=
++++++++++++++++<br>
&gt;&gt;&gt; 2 files changed, 92 insertions(+)<br>
&gt;&gt; never ever intermix doc/ changes with actual code. You really need=
 to learn on how to split patches properly. There is no reason at all that =
this are not two patches.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/doc/obex-api.txt b/doc/obex-api.txt<br>
&gt;&gt;&gt; index 759c4d8..ef5d85e 100644<br>
&gt;&gt;&gt; --- a/doc/obex-api.txt<br>
&gt;&gt;&gt; +++ b/doc/obex-api.txt<br>
&gt;&gt;&gt; @@ -651,6 +651,12 @@ Methods =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vo=
id SetFolder(string name)<br>
&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Possible errors: org.b=
luez.obex.Error.InvalidArguments<br>
&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0org.bluez.obex.Error.Failed<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; + =A0 =A0 =A0 =A0 =A0 void RegisterNotifications(boolean)<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Register / unregister re=
ception of notifications.<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Possible errors: org.blu=
ez.obex.Error.InvalidArguments<br>
&gt;&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0org.bluez.obex.Error.Failed<br></div></div></blockquote></div><b=
r>Why we are not doing this automatically? The application can opt out by n=
ot connecting to signals, but I see no reason why not to be connected to re=
gister the notification channel automatically when connecting the MAP sessi=
on if the remote support it.<br clear=3D"all">
<div><br></div>-- <br>Luiz Augusto von Dentz
</div></div>

--20cf307cfe0a3c859f04d7d3d2f6--
