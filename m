Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 17 Feb 2010 15:30:42 -0600
Message-ID: <8a7a8d7b1002171330m7d1549deye643aecad10c5822@mail.gmail.com>
Subject: What's the idea of security_cfm is called for both hci_proto_auth_cfm
	and hci_proto_encrypt_cfm? -resend
From: Liejun Tao <liejuntao001@gmail.com>
To: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,
Beside the l2cap issue with Blackberry 8900, I meet another l2cap
connection failure issue when testing
PTS AVRCP_TC_TG_PTT_BV_01_I.

For 8900, the sequence is:
l2cap_do_start(): send L2CAP_INFO_REQ
security_cfm(): send L2CAP_CONN_REQ
l2cap_information_rsp(): call l2cap_do_start(), send L2CAP_CONN_REQ again

For PTS AVRCP_TC_TG_PTT_BV_01_I, the sequence is:
l2cap_do_start(): send L2CAP_CONN_REQ
security_cfm():send L2CAP_CONN_REQ again
l2cap_conn_rsp(): receive L2CAP_CR_PEND
l2cap_conn_rsp(): receive L2CAP_CR_NO_MEM

In both cases, security_cfm() is called from hci_proto_encrypt_cfm(),
and interrupt the normal sequence of l2cap connection.

security_cfm() is also called in hci_proto_auth_cfm. I feel auth_cfm
and encryption_cfm are for different events, why they call the same
function?

What's your mind to avoid 2 connection request?

Aside, should we set a state bit after send l2CAP_CONN_REQ?

Below is a piece of kernel debug message when testing AVRCP_TC_TG_PTT_BV_01_I,
We can see 2 CONN_REQ.

resend as not sure previous mail got sent.




<3>[  541.587463] l2cap_do_connect: DB:D8:AA:D4:23:00 ->
A0:33:E7:98:80:00 psm 0x19
<3>[  541.604095] hci_get_route: DB:D8:AA:D4:23:00 -> A0:33:E7:98:80:00
<3>[  541.610687] hci_connect: hci0 dst A0:33:E7:98:80:00
<3>[  541.615814] __l2cap_chan_add: conn ccd49940, psm 0x19, dcid 0x0000
<3>[  541.622314] l2cap_sock_set_timer: sk ccbc0000 state 5 timeout 5120
<3>[  541.628814] hci_conn_security: conn c900c000
<3>[  541.633270] l2cap_build_cmd: conn ccd49940, code 0x02, ident 0x05, len 4
<3>[  541.640319] l2cap_send_cmd: code 0x02
<3>[  541.644165] hci_send_acl: hci0 conn c900c000 flags 0x0
<3>[  541.649536] hci_send_acl: hci0 nonfrag skb cec59200 len 16
<3>[  541.655303] hci_tx_task: hci0 acl 4 sco 4
<3>[  541.659484] hci_sched_acl: hci0
<3>[  541.662780] hci_low_sent: conn c900c000 quote 4
<3>[  541.667541] hci_sched_acl: skb cec59200 len 16
<3>[  541.672180] hci_conn_enter_active_mode: conn c900c000 mode 0
<3>[  541.678131] hci_send_frame: hci0 type 2 len 16
<3>[  541.682800] hci_send_to_sock: hdev c453c000 len 16
<3>[  541.687805] hci_uart_send_frame: hci0: type 2 len 16
<3>[  541.693023] ll_enqueue: hu c9590d80 skb cec59200
<3>[  541.697845] ll_enqueue: device asleep, waking up and queueing packet
<3>[  541.704467] send_hcill_cmd: hu c9590d80 cmd 0x32
<3>[  541.709320] hci_uart_tx_wakeup:
<3>[  541.712738] hci_low_sent: conn (null) quote 0
<3>[  541.717315] ll_recv: hu c9590d80 count 1 rx_state 0 rx_count 0
<3>[  541.723419] ll_recv: HCILL_WAKE_UP_ACK packet
<3>[  541.727996] ll_device_woke_up: hu c9590d80
<3>[  541.732269] hci_uart_tx_wakeup:
<3>[  541.735687] hci_sched_sco: hci0
<3>[  541.738983] hci_low_sent: conn (null) quote 0
<3>[  541.743560] ll_recv: hu c9590d80 count 8 rx_state 0 rx_count 0
<3>[  541.749664] ll_recv: Event packet
<3>[  541.753143] ll_recv: Event header: evt 0x13 plen 5
<3>[  541.758178] ll_check_data_len: len 5 room 1078
<3>[  541.762847] ll_recv: Complete data
<3>[  541.766387] hci_sched_esco: hci0
<3>[  541.769775] hci_low_sent: conn (null) quote 0
<3>[  541.774353] hci_uart_tty_wakeup:
<3>[  541.777832] hci_uart_tx_wakeup:
<3>[  541.781188] hci_rx_task: hci0
<3>[  541.784301] hci_send_to_sock: hdev c453c000 len 7
<3>[  541.789215] hci_num_comp_pkts_evt: hci0 num_hndl 1
<3>[  541.794250] hci_tx_task: hci0 acl 4 sco 4
<3>[  541.798431] hci_sched_acl: hci0
<3>[  541.801727] hci_low_sent: conn (null) quote 0
<3>[  541.806274] hci_sched_sco: hci0
<3>[  541.809570] hci_low_sent: conn (null) quote 0
<3>[  541.814117] hci_sched_esco: hci0
<3>[  541.817535] ll_recv: hu c9590d80 count 7 rx_state 0 rx_count 0
<3>[  541.823608] ll_recv: Event packet
<3>[  541.827117] ll_recv: Event header: evt 0x08 plen 4
<3>[  541.832153] ll_check_data_len: len 4 room 1078
<3>[  541.836791] ll_recv: Complete data
<3>[  541.840423] ll_recv: hu c9590d80 count 27 rx_state 0 rx_count 0
<3>[  541.846588] ll_recv: ACL packet
<3>[  541.849945] ll_recv: ACL header: dlen 16
<3>[  541.854034] ll_check_data_len: len 16 room 1076
<3>[  541.858764] ll_recv: Complete data
<3>[  541.862335] ll_recv: ACL packet
<3>[  541.865661] ll_recv: ACL header: dlen 16
<3>[  541.869750] ll_check_data_len: len 16 room 1076
<3>[  541.874481] ll_recv: hu c9590d80 count 32 rx_state 4 rx_count 15
<3>[  541.880798] ll_recv: Complete data
<3>[  541.884338] ll_recv: ACL packet
<3>[  541.887664] ll_recv: ACL header: dlen 12
<3>[  541.891754] ll_check_data_len: len 12 room 1076
<3>[  541.896514] ll_recv: Complete data
<3>[  541.900054] hci_low_sent: conn (null) quote 0
<3>[  541.904632] hci_rx_task: hci0
<3>[  541.907714] hci_send_to_sock: hdev c453c000 len 6
<3>[  541.912658] hci_encrypt_change_evt: hci0 status 0
<3>[  541.917602] l2cap_security_cfm: conn ccd49940
<3>[  541.922149] l2cap_build_cmd: conn ccd49940, code 0x02, ident 0x06, len 4
<3>[  541.929168] l2cap_send_cmd: code 0x02
<3>[  541.933013] ll_recv: hu c9590d80 count 1 rx_state 0 rx_count 0
<3>[  541.939117] ll_recv: HCILL_GO_TO_SLEEP_IND packet
<3>[  541.944030] ll_device_want_to_sleep: hu c9590d80
<3>[  541.948883] send_hcill_cmd: hu c9590d80 cmd 0x31
<3>[  541.953704] hci_uart_tx_wakeup:
<3>[  541.957122] hci_send_acl: hci0 conn c900c000 flags 0x0
<3>[  541.962493] hci_send_acl: hci0 nonfrag skb cec599d0 len 16
<3>[  541.968231] rfcomm_security_cfm: conn c900c000 status 0x00 encrypt 0x01
<3>[  541.975189] hci_send_to_sock: hdev c453c000 len 20
<3>[  541.980224] hci_rx_task: hci0 ACL data packet
<3>[  541.984771] hci_acldata_packet: hci0 len 16 handle 0x1 flags 0x2
<3>[  541.991058] hci_conn_enter_active_mode: conn c900c000 mode 0
<3>[  541.996978] l2cap_recv_acldata: conn ccd49940 len 16 flags 0x2
<3>[  542.003082] l2cap_recv_frame: len 12, cid 0x0001
<3>[  542.007934] l2cap_raw_recv: conn ccd49940
<3>[  542.012176] l2cap_sig_channel: code 0x03 len 8 id 0x05
<3>[  542.017547] l2cap_connect_rsp: dcid 0x0042 scid 0x0042 result
0x01 status 0x00
<3>[  542.025115] hci_send_to_sock: hdev c453c000 len 20
<3>[  542.030120] hci_rx_task: hci0 ACL data packet
<3>[  542.034698] hci_acldata_packet: hci0 len 16 handle 0x1 flags 0x2
<3>[  542.040985] hci_conn_enter_active_mode: conn c900c000 mode 0
<3>[  542.046905] l2cap_recv_acldata: conn ccd49940 len 16 flags 0x2
<3>[  542.053009] l2cap_recv_frame: len 12, cid 0x0001
<3>[  542.057830] l2cap_raw_recv: conn ccd49940
<3>[  542.062042] l2cap_sig_channel: code 0x03 len 8 id 0x05
<3>[  542.067413] l2cap_connect_rsp: dcid 0x0042 scid 0x0042 result
0x00 status 0x00
<3>[  542.074981] l2cap_build_conf_req: sk ccbc0000
<3>[  542.079528] l2cap_build_cmd: conn ccd49940, code 0x04, ident 0x07, len 4
<3>[  542.086578] l2cap_send_cmd: code 0x04
<3>[  542.090423] hci_send_acl: hci0 conn c900c000 flags 0x0
<3>[  542.095764] hci_send_acl: hci0 nonfrag skb cec59840 len 16
<3>[  542.101531] hci_send_to_sock: hdev c453c000 len 16
