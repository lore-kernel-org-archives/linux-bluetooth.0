Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Daniel Haensse <haensse@swissembedded.com>
Reply-To: Daniel Haensse <haensse@swissembedded.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-Id: <200309072126.20042.haensse@swissembedded.com>
Subject: [Bluez-devel] Can't open device hci0. No such device(19)
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 7 Sep 2003 21:26:20 +0200
Content-Type: text/plain; CHARSET=us-ascii

Hi list,

the error changes depending on the start of hcid (hcid &  or hcid -n &).

In the mean time, I did update the kernel tree with the latest patch, but=20
still the same error.

What is this timeout  OCF_WRITE_PG_TIMEOUT? Sometimes I also get a=20
OCF_WRITE_CA_TIMEOUT succeseful. Might this be related to our slow cpu=20
(68vz328)?=20

Could anybody please point out where to start?

very frustrating, need a beer now :-(

regards

Dani

PS: Could you please send a copy (also the one in return of the previous=20
email) directly to my email address, for some reasons, I don't get any emai=
l=20
anymore from the list without digest mode. Thanks

--------------------------------------------------------
hci_register_proto: 0002a100 name L2CAP id 0
BlueZ L2CAP ver 2.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
hci_register_proto: 0002a188 name SCO id 1
BlueZ SCO ver 0.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ RFCOMM ver 1.0
Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
BlueZ BNEP ver 1.1
Copyright (C) 2001,2002 Inventel Systemes
Written 2001,2002 by Clement Moreau <clement.moreau@inventel.fr>
Written 2001,2002 by David Libault <david.libault@inventel.fr>
Copyright (C) 2002 Maxim Krasnyanskiy <maxk@qualcomm.com>
l2cap_sock_create: sock 000b2f4e
l2cap_sock_init: sk 000f3cb0
l2cap_sock_bind: sk 000f3cb0, 00:00:00:00:00:00 768
l2cap_sock_setsockopt: sk 000f3cb0
l2cap_sock_listen: sk 000f3cb0 backlog 10
VFS: Mounted root (romfs filesystem) readonly.
eth0: using half-duplex 10Base-T (RJ-45)

dragonix login: root
Password:
# hcid &
31
# hci_sock_create: sock 001af30e
hci_sock_setsockopt: sk 001a6030, opt 2
hci_sock_bind: sock 001af30e sk 001a6030
hci_sock_ioctl: cmd 800448d2 arg 17c058

# hciattach /dev/ttyS1 csr 115200 flow
CSR build ID 0x01-0x75
ttyS1 console mode off
hci_register_dev: 01c1a204 name  type 3
hci_sock_dev_event: hdev hci0 event 1
hci_send_to_sock: hdev 00000000 len 8
hci_sock_recvmsg: sock 001af30e, sk 001a6030
hci_sock_create: sock 001afd8e
hci_sock_bind: sock 001afd8e sk 001a6350
hci_dev_get: 0
hci_sock_ioctl: cmd 400448c9 arg 0
hci_dev_get: 0
hci_dev_open: hci0 01c1a204
__hci_request: hci0 start
hci_init_req: hci0 0
hci_send_cmd: hci0 ogf 0x4 ocf 0x3 plen 0
hci_send_cmd: skb len 3
hci_send_cmd: hci0 ogf 0x4 ocf 0x5 plen 0
hci_cmd_task: hci0 cmd 1
hci_send_frame: hci0 type 1 len 3
hci_send_to_sock: hdev 01c1a204 len 3
hci_recv_frame: hci0 type 4 len 14
hci_rx_task: hci0
hci_send_to_sock: hdev 01c1a204 len 14
hci_event_packet: hci0 evt 0xe
hci_cc_info_param: hci0 ocf 0x3
hci_cc_info_param: hci0: features 0xff 0xff 0xf
hci_send_cmd: skb len 3
hci_send_cmd: hci0 ogf 0x4 ocf 0x9 plen 0
hci_cmd_task: hci0 cmd 1
hci_send_frame: hci0 type 1 len 3
hci_send_to_sock: hdev 01c1a204 len 3
hci_send_cmd: skb len 3
hci_send_cmd: hci0 ogf 0x3 ocf 0x25 plen 0
hci_cmd_task: hci0 cmd 0
hci_send_cmd: skb len 3
hci_send_cmd: hci0 ogf 0x3 ocf 0x5 plen 1
hci_recv_frame: hci0 type 4 len 13
hci_rx_task: hci0
hci_send_to_sock: hdev 01c1a204 len 13
hci_event_packet: hci0 evt 0xe
hci_cc_info_param: hci0 ocf 0x5
hci_cc_info_param: hci0 mtu: acl 192, sco 64 max_pkt: acl 8, sco 8
hci_cmd_task: hci0 cmd 1
hci_send_frame: hci0 type 1 len 3
hci_send_to_sock: hdev 01c1a204 len 3
hci_recv_frame: hci0 type 4 len 12
hci_rx_task: hci0
hci_send_to_sock: hdev 01c1a204 len 12
hci_event_packet: hci0 evt 0xe
hci_cc_info_param: hci0 ocf 0x9
hci_req_complete: hci0 result 0x00
hci_cmd_task: hci0 cmd 1
hci_send_frame: hci0 type 1 len 3
hci_send_to_sock: hdev 01c1a204 len 3
hci_recv_frame: hci0 type 4 len 8
hci_rx_task: hci0
hci_send_to_sock: hdev 01c1a204 len 8
hci_event_packet: hci0 evt 0xe
hci_cc_host_ctl: hci0 ocf 0x25
hci_cc_host_ctl: hci0: voice setting 0x0060
hci_send_cmd: skb len 4
hci_send_cmd: hci0 ogf 0x3 ocf 0x18 plen 2
hci_cmd_task: hci0 cmd 1
hci_send_frame: hci0 type 1 len 4
hci_send_to_sock: hdev 01c1a204 len 4
hci_send_cmd: skb len 5
hci_recv_frame: hci0 type 4 len 6
hci_rx_task: hci0
hci_send_to_sock: hdev 01c1a204 len 6
hci_event_packet: hci0 evt 0xe
hci_cc_host_ctl: hci0 ocf 0x5
hci_cc_host_ctl: hci0 SET_EVENT_FLT succeseful
hci_send_cmd: hci0 ogf 0x3 ocf 0x16 plen 2
hci_cmd_task: hci0 cmd 1
hci_send_frame: hci0 type 1 len 5
hci_send_to_sock: hdev 01c1a204 len 5
hci_send_cmd: skb len 5
hci_recv_frame: hci0 type 4 len 6
hci_rx_task: hci0
hci_send_to_sock: hdev 01c1a204 len 6
hci_event_packet: hci0 evt 0xe
hci_cc_host_ctl: hci0 ocf 0x18
hci_cc_host_ctl: hci0: OCF_WRITE_PG_TIMEOUT succeseful
hci_unregister_dev: 01c1a204 name hci0 type 3
hci_dev_do_close: hci0 01c1a204
hci_cmd_task: hci0 cmd 1
hci_send_frame: hci0 type 1 len 5
hci_send_to_sock: hdev 01c1a204 len 5
hci_req_cancel: hci0 err 0x13
__hci_request: hci0 end: err 0
hci_sock_dev_event: hdev hci0 event 3
hci_send_to_sock: hdev 00000000 len 8
inquiry_cache_flush: cache 01c1a2fa
hci_conn_hash_flush: hdev hci0
hci_sock_dev_event: hdev hci0 event 4
hci_send_to_sock: hdev 00000000 len 8
__hci_request: hci0 start
hci_reset_req: hci0 0
hci_send_cmd: hci0 ogf 0x3 ocf 0x3 plen 0
hci_send_cmd: skb len 3
hci_sock_ioctl: cmd 400448e2 arg 1aba22
hci_dev_get: 0
hci_cmd_task: hci0 cmd 1
hci_send_frame: hci0 type 1 len 3
hci_send_to_sock: hdev 01c1a204 len 3
hci_sock_ioctl: cmd 400448e1 arg 1aba22
hci_dev_get: 0
hci_sock_release: sock 001afd8e sk 001a6350
hci_sock_recvmsg: sock 001af30e, sk 001a6030
hci_sock_create: sock 001afd8e
hci_sock_bind: sock 001afd8e sk 001a6350
hci_dev_get: 0
hci_sock_release: sock 001afd8e sk 001a6350
hci_sock_create: sock 001afd8e
hci_sock_bind: sock 001afd8e sk 001a6350
hci_dev_get: 0
hci_sock_release: sock 001afd8e sk 001a6350
hci_sock_recvmsg: sock 001af30e, sk 001a6030
__hci_request: hci0 end: err -110
hci_sock_dev_event: hdev hci0 event 2
hci_send_to_sock: hdev 00000000 len 8
# hci_sock_recvmsg: sock 001af30e, sk 001a6030

# cat /var/log/messages
<46> Jan  1 19:20:30 2001 syslogd started: BusyBox v0.60.4=20
(2003.09.07-17:38+0000)
<86> Jan  1 19:20:44 2001 login: Authentication successful for root from
<30> Jan  1 19:20:48 2001 hcid[32]: HCI daemon ver 2.3 started
<30> Jan  1 19:21:04 2001 hcid[32]: HCI dev 0 registered
<27> Jan  1 19:21:04 2001 hcid[35]: Can't set link mode on hci0. No such=20
device(19)
<27> Jan  1 19:21:04 2001 hcid[35]: Can't set link policy on hci0. No such=20
device(19)
<30> Jan  1 19:21:04 2001 hcid[32]: HCI dev 0 up
<27> Jan  1 19:21:04 2001 hcid[36]: Can't open device hci0. No such device(=
19)
<30> Jan  1 19:21:04 2001 hcid[32]: Starting security manager 0
<27> Jan  1 19:21:04 2001 hcid[32]: Can't open device hci0. No such device(=
19)
<30> Jan  1 19:21:04 2001 hcid[32]: HCI dev 0 down
<30> Jan  1 19:21:04 2001 hcid[32]: HCI dev 0 unregistered



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
