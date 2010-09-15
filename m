Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [RFC] BlueZ D-Bus Sim Access Profile Server API description
Date: Wed, 15 Sep 2010 09:32:00 +0200
Message-ID: <A9AC1023FCA4654D92AC24C2A8F6A09201A2B923@renesas4bis.renesas-rdf.local>
In-Reply-To: <4C906430.90900@Atheros.com>
References: <1284374584-12282-1-git-send-email-suraj@atheros.com>	 <1284442946.2405.50.camel@localhost.localdomain>	 <4C8F160B.4010401@Atheros.com> <1284522264.2405.89.camel@localhost.localdomain> <4C906430.90900@Atheros.com>
From: "Nicolas GUILBAUD" <nicolas.guilbaud.wj@rdf.renesas.com>
To: "Suraj Sumangala" <suraj@Atheros.com>,
        "Marcel Holtmann" <marcel@holtmann.org>
Cc: "Suraj Sumangala" <Suraj.Sumangala@Atheros.com>,
        <linux-bluetooth@vger.kernel.org>,
        "Jothikumar Mothilal" <Jothikumar.Mothilal@Atheros.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel and Suraj,

-----Message d'origine-----
De=A0: linux-bluetooth-owner@vger.kernel.org =
[mailto:linux-bluetooth-owner@vger.kernel.org] De la part de Suraj =
Sumangala
Envoy=E9=A0: mercredi 15 septembre 2010 08:14
=C0=A0: Marcel Holtmann
Cc=A0: Suraj Sumangala; linux-bluetooth@vger.kernel.org; Jothikumar =
Mothilal
Objet=A0: Re: [RFC] BlueZ D-Bus Sim Access Profile Server API =
description

>Hi Marcel,
>
>On 9/15/2010 9:14 AM, Marcel Holtmann wrote:
>> Hi Suraj,
>>
>>>
>>> I would really appreciate if you can give me any idea about working
>>> around the above mentioned issues.
>>
>> if we talk about the SAP server role found in a mobile phone, then =
that
>> support clearly needs to interact with the telephony stack. Since =
when
>> SAP is active the telephony stack needs to be suspended and all SIM
>> transaction being forwarded.
>>
>> Currently I would be thinking that the SAP implementation should be =
done
>> inside oFono actually. Since then you have direct access to the
>> hardware. The D-Bus approach just doesn't sound correct to me. I =
could
>> be of course wrong, but I can't wrap my mind around on how you can =
make
>> this work.
>>
>> Even with file descriptor passing this doesn't look like the right
>> approach. If we need a hardware abstraction than we either use oFono =
or
>> we have to create some SAP hardware access abstraction.
>
>The advantage I thought d-bus has would be the generic interface it=20
>could provide. But, if we have a system with direct access to the Sim=20
>access hardware, D-bus could possibly become a bottleneck.
>
>I would really appreciate if others who have worked with Sim Access and =

>OFono can give their comments.
>
>Also, please share some information on regarding the SIM reader=20
>implementation in linux based systems.
>
>>
>> The SAP client role found a carkit is obviously a different story.
>>
>> Regards
>>
>> Marcel
>>
>>
>Regards
>Suraj

I agree with Marcel, because in standard Mobile phone implementation, =
the SIM card is directly connected to the Modem. To access the SIM card, =
AT command (or proprietary commands) are needed, oFono implements both =
of them to access SIM card in Modem side, but in my understanding there =
is no possibilities to disconnect modem (in oFono) due to SIM SAP.

In the case where SIM card is connected to the Application processor =
(Linux side), it's missing the SIM stack (APDU server...). I don't find =
any SIM implementation in Linux, may be we have to specify it.=20


Best Regards,

Nicolas.
