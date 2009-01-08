Return-Path: <cyrus@holtmann.org>
From: "Liu, Raymond" <raymond.liu@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 8 Jan 2009 14:29:02 +0800
Subject: Anyone familiar with SAP prifile or ISO7816 or SIM card related
 applications?
Message-ID: <0463F45F3606F4428ED35AC8C709F92E047EBD5D@pdsmsx502.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi 

	Is there anybody familiar with SAP on other platform or SIM card related applications?
	We are trying to implement SAP (SIM Access Profile) for BlueZ.

	While I notice that except GSM 11.11 / GSM 11.14 / ISO 7816, there are PC/SC standard build upon ISO7816 for smartcard reader.
	And there are existing library say libpcsclite and libchipcard etc for PC/SC.

	So, my question is
	1 seems to handle smartcard reader is somehow standardized already. While how's case that a sim card is attached to BP modem, and modem will expose its own interface to access sim card? Is there any standard interface? (I don't see one)
	2 Should SAP be implemented independent with the current smartcard reader library and provide the data exchange method through dbus or should we somehow extend the current card reader related library and the pass on the data for user to a sap service (this way seems we might need to parse part of the SIM card APDU command)

	Can anyone have related experience give me some advises?
	Thanks 

Best Regards,
Raymond 

