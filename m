Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <DE6F5576-C7C9-4EA9-B242-3489F0651FBC@holtmann.org>
References: <1363716255-21332-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1363716255-21332-3-git-send-email-frederic.dalleau@linux.intel.com>
	<DE6F5576-C7C9-4EA9-B242-3489F0651FBC@holtmann.org>
Date: Mon, 8 Apr 2013 10:55:08 +0200
Message-ID: <CA+QXtDuOkVD9H3ot2ODsEdUc9bfDiz0ZxPA2GxaV9SrxtWBPkA@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] Bluetooth: Add SCO socket voice_setting option
From: "Dalleau, Frederic" <frederic.dalleau@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?= <frederic.dalleau@linux.intel.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/alternative; boundary=089e01633a8cfeb28a04d9d597b8
List-ID: <linux-bluetooth.vger.kernel.org>

--089e01633a8cfeb28a04d9d597b8
Content-Type: text/plain; charset=ISO-8859-1

Hi Marcel,

On Tue, Mar 26, 2013 at 9:22 PM, Marcel Holtmann <marcel@holtmann.org>wrote:

> I find this parameter name a bit long. What about just "setting" or
> "settings" or "voice". I am open for suggestions.
>
> Also should this be part of options or the socket address structure.
>
> Another option would be to introduce a SCO_SETTINGS or SCO_VOICE socket
> option. With just this one parameter.
>
> Since the default value of voice setting is not 0x0000, it might make
> actually more sense to introduce a new socket option. Playing the memset
> handling would only work nicely if the default would be 0x0000, but it
> isn't.
>

I agree that having a separate socket option is better. IMHO, having it in
the
sockaddr is not enough because you don't know in advance what stream is
flowing for incoming connections. It could improve the API for outgoing
connections.

My concern is how do we handle user values.
If the user do not set this option, hci_conn->settings contains 0x0000.
In this case, it is possible to start the sco connection as we have it
today.
If the user set 0x0060 (cvsd 16 bits) or 0x0003 (transparent data), then it
is
possible to start S3, S2, S1 or T2, T1 sequences.

For other values, IMHO, returning an error would be the way to go.

If the above is fine for you, we can discuss the naming. What about the
following ?

#define SCO_SETTINGS  0x03
struct sco_settings {
        __u16           settings;
};

Regards,
Fred

--089e01633a8cfeb28a04d9d597b8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Marcel,<br><div><div class=3D"gmail_extra"><br><div cla=
ss=3D"gmail_quote">On Tue, Mar 26, 2013 at 9:22 PM, Marcel Holtmann <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:marcel@holtmann.org" target=3D"_blank">mar=
cel@holtmann.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">I find this parameter nam=
e a bit long. What about just &quot;setting&quot; or &quot;settings&quot; o=
r &quot;voice&quot;. I am open for suggestions.<br>


<br>
Also should this be part of options or the socket address structure.<br>
<br>
Another option would be to introduce a SCO_SETTINGS or SCO_VOICE socket opt=
ion. With just this one parameter.<br>
<br>
Since the default value of voice setting is not 0x0000, it might make actua=
lly more sense to introduce a new socket option. Playing the memset handlin=
g would only work nicely if the default would be 0x0000, but it isn&#39;t.<=
br>


</blockquote><div><br></div>I agree that having a separate socket option is=
 better. IMHO, having it in the<br>sockaddr is not enough because you don&#=
39;t know in advance what stream is<br>flowing for incoming connections. It=
 could improve the API for outgoing<br>
connections.<br><br>My concern is how do we handle user values.<br>If the u=
ser do not set this option, hci_conn-&gt;settings contains 0x0000.<br>In th=
is case, it is possible to start the sco connection as we have it today.<br=
>
If the user set 0x0060 (cvsd 16 bits) or 0x0003 (transparent data), then it=
 is<br>possible to start S3, S2, S1 or T2, T1 sequences.<br><br>For other v=
alues, IMHO, returning an error would be the way to go.<br><br>If the above=
 is fine for you, we can discuss the naming. What about the<br>
following ?<br><br>#define SCO_SETTINGS=A0 0x03<br>struct sco_settings {<br=
>=A0=A0=A0=A0=A0=A0=A0 __u16=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 settings;<br>}; =
<br><br><div>Regards,<br>Fred<br>
<br></div></div></div></div></div>

--089e01633a8cfeb28a04d9d597b8--
