Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <marcel@holtmann.org>
CC: <suraj@atheros.com>, <linux-bluetooth@vger.kernel.org>,
	<Jothikumar.Mothilal@Atheros.com>, <joakim.xj.ceder@stericsson.com>
Date: Wed, 6 Oct 2010 10:28:41 +0300
Subject: RE: Sim Access profile server implementation
Message-ID: <99B09243E1A5DA4898CDD8B700111448097D01B6CF@EXMB04.eu.tieto.com>
References: <1285657515.12097.7.camel@atheros013-desktop>
	 <1286265730.17473.29.camel@aeonflux>
	 <99B09243E1A5DA4898CDD8B700111448097D01B371@EXMB04.eu.tieto.com>
 <1286280767.17473.89.camel@aeonflux>
In-Reply-To: <1286280767.17473.89.camel@aeonflux>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel,

>
>please no top posting on this mailing list.
>

Sorry, didn't know that.  Thanks for pointing this out.

>> I understand you concerns about dbus reliability and I agree=20
>with you , but I guess we should find a compromise solution as=20
>ofono is not used widely in Linux mobile platforms nowadays.
>>=20
>> I my view, combination of a bluez plugin for sap and a=20
>platform dependend sim driver is a reliable and most available=20
>solution so far. The SAP plugin implements BT SAP spec and=20
>require simple API (connect, disconnect, apdu, atr, status)=20
>which is implemented in SIM driver for a certain platform.=20
>This way it's relatively easy to support SAP in different=20
>platforms. Ofono can have its own driver as well.
>>=20
>> What's you view on such design?
>> Can we also have a double solution one in ofono for ofono=20
>aware platforms and the second as a plugin for others?=20
>
>I am fine with starting this in BlueZ and see how far we get.=20
>And yes, plugin based is a must from my point of view. It is=20
>most likely similar to our different telephony drivers for=20
>Handsfree support.

It's nice to here that.

>We will move strongly in the direction of oFono being the main=20
>telephony stack. So I do care mostly that this work in=20
>conjunction with oFono.
>Everything else is just a nice benefit if it doesn't clutter=20
>the overhaul implementation and requires pointless abstraction=20
>everywhere.
>> BTW, I already have this implemented and tested with real hardware=20
>> (STEricsson). Bluez SAP works fine with Nokia 616 carkit :)
>
>Can you share that code with us. And also hardware if you. We=20
>are still having hard time to find proper hardware to test this on.

Will send a patch soon. I use http://www.stericsson.com/platforms/U8500.jsp=
 hw, but need to check if I can share one with you.

Regards,
/Waldek=
