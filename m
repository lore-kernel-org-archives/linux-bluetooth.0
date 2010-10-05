Return-Path: <cyrus@holtmann.org>
Subject: RE: Sim Access profile server implementation
From: Marcel Holtmann <marcel@holtmann.org>
To: Waldemar.Rymarkiewicz@tieto.com
Cc: suraj@atheros.com, linux-bluetooth@vger.kernel.org,
	Jothikumar.Mothilal@Atheros.com, joakim.xj.ceder@stericsson.com
In-Reply-To: <99B09243E1A5DA4898CDD8B700111448097D01B371@EXMB04.eu.tieto.com>
References: <1285657515.12097.7.camel@atheros013-desktop>
	 <1286265730.17473.29.camel@aeonflux>
	 <99B09243E1A5DA4898CDD8B700111448097D01B371@EXMB04.eu.tieto.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Oct 2010 14:12:47 +0200
Message-ID: <1286280767.17473.89.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

please no top posting on this mailing list.

> I understand you concerns about dbus reliability and I agree with you , but I guess we should find a compromise solution as ofono is not used widely in Linux mobile platforms nowadays.
> 
> I my view, combination of a bluez plugin for sap and a platform dependend sim driver is a reliable and most available solution so far. The SAP plugin implements BT SAP spec and require simple API (connect, disconnect, apdu, atr, status) which is implemented in SIM driver for a certain platform. This way it's relatively easy to support SAP in different platforms. Ofono can have its own driver as well.
> 
> What's you view on such design?
> Can we also have a double solution one in ofono for ofono aware platforms and the second as a plugin for others? 

I am fine with starting this in BlueZ and see how far we get. And yes,
plugin based is a must from my point of view. It is most likely similar
to our different telephony drivers for Handsfree support.

We will move strongly in the direction of oFono being the main telephony
stack. So I do care mostly that this work in conjunction with oFono.
Everything else is just a nice benefit if it doesn't clutter the
overhaul implementation and requires pointless abstraction everywhere.

> BTW, I already have this implemented and tested with real hardware (STEricsson). Bluez SAP works fine with Nokia 616 carkit :)

Can you share that code with us. And also hardware if you. We are still
having hard time to find proper hardware to test this on.

Regards

Marcel


