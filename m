Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Dmitri Khokhlov" <dkhokhlov@hotmail.com>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001B_01C3EB49.2B5D4A60"
Message-ID: <BAY8-DAV8lzzOjPtlBB000035dd@hotmail.com>
Subject: [Bluez-devel] racing condition in accepting incoming RFCOMM connection
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 4 Feb 2004 18:03:18 -0800

This is a multi-part message in MIME format.

------=_NextPart_000_001B_01C3EB49.2B5D4A60
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit

Hi

It looks like there is a racing condition in accepting incoming RFCOMM
connection. It happens to me in 90% cases when a headset originates
connection to a voice gateway. If RFCOMM SAMB command frame comes in L2CAP
data packet right after L2CAP Configuration Request packet and there is no
active RFCOMM sessions yet then the kernel RFCOMM thread wakes up only one
time and creates new session but does not process SAMB frame from second
L2CAP data packet waiting in queue. Connection setup hangs. Headset is
waiting for UA frame response but the kernel RFCOMM thread keeps sleeping.
The kernel log for bad case is attached. I use the following environment:
Kernel: Linux 2.4.21 + patch-2.4.21-mh6, PowerPC.
Headsets: Motorola Model 98405H, BlueTrek-G2.
Voice gateway: Murata BlueModule, CSR BlueCore: BC02 (Hardware ID 8a)
firmware version 526
A possible solution could be to force additional thread wakeup right after
successful creation of new session in rfcomm_accept_connection(). The patch
is attached.

Regards.
Dmitri
mailto: dkhokhlov@hotmail.com

------=_NextPart_000_001B_01C3EB49.2B5D4A60
Content-Type: application/octet-stream;
	name="patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch"

diff -Naur  linux.org/net/bluetooth/rfcomm/core.c.old  =
linux/net/bluetooth/rfcomm/core.c=0A=
--- linux.org/net/bluetooth/rfcomm/core.c	Mon Feb  2 10:45:56 2004=0A=
+++ linux/net/bluetooth/rfcomm/core.c	Wed Feb  4 13:23:38 2004=0A=
@@ -1654,8 +1654,10 @@=0A=
 	nsock->sk->state_change =3D rfcomm_l2state_change;=0A=
 =0A=
 	s =3D rfcomm_session_add(nsock, BT_OPEN);=0A=
-	if (s)=0A=
+	if (s) {=0A=
 		rfcomm_session_hold(s);=0A=
+		rfcomm_schedule(RFCOMM_SCHED_RX);=0A=
+	}	=0A=
 	else=0A=
 		sock_release(nsock);=0A=
 }=0A=

------=_NextPart_000_001B_01C3EB49.2B5D4A60
Content-Type: application/octet-stream;
	name="log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="log"

...incoming RFCOMM connection setup, DLC config negotiation...=0A=
=0A=
Feb 3 16:24:49 10 kernel: hci_rx_task: hci0 ACL data packet=0A=
Feb 3 16:24:49 10 kernel: hci_acldata_packet: hci0 len 16 handle 0x29 =
flags 0x2=0A=
Feb 3 16:24:49 10 kernel: l2cap_recv_acldata: conn c02f0d20 len 16 flags =
0x2=0A=
Feb 3 16:24:49 10 kernel: l2cap_recv_frame: len 12, cid 0x0001=0A=
Feb 3 16:24:49 10 kernel: l2cap_sig_channel: code 0x04 len 8 id 0x04=0A=
=0A=
>>>>>>>>>Feb 3 16:24:49 10 kernel: l2cap_config_req: dcid 0x0041 flags =
0x00=0A=
=0A=
Feb 3 16:24:49 10 kernel: l2cap_parse_conf_req: sk c158aac0 len 4=0A=
Feb 3 16:24:49 10 kernel: l2cap_get_conf_opt: type 0x01 len 2 val 0x84=0A=
Feb 3 16:24:49 10 kernel: l2cap_build_conf_rsp: sk c158aac0 complete 1=0A=
Feb 3 16:24:49 10 kernel: l2cap_conf_output: sk c158aac0 result 0=0A=
Feb 3 16:24:49 10 kernel: l2cap_build_cmd: conn c02f0d20, code 0x05, =
ident 0x04, len 6=0A=
Feb 3 16:24:49 10 kernel: l2cap_send_rsp: code 0x05=0A=
Feb 3 16:24:49 10 kernel: hci_send_acl: hci0 conn c1cc7aa0 flags 0x0=0A=
Feb 3 16:24:49 10 kernel: hci_send_acl: hci0 nonfrag skb c03fef20 len 18=0A=
Feb 3 16:24:49 10 kernel: l2cap_build_conf_req: sk c158aac0=0A=
Feb 3 16:24:49 10 kernel: l2cap_add_conf_opt: type 0x01 len 2 val 0x400=0A=
Feb 3 16:24:49 10 kernel: l2cap_build_cmd: conn c02f0d20, code 0x04, =
ident 0x02, len 8=0A=
Feb 3 16:24:49 10 kernel: l2cap_send_req: code 0x04=0A=
Feb 3 16:24:49 10 kernel: hci_send_acl: hci0 conn c1cc7aa0 flags 0x0=0A=
Feb 3 16:24:49 10 kernel: hci_send_acl: hci0 nonfrag skb c0289480 len 20=0A=
Feb 3 16:24:49 10 kernel: hci_tx_task: hci0 acl 8 sco 8=0A=
Feb 3 16:24:49 10 kernel: hci_sched_acl: hci0=0A=
Feb 3 16:24:49 10 kernel: hci_low_sent: conn c1cc7aa0 quote 8=0A=
Feb 3 16:24:49 10 kernel: hci_sched_acl: skb c03fef20 len 18=0A=
Feb 3 16:24:49 10 kernel: hci_send_frame: hci0 type 2 len 18=0A=
Feb 3 16:24:49 10 kernel: hci_send_to_sock: hdev c02a9804 len 18=0A=
Feb 3 16:24:49 10 kernel: hci_uart_send_frame: hci0: type 2 len 18=0A=
Feb 3 16:24:49 10 kernel: hci_uart_tx_wakeup:=0A=
Feb 3 16:24:49 10 kernel: hci_sched_acl: skb c0289480 len 20=0A=
Feb 3 16:24:49 10 kernel: hci_send_frame: hci0 type 2 len 20=0A=
Feb 3 16:24:49 10 kernel: hci_send_to_sock: hdev c02a9804 len 20=0A=
Feb 3 16:24:49 10 kernel: hci_uart_send_frame: hci0: type 2 len 20=0A=
Feb 3 16:24:49 10 kernel: hci_uart_tx_wakeup:=0A=
Feb 3 16:24:49 10 kernel: hci_low_sent: conn 00000000 quote 0=0A=
Feb 3 16:24:49 10 kernel: hci_sched_sco: hci0=0A=
Feb 3 16:24:49 10 kernel: hci_low_sent: conn 00000000 quote 0=0A=
Feb 3 16:24:49 10 kernel: hci_uart_tty_wakeup:=0A=
Feb 3 16:24:49 10 kernel: hci_uart_tx_wakeup:=0A=
Feb 3 16:24:49 10 kernel: hci_recv_frame: hci0 type 4 len 7=0A=
Feb 3 16:24:49 10 kernel: hci_rx_task: hci0=0A=
Feb 3 16:24:49 10 kernel: hci_send_to_sock: hdev c02a9804 len 7=0A=
Feb 3 16:24:49 10 kernel: hci_event_packet: hci0 evt 0x13=0A=
Feb 3 16:24:49 10 kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Feb 3 16:24:49 10 kernel: hci_tx_task: hci0 acl 7 sco 8=0A=
Feb 3 16:24:49 10 kernel: hci_sched_acl: hci0=0A=
Feb 3 16:24:49 10 kernel: hci_low_sent: conn 00000000 quote 0=0A=
Feb 3 16:24:49 10 kernel: hci_sched_sco: hci0=0A=
Feb 3 16:24:49 10 kernel: hci_low_sent: conn 00000000 quote 0=0A=
Feb 3 16:24:49 10 kernel: hci_recv_frame: hci0 type 4 len 7=0A=
Feb 3 16:24:49 10 kernel: hci_rx_task: hci0=0A=
Feb 3 16:24:49 10 kernel: hci_send_to_sock: hdev c02a9804 len 7=0A=
Feb 3 16:24:49 10 kernel: hci_event_packet: hci0 evt 0x13=0A=
Feb 3 16:24:49 10 kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Feb 3 16:24:49 10 kernel: hci_tx_task: hci0 acl 8 sco 8=0A=
Feb 3 16:24:49 10 kernel: hci_sched_acl: hci0=0A=
Feb 3 16:24:49 10 kernel: hci_low_sent: conn 00000000 quote 0=0A=
Feb 3 16:24:49 10 kernel: hci_sched_sco: hci0=0A=
Feb 3 16:24:49 10 kernel: hci_low_sent: conn 00000000 quote 0=0A=
Feb 3 16:24:49 10 kernel: hci_recv_frame: hci0 type 2 len 21=0A=
Feb 3 16:24:49 10 kernel: hci_rx_task: hci0=0A=
Feb 3 16:24:49 10 kernel: hci_send_to_sock: hdev c02a9804 len 21=0A=
Feb 3 16:24:49 10 kernel: hci_rx_task: hci0 ACL data packet=0A=
Feb 3 16:24:49 10 kernel: hci_acldata_packet: hci0 len 17 handle 0x29 =
flags 0x2=0A=
Feb 3 16:24:49 10 kernel: l2cap_recv_acldata: conn c02f0d20 len 17 flags =
0x2=0A=
=0A=
>>>>>>Feb 3 16:24:49 10 kernel: l2cap_recv_acldata: Start: total len 18, =
frag len 17=0A=
=0A=
Feb 3 16:24:49 10 kernel: hci_recv_frame: hci0 type 2 len 5=0A=
Feb 3 16:24:49 10 kernel: hci_rx_task: hci0=0A=
Feb 3 16:24:49 10 kernel: hci_send_to_sock: hdev c02a9804 len 5=0A=
Feb 3 16:24:49 10 kernel: hci_rx_task: hci0 ACL data packet=0A=
Feb 3 16:24:49 10 kernel: hci_acldata_packet: hci0 len 1 handle 0x29 =
flags 0x1=0A=
Feb 3 16:24:49 10 kernel: l2cap_recv_acldata: conn c02f0d20 len 1 flags =
0x1=0A=
Feb 3 16:24:49 10 kernel: l2cap_recv_acldata: Cont: frag len 1 =
(expecting 1)=0A=
Feb 3 16:24:49 10 kernel: l2cap_recv_frame: len 14, cid 0x0001=0A=
Feb 3 16:24:49 10 kernel: l2cap_sig_channel: code 0x05 len 10 id 0x02=0A=
=0A=
>>>>>>Feb 3 16:24:49 10 kernel: l2cap_config_rsp: scid 0x0041 flags 0x00 =
result 0x00=0A=
=0A=
Feb 3 16:24:49 10 kernel: l2cap_chan_ready: sk c158aac0, parent c02c3080=0A=
Feb 3 16:24:49 10 kernel: l2cap_sock_clear_timer: sock c158aac0 state 1=0A=
Feb 3 16:24:49 10 kernel: rfcomm_l2data_ready: c02c3080 bytes 0=0A=
Feb 3 16:24:49 10 kernel: hci_recv_frame: hci0 type 2 len 12=0A=
Feb 3 16:24:49 10 kernel: hci_rx_task: hci0=0A=
Feb 3 16:24:49 10 kernel: hci_send_to_sock: hdev c02a9804 len 12=0A=
Feb 3 16:24:49 10 kernel: hci_rx_task: hci0 ACL data packet=0A=
Feb 3 16:24:49 10 kernel: hci_acldata_packet: hci0 len 8 handle 0x29 =
flags 0x2=0A=
Feb 3 16:24:49 10 kernel: l2cap_recv_acldata: conn c02f0d20 len 8 flags =
0x2=0A=
=0A=
>>>>>>Feb 3 16:24:49 10 kernel: l2cap_recv_frame: len 4, cid 0x0041 =
>>>>>>>>>SABM=0A=
=0A=
Feb 3 16:24:49 10 kernel: l2cap_data_channel: sk c158aac0, len 4=0A=
Feb 3 16:24:49 10 kernel: hci_acldata_packet: hci0 len 4 handle 0x29 =
flags 0x2 @@@@@@ after recv_acldata=0A=
=0A=
>>>>>>Feb 3 16:24:49 10 kernel: rfcomm_accept_connection: session =
c02f05a0=0A=
=0A=
Feb 3 16:24:49 10 kernel: l2cap_sock_accept: sk c02c3080 timeo 0=0A=
Feb 3 16:24:49 10 kernel: l2cap_sock_accept: new socket c158aac0=0A=
Feb 3 16:24:49 10 kernel: rfcomm_session_add: session c02f0ae0 sock =
c155a560=0A=
Feb 3 16:24:49 10 kernel: rfcomm_worker: worker loop event 0x0=0A=
=0A=
.. nothing happens here. =0A=

------=_NextPart_000_001B_01C3EB49.2B5D4A60--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
