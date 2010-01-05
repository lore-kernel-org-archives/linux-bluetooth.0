Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Jan 2010 11:51:52 +0100
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: "Daniel T. Cobra" <dcobra@videam.com.br>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Long delay to (re)connect a bluetooth mouse
Message-ID: <20100105115152.506eb191@strolchi.home.s3e.de>
In-Reply-To: <4B423816.4060405@videam.com.br>
References: <1260906227.4b27e6f39cc7c@www.fastmail.com.br>
	<4B2A4B90.1040009@videam.com.br>
	<4B2BBF58.4030901@videam.com.br>
	<1261173899.4041.96.camel@localhost.localdomain>
	<1261176544.4b2c06e0e0eae@www.fastmail.com.br>
	<1261177111.4041.99.camel@localhost.localdomain>
	<20091223164841.7070e75d@strolchi.home.s3e.de>
	<4B325905.6090103@videam.com.br>
	<20091229160135.12d85fe6@strolchi.home.s3e.de>
	<4B423816.4060405@videam.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 04 Jan 2010 16:48:54 -0200
"Daniel T. Cobra" <dcobra@videam.com.br> wrote:

> Hi Stefan:
> 
> I'm back from the holidays.
> 
> Since I was not able to find a free hcidump equivalent for Windows, I 
> think we could at least compare the dumps for your mouse and mine, as 
> you suggested. Could you please post yours (with timestamps)?

Sure. Here it is. I have put the mouse away at 11:21:27.262588 and
clicked on it at ~ 11:36:50.

HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffff
2010-01-05 11:21:24.021089 > ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 0]
      0000: a1 02 00 ed 05 00                                 ......
2010-01-05 11:21:24.140076 > ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 0]
      0000: a1 02 00 e6 06 00                                 ......
2010-01-05 11:21:24.141054 > ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 0]
      0000: a1 02 00 f0 03 00                                 ......
2010-01-05 11:21:24.143056 > HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 11 mode 0x00 interval 0
    Mode: Active
2010-01-05 11:21:24.174052 > HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 11 mode 0x02 interval 20
    Mode: Sniff
2010-01-05 11:21:27.125620 > ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 0]
      0000: a1 02 00 47 f9 00                                 ...G..
2010-01-05 11:21:27.127603 > ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 0]
      0000: a1 02 00 00 ff 00                                 ......
2010-01-05 11:21:27.225596 > ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 0]
      0000: a1 02 00 01 00 00                                 ......
2010-01-05 11:21:27.250605 > ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 0]
      0000: a1 02 00 ff 00 00                                 ......
2010-01-05 11:21:27.262588 > ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 0]
      0000: a1 02 00 01 00 00                                 ......
2010-01-05 11:21:37.289076 > HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 11 mode 0x00 interval 0
    Mode: Active
2010-01-05 11:21:37.320067 > HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 11 mode 0x02 interval 96
    Mode: Sniff
2010-01-05 11:31:37.161200 > ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
2010-01-05 11:31:37.161265 < ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
2010-01-05 11:31:37.162087 < ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
2010-01-05 11:31:37.221188 > ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
2010-01-05 11:31:37.221261 < ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
2010-01-05 11:31:37.340173 > ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
2010-01-05 11:31:37.521139 > HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 11 mode 0x00 interval 0
    Mode: Active
2010-01-05 11:31:37.538121 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 3
2010-01-05 11:31:37.651115 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 11 reason 0x16
    Reason: Connection Terminated by Local Host
2010-01-05 11:36:50.103021 > HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:0F:F6:60:44:0B class 0x002580 type ACL
2010-01-05 11:36:50.103084 < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:0F:F6:60:44:0B role 0x00
    Role: Master
2010-01-05 11:36:50.107013 > HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
2010-01-05 11:36:50.278988 > HCI Event: Role Change (0x12) plen 8
    status 0x35 bdaddr 00:0F:F6:60:44:0B role 0x01
    Error: Role Switch Failed
2010-01-05 11:36:50.342981 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 11 bdaddr 00:0F:F6:60:44:0B type ACL encrypt 0x00
2010-01-05 11:36:50.343061 < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 11
2010-01-05 11:36:50.346967 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2010-01-05 11:36:50.348966 > HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 11
    Features: 0xbc 0x02 0x04 0x38 0x08 0x00 0x00 0x00
2010-01-05 11:36:50.362865 < HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:0F:F6:60:44:0B mode 2 clkoffset 0x0000
2010-01-05 11:36:50.364963 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2010-01-05 11:36:50.671937 > HCI Event: Role Change (0x12) plen 8
    status 0x35 bdaddr 00:0F:F6:60:44:0B role 0x01
    Error: Role Switch Failed
2010-01-05 11:36:50.773903 > HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:0F:F6:60:44:0B name 'Acer Bluetooth Wireless Mouse'
2010-01-05 11:36:51.503812 > HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:0F:F6:60:44:0B role 0x00
    Role: Master
2010-01-05 11:36:51.517810 > ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0042
2010-01-05 11:36:51.517868 < ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0042 result 1 status 0
      Connection pending - No futher information available
2010-01-05 11:36:51.517876 < ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
2010-01-05 11:36:51.525808 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0004
        Bi-directional QoS
2010-01-05 11:36:51.525853 < ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0042 result 0 status 0
      Connection successful
2010-01-05 11:36:51.530806 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 185 
2010-01-05 11:36:51.530854 < ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 4
      MTU 185 
2010-01-05 11:36:51.530861 < ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 0
2010-01-05 11:36:51.534794 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 4
2010-01-05 11:36:51.537805 > ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 185 
2010-01-05 11:36:51.538802 > ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0043
2010-01-05 11:36:51.538852 < ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0043 result 1 status 2
      Connection pending - Authorization pending
2010-01-05 11:36:51.539104 < ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0043 result 0 status 0
      Connection successful
2010-01-05 11:36:51.546803 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 185 
2010-01-05 11:36:51.546849 < ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0043 flags 0x00 result 0 clen 4
      MTU 185 
2010-01-05 11:36:51.546856 < ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0043 flags 0x00 clen 0
2010-01-05 11:36:51.557793 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 4
2010-01-05 11:36:51.562794 > ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 185 
2010-01-05 11:36:51.566781 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 11 flags 0
    Service type: 1
    Token rate: 850
    Peak bandwith: 0
    Latency: 20000
    Delay variation: -1
2010-01-05 11:36:51.568787 > ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 01 00 00 00                                    .....
2010-01-05 11:36:51.574819 > ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 00 00 00                                    .....
2010-01-05 11:36:51.575497 < ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(d): cid 0x0043 len 6 [psm 19]
      HIDP: Data: Output report
      0000: 02 00 00 00 00                                    .....
2010-01-05 11:36:51.575514 < ACL data: handle 11 flags 0x02 dlen 7
    L2CAP(d): cid 0x0043 len 3 [psm 19]
      HIDP: Data: Output report
      0000: 03 00                                             ..
2010-01-05 11:36:51.581799 > ACL data: handle 11 flags 0x02 dlen 5
    L2CAP(d): cid 0x0041 len 1 [psm 19]
      HIDP: Handshake: Unsupported request
2010-01-05 11:36:51.583790 > ACL data: handle 11 flags 0x02 dlen 5
    L2CAP(d): cid 0x0041 len 1 [psm 19]
      HIDP: Handshake: Unsupported request
2010-01-05 11:36:51.594788 > HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 11 mode 0x02 interval 20
    Mode: Sniff
2010-01-05 11:36:51.788764 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 3

-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
