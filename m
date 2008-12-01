Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Dec 2008 18:45:59 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: New property for DeviceFound signals to distinguish EIR devices
Message-ID: <20081201164559.GA30372@localhost>
References: <20081201155356.GA28077@localhost> <1228147977.31158.149.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1228147977.31158.149.camel@violet.holtmann.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Dec 01, 2008, Marcel Holtmann wrote:
> so I do like the idea of a boolean property. That is pretty simple. So
> my current proposal would be "LegacyPairing". Since the Simple Pairing
> should become the default and handles all the use cases right, we only
> need to detect the cases for the old 2.0 and before devices.
> 
> However this has a limitation. We make the assumption that we always get
> the Extended Inquiry Result. So setting LegacyPairing=True doesn't mean
> that we are not doing Simple Pairing. It just means that we don't know
> at this point of time if the remote device supports its. In practice we
> might not be seeing this, but it is not mandatory for 2.1 devices to
> enable Extended Inquiry Response.

I'd be fine with adding a LecacyPairing boolean both to the DeviceFound
signal and the Device interface. I don't think the false-positive case
is too bad since it shouldn't happen often and the UI can simply fall
back to SSP then (which is a potential source of confusion for the user
but at least the pairing can proceed).

> We could also cache the value since if we do SDP before initiating a
> dedicated pairing (only fails with Security Mode 3 devices) and then we
> do get the real value if Simple Pairing is enabled or not.

The problem is precisely these Security Mode 3 devices. I still see
plenty of them when I go to UnplugFests. If we go ahead and try to do
SDP with them before dedicated bonding we've already lost the chance to
get the PIN from the user before its actually requested by the
controler. We could simply reject any PIN request caused by the SDP but
that has at least the following issues:

1. it would make the overall procedure longer (and the double
connect/auth request could have interop. implications with some devices)

2. it can't be done in a clean way with the existing D-Bus API since
there's no direct agent association for CreateDevice like there is for
CreatePairedDevice

> So while adding it to the DeviceFound properties would be nice, but I
> think adding it to the actual device properties might make more sense.
> However right now the wizard is not doing SDP before pairing.

At least according to the API doc, whatever property is available in the
DeviceFound signal should also be available in the Device interface. So
if we add this to the DeviceFound signal the rest takes care of itself
if we intend to conform to the current API description :)

Johan
