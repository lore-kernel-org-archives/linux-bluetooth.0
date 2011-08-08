Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMhHtTzr_jguh1MpF+_-4m1_he-4KhR7fc9TscsVb4aFDX12jA@mail.gmail.com>
References: <CAJdJm_OmwPrc_3nT3zOSa0PLQBfr8hzyXuWHj=JJXYdWagoG7w@mail.gmail.com>
 <CAMhHtTzr_jguh1MpF+_-4m1_he-4KhR7fc9TscsVb4aFDX12jA@mail.gmail.com>
From: Ash K <ashoksarf@gmail.com>
Date: Mon, 8 Aug 2011 17:00:53 -0500
Message-ID: <CAMhHtTzN0hr_LucwSd8Sg=+XHkyV2nSyAECrg-2FOavfS+69xA@mail.gmail.com>
Subject: Re: [RFC] New mgmt API for Features Exchange (was: Re: Security level
 for Primary Services discovery during pairing)
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: VISHWANATH KM <a21174@motorola.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Also, section 2.1 from core spec 4.0 L2CAP says:

2.1 CHANNEL IDENTIFIERS
A channel identifier (CID) is the local name representing a logical
channel endpoint
on the device. The null identifier (0x0000) shall never be used as a destination
endpoint. Identifiers from 0x0001 to 0x003F are reserved for specific
L2CAP functions. These channels are referred to as Fixed Channels. At a minimum,
the L2CAP Signaling channel (Fixed Channel 0x0001) or the L2CAP LE
Signaling channel (Fixed Channel 0x0005) shall be supported. If Fixed Channel
0x0005 is supported, then Fixed Channels 0x0004 and 0x0006 shall be
supported (see Table 2.1).

Which mean SMP L2CAP (0x0006) channel is mandatory if a device is
using LE connection. In least case a implementation would have to
implement SMP module which returns error (pairing not supported or
command not supported). This procedure could be used to identify if
SMP is supported.

As I said in earlier mail, SMP procedure might not be invoked until a
service requests for it. This might make error handling easier, since
once would have just return GATT procedure failure since stating
remote device does not support pairing or pairing command.


On Mon, Aug 8, 2011 at 12:05 PM, Ash K <ashoksarf@gmail.com> wrote:
> Hi All,
>
> LE is designed for low energy devices and as far as I can understand
> Encryption/security related features are should not be used until the
> service requests for it (even if it is supported), this might drain
> low energy devices unnecessarily (since some service may not need
> security). For example: Device Information service access.
>
> The correct procedure would be to start security related procedure
> once any GATT service request for it. You can see the procedure in
> "BLUETOOTH SPECIFICATION Version 4.0 [Vol 3] page 365 of 656"
> (Bluetooth 4.0 core spec absolute page number 1725). Attached the flow
> chart image from spec.
>
> As soon as you see a request for security mode, you can assume that
> remote device supports SMP and encryption bit can also be verified
> from remote feature.
>
> Let me know thoughts.
>
> Thanks,
> Ashok
>
> On Mon, Aug 8, 2011 at 10:32 AM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
>> Hi,
>>
>> On Mon, Aug 8, 2011 at 10:59 AM, VISHWANATH KM <a21174@motorola.com> wrote:
>>>> I think you have two options:
>>>>
>>>> 1) Always use CreateDevice(). Then if you want to issue SMP pairing,
>>>> you can change the BT_IO_SECLEVEL when connection with bt_io_connect()
>>>> (I haven't tested this lately, but I remember it used to work).
>>>>
>>>> 2) Extend the kernel Management API to allow Features Exchange. See
>>>> doc/mgmt-api.txt for the existing commands, to have an idea on how it
>>>> works (I recommend first sending an API proposal here to the list).
>>>
>>> Option 2 sounds better, where we use CreatePairedDevice and after the LE ACL
>>> is established we can do LE Read Remote features, (similar to what we do for
>>> BR i.e we do HCI Read Remote features in conn complete ) and if Encryption
>>> feature bit is set then we trigger SMP else we don't, pls let me know if any
>>> comments, if this sounds ok then i will mail the changes to this maillist
>>> for further review
>>
>> Let's hear others opinions. Johan, Marcel, Gustavo?
>>
>> Regards,
>> --
>> Anderson Lizardo
>> Instituto Nokia de Tecnologia - INdT
>> Manaus - Brazil
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
>
> --
> Ash
>



-- 
Ash
