Return-Path: <cyrus@holtmann.org>
Message-ID: <4C91CC60.6080604@Atheros.com>
Date: Thu, 16 Sep 2010 13:20:56 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: "Waldemar.Rymarkiewicz@tieto.com" <Waldemar.Rymarkiewicz@tieto.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
	Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Subject: Re: [RFC] BlueZ D-Bus Sim Access Profile Server API description
References: <1284374584-12282-1-git-send-email-suraj@atheros.com>	 <1284442946.2405.50.camel@localhost.localdomain>	 <4C8F160B.4010401@Atheros.com> <1284522264.2405.89.camel@localhost.localdomain> <99B09243E1A5DA4898CDD8B700111448097968EDE3@EXMB04.eu.tieto.com>
In-Reply-To: <99B09243E1A5DA4898CDD8B700111448097968EDE3@EXMB04.eu.tieto.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> I agree with this too. I prefere to have a sap implementation as bluez plugin, but we need to define api for sim operations which could be implemented in ofono or other proprietary stacks. I guess dbus was intended to be kind of hw abstraction api.
> Some time ago Claudio sent proposal implementation of sap server where he defined api for a driver to sim.

The main question will be
"where should be SAP profile packet handling be implemented?"

1. If it has to be implemented as part of bluetoothd, there is no other 
option other than using dbus so that we have a consistent interface for 
all modules who would be interested in using it.

2. If it has to be done in the "modem/SIM reader", then it will be part 
of that module, not an independent module.

will all SIM card reader implementation be ready to implement a 
Bluetooth SAP parser as part of it just to support Bluetooth as transport?

>
> Regards,
> /Waldek

Regards
Suraj
