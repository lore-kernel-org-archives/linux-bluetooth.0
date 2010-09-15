Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [RFC] BlueZ D-Bus Sim Access Profile Server API description
Date: Wed, 15 Sep 2010 10:56:14 +0200
Message-ID: <A9AC1023FCA4654D92AC24C2A8F6A09201A2B9DF@renesas4bis.renesas-rdf.local>
In-Reply-To: <4C9082C8.9030502@Atheros.com>
References: <1284374584-12282-1-git-send-email-suraj@atheros.com>	 <1284442946.2405.50.camel@localhost.localdomain>	 <4C8F160B.4010401@Atheros.com> <1284522264.2405.89.camel@localhost.localdomain> <4C906430.90900@Atheros.com> <A9AC1023FCA4654D92AC24C2A8F6A09201A2B923@renesas4bis.renesas-rdf.local> <4C9082C8.9030502@Atheros.com>
From: "Nicolas GUILBAUD" <nicolas.guilbaud.wj@rdf.renesas.com>
To: "Suraj Sumangala" <suraj@Atheros.com>
Cc: "Suraj Sumangala" <Suraj.Sumangala@Atheros.com>,
        "Marcel Holtmann" <marcel@holtmann.org>,
        <linux-bluetooth@vger.kernel.org>,
        "Jothikumar Mothilal" <Jothikumar.Mothilal@Atheros.com>
List-ID: <linux-bluetooth.vger.kernel.org>



>-----Message d'origine-----
>De=A0: linux-bluetooth-owner@vger.kernel.org =
[mailto:linux-bluetooth->owner@vger.kernel.org] De la part de Suraj =
Sumangala
>Envoy=E9=A0: mercredi 15 septembre 2010 10:25
>=C0=A0: Nicolas GUILBAUD
>Cc=A0: Suraj Sumangala; Marcel Holtmann; =
linux-bluetooth@vger.kernel.org; >Jothikumar Mothilal
>Objet=A0: Re: [RFC] BlueZ D-Bus Sim Access Profile Server API =
description
>
>Hi Nicolas,
>
>On 9/15/2010 1:02 PM, Nicolas GUILBAUD wrote:
>> Hello Marcel and Suraj,
>>
>> I agree with Marcel, because in standard Mobile phone implementation, =
the >SIM card is directly connected to the Modem. To access the SIM =
card, AT >command (or proprietary commands) are needed, oFono implements =
both of them >to access SIM card in Modem side, but in my understanding =
there is no >possibilities to disconnect modem (in oFono) due to SIM =
SAP.
>>
>> In the case where SIM card is connected to the Application processor =
>(Linux side), it's missing the SIM stack (APDU server...). I don't find =
any >SIM implementation in Linux, may be we have to specify it.
>>
>Other than transferring APDUs, SAP profile also specifies operations on =

>the SIM cards like SIM Reset, SIM power on/off, Getting Card reader=20
>status etc.
>
>How do we do these operations case of mobile phones?

There are specific interfaces, you can find example of interface in =
Nokia Wireless Open API (uicc_fp.pdf) in =
http://www.wirelessmodemapi.com/, register is free.

SIM reset is an OFF command following by ON command (ATR comes with ON), =
card status is a local information...=20


Best Regards,
Nicolas.
