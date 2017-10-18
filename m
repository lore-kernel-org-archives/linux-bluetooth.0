Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 18 Oct 2017 14:16:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Surface 3 Pen (BLE HID) not sending events
Message-ID: <20171018111611.GA8301@x1c.lan>
References: <1508258502.5910.68.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1508258502.5910.68.camel@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Tue, Oct 17, 2017, Bastien Nocera wrote:
> The Surface 3 pen (part of the 2nd generation of Surface pens[1]) uses
> Bluetooth LE for its top button, which one can assign to a function,
> usually a note taking application on Windows.
> 
> After pairing, bluez throws away all the characteristics, UUIDs and
> other properties it gathered[2].
> 
> Subsequent attempts at pressing the pen button just throws a wobbly[3].
> 
> Any ideas? This apparently used to work, and there's some very hacky
> solutions for those devices:

Do you happen to have a btmon log of the pairing? The reason could e.g.
be that the device doesn't set the bonding flag (in which case our
discarding of information is at least specification-wise correct). The
HCI log you posted seems to be a reconnection when pairing has already
happened. Also, please avoid using hcidump since it does a worse job of
decoding stuff (especially newer protocol features).

Johan
