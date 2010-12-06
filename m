Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTik=WyfpbULNywPPXGi-KB=6tK3on2p6TYL94E0O@mail.gmail.com>
References: <1291386532-4985-1-git-send-email-claudio.takahasi@openbossa.org>
	<AANLkTik=WyfpbULNywPPXGi-KB=6tK3on2p6TYL94E0O@mail.gmail.com>
Date: Mon, 6 Dec 2010 15:20:01 -0300
Message-ID: <AANLkTimrcQTPWEr39WG9f_+-jEbkn4T-6_33KGqOdtfV@mail.gmail.com>
Subject: Re: [PATCH 1/5] Add device type to identify LE, BR/EDR or dual mode devices
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

>> +{
>> +       /* Inferring the remote type based on the EIR Flags field */
>> +
>> +       if (flags & EIR_SIM_CONTROLLER && flags & EIR_SIM_HOST)
>> +               return DUALMODE_TYPE;
>
> Can the above be simplified to the following?
>
>  if (flags & (EIR_SIM_CONTROLLER | EIR_SIM_HOST))

We are both wrong, read the last sentence for dual mode devices.

>From Bluetooth SPEC(page 1744):

BR/EDR/LE OPERATION MODES AND PROCEDURE
13.1.1.2 Discoverable Mode
...
A device supporting both BR/EDR and LE physical links shall expose the
capabilities of both physical links by performing the following steps:
a) The ‘LE Supported (Controller)’ and ‘LE Supported (Host)’ bits in
the LMP features shall be set as defined in [Vol. 2], Part C Section
3.2.
b) The ‘BR/EDR Not Supported’ bit in the Flags AD type shall be set to
‘0’ as defined in Section 18.1.
c) The ‘Simultaneous LE and BR/EDR to Same Device Capable
(Controller)’ and ‘Simultaneous LE and BR/EDR to Same Device Capable
(Host)’ bits in the Flags AD type shall be set to ‘0’ as defined in
Section 18.1

>
> I know the semantics will change slightly, but I suppose that either
> host or controller supports simultaneous LE and BR/EDR, it can be
> considered dual mode. It would no be necessary to have *both* bits set
> (my impression).
>
>> @@ -3082,6 +3098,7 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
>>        if (new_dev) {
>>                dev->le = TRUE;
>>                dev->evt_type = info->evt_type;
>> +               dev->type = LE_TYPE;
>>        } else if (dev->rssi == rssi)
>>                return;
>>
>
> Can you remind me why both dev->le and dev->type are necessary in
> struct remote_dev_info ?

"le" will be removed. Thanks!

Regards,
Claudio
