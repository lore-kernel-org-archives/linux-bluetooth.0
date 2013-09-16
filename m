Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Sep 2013 11:52:55 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Syam Sidhardhan <syamsidhardh@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Syam Sidhardhan <s.syam@samsung.com>
Subject: Re: [PATCH 1/1 v4] Bluetooth: Fix ACL alive for long in case of non
 pariable devices
Message-ID: <20130916145255.GA1996@joana>
References: <1375721952-3601-1-git-send-email-syamsidhardh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375721952-3601-1-git-send-email-syamsidhardh@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

2013-08-06 Syam Sidhardhan <syamsidhardh@gmail.com>:

> From: Syam Sidhardhan <s.syam@samsung.com>
> 
> For certain devices (ex: HID mouse), support for authentication,
> pairing and bonding is optional. For such devices, the ACL alive
> for too long after the L2CAP disconnection.
> 
> To avoid the ACL alive for too long after L2CAP disconnection, reset the
> ACL disconnect timeout back to HCI_DISCONN_TIMEOUT during L2CAP connect.
> 
> While merging the commit id:a9ea3ed9b71cc3271dd59e76f65748adcaa76422
> this issue might have introduced.
> 
> Hcidump info:
> sh-4.1# /opt/hcidump -Xt
> HCI sniffer - Bluetooth packet analyzer ver 2.4
> device: hci0 snap_len: 1500 filter: 0xffffffff
> 2013-08-05 16:48:47.847053 > HCI Event: Connect Request (0x04) plen 10
>     bdaddr 00:12:A1:65:E5:B2 class 0x002580 type ACL
> 2013-08-05 16:48:47.847310 < HCI Command: Accept Connection Request (0x01
>     |0x0009) plen 7
>     bdaddr 00:12:A1:65:E5:B2 role 0x00
>     Role: Master
> 2013-08-05 16:48:47.848436 > HCI Event: Command Status (0x0f) plen 4
>     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> 2013-08-05 16:48:48.007120 > HCI Event: Role Change (0x12) plen 8
>     status 0x00 bdaddr 00:12:A1:65:E5:B2 role 0x00
>     Role: Master
> 2013-08-05 16:48:48.050475 > HCI Event: Connect Complete (0x03) plen 11
>     status 0x00 handle 12 bdaddr 00:12:A1:65:E5:B2 type ACL encrypt 0x00
> 2013-08-05 16:48:48.051235 < HCI Command: Read Remote Supported Features
>     (0x01|0x001b) plen 2
>     handle 12
> 2013-08-05 16:48:48.051691 > HCI Event: Command Status (0x0f) plen 4
>     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> 2013-08-05 16:48:48.051864 > HCI Event: Read Remote Supported Features
>     (0x0b) plen 11
>     status 0x00 handle 12
>     Features: 0xbc 0x02 0x04 0x38 0x08 0x00 0x00 0x00
> 2013-08-05 16:48:48.051899 < HCI Command: Remote Name Request (0x01|
>     0x0019) plen 10
>     bdaddr 00:12:A1:65:E5:B2 mode 2 clkoffset 0x0000
> 2013-08-05 16:48:48.052530 > HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> 2013-08-05 16:48:48.056407 > ACL data: handle 12 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 17 scid 0x0049
> 2013-08-05 16:48:48.056492 < ACL data: handle 12 flags 0x00 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0049 result 1 status 0
>       Connection pending - No futher information available
> 2013-08-05 16:48:48.056510 < ACL data: handle 12 flags 0x00 dlen 10
>     L2CAP(s): Info req: type 2
> 2013-08-05 16:48:48.061404 > HCI Event: Number of Completed Packets
>     (0x13) plen 5
>     handle 12 packets 2
> 2013-08-05 16:48:48.064019 > ACL data: handle 12 flags 0x02 dlen 16
>     L2CAP(s): Info rsp: type 2 result 0
>       Extended feature mask 0x0004
>         Bi-directional QoS
> 2013-08-05 16:48:48.064059 < ACL data: handle 12 flags 0x00 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0049 result 0 status 0
>       Connection successful
> 2013-08-05 16:48:48.064071 < ACL data: handle 12 flags 0x00 dlen 12
>     L2CAP(s): Config req: dcid 0x0049 flags 0x00 clen 0
> 2013-08-05 16:48:48.067220 > HCI Event: Remote Name Req Complete (0x07)
>     plen 255
>     status 0x00 bdaddr 00:12:A1:65:E5:B2 name 'Bluetooth Mouse'
> 2013-08-05 16:48:48.067627 > HCI Event: Number of Completed Packets
>     (0x13) plen 5
>     handle 12 packets 2
> 2013-08-05 16:48:48.070114 > ACL data: handle 12 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>       MTU 185
> 2013-08-05 16:48:48.070148 < ACL data: handle 12 flags 0x00 dlen 18
>     L2CAP(s): Config rsp: scid 0x0049 flags 0x00 result 0 clen 4
>       MTU 185
> 2013-08-05 16:48:48.072642 > ACL data: handle 12 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
>       MTU 185
> 2013-08-05 16:48:48.075123 > ACL data: handle 12 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 19 scid 0x004a
> 2013-08-05 16:48:48.075196 < ACL data: handle 12 flags 0x00 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x004a result 1 status 2
>       Connection pending - Authorization pending
> 2013-08-05 16:48:48.075364 < ACL data: handle 12 flags 0x00 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x004a result 0 status 0
>       Connection successful
> 2013-08-05 16:48:48.075403 < ACL data: handle 12 flags 0x00 dlen 12
>     L2CAP(s): Config req: dcid 0x004a flags 0x00 clen 0
> 2013-08-05 16:48:48.077633 > HCI Event: Number of Completed Packets
>     (0x13) plen 5
>     handle 12 packets 2
> 2013-08-05 16:48:48.080127 > HCI Event: Number of Completed Packets
>     (0x13) plen 5
>     handle 12 packets 2
> 2013-08-05 16:48:48.081355 > ACL data: handle 12 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
>       MTU 185
> 2013-08-05 16:48:48.081402 < ACL data: handle 12 flags 0x00 dlen 18
>     L2CAP(s): Config rsp: scid 0x004a flags 0x00 result 0 clen 4
>       MTU 185
> 2013-08-05 16:48:48.082633 > ACL data: handle 12 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
>       MTU 185
> 2013-08-05 16:48:48.084838 < ACL data: handle 12 flags 0x00 dlen 12
>     L2CAP(d): cid 0x004a len 8 [psm 19]
>       HIDP: Data: Output report
>       0000: 02 00 00 00 00 00 00                              .......
> ...
> ...
> 
> 2013-08-05 16:49:00.894129 < ACL data: handle 12 flags 0x00 dlen 12
>     L2CAP(s): Disconn req: dcid 0x004a scid 0x0041
> 2013-08-05 16:49:00.894195 < HCI Command: Exit Sniff Mode (0x02|0x0004)
>     plen 2
>     handle 12
> 2013-08-05 16:49:00.894269 < ACL data: handle 12 flags 0x00 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0049 scid 0x0040
> 2013-08-05 16:49:00.895645 > HCI Event: Command Status (0x0f) plen 4
>     Exit Sniff Mode (0x02|0x0004) status 0x00 ncmd 1
> 2013-08-05 16:49:00.934391 > HCI Event: Mode Change (0x14) plen 6
>     status 0x00 handle 12 mode 0x00 interval 0
>     Mode: Active
> 2013-08-05 16:49:00.936592 > HCI Event: Number of Completed Packets
>     (0x13) plen 5
>     handle 12 packets 2
> 2013-08-05 16:49:00.951577 > ACL data: handle 12 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x004a scid 0x0041
> 2013-08-05 16:49:00.952820 > ACL data: handle 12 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0049 scid 0x0040
> 2013-08-05 16:49:00.969165 > HCI Event: Mode Change (0x14) plen 6
>     status 0x00 handle 12 mode 0x02 interval 50
>     Mode: Sniff
> 
> 2013-08-05 16:49:48.175533 > HCI Event: Mode Change (0x14) plen 6
>     status 0x00 handle 12 mode 0x00 interval 0
>     Mode: Active
> 2013-08-05 16:49:48.219045 > HCI Event: Mode Change (0x14) plen 6
>     status 0x00 handle 12 mode 0x02 interval 108
>     Mode: Sniff
> 
> 2013-08-05 16:51:00.968209 < HCI Command: Disconnect (0x01|0x0006) plen 3
>     handle 12 reason 0x13
>     Reason: Remote User Terminated Connection
> 2013-08-05 16:51:00.969056 > HCI Event: Command Status (0x0f) plen 4
>     Disconnect (0x01|0x0006) status 0x00 ncmd 1
> 2013-08-05 16:51:01.013495 > HCI Event: Mode Change (0x14) plen 6
>     status 0x00 handle 12 mode 0x00 interval 0
>     Mode: Active
> 2013-08-05 16:51:01.073777 > HCI Event: Disconn Complete (0x05) plen 4
>     status 0x00 handle 12 reason 0x16
>     Reason: Connection Terminated by Local Host
> 
> ========================= Conn status =================================
> sh-4.1# date; hcitool con
> Mon Aug  5 16:49:16 KST 2013
> Connections:
>         > ACL 00:12:A1:65:E5:B2 handle 12 state 1 lm MASTER
> sh-4.1# date; hcitool con
> Mon Aug  5 16:50:32 KST 2013
> Connections:
>         > ACL 00:12:A1:65:E5:B2 handle 12 state 1 lm MASTER
> sh-4.1# date; hcitool con
> Mon Aug  5 16:50:59 KST 2013
> Connections:
>         > ACL 00:12:A1:65:E5:B2 handle 12 state 1 lm MASTER
> sh-4.1# date; hcitool con
> Mon Aug  5 16:51:01 KST 2013
> Connections:
> sh-4.1#
> 
> ============================ After  fix ================================
> 
> 2013-08-05 16:57:35.986648 < ACL data: handle 11 flags 0x00 dlen 12
>     L2CAP(s): Disconn req: dcid 0x004c scid 0x0041
> 2013-08-05 16:57:35.986713 < HCI Command: Exit Sniff Mode (0x02|0x0004)
>     plen 2
>     handle 11
> 2013-08-05 16:57:35.986785 < ACL data: handle 11 flags 0x00 dlen 12
>     L2CAP(s): Disconn req: dcid 0x004b scid 0x0040
> 2013-08-05 16:57:35.988110 > HCI Event: Command Status (0x0f) plen 4
>     Exit Sniff Mode (0x02|0x0004) status 0x00 ncmd 1
> 2013-08-05 16:57:36.030714 > HCI Event: Mode Change (0x14) plen 6
>     status 0x00 handle 11 mode 0x00 interval 0
>     Mode: Active
> 2013-08-05 16:57:36.032950 > HCI Event: Number of Completed Packets
>     (0x13) plen 5
>     handle 11 packets 2
> 2013-08-05 16:57:36.047926 > ACL data: handle 11 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x004c scid 0x0041
> 2013-08-05 16:57:36.049200 > ACL data: handle 11 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x004b scid 0x0040
> 2013-08-05 16:57:36.065509 > HCI Event: Mode Change (0x14) plen 6
>     status 0x00 handle 11 mode 0x02 interval 50
>     Mode: Sniff
> 
> 2013-08-05 16:57:40.052006 < HCI Command: Disconnect (0x01|0x0006) plen 3
>     handle 11 reason 0x13
>     Reason: Remote User Terminated Connection
> 2013-08-05 16:57:40.052869 > HCI Event: Command Status (0x0f) plen 4
>     Disconnect (0x01|0x0006) status 0x00 ncmd 1
> 2013-08-05 16:57:40.104731 > HCI Event: Mode Change (0x14) plen 6
>     status 0x00 handle 11 mode 0x00 interval 0
>     Mode: Active
> 2013-08-05 16:57:40.146935 > HCI Event: Disconn Complete (0x05) plen 4
>     status 0x00 handle 11 reason 0x16
>     Reason: Connection Terminated by Local Host
> 
> Signed-off-by: Sang-Ki Park <sangki79.park@samsung.com>
> Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
> 
> v1 -> Modified the code as per the latest code.
> v2 -> Add descriptive comment as per Marcel request.
> v3 -> Moved from l2cap_conn_ready() to l2cap_connect() inorder to fix remote
>       non ssp pairing timeout. Generated the patch based on bluetooth.git tree.
> v4 -> Include hcidump logs showing the conn status before and after fix.
> 
> This patch is generated the patch based on bluetooth.git tree.
> 
>  net/bluetooth/l2cap_core.c |    7 +++++++
>  1 file changed, 7 insertions(+)

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
