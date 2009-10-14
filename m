Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2d5a2c100910120306g54a8c79bt42164babb123f4b2@mail.gmail.com>
References: <1e9e22610910111120p25a850bflcc31794f7e29192e@mail.gmail.com>
	 <2d5a2c100910120306g54a8c79bt42164babb123f4b2@mail.gmail.com>
Date: Wed, 14 Oct 2009 08:51:25 -0300
Message-ID: <1e9e22610910140451t7b98d14eq807fddb53a83d43c@mail.gmail.com>
Subject: Re: Failed to connect to SDP server / Connection reset by peer
From: Addo Del Grossi <addo.delgrossi@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,


Below the hcidump resulsts.

HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
2009-10-14 08:46:21.982680 < HCI Command: Create Connection
(0x01|0x0005) plen 13
    bdaddr 00:0E:6D:70:B9:A6 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2009-10-14 08:46:22.014774 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2009-10-14 08:46:24.795777 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:0E:6D:70:B9:A6 type ACL encrypt 0x00
2009-10-14 08:46:24.795829 < HCI Command: Read Remote Supported
Features (0x01|0x001b) plen 2
    handle 42
2009-10-14 08:46:24.800673 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
2009-10-14 08:46:24.812688 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
2009-10-14 08:46:24.814685 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
2009-10-14 08:46:24.814699 < HCI Command: Remote Name Request
(0x01|0x0019) plen 10
    bdaddr 00:0E:6D:70:B9:A6 mode 2 clkoffset 0x0000
2009-10-14 08:46:24.819703 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2009-10-14 08:46:24.823702 > HCI Event: Read Remote Supported Features
(0x0b) plen 11
    status 0x00 handle 42
    Features: 0xbf 0x28 0x21 0x00 0x00 0x00 0x00 0x00
2009-10-14 08:46:24.823739 < ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
2009-10-14 08:46:24.829775 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 42 packets 1
2009-10-14 08:46:24.845778 > ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Info rsp: type 1 result 1
      Not supported
2009-10-14 08:46:24.865698 > HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:0E:6D:70:B9:A6 name 'Nokia 6610'
2009-10-14 08:46:24.868054 < HCI Command: Read Remote Version
Information (0x01|0x001d) plen 2
    handle 42
2009-10-14 08:46:24.869689 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 42 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 5000
    Delay variation: -1
2009-10-14 08:46:24.873773 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Version Information (0x01|0x001d) status 0x00 ncmd 1
2009-10-14 08:46:24.883704 > HCI Event: Read Remote Ver Info Complete
(0x0c) plen 8
    status 0x00 handle 42
    LMP Version: 1.1 (0x1) LMP Subversion: 0x248
    Manufacturer: Nokia Mobile Phones (1)
2009-10-14 08:46:28.896709 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x13
    Reason: Remote User Terminated Connection



Thank you very much!,
Addo




On Mon, Oct 12, 2009 at 7:06 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Sun, Oct 11, 2009 at 8:20 PM, Addo Del Grossi
> <addo.delgrossi@gmail.com> wrote:
>> Hi,
>>
>> I upgraded to Ubuntu Karmic and found problems when using the command sdptool.
>> I was found that the problem only when use the kernel 2.6.31,
>> using the old 2.6.28 Kernel sdptool the command works correctly.
>>
>> Note: We also did the test by downloading the Vanilla kernel
>> kernel.org site and the same error was found.
>>
>
> It is difficult to guess without hcidump output, could you please try
> this: > sudo hcidump -XVt
>
> There is a high chance that this is not really related to sdptool
> itself, as you are using the same BlueZ version in both cases, but
> some pairing/bonding/security issue.
>
> --
> Luiz Augusto von Dentz
