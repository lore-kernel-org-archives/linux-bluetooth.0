Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 26 Jan 2009 15:29:33 -0800
Message-ID: <35c90d960901261529i699411a7jddb81b8d9bef74f8@mail.gmail.com>
Subject: duplicate L2CAP connection requests - before and after L2CAP
	information response
From: Nick Pelly <npelly@google.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

We've noticed In some situations Bluez will send duplicate L2CAP
connection requests.
- Both are due to the same userspace connect() call, and have the same
PSM and SCID, but different identifier. So the remote stack cannot
send duplicate response because of different identifiers.
- The first occurs before receiving L2CAP info response, and the
second after due to the l2cap_information_rsp() -> l2cap_conn_start()
code path.

We are able to reproduce this consistently with basically any A2DP PTS
test case. It only happens when the test case is started when already
paired. This causes the PTS test case to fail because the tester
rejects the second L2CAP request (resource unavailable).

We are using 2.6.27. I looked at l2cap.c in bluetooth-testing.git and
believe it will have the same issue.

Question: to fix, which connection request should be removed?

Nick

Logs:

hcidump -XVt

2009-01-26 15:14:10.922419 < HCI Command: Create Connection
(0x01|0x0005) plen 13
    bdaddr 00:0C:55:35:03:A6 ptype 0xcc18 rswitch 0x01 clkoffset 0x2297 (valid)
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2009-01-26 15:14:10.941615 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2009-01-26 15:14:12.192011 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:0C:55:35:03:A6 type ACL encrypt 0x00
2009-01-26 15:14:12.250025 < HCI Command: Read Remote Supported
Features (0x01|0x001b) plen 2
    handle 1
2009-01-26 15:14:12.273463 < ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
2009-01-26 15:14:12.296443 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2009-01-26 15:14:12.300044 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
2009-01-26 15:14:12.300044 > HCI Event: Read Remote Supported Features
(0x0b) plen 11
    status 0x00 handle 1
    Features: 0xff 0xff 0x8f 0x7e 0x98 0x1f 0x59 0x83
2009-01-26 15:14:12.595637 < ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0040

<---- Request 1

2009-01-26 15:14:12.618586 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 1 packets 1
2009-01-26 15:14:12.652918 > ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
2009-01-26 15:14:12.974330 < ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0040

<---- Request 2

2009-01-26 15:14:12.998408 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 1 packets 1
2009-01-26 15:14:12.998530 > ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
2009-01-26 15:14:12.998530 > ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
2009-01-26 15:14:12.998561 > ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
2009-01-26 15:14:13.209895 < ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
2009-01-26 15:14:13.220027 < ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 672
2009-01-26 15:14:13.242793 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 1 packets 1
2009-01-26 15:14:13.277674 > ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
2009-01-26 15:14:13.277674 > ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0040 result 4 status 0
      Connection refused - no resources available





[  144.750667] l2cap_sock_create: sock c5de2640
[  144.755336] l2cap_sock_init: sk c4ffc600
[  144.759884] l2cap_sock_bind: sk c4ffc600, 00:00:00:00:00:00 0
[  144.766109] l2cap_sock_connect: sk c4ffc600
[  144.808681] l2cap_do_connect: 00:00:00:00:00:00 -> A6:03:35:55:0C:00 psm 0x19
[  144.816402] hci_inquiry_cache_lookup: cache c58d7a34, A6:03:35:55:0C:00
[  144.823360] hci_send_cmd: hci0 opcode 0x405 plen 13
[  144.828792] hci_send_cmd: skb len 16
[  144.832729] l2cap_conn_add: hcon c4ffce00 conn c5b1f860
[  144.838497] __l2cap_chan_add: conn c5b1f860, psm 0x19, dcid 0x0000
[  144.845028] l2cap_sock_set_timer: sk c4ffc600 state 5 timeout 4000
[  144.851833] hci_cmd_task: hci0 cmd 1
[  144.855739] hci_send_frame: hci0 type 1 len 16
[  144.880825] hci_rx_task: hci0
[  144.884426] hci_sent_cmd_data: hci0 opcode 0x405
[  144.914486] hci_dev_get: 0
[  145.903408] hci_rx_task: hci0
[  145.907344] hci_send_cmd: hci0 opcode 0x41b plen 2
[  145.912593] hci_send_cmd: skb len 5
[  145.916530] l2cap_connect_cfm: hcon c4ffce00 bdaddr
A6:03:35:55:0C:00 status 0
[  145.924526] l2cap_conn_ready: conn c5b1f860
[  145.929165] l2cap_build_cmd: conn c5b1f860, code 0x0a, ident 0x01, len 2
[  145.936641] l2cap_send_cmd: code 0x0a
[  145.940731] hci_send_acl: hci0 conn c4ffce00 flags 0x0
[  145.946651] hci_send_acl: hci0 nonfrag skb c6036380 len 14
[  145.952572] hci_cmd_task: hci0 cmd 1
[  145.956936] hci_send_frame: hci0 type 1 len 5
[  145.961788] hci_tx_task: hci0 acl 4 sco 4
[  145.966213] hci_sched_acl: hci0
[  145.970119] hci_low_sent: conn c4ffce00 quote 4
[  145.975093] hci_sched_acl: skb c6036380 len 14
[  145.979946] hci_send_frame: hci0 type 2 len 14
[  145.985195] hci_low_sent: conn 00000000 quote 0
[  145.990139] hci_sched_sco: hci0
[  145.993709] hci_low_sent: conn 00000000 quote 0
[  145.998989] hci_sched_esco: hci0
[  146.002651] hci_low_sent: conn 00000000 quote 0
[  146.007930] hci_rx_task: hci0
[  146.011898] hci_rx_task: hci0
[  146.015377] l2cap_connect_cfm: hcon c4ffce00 bdaddr
A6:03:35:55:0C:00 status 0
[  146.023403] l2cap_conn_ready: conn c5b1f860
[  146.260006] l2cap_build_cmd: conn c5b1f860, code 0x02, ident 0x02, len 4
[  146.267147] l2cap_send_cmd: code 0x02

<--- sending first connection request

[  146.271572] hci_send_acl: hci0 conn c4ffce00 flags 0x0
[  146.277156] hci_send_acl: hci0 nonfrag skb c6036980 len 16
[  146.283443] hci_tx_task: hci0 acl 3 sco 4
[  146.287868] hci_sched_acl: hci0
[  146.291439] hci_low_sent: conn c4ffce00 quote 3
[  146.296749] hci_sched_acl: skb c6036980 len 16
[  146.301601] hci_send_frame: hci0 type 2 len 16
[  146.306850] hci_low_sent: conn 00000000 quote 0
[  146.311794] hci_sched_sco: hci0
[  146.315364] hci_low_sent: conn 00000000 quote 0
[  146.320644] hci_sched_esco: hci0
[  146.324306] hci_low_sent: conn 00000000 quote 0
[  146.329677] hci_rx_task: hci0
[  146.333492] hci_tx_task: hci0 acl 3 sco 4
[  146.337917] hci_sched_acl: hci0
[  146.341488] hci_low_sent: conn 00000000 quote 0
[  146.346798] hci_sched_sco: hci0
[  146.350368] hci_low_sent: conn 00000000 quote 0
[  146.355312] hci_sched_esco: hci0
[  146.359310] hci_low_sent: conn 00000000 quote 0
[  146.364467] hci_rx_task: hci0
[  146.367885] hci_rx_task: hci0 ACL data packet
[  146.373043] hci_acldata_packet: hci0 len 16 handle 0x1 flags 0x2
[  146.379482] l2cap_recv_acldata: conn c5b1f860 len 16 flags 0x2
[  146.386104] l2cap_recv_frame: len 12, cid 0x0001
[  146.391140] l2cap_raw_recv: conn c5b1f860
[  146.395565] l2cap_sig_channel: code 0x0b len 8 id 0x01
[  146.401485] l2cap_information_rsp: type 0x0002 result 0x00
[  146.407406] l2cap_conn_start: conn c5b1f860
[  146.639156] l2cap_build_cmd: conn c5b1f860, code 0x02, ident 0x03, len 4
[  146.646633] l2cap_send_cmd: code 0x02

<-- sending second connection request

[  146.650722] hci_send_acl: hci0 conn c4ffce00 flags 0x0
[  146.656643] hci_send_acl: hci0 nonfrag skb c6036440 len 16
[  146.662563] hci_tx_task: hci0 acl 3 sco 4
[  146.667019] hci_sched_acl: hci0
[  146.670925] hci_low_sent: conn c4ffce00 quote 3
[  146.675869] hci_sched_acl: skb c6036440 len 16
[  146.681087] hci_send_frame: hci0 type 2 len 16
[  146.686000] hci_low_sent: conn 00000000 quote 0
[  146.690975] hci_sched_sco: hci0
[  146.694881] hci_low_sent: conn 00000000 quote 0
[  146.699825] hci_sched_esco: hci0
[  146.703457] hci_low_sent: conn 00000000 quote 0
