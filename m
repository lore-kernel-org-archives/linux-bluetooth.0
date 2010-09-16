Return-Path: <cyrus@holtmann.org>
Subject: RE: [RFC] BlueZ D-Bus Sim Access Profile Server API description
From: Marcel Holtmann <marcel@holtmann.org>
To: Waldemar.Rymarkiewicz@tieto.com
Cc: suraj@Atheros.com, Suraj.Sumangala@Atheros.com,
	linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
In-Reply-To: <99B09243E1A5DA4898CDD8B700111448097968EDE3@EXMB04.eu.tieto.com>
References: <1284374584-12282-1-git-send-email-suraj@atheros.com>
	 <1284442946.2405.50.camel@localhost.localdomain>
	 <4C8F160B.4010401@Atheros.com>
	 <1284522264.2405.89.camel@localhost.localdomain>
	 <99B09243E1A5DA4898CDD8B700111448097968EDE3@EXMB04.eu.tieto.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Sep 2010 08:04:30 +0900
Message-ID: <1284678270.2405.148.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

> >if we talk about the SAP server role found in a mobile phone, 
> >then that support clearly needs to interact with the telephony 
> >stack. Since when SAP is active the telephony stack needs to 
> >be suspended and all SIM transaction being forwarded.
> 
> I agree, but a telephony stack needs to care about its state when SAP is active. Not all linux based mobile platforms use ofono.

I think they should use oFono of course since that is the only way to be
modem hardware agnostic in the long run.

> >Currently I would be thinking that the SAP implementation 
> >should be done inside oFono actually. Since then you have 
> >direct access to the hardware. The D-Bus approach just doesn't 
> >sound correct to me. I could be of course wrong, but I can't 
> >wrap my mind around on how you can make this work.
> 
> I assume that ofono should handle sap transactions (as it's kind of hardware abstraction for bluez) and expose SAP APDU interfaces as i.e Nokia did for sap transactions in spec (http://www.wirelessmodemapi.com/), and not implement sap profile itself.  Again, not all use ofono as telephony stack.
> 
> Sorry, I don't know ofono well. What's the interface between ofono and bluez? 

In this case there will be no direct interface besides oFono registering
the SDP records for SAP.

> >Even with file descriptor passing this doesn't look like the 
> >right approach. If we need a hardware abstraction than we 
> >either use oFono or we have to create some SAP hardware access 
> >abstraction.
> 
> I agree with this too. I prefere to have a sap implementation as bluez plugin, but we need to define api for sim operations which could be implemented in ofono or other proprietary stacks. I guess dbus was intended to be kind of hw abstraction api.
> Some time ago Claudio sent proposal implementation of sap server where he defined api for a driver to sim.

I still don't see this as a really good idea. We want modem abstraction
inside oFono and not all over the place.

Regards

Marcel


