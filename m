Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH BlueZ 0/4] Improvements to the LE Advertising API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJLTA8hkry_iv8-Qe49J2vHiSLphycGFOu_aUKSPD8+hv9+=0g@mail.gmail.com>
Date: Mon, 13 Apr 2015 11:16:07 -0700
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <97A5FA5F-A2DD-472B-A5F2-BEB218B10403@holtmann.org>
References: <1428692768-31941-1-git-send-email-jamuraa@chromium.org> <CABBYNZLwepfONDEtS_E9oODRRwzEfcB5hHcwFcBGhd1X9wyPPA@mail.gmail.com> <CAJLTA8hkry_iv8-Qe49J2vHiSLphycGFOu_aUKSPD8+hv9+=0g@mail.gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

>>> Adds a method to add the TX Power attribute to the advertisements that are sent
>>> through the D-Bus interface, and supports more than one advertisement based on
>>> the maximum number reported by the kernel.
>> 
>> That doesn't say why we should expose the IncludeTXPower, I thought we
>> would let bluetoothd figure if that should be included or not, we may
>> not have enough space or don't have this information from the
>> controller.
>> 
> 
> This just exposes the flag that is available on the MGMT API. If we
> don't have a reason to turn it on and off from user space, we should
> remove that flag too.

the kernel side needs this flag. You can not emulate it from userspace. The reason is that userspace has no idea what the actual TX power is. Only the kernel knows. If you build the value in userspace by yourself, then you are plain faking / hardcoding it.

Regards

Marcel

