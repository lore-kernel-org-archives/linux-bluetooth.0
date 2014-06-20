Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <FDFE96A3-5B0D-440D-B9BF-1905E4BC2034@holtmann.org>
References: <CANLOmB5UXAJRModTofiYy-gtj=DvDiq_PU_n6NswrbXw_9_94A@mail.gmail.com>
 <CD90C45F-0899-43A6-870C-DE24E43E5D04@holtmann.org> <CANLOmB5fo8JvrtXGdp+3eqXcPiSauEyD8L6Gcer0cWD6+Qtp_A@mail.gmail.com>
 <FDFE96A3-5B0D-440D-B9BF-1905E4BC2034@holtmann.org>
From: Seon-Wook Park <seon.wook@swook.net>
Date: Fri, 20 Jun 2014 14:18:04 +0900
Message-ID: <CANLOmB5K6=B3H3-7DMVBspJVNzgSF2rc=GAa7oqvTBk1QtWvjQ@mail.gmail.com>
Subject: Re: L2CAP socket to HCI handle, opposite possible?
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

>> Thank you for your suggestions.
>>
>> I notice in `doc/mgmt-api.txt` that there is no mention of updating
>> connection parameters, which is what we're currently aiming to get by
>> tweaking the library used. These parameters include:
>>
>> - min. interval
>> - max. interval
>> - latency
>> - supervisor timeout
>>
>> Is it possible to set connection parameters on BLE connect using the
>> mgmt API? It is possible with `hci_le_conn_create` but not with the
>> opening of an L2CAP socket connection.
>
> if you search the archive there is an API proposal for storing proposed c=
onnection parameters and being able to load them back on system start. So t=
hat once a peripheral has proposed different connection parameters, they wi=
ll be horned automatically for the next connection creation.
>
> Changing them on the central independent on what the peripheral wants fro=
m us is something that only Bluetooth 4.1 devices with link layer topology =
are suppose to do and for that a new L2CAP socket option would be needed.

Thanks yet again for your response.

I found that the L2CAP socket open does reuse existing HCI
connections. Therefore one can create a HCI connection, then open a
L2CAP socket to use custom connection parameters.

This has solved our issue for now, though I will definitely keep your
comments in mind for when I next work with low-level BLE.

Thanks and best regards,

Seon-Wook Park
