Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimhUD74h=QDKQu=EGfPXYHafuTMnwQ-RbGeaUFp@mail.gmail.com>
References: <AANLkTi=652bHGqL841fp1ufO1_7C3iTq+tZ4eBcGtEiO@mail.gmail.com>
	<4D4BED6C.3040506@nokia.com>
	<AANLkTinVkr3ivG0-Jt-sCJe0VLpPFTUAgDaTTiM5U51A@mail.gmail.com>
	<AANLkTimhUD74h=QDKQu=EGfPXYHafuTMnwQ-RbGeaUFp@mail.gmail.com>
Date: Wed, 9 Feb 2011 17:17:03 +0530
Message-ID: <AANLkTinRHYs+W+os7xn1O9cehqFnzOzhnedsqXWiNAcN@mail.gmail.com>
Subject: Re: Not able to test GATT on ubuntu
From: Vijayalakshmi N <vijayalakshmi.nk@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mika Linnanoja <mika.linnanoja@nokia.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Feb 4, 2011 at 7:15 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Fri, Feb 4, 2011 at 2:33 PM, Vijayalakshmi N
> <vijayalakshmi.nk@gmail.com> wrote:
>> Hi Mika,
>>
>> I did use --le option but I get that the socket cannot bind error:
>>
>> l2cap_bind: Address already in use (98)
>>
>> I did take Vinicius Gomes'  kernel patches for LE and compile it.
>>
>> I will get the hcidump for LE as you have said.
>>
>> Could you pls. tell me why I'm getting the l2cap error.
>
> Well that normally indicate that there is some other application
> listen on the same psm, but I doubt that could happen in this case
> since normally you are not able to run multiple instances of
> bluetoothd simultaneously, so perhaps this could be caused by LE not
> enabled in the kernel or something like that.

Now I have an updated setup where the bluetooth kernel code with BLE
patches are taken from
http://git.infradead.org/users/vcgomes/linux-2.6.git/tree/refs/heads/devel
and hcidump 2.0

With the gatttool cmd
 gatttool -i hci0 -b <bdaddr> --uuid=0x1801 --start=0x0001
--end=0x0fff --primary

just returns with
"Discover primary services by UUID failed: No attribute found within
the given range"

Though my SDP Record at the Server has the attribute for 0x0004 which
is 'protocol Descriptor List' well with in the range of 0x0001 &
0x0fff.
I also tried to set a user defined attribute using sdptool setattr
command and then used the relative range on the client; but still the
response was failure.

The procedure that I followed was:
At the GATT Server side
1. GATT Service is registered (automatically with the bt daemon)
2. Enable piscan
3. Enable advertising

At the Client side
1. Do lescan
2. Do lecc
or without 1& 2 also
3. gatttool -i hci0 -b <bdaddr> --uuid=0x1801 --start=0x0001
--end=0x0fff --primary

Should I be listening at the GATT Server to reposnd to the Primary
Services request?
Or is there any other settings to be followed?
Pls. help.

Please find the hcidump for the same (Master BT device):

 HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 08:00:28:0D:61:56 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 08:00:28:0D:61:56 type ACL encrypt 0x00
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 1
    Features: 0xff 0xfe 0x2d 0xfe 0xdb 0xff 0x7b 0x87
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 1 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 1 page 1 max 1
    Features: 0x07 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 08:00:28:0D:61:56 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 08:00:28:0D:61:56 name 'GATT_SERVER'
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 1
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 08:00:28:0D:61:56
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 08:00:28:0D:61:56 key 60CD21545C338F83BA01C22A9076D385
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 08:00:28:0D:61:56
> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 1
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
    handle 1 encrypt 0x01
> HCI Event: Command Status (0x0f) plen 4
    Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 1 encrypt 0x01
< ACL data: handle 1 flags 0x00 dlen 10
    06 00 01 00 0A 01 02 00 02 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x00b8
< ACL data: handle 1 flags 0x00 dlen 10
    06 00 01 00 0A 02 02 00 03 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 20
    L2CAP(s): Info rsp: type 3 result 0
      Fixed channel list
< ACL data: handle 1 flags 0x00 dlen 12
    08 00 01 00 02 03 04 00 1F 00 40 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< ACL data: handle 1 flags 0x00 dlen 16
    0C 00 01 00 0B 01 08 00 02 00 00 00 B8 00 00 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(s): Info req: type 3
< ACL data: handle 1 flags 0x00 dlen 20
    10 00 01 00 0B 02 0C 00 03 00 00 00 02 00 00 00 00 00 00 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> ACL data: handle 1 flags 0x02 dlen 23
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 11
      RFC 0x00 (Basic)
< ACL data: handle 1 flags 0x00 dlen 23
    13 00 01 00 04 04 0F 00 40 00 00 00 04 09 00 00 00 00 00 00
    00 00 00
< ACL data: handle 1 flags 0x00 dlen 18
    0E 00 01 00 05 03 0A 00 40 00 00 00 00 00 01 02 A0 02
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 2
> ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 672
< ACL data: handle 1 flags 0x00 dlen 13
    09 00 40 00 06 01 00 FF 0F 00 28 01 18
Discover primary services by UUID failed: No attribute found within
the given range
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 0]
      01 06 01 00 0A
< ACL data: handle 1 flags 0x00 dlen 12
    08 00 01 00 06 05 04 00 40 00 40 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
root@ubuntu-desktop:/home/ubuntu# < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 1 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x16
    Reason: Connection Terminated by Local Host

Thanks,
Vijayalakshmi
>
>> Thanks,
>> Vijayalakshmi
>>
>>
>>
>> On Fri, Feb 4, 2011 at 5:43 PM, Mika Linnanoja <mika.linnanoja@nokia.com> wrote:
>>> On 02/04/2011 01:59 PM, ext Vijayalakshmi N wrote:
>>>>
>>>> Dear all,
>>>>
>>>> I have taken the bluetooth code with BLE changes  (net/bluetooth and
>>>> include/net/bluetooth) from
>>>>
>>>>
>>>> http://git.infradead.org/users/vcgomes/linux-2.6.git/tree/refs/heads/le-l2cap
>>>> to my 2.6.35 kernel and built the kernel.
>>>>
>>>> and also built bluez 4.84 on ubuntu 10.10.
>>>>
>>>> Tried testing GATT with the gatttool that is available with the bluez.
>>>>
>>>> gatttool --primary -b<bd-address>
>>>
>>> Hi.
>>>
>>> If you want to use LE add "--le" to gatttool options. Otherwise (and evident
>>> from your hcidump) it tries to create classic BT connection.
>>>
>>> We haven't tried adding LE kernel patches to .35 kernels (stock ubuntu one),
>>> why don't you checkout whole vcgomes' kernel and compile it for your ubuntu
>>> box instead?
>>>
>>> Boots fine in Ubuntu 10.10. Used "make oldconfig" with .config from /boot/
>>> for stock kernel and answered defaults to most questions and "Y" to the one
>>> asking about enabling SMP for BT LE.
>>>
>>>> Please see the log (hcidump) of the Master BT device below followed by
>>>> the hcidump of Slave (GATT Server).
>>>
>>> Also, upgrade to hcidump 2.0 it has LE stuff in it, logs will be more
>>> useful. Ie get git version and compile and run from compile dir, no need to
>>> install.
>>>
>>>> Thanks,
>>>> Vijayalakshmi
>>>
>>> BR,
>>> Mika
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
>
> --
> Luiz Augusto von Dentz
> Computer Engineer
>
