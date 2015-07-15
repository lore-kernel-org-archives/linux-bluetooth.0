Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1286560591.507561436424400764.JavaMail.weblogic@ep2mlwas08a>
References: <1286560591.507561436424400764.JavaMail.weblogic@ep2mlwas08a>
Date: Wed, 15 Jul 2015 15:14:32 +0300
Message-ID: <CABBYNZ+z0bNxzRSJT9ntF2Rw-Ufi==xHsDbUG5MUdJgqV-_eKQ@mail.gmail.com>
Subject: Re: [Request] Clarification related to pairing in a particular scenario
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: nagaraj.dr@samsung.com
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"s.syam@samsung.com" <s.syam@samsung.com>,
	"rakesh.mk@samsung.com" <rakesh.mk@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jul 9, 2015 at 9:46 AM, Nagaraj D R <nagaraj.dr@samsung.com> wrote:
> Hello all,
> could someone please clarify my doubt related to the concept of pairing in a particular scenario
>
> If a remote device having no I/O capability (also authentication : general bonding, and  No MITM protection)
> sent a pairing request to our local device(DUT running with the bluez stack), local device stack auto accept
> the pairing request even though local device has I/O capability
>
> Is the Behavior of auto-accepting the pairing request justified?
> -- According to the specification "From the Bluetooth Core Specification 4.1 page 1958:
>  "if both devices have set the Authentication_Requirements parameter to one of the MITM
>   Protection Not Required options, authentication stage 1 shall function as if both devices
>   set their IO capabilities to  DisplayOnly (e.g., Numeric comparison with automatic confirmation on both devices)"

There is a more precise answer to this in:

BLUETOOTH SPECIFICATION Version 4.2 [Vol 3, Part C]
page 323 Table 5.7: IO Capability Mapping to Authentication Stage 1

So if we rule No MITM shall be treated as DisplayOnly it would fall
into the very first case described in that table:

'Numeric Comparison with automatic confirmation on both devices'.

>  Local device had set the "NO MITM protection required" based on the remote authentication and capabilities.
>   Is the behavior of over-riding local device MITM capability necessary?
>
> In case of local device initiating a connection to the remote device, auto accept from the stack is acceptable
> but in case of remote initiated connection, auto-accept will cause user inconvenience, Isn't it?
>
> I have tested the similar scenario with the device having bluedroid stack, here we get a authorization popup,
> action on which will complete the pairing and connection. i.e auto-pairing is not done in stack

I guess it is because it does not take into account that No MITM shall
be treated as DisplayOnly.

> May be we all have the following query,
> How does remote-device sent pairing request to Local device, when it doesn't have "NoInputNoOutput" capability?
> Ans: Remote device was paired and connected by local device first and then disconnected and link key is removed in the local device.
>         When remote device is restarted, it is attempting to connect to the local device. When link-key validation failed, it attempted pairing

We I assume the default for Android in DisplayYesNo, so I have no idea
how it end up with NoInputNoOutput, also this could downgrade the
previous link key from authenticated to unauthenticated which I don't
think is secure, in short I think there is a bug in Android and it
shall never send NoInputNoOutput. In fact I experience something
different recently, Android would sent No Bonding flag when
reconnecting but with MITM, but this was with 4.4 not 5.0.

> Remote device : I'm using Motorola Roadster 2
> Local device : DUT running with latest bluez stack
>
>
> HCI_Dump snippet when remote device initiated the connection to local device(DUT)
>> HCI Event: Link Key Request (0x17) plen 6
>     bdaddr 00:24:1C:D6:6F:1B
> < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
>     bdaddr 00:24:1C:D6:6F:1B
>> HCI Event: Command Complete (0x0e) plen 10
>     Link Key Request Negative Reply (0x01|0x000c) ncmd 1
>     status 0x00 bdaddr 00:24:1C:D6:6F:1B
>> HCI Event: IO Capability Response (0x32) plen 9
>     bdaddr 00:24:1C:D6:6F:1B capability 0x03 oob 0x00 auth 0x04
>     Capability: NoInputNoOutput (OOB data not present)
>     Authentication: General Bonding (No MITM Protection)
>> HCI Event: IO Capability Request (0x31) plen 6
>     bdaddr 00:24:1C:D6:6F:1B
> < HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
>     bdaddr 00:24:1C:D6:6F:1B capability 0x01 oob 0x00 auth 0x04
>     Capability: DisplayYesNo (OOB data not present)
>     Authentication: General Bonding (No MITM Protection)
>> HCI Event: Command Complete (0x0e) plen 10
>     IO Capability Request Reply (0x01|0x002b) ncmd 1
>     status 0x00 bdaddr 00:24:1C:D6:6F:1B
>> HCI Event: User Confirmation Request (0x33) plen 10
>     bdaddr 00:24:1C:D6:6F:1B passkey 297587
> < HCI Command: User Confirmation Request Reply (0x01|0x002c) plen 6
>     bdaddr 00:24:1C:D6:6F:1B
>> HCI Event: Command Complete (0x0e) plen 10
>     User Confirmation Request Reply (0x01|0x002c) ncmd 1
>     status 0x00 bdaddr 00:24:1C:D6:6F:1B
>> HCI Event: Simple Pairing Complete (0x36) plen 7
>     status 0x00 bdaddr 00:24:1C:D6:6F:1B
>> HCI Event: Link Key Notification (0x18) plen 23
>     bdaddr 00:24:1C:D6:6F:1B key 1F9A7E9411E435EA4DF05A10E6DEE451 type 4
>     Type: Unauthenticated Combination Key
>
>
>
> Regards
> Nagaraj D R



-- 
Luiz Augusto von Dentz
