Return-Path: <cyrus@holtmann.org>
Subject: Re: New property for DeviceFound signals to distinguish EIR devices
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20081201155356.GA28077@localhost>
References: <20081201155356.GA28077@localhost>
Content-Type: text/plain
Date: Mon, 01 Dec 2008 17:12:57 +0100
Message-Id: <1228147977.31158.149.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> I think it'd be beneficial to add a new property to the DeviceFound
> signals so that the UI performing the discovery would know if an
> Extended Inquiry Result was received and therefore conclude that this is
> a 2.1 (or newer) device. With the current API this is not really
> possible, e.g. a device name could be part of the signal because of EIR
> or it might be there simply because it was cached previously.
> 
> The benefit in knowing this "2.1 or newer" information is that the UI
> could anticipate whether legacy or secure simple pairing will be
> triggered or not. For us in Maemo we have only had to worry about legacy
> pairing so far due to 2.0 or older hardware. Because of this we have
> been able to eliminate the delay in getting a PIN request from the
> controller and the user responding to it simply by asking the user for
> the PIN *before* starting the actual pairing procedure. Especially for
> longer PINs there's a risk of a timeout error on the lower layers and so
> this delay elimination is a good thing.
> 
> Now, that SSP might occur it would be confusing for the user to be
> presented with a PIN dialog and then a few moments later with e.g. a
> passkey confirmation dialog for SSP. However, with the new property the
> UI could make this preliminary PIN entry only occur when it's really
> needed.
> 
> So, what should the new property be called?
> 
> * I proposed "SSP" (a boolean) on IRC but Marcel didn't think it's such
> a good idea since there shouldn't be any artificial coupling between SSP
> and EIR (since essentially they are two different things even though
> they typically occur together).
> 
> * If SSP isn't good, then how about "EIR" which would also be a boolean
> 
> * Another alternative would be to introduce a "Version" property that
> could be reused also in the Adapter interface to show which core spec
> version is being used. Another question is should it be numeric or a
> string? A numeric one would allow easy comparisons but a string would be
> more flexible and consistent with the rest of the D-Bus API.

so I do like the idea of a boolean property. That is pretty simple. So
my current proposal would be "LegacyPairing". Since the Simple Pairing
should become the default and handles all the use cases right, we only
need to detect the cases for the old 2.0 and before devices.

However this has a limitation. We make the assumption that we always get
the Extended Inquiry Result. So setting LegacyPairing=True doesn't mean
that we are not doing Simple Pairing. It just means that we don't know
at this point of time if the remote device supports its. In practice we
might not be seeing this, but it is not mandatory for 2.1 devices to
enable Extended Inquiry Response.

We could also cache the value since if we do SDP before initiating a
dedicated pairing (only fails with Security Mode 3 devices) and then we
do get the real value if Simple Pairing is enabled or not.

So while adding it to the DeviceFound properties would be nice, but I
think adding it to the actual device properties might make more sense.
However right now the wizard is not doing SDP before pairing.

Regards

Marcel


