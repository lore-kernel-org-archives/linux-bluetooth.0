Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050216155732.29721.qmail@web53201.mail.yahoo.com>
From: Filipa Duarte <filipa_duarte@yahoo.com>
To: BlueZ Devel <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] L2CAP & HCI trace
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 16 Feb 2005 07:57:32 -0800 (PST)

Hi,

I suppose that this is a quite stupid question but I
would like to know how can I have the same kind of
trace as Victor had (in the end of the e-mail)? 

The reason why is that I would like to identify which
are the functions (like l2cap_sock_sendmsg,
l2cap_chan_send, hci_send_acl, etc) used to send data
on the l2cap/hci layers. Could anyone give me any
direction to find this?

Many thanks,

Filipa

 > 10:29:54.4645405 l2cap_sock_sendmsg: sock c7177340,
sk c72a24a0
 > 10:29:54.4646345 l2cap_chan_send: sk c72a24a0 len
506
 > 10:29:54.4646865 hci_send_acl: hci0 conn c738c660
flags 0x0
 > 10:29:54.4646985 hci_send_acl: hci0 frag c74d92c0
len 196
 > 10:29:54.4647105 hci_send_acl: hci0 frag c71b6220
len 196
 > 10:29:54.4647225 hci_send_acl: hci0 frag c74d9440
len 130
 > 10:29:54.4647345 hci_tx_task: hci0 acl 4 sco 9
 > 10:29:54.4647455 hci_sched_acl: hci0
 > 10:29:54.4647545 hci_low_sent: conn c738c660 quote
4
 > 10:29:54.4647655 hci_sched_acl: skb c74d92c0 len
196
 > 10:29:54.4647765 hci_send_frame: hci0 type 2 len
196
 > 10:29:54.4647875 hci_uart_send_frame: hci0: type 2
len 196
 > 10:29:54.4647995 h4_enqueue: hu c7ced400 skb
c74d92c0
 > 10:29:54.4648115 hci_uart_tx_wakeup:
 > 10:29:54.4648205 hci_sched_acl: skb c71b6220 len
196
 > 10:29:54.4648325 hci_send_frame: hci0 type 2 len
196
 > 10:29:54.4648435 hci_uart_send_frame: hci0: type 2
len 196
 > 10:29:54.4648555 h4_enqueue: hu c7ced400 skb
c71b6220
 > 10:29:54.4648665 hci_uart_tx_wakeup:
 > 10:29:54.4648755 hci_sched_acl: skb c74d9440 len
130
 > 10:29:54.4648865 hci_send_frame: hci0 type 2 len
130
 > 10:29:54.4649085 hci_uart_send_frame: hci0: type 2
len 130
 > 10:29:54.4649205 h4_enqueue: hu c7ced400 skb
c74d9440
 > 10:29:54.4649325 hci_uart_tx_wakeup:
 > 10:29:54.4649615 hci_low_sent: conn 00000000 quote
0
 > 10:29:54.4649725 hci_sched_sco: hci0
 > 10:29:54.4649815 hci_low_sent: conn 00000000 quote
0
 > 10:29:54.4649925 hci_uart_tty_wakeup:
 > 10:29:54.4650015 hci_uart_tx_wakeup:
 > 10:29:54.4731195 h4_recv: hu c7ced400 count 4
rx_state 0 rx_count 0
 > 10:29:54.4731785 h4_recv: Event packet
 > 10:29:54.4731885 h4_recv: Event header: evt 0x10
plen 1
 > 10:29:54.4732025 h4_check_data_len: len 1 room 1046
 > 10:29:54.4732135 h4_recv: Complete data
 > 10:29:54.4732235 hci_recv_frame: hci0 type 4 len 3
 > 10:29:54.4732335 hci_rx_task: hci0
 > 10:29:54.4732445 hci_event_packet: hci0 evt 0x10
 > 10:29:54.5151125 h4_recv: hu c7ced400 count 8
rx_state 0 rx_count 0
 > 10:29:54.5151715 h4_recv: Event packet
 > 10:29:54.5151815 h4_recv: Event header: evt 0x13
plen 5
 > 10:29:54.5151965 h4_check_data_len: len 5 room 1046
 > 10:29:54.5152075 h4_recv: Complete data
 > 10:29:54.5152165 hci_recv_frame: hci0 type 4 len 7
 > 10:29:54.5152275 hci_rx_task: hci0
 > 10:29:54.5152385 hci_event_packet: hci0 evt 0x13
 > 10:29:54.5152525 hci_num_comp_pkts_evt: hci0
num_hndl 1
 > 10:29:54.5184605 hci_tx_task: hci0 acl 3 sco 9
 > 10:29:54.5185165 hci_sched_acl: hci0
 > 10:29:54.5185285 hci_low_sent: conn 00000000 quote
0
 > 10:29:54.5185405 hci_sched_sco: hci0
 > 10:29:54.5185525 hci_low_sent: conn 00000000 quote 0

=====
-- 
Filipa Duarte

Computer Engineering Laboratory
Electrical Engineering Department
Delft University of Technology

Melkeweg 4
2628 CD Delft
The Netherlands

phone: +31 (0)15 278 5021
fax:   +31 (0)15 278 4898


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - now with 250MB free storage. Learn more.
http://info.mail.yahoo.com/mail_250


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
