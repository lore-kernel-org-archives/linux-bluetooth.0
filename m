Return-Path: <cyrus@holtmann.org>
References: <1278625779.10421.80.camel@localhost.localdomain> <1278968772-29446-1-git-send-email-rshaffer@codeaurora.org> <1278972477.6282.10.camel@localhost.localdomain> <BCDE476F204B134B8B235FB275BC3AD810407AA0CD@NALASEXMB01.na.qualcomm.com> <1279135803.6282.58.camel@localhost.localdomain>
Message-Id: <242ECFC3-02DC-413B-BD49-A2B2650202B3@codeaurora.org>
From: Matthew Wilson <mtwilson@codeaurora.org>
To: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1279135803.6282.58.camel@localhost.localdomain>
Content-Type: multipart/alternative;
	boundary=Apple-Mail-18-186022871
Mime-Version: 1.0 (iPad Mail 7B367)
Subject: Re: [PATCH 3/3] Bluetooth: Synchronize SCO/eSCO connection requests to ACL state
Date: Wed, 14 Jul 2010 15:55:33 -0500
Cc: "Perelet, Oleg" <operelet@quicinc.com>,
 Ron Shaffer <rshaffer@codeaurora.org>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "Wilson, Matt" <mtwilson@quicinc.com>
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail-18-186022871
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Marcel,

On Jul 14, 2010, at 2:30 PM, Marcel Holtmann <marcel@holtmann.org> =
wrote:
>>=20
>>=20
>>=20
>=20
> is there really a problem? The LMP will send an error via HCI. So we =
do
> get the mode changed event, but just with an error. And since we are =
not
> checking the error at all, we just go ahead with the SCO setup attempt
> in that case.

The attempt to start SCO after the related ACL is no longer present =
makes no sense.

Either after mode change event with no success or disconnection complete =
event the result is the same; there is no valid ACL to attempt SCO/eSCO.

Error code 0x02 "unknown connection identifier" may apply for the =
command status event for setup synchronous connection command but the =
spec does not require it.

-Matt=

--Apple-Mail-18-186022871
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body bgcolor=3D"#FFFFFF"><div><span class=3D"Apple-style-span" =
style=3D"-webkit-tap-highlight-color: rgba(26, 26, 26, 0.28125); =
-webkit-composition-fill-color: rgba(175, 192, 227, 0.214844); =
-webkit-composition-frame-color: rgba(77, 128, 180, 0.214844); =
">Marcel,</span></div><div><span class=3D"Apple-style-span" =
style=3D"-webkit-tap-highlight-color: rgba(26, 26, 26, 0.277344); =
-webkit-composition-fill-color: rgba(175, 192, 227, 0.210938); =
-webkit-composition-frame-color: rgba(77, 128, 180, =
0.210938);"><br></span></div><div><span class=3D"Apple-style-span" =
style=3D"-webkit-tap-highlight-color: rgba(26, 26, 26, 0.28125); =
-webkit-composition-fill-color: rgba(175, 192, 227, 0.214844); =
-webkit-composition-frame-color: rgba(77, 128, 180, 0.214844); ">On Jul =
14, 2010, at 2:30 PM, Marcel Holtmann &lt;<a =
href=3D"mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; =
wrote:</span></div><blockquote type=3D"cite"><div><blockquote =
type=3D"cite"><span></span></blockquote><blockquote =
type=3D"cite"><span></span></blockquote><blockquote =
type=3D"cite"><span></span></blockquote><span></span><br><span>is there =
really a problem? The LMP will send an error via HCI. So we =
do</span><br><span>get the mode changed event, but just with an error. =
And since we are not</span><br><span>checking the error at all, we just =
go ahead with the SCO setup attempt</span><br><span>in that =
case.</span><br></div></blockquote><br><span class=3D"Apple-style-span" =
style=3D"font-size: medium; -webkit-tap-highlight-color: rgba(26, 26, =
26, 0.296875); -webkit-composition-fill-color: rgba(175, 192, 227, =
0.230469); -webkit-composition-frame-color: rgba(77, 128, 180, =
0.230469); "><div>The attempt to start SCO after the related ACL is no =
longer present makes no sense.</div><div><br></div><div>Either after =
mode change event with no success or disconnection complete event the =
result is the same; there is no valid ACL to attempt =
SCO/eSCO.</div><div><br></div><div>Error code 0x02 "unknown connection =
identifier" may apply for the command status event for setup synchronous =
connection command but the spec does not require =
it.</div><div><br></div><div>-Matt</div></span></body></html>=

--Apple-Mail-18-186022871--
