Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <24D2CD11-D43B-4F53-8A7C-175934A54C87@holtmann.org>
References: <1411746855-9936-1-git-send-email-fons@spotify.com> <24D2CD11-D43B-4F53-8A7C-175934A54C87@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
Date: Mon, 29 Sep 2014 12:59:55 +0200
Message-ID: <CAHF=Y4owMj-RBquSk2GWVjGSL4H1SU0qC6pVEN6DJvdmyqw9zA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Add HCI_AUTO_CONN_DIRECT_REPORT_IND
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=90e6ba6e87a01de8310504322d39
List-ID: <linux-bluetooth.vger.kernel.org>

--90e6ba6e87a01de8310504322d39
Content-Type: text/plain; charset=UTF-8

Hi Marcel,


> I am not really convinced that this is a good idea. In general either you
> really want Action 0x01 and only accept incoming connection or you want
> Action 0x02 and connect to the device no matter what.
>

We are dealing with an HID device which sends meaningful information
in ADV_IND reports
and to which we want to connect when receiving ADV_DIRECT_IND reports.

Without kernel support for auto-connecting on ADV_IND while still
forwarding ADV_DIRECT_IND to userland, we are forced to keep active
scanning on so that the content of ADV_IND reports isn't lost.

We would of course like to avoid active scanning when possible, hence the
reason on the patch.

Originally I had the idea that the advertising data that you receive from
> ADV_IND when Action 0x02 is in play gets also included in Device Connected
> event.


In our particular case, based on the content of ADV_IND we may not want to
or simply can't connect to the device right away. In other words, the
Device Connected event may never arrive (if the connection fails) and if it
does, it's already too late to decide whether we want to connect or not.

One could argue that the device should be broadcasting ADV_NONCONN_IND
instead, but I don't think it makes it non-compliant.

Johan told me on IRC that, as opposed to introducing
HCI_AUTO_CONN_DIRECT_REPORT_IND, modifying HCI_AUTO_CONN_DIRECT to also
forward ADV_IND to userland in Device Found events could be considered. Are
you open to this idea?


-- 
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com

--90e6ba6e87a01de8310504322d39
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Marcel,</div><div><br></div><div class=3D"gmail_ex=
tra"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,20=
4,204);border-left-style:solid;padding-left:1ex"><span><br>
</span>I am not really convinced that this is a good idea. In general eithe=
r you really want Action 0x01 and only accept incoming connection or you wa=
nt Action 0x02 and connect to the device no matter what.<br></blockquote><d=
iv><br></div><div>We are dealing with an HID device which sends meaningful =
information in=C2=A0<span style=3D"color:rgb(80,0,80);font-family:arial,san=
s-serif;font-size:13px">ADV_IND=C2=A0reports and to which we want to connec=
t=C2=A0</span>when receiving=C2=A0<font color=3D"#500050" face=3D"arial, sa=
ns-serif">ADV_DIRECT_IND reports.</font><br><br><font color=3D"#500050" fac=
e=3D"arial, sans-serif">Without kernel support for=C2=A0auto-connecting=C2=
=A0on </font><span style=3D"color:rgb(80,0,80);font-family:arial,sans-serif=
;font-size:13px">ADV_IND while still forwarding=C2=A0</span><span style=3D"=
color:rgb(80,0,80);font-family:arial,sans-serif;font-size:13px">ADV_DIRECT_=
IND to userland,=C2=A0</span><span style=3D"color:rgb(80,0,80);font-family:=
arial,sans-serif;font-size:13px">we are forced to keep active scanning on s=
o that the content of=C2=A0</span><span style=3D"color:rgb(80,0,80);font-fa=
mily:arial,sans-serif;font-size:13px">ADV_IND</span><span style=3D"color:rg=
b(80,0,80);font-family:arial,sans-serif;font-size:13px">=C2=A0reports isn&#=
39;t lost.<br><br>We would of course like to avoid active scanning when pos=
sible, hence the reason on the patch.</span></div><div><br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width=
:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-lef=
t:1ex">
Originally I had the idea that the advertising data that you receive from A=
DV_IND when Action 0x02 is in play gets also included in Device Connected e=
vent. </blockquote><div><br></div><div>In our particular case, based on the=
 content of ADV_IND we may not want to or simply can&#39;t connect to the d=
evice right away. In other words, the Device Connected event may never arri=
ve (if the connection fails) and if it does, it&#39;s already too late to d=
ecide whether we want to connect or not.<br><br>One could argue that the de=
vice should be broadcasting ADV_NONCONN_IND instead, but I don&#39;t think =
it makes it non-compliant.=C2=A0<br><br>Johan told me on IRC that, as oppos=
ed to introducing HCI_AUTO_CONN_DIRECT_REPORT_IND, modifying=C2=A0<span sty=
le=3D"color:rgb(80,0,80);font-family:arial,sans-serif;font-size:13px">HCI_A=
UTO_CONN_DIRECT to also forward=C2=A0</span>ADV_IND to userland in Device F=
ound events could be considered. Are you open to this idea?<br><br></div><d=
iv>=C2=A0</div></div>-- <br><div dir=3D"ltr"><div style=3D"font-family:aria=
l;font-size:small">Alfonso Acosta</div><div style=3D"font-family:arial;font=
-size:small"><br></div><div style=3D"font-family:arial;font-size:small">Emb=
edded Systems Engineer at Spotify</div><div style=3D"font-family:arial;font=
-size:small">Birger Jarlsgatan 61, Stockholm, Sweden</div><div style=3D"fon=
t-family:arial;font-size:small"><a href=3D"http://www.spotify.com" target=
=3D"_blank">http://www.spotify.com</a></div></div>
</div></div>

--90e6ba6e87a01de8310504322d39--
