Return-Path: <cyrus@holtmann.org>
Subject: Re: New property for DeviceFound signals to distinguish EIR devices
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20081201164559.GA30372@localhost>
References: <20081201155356.GA28077@localhost>
	 <1228147977.31158.149.camel@violet.holtmann.net>
	 <20081201164559.GA30372@localhost>
Content-Type: text/plain
Date: Mon, 01 Dec 2008 18:05:44 +0100
Message-Id: <1228151144.31158.151.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > so I do like the idea of a boolean property. That is pretty simple. So
> > my current proposal would be "LegacyPairing". Since the Simple Pairing
> > should become the default and handles all the use cases right, we only
> > need to detect the cases for the old 2.0 and before devices.
> > 
> > However this has a limitation. We make the assumption that we always get
> > the Extended Inquiry Result. So setting LegacyPairing=True doesn't mean
> > that we are not doing Simple Pairing. It just means that we don't know
> > at this point of time if the remote device supports its. In practice we
> > might not be seeing this, but it is not mandatory for 2.1 devices to
> > enable Extended Inquiry Response.
> 
> I'd be fine with adding a LecacyPairing boolean both to the DeviceFound
> signal and the Device interface. I don't think the false-positive case
> is too bad since it shouldn't happen often and the UI can simply fall
> back to SSP then (which is a potential source of confusion for the user
> but at least the pairing can proceed).

okay. Then lets add a boolean "LegacyPairing" property and see how far
this helps us with improving the wizard.

Regards

Marcel


