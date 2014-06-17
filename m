Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CD90C45F-0899-43A6-870C-DE24E43E5D04@holtmann.org>
References: <CANLOmB5UXAJRModTofiYy-gtj=DvDiq_PU_n6NswrbXw_9_94A@mail.gmail.com>
 <CD90C45F-0899-43A6-870C-DE24E43E5D04@holtmann.org>
From: Seon-Wook Park <seon.wook@swook.net>
Date: Tue, 17 Jun 2014 21:31:47 +0900
Message-ID: <CANLOmB5fo8JvrtXGdp+3eqXcPiSauEyD8L6Gcer0cWD6+Qtp_A@mail.gmail.com>
Subject: Re: L2CAP socket to HCI handle, opposite possible?
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

Thank you for your suggestions.

I notice in `doc/mgmt-api.txt` that there is no mention of updating
connection parameters, which is what we're currently aiming to get by
tweaking the library used. These parameters include:

- min. interval
- max. interval
- latency
- supervisor timeout

Is it possible to set connection parameters on BLE connect using the
mgmt API? It is possible with `hci_le_conn_create` but not with the
opening of an L2CAP socket connection.

Thanks again.

Regards,
Seon-Wook Park

On 17 June 2014 19:57, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Sean-Wook,
>
>> I'm currently using noble, a BLE library written in node.js.
>>
>> The issue, as mentioned in more detail on GitHub [2], has to do with
>> setting connection parameters on connect to a peripheral.
>>
>> The library currently connects to peripherals via a L2CAP socket
>> connection. The HCI handle for each connection is retrieved via
>> `getsockopt` using the key `L2CAP_CONNINFO`. This HCI handle is then
>> used for actions such as retrieving RSSI values.
>>
>> This unfortunately does not allow the setting of connection parameters
>> which can later be updated with `hci_le_conn_update` with a long
>> interval (15s) between connecting and acknowledging of parameters
>> update. This is not appropriate for our use.
>>
>> From looking through bluez sources, I have gathered that min/max
>> interval parameters are taken from a `struct hci_dev` associated with
>> the connection attempt, while supervisation_timeout values have
>> hardcoded defaults. The `hci_dev` struct is unretrievable however. Is
>> there a way I have missed?
>>
>> These problems could be alleviated if I could create a HCI socket
>> connection and retrieve/create a L2CAP channel from it to use in
>> further communication. Is this possible?
>
> the problem is that it is using a really bad combination of kernel interf=
aces. The raw HCI access to the socket has been deprecated since a while no=
w and we are not writing direct HCI commands anymore.
>
> This means if you want to use L2CAP sockets to run ATT/GATT over it, then=
 you should use the mgmt API (doc/mgmt-api.txt) for handling all the power =
related functionality. However using mgmt API directly makes only sense if =
you are not running bluetoothd. If you are running bluetoothd then you shou=
ld integrate with the D-Bus API of bluetoothd.
>
> Another alternative for LE only support might be to actually use the HCI =
User Channel feature that got introduced with Linux 3.13. This one allows y=
ou direct access to the HCI layer of the Bluetooth module and it makes sure=
 that bluetoothd or any other tool will stay away from it. It provides you =
a H:4 framed socket where you can send and receive HCI commands, event and =
data packets directly. However entering HCI User Channel means that you can=
 no longer user L2CAP sockets. So you have to implement that L2CAP part in =
noble itself. An example of how easy the HCI User Channel is can be found i=
n tools/ibeacon.c.
>
> So either you trust the kernel to do the right thing when it comes to HCI=
 support and focus on mgmt API or you drive the whole host stack by yoursel=
f by using HCI User Channel. I think using HCI User Channel is the better a=
pproach. Especially if you are looking into LE only support.
>
> Regards
>
> Marcel
>
