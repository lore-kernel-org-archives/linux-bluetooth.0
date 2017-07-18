Return-Path: <jonah@sense.com>
From: Jonah Petri <jonah@sense.com>
Message-Id: <04050C11-F780-4C5C-A49E-1B3DFEEFA066@sense.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_31F8CAEC-B1F8-4D3A-91FC-1F4E059C865B"
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] gatt-server: Implement NegotiatedMTU property on Device1
Date: Tue, 18 Jul 2017 08:40:53 -0400
In-Reply-To: <E9CF469C-80A3-4EB6-A46B-85F46BEC8D24@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
References: <CF389661-A1F2-4A25-96CD-0070FE33A1DE@sense.com>
 <CABBYNZKZCEQvA7fxqc5JtmBGGarqPRCntwFkRy4GZns35F1zvQ@mail.gmail.com>
 <8E72D5C7-FA44-4B06-82D7-2FCB22E26778@holtmann.org>
 <F04ADABE-DEA1-4003-9E95-E9FE8B8C94F4@sense.com>
 <1A61FCA4-F476-456F-AAAE-3C7753885BD4@holtmann.org>
 <C263BD82-A6D4-4325-BA01-2DD7A1F68532@sense.com>
 <E9CF469C-80A3-4EB6-A46B-85F46BEC8D24@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail=_31F8CAEC-B1F8-4D3A-91FC-1F4E059C865B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Marcel,

> On Jul 18, 2017, at 2:42 AM, Marcel Holtmann <marcel@holtmann.org> =
wrote:
>=20
>>>> The negotiation of the MTU can be a significant event to the client =
interacting via dbus, so how should the completion of that negotiation =
be exposed, if not via an attribute as I proposed above?  Some boolean =
"MaxPayloadNegotiationCompleted" method?
>>>=20
>>> there will be PropertiesChanged signal once the MTU has been =
altered. Otherwise it will start out with 23 in case of LE or the =
minimum of whatever L2CAP has configured for BR/EDR. We do the same for =
RFCOMM btw. where it takes the minimum value from the two MTUs.
>>>=20
>>=20
>> I understand.  However, there is no way for a dbus client to tell the =
difference between these two scenarios:
>>=20
>> 1) The MTU has been negotiated to 23  (in the case of LE)
>> 2) The MTU negotiation has not been completed
>>=20
>> I expect many clients making use of this information will want to =
wait until the MTU negotiation is complete, and then begin normal =
operation.  A single attribute representing the current MTU seems to not =
be sufficient to implement such a dbus client.
>=20
> the other option is to leave the property out until the MTU has been =
negotiated. So in case of LE and Exchange MTU has not yet happened, that =
property does not exist. In BR/EDR it will always exist since L2CAP has =
finished already.
>=20
> So clients can start whenever they see the PropertiesChanged signal or =
get the property in the first place.
>=20

This seems fine to me.  Thanks for the feedback.  I will submit a new =
patch.

Jonah


--Apple-Mail=_31F8CAEC-B1F8-4D3A-91FC-1F4E059C865B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">Hi Marcel,<div class=3D""><br class=3D""><div><blockquote =
type=3D"cite" class=3D""><div class=3D"">On Jul 18, 2017, at 2:42 AM, =
Marcel Holtmann &lt;<a href=3D"mailto:marcel@holtmann.org" =
class=3D"">marcel@holtmann.org</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><div =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Monaco; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D""><blockquote type=3D"cite" =
class=3D""><blockquote type=3D"cite" class=3D"">The negotiation of the =
MTU can be a significant event to the client interacting via dbus, so =
how should the completion of that negotiation be exposed, if not via an =
attribute as I proposed above? &nbsp;Some boolean =
"MaxPayloadNegotiationCompleted" method?<br class=3D""></blockquote><br =
class=3D"">there will be PropertiesChanged signal once the MTU has been =
altered. Otherwise it will start out with 23 in case of LE or the =
minimum of whatever L2CAP has configured for BR/EDR. We do the same for =
RFCOMM btw. where it takes the minimum value from the two MTUs.<br =
class=3D""><br class=3D""></blockquote><br class=3D"">I understand. =
&nbsp;However, there is no way for a dbus client to tell the difference =
between these two scenarios:<br class=3D""><br class=3D"">1) The MTU has =
been negotiated to 23 &nbsp;(in the case of LE)<br class=3D"">2) The MTU =
negotiation has not been completed<br class=3D""><br class=3D"">I expect =
many clients making use of this information will want to wait until the =
MTU negotiation is complete, and then begin normal operation. &nbsp;A =
single attribute representing the current MTU seems to not be sufficient =
to implement such a dbus client.<br class=3D""></blockquote><br =
style=3D"font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Monaco; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">the other option is to leave the property out =
until the MTU has been negotiated. So in case of LE and Exchange MTU has =
not yet happened, that property does not exist. In BR/EDR it will always =
exist since L2CAP has finished already.</span><br style=3D"font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Monaco; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">So clients can start whenever they see the =
PropertiesChanged signal or get the property in the first =
place.</span><br style=3D"font-family: Monaco; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></div></blockquote><br class=3D""></div><div>This seems =
fine to me. &nbsp;Thanks for the feedback. &nbsp;I will submit a new =
patch.</div><div><br class=3D""></div><div>Jonah</div><br =
class=3D""></div></body></html>=

--Apple-Mail=_31F8CAEC-B1F8-4D3A-91FC-1F4E059C865B--
