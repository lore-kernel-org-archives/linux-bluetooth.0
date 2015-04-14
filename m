Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <CAJLTA8hYK9qiy+SfW-G+fZeHbOGYq4j0Z+L90p-8oaghCc_P7w@mail.gmail.com>
References: <1428692768-31941-1-git-send-email-jamuraa@chromium.org>
	<CABBYNZLwepfONDEtS_E9oODRRwzEfcB5hHcwFcBGhd1X9wyPPA@mail.gmail.com>
	<CAJLTA8hkry_iv8-Qe49J2vHiSLphycGFOu_aUKSPD8+hv9+=0g@mail.gmail.com>
	<97A5FA5F-A2DD-472B-A5F2-BEB218B10403@holtmann.org>
	<CAJLTA8hYK9qiy+SfW-G+fZeHbOGYq4j0Z+L90p-8oaghCc_P7w@mail.gmail.com>
Date: Tue, 14 Apr 2015 11:18:56 -0700
Message-ID: <CAHrH25RJt8Kh61Djqx+w9DECd3JfUEXjjA4wXdUDra6MuvkyGg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/4] Improvements to the LE Advertising API
From: Arman Uguray <armansito@chromium.org>
To: Michael Janssen <jamuraa@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

> On Mon, Apr 13, 2015 at 11:27 AM, Michael Janssen <jamuraa@chromium.org> =
wrote:
> Hi Marcel:
>
> On Mon, Apr 13, 2015 at 11:16 AM, Marcel Holtmann <marcel@holtmann.org> w=
rote:
>> Hi Michael,
>>
>>>>> Adds a method to add the TX Power attribute to the advertisements tha=
t are sent
>>>>> through the D-Bus interface, and supports more than one advertisement=
 based on
>>>>> the maximum number reported by the kernel.
>>>>
>>>> That doesn't say why we should expose the IncludeTXPower, I thought we
>>>> would let bluetoothd figure if that should be included or not, we may
>>>> not have enough space or don't have this information from the
>>>> controller.
>>>>
>>>
>>> This just exposes the flag that is available on the MGMT API. If we
>>> don't have a reason to turn it on and off from user space, we should
>>> remove that flag too.
>>
>> the kernel side needs this flag. You can not emulate it from userspace. =
The reason is that userspace has no idea what the actual TX power is. Only =
the kernel knows. If you build the value in userspace by yourself, then you=
 are plain faking / hardcoding it.
>
> We are not emulating it from userspace.  This property signals to the
> kernel to include the power.  It mirrors the MGMT API flag on the Add
> Advertising Command:
>
> 4 Add TX Power field to Adv_Data
>
> We do not build the value in userspace, but just set this flag when
> the property is set.
>

Michael is simply using this property to determine whether or not the
MGMT_ADV_FLAG_TX_POWER should passed to the mgmt command. I think such
an API makes sense, but did you have something different in mind like
always setting this flag from D-Bus?

>>
>> Regards
>>
>> Marcel
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Somewhat unrelated to the discussion but I think there is a bug in how
register_advertisement determines to return "AlreadyExists" as an
error. It looks like you're simply comparing object paths but you
should really be comparing the object path AND the sender. Basically
object paths are unique to each external application so if two of
these want to use an identical object path that should be OK.

Thanks,
Arman
