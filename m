Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH] Add GetCachedServices to device API.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1362187350-23421-1-git-send-email-deymo@chromium.org>
Date: Fri, 1 Mar 2013 17:29:30 -0800
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org,
	johan.hedberg@intel.com
Message-Id: <1756C3D5-55FB-4037-BEC4-4095E49B43D3@holtmann.org>
References: <1362187350-23421-1-git-send-email-deymo@chromium.org>
To: Alex Deymo <deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,


> This fix implements a new GetCachedServices() function with similar
> functionality as DiscoverServices(), except it only retrieves information
> from an internal cache.
> 
> Signed-off-by: Alex Deymo <deymo@chromium.org>
> 
> ---
> 
> Some background:
> Currently, only the device properties are always available while the device
> is off or out of range, but the service records are not. The
> org.bluez.Device.ServiceRecords() call fails if the device is off, but some
> important information relevant to the connection is present only there. For
> example, for mice and keyboard, the HIDNormallyConnectable and
> HIDReconnectInitiate tells if we are supposed to initiate a connection to
> the device while it is off. When bluetoothd restarts and has such a divice
> paired in its records, there is no way from the DBus interface to tell if
> this device is "normally connectable" or not. This GetCachedServices() aims
> to solve this problem.

why would we expose this in this format and not make the HID support work according to these SDP attributes? Just make it work without having any application interact with it.

Or on a different questions, why are these not exported as properties for the input interface. Why this big hammer one fits all approach?

Regards

Marcel

