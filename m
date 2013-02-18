Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Feb 2013 10:55:51 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Randy Yates <yates@digitalsignallabs.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: BT_ADDR not updated
Message-ID: <20130218085551.GA11034@x220>
References: <87bobkjoqs.fsf@randy.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87bobkjoqs.fsf@randy.site>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Randy,

On Sat, Feb 16, 2013, Randy Yates wrote:
> This question is regarding bluez 5.2:
> 
> i'm changing bt addr "on-the-fly" via a vendor-specific hcitool
> command but the bluetoothctl is not seeing the new address, even
> after a hciconfig hci0 reset
> 
> however i do see the new address via "hcitool dev", so it's getting
> changed in the device
> 
> is there some bug in bluez updating the device address on a reset?

The address is assumed to stay unchanged from the moment that the
existence of the controller is presented to user space, i.e. there is no
event through which user space would be notified of changes to its
address. If your hardware requires this kind of initialization (e.g. if
it doesn't have a proper address from the start) the best place for
writing the address would probably be the HCI driver's initialization
routine.

Johan
