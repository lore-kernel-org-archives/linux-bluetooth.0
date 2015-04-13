Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <97A5FA5F-A2DD-472B-A5F2-BEB218B10403@holtmann.org>
References: <1428692768-31941-1-git-send-email-jamuraa@chromium.org>
	<CABBYNZLwepfONDEtS_E9oODRRwzEfcB5hHcwFcBGhd1X9wyPPA@mail.gmail.com>
	<CAJLTA8hkry_iv8-Qe49J2vHiSLphycGFOu_aUKSPD8+hv9+=0g@mail.gmail.com>
	<97A5FA5F-A2DD-472B-A5F2-BEB218B10403@holtmann.org>
Date: Mon, 13 Apr 2015 11:27:23 -0700
Message-ID: <CAJLTA8hYK9qiy+SfW-G+fZeHbOGYq4j0Z+L90p-8oaghCc_P7w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/4] Improvements to the LE Advertising API
From: Michael Janssen <jamuraa@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel:

On Mon, Apr 13, 2015 at 11:16 AM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Michael,
>
>>>> Adds a method to add the TX Power attribute to the advertisements that=
 are sent
>>>> through the D-Bus interface, and supports more than one advertisement =
based on
>>>> the maximum number reported by the kernel.
>>>
>>> That doesn't say why we should expose the IncludeTXPower, I thought we
>>> would let bluetoothd figure if that should be included or not, we may
>>> not have enough space or don't have this information from the
>>> controller.
>>>
>>
>> This just exposes the flag that is available on the MGMT API. If we
>> don't have a reason to turn it on and off from user space, we should
>> remove that flag too.
>
> the kernel side needs this flag. You can not emulate it from userspace. T=
he reason is that userspace has no idea what the actual TX power is. Only t=
he kernel knows. If you build the value in userspace by yourself, then you =
are plain faking / hardcoding it.

We are not emulating it from userspace.  This property signals to the
kernel to include the power.  It mirrors the MGMT API flag on the Add
Advertising Command:

4 Add TX Power field to Adv_Data

We do not build the value in userspace, but just set this flag when
the property is set.

>
> Regards
>
> Marcel
>
