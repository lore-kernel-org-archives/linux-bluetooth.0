Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Jul 2010 00:32:25 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: Re: L2CAP unknown options
Message-ID: <20100728033225.GB22156@vigoh>
References: <4C4EA1CB.2050406@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C4EA1CB.2050406@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

* Ville Tervo <ville.tervo@nokia.com> [2010-07-27 12:07:23 +0300]:

> Hi,
> 
> I found following problem with bluetooth-next-2.6.
> 
> Kernel disconnects if remote device replies with "unknown options"
> result code. I guess in that case a new config req should be sent
> without unknown option. I didn't check the spec yet.

It's a regression introduced by this commit 
625477523b4e656fbcc5ec2a8ca7a1beb39b1caf

It adds the RFC when requesting Basic Mode, this is a PTS requirement.
A possible fix should be send a new Config Req without RFC or do not
send the RFC in the first request when the other side doesn't support
Info Req.

> 
> The remote device is Nokia 9300.
> 
> 2010-07-27 11:44:07.364827 < ACL data: handle 11 flags 0x02 dlen 10
>     L2CAP(s): Info req: type 2
> 2010-07-27 11:44:07.365337 < HCI Command: Remote Name Request
> (0x01|0x0019) plen 10
>     bdaddr 00:12:37:F0:F1:77 mode 2 clkoffset 0x0000
> 2010-07-27 11:44:07.367793 > HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> 2010-07-27 11:44:07.384797 > HCI Event: Max Slots Change (0x1b) plen 3
>     handle 11 slots 5
> 2010-07-27 11:44:07.406820 > ACL data: handle 11 flags 0x02 dlen 12
>     L2CAP(s): Info rsp: type 2 result 1
>       Not supported
> 2010-07-27 11:44:07.406849 < ACL data: handle 11 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0040
> 2010-07-27 11:44:07.431790 > HCI Event: Remote Name Req Complete
> (0x07) plen 255
>     status 0x00 bdaddr 00:12:37:F0:F1:77 name 'vt-m'
> 2010-07-27 11:44:07.433780 > HCI Event: Number of Completed Packets
> (0x13) plen 5
>     handle 11 packets 2
> 2010-07-27 11:44:07.474801 > ACL data: handle 11 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0040 result 1 status 2
>       Connection pending - Authorization pending
> 2010-07-27 11:44:07.668818 > ACL data: handle 11 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0040 result 0 status 0
>       Connection successful
> 2010-07-27 11:44:07.668851 < ACL data: handle 11 flags 0x02 dlen 23
>     L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 11
>       RFC 0x00 (Basic)
> 2010-07-27 11:44:07.669814 > ACL data: handle 11 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> 2010-07-27 11:44:07.669840 < ACL data: handle 11 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 4
>       MTU 672
> 2010-07-27 11:44:07.675794 > HCI Event: Number of Completed Packets
> (0x13) plen 5
>     handle 11 packets 2
> 2010-07-27 11:44:07.682822 > ACL data: handle 11 flags 0x02 dlen 19
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 3 clen 5
>       Failure - unknown options
>       RFC QoS 0f 00 42
> 2010-07-27 11:44:07.682843 < ACL data: handle 11 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0042 scid 0x0040
> 2010-07-27 11:44:07.693823 > ACL data: handle 11 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0042 scid 0x0040

-- 
Gustavo F. Padovan
http://padovan.org
