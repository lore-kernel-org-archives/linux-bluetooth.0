Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <marcel@holtmann.org>, <suraj@Atheros.com>
CC: <Suraj.Sumangala@Atheros.com>, <linux-bluetooth@vger.kernel.org>,
	<Jothikumar.Mothilal@Atheros.com>
Date: Wed, 15 Sep 2010 12:18:54 +0300
Subject: RE: [RFC] BlueZ D-Bus Sim Access Profile Server API description
Message-ID: <99B09243E1A5DA4898CDD8B700111448097968EDE3@EXMB04.eu.tieto.com>
References: <1284374584-12282-1-git-send-email-suraj@atheros.com>
	 <1284442946.2405.50.camel@localhost.localdomain>
	 <4C8F160B.4010401@Atheros.com>
 <1284522264.2405.89.camel@localhost.localdomain>
In-Reply-To: <1284522264.2405.89.camel@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,=20

>if we talk about the SAP server role found in a mobile phone,=20
>then that support clearly needs to interact with the telephony=20
>stack. Since when SAP is active the telephony stack needs to=20
>be suspended and all SIM transaction being forwarded.

I agree, but a telephony stack needs to care about its state when SAP is ac=
tive. Not all linux based mobile platforms use ofono.

>Currently I would be thinking that the SAP implementation=20
>should be done inside oFono actually. Since then you have=20
>direct access to the hardware. The D-Bus approach just doesn't=20
>sound correct to me. I could be of course wrong, but I can't=20
>wrap my mind around on how you can make this work.

I assume that ofono should handle sap transactions (as it's kind of hardwar=
e abstraction for bluez) and expose SAP APDU interfaces as i.e Nokia did fo=
r sap transactions in spec (http://www.wirelessmodemapi.com/), and not impl=
ement sap profile itself.  Again, not all use ofono as telephony stack.

Sorry, I don't know ofono well. What's the interface between ofono and blue=
z?=20

>Even with file descriptor passing this doesn't look like the=20
>right approach. If we need a hardware abstraction than we=20
>either use oFono or we have to create some SAP hardware access=20
>abstraction.

I agree with this too. I prefere to have a sap implementation as bluez plug=
in, but we need to define api for sim operations which could be implemented=
 in ofono or other proprietary stacks. I guess dbus was intended to be kind=
 of hw abstraction api.
Some time ago Claudio sent proposal implementation of sap server where he d=
efined api for a driver to sim.

Regards,
/Waldek=
