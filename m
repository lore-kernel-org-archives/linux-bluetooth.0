Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] HCI Events and errors
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <37D1FAB2FA7B7E4993785B956F853C73181463@ednex506.dsto.defence.gov.au>
References: 
	 <37D1FAB2FA7B7E4993785B956F853C73181463@ednex506.dsto.defence.gov.au>
Content-Type: text/plain
Message-Id: <1107319236.9276.7.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 02 Feb 2005 05:40:36 +0100

Hi Victor,

> > what does "hciconfig -a" say? If I remember correctly then there is
> > neither a CSR nor a Zeevo chip in this model.
> 
> hci0:   Type: UART
>         BD Address: 08:00:17:1A:F3:43 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes: 600 acl:0 sco:0 events:28 errors:0
>         TX bytes: 326 acl:0 sco:0 commands:13 errors:0
>         Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1
>         Link policy:
>         Link mode: MASTER
>         Name: 'Testing'
>         Class: 0xff0100
>         Service Classes: Positioning, Networking, Rendering, Capturing, Object
> Transfer, Audio, n
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x180 LMP Ver: 1.1 (0x1) LMP Subver: 0x180
>         Manufacturer: RTX Telecom A/S (21)

is there a reason why you use only DM1 packets and haven't activated any
of the link policies? Try if this changes something.

> > Who is sending to whom?
> 
> The PC does the listen() and accept(), the ipaq does the connect(), then
> the ipaq repeatedly calls send() and usleep().  The test program is
> loosely based on l2test.c.

This should work fine.

> > Show me that part, because I don't believe that this is an allocation
> > problem inside BlueZ.
> 
> I've pasted the important parts at the end of this email, the full trace
> is quite long but is available on request.  The hardware error mentioned
> above can be seen at timestamp 10:29:54.4732445.
> 
> Thanks for your quick response.  I'll see how I go with adding the 'reset'
> functionality, to see what difference it makes.
> 
> A random healthy exchange:
> 
> 10:29:51.0445595 l2cap_sock_sendmsg: sock c7177340, sk c72a24a0
> 10:29:51.0446535 l2cap_chan_send: sk c72a24a0 len 506
> 10:29:51.0447065 hci_send_acl: hci0 conn c738c660 flags 0x0
> 10:29:51.0447185 hci_send_acl: hci0 frag c71b6220 len 196
> 10:29:51.0447305 hci_send_acl: hci0 frag c74d98c0 len 196
> 10:29:51.0447425 hci_send_acl: hci0 frag c74d92c0 len 130
> 10:29:51.0447545 hci_tx_task: hci0 acl 4 sco 9
> 10:29:51.0447645 hci_sched_acl: hci0
> 10:29:51.0447735 hci_low_sent: conn c738c660 quote 4
> 10:29:51.0447845 hci_sched_acl: skb c71b6220 len 196
> 10:29:51.0447965 hci_send_frame: hci0 type 2 len 196
> 10:29:51.0448075 hci_uart_send_frame: hci0: type 2 len 196
> 10:29:51.0448195 h4_enqueue: hu c7ced400 skb c71b6220
> 10:29:51.0448315 hci_uart_tx_wakeup:
> 10:29:51.0448405 hci_sched_acl: skb c74d98c0 len 196
> 10:29:51.0448515 hci_send_frame: hci0 type 2 len 196
> 10:29:51.0448625 hci_uart_send_frame: hci0: type 2 len 196
> 10:29:51.0448745 h4_enqueue: hu c7ced400 skb c74d98c0
> 10:29:51.0448865 hci_uart_tx_wakeup:
> 10:29:51.0448955 hci_sched_acl: skb c74d92c0 len 130
> 10:29:51.0449055 hci_send_frame: hci0 type 2 len 130
> 10:29:51.0449285 hci_uart_send_frame: hci0: type 2 len 130
> 10:29:51.0449405 h4_enqueue: hu c7ced400 skb c74d92c0
> 10:29:51.0449515 hci_uart_tx_wakeup:
> 10:29:51.0449815 hci_low_sent: conn 00000000 quote 0
> 10:29:51.0449925 hci_sched_sco: hci0
> 10:29:51.0450015 hci_low_sent: conn 00000000 quote 0
> 10:29:51.0450125 hci_uart_tty_wakeup:
> 10:29:51.0450215 hci_uart_tx_wakeup:
> 10:29:51.0801355 h4_recv: hu c7ced400 count 8 rx_state 0 rx_count 0
> 10:29:51.0801955 h4_recv: Event packet
> 10:29:51.0802045 h4_recv: Event header: evt 0x13 plen 5
> 10:29:51.0802195 h4_check_data_len: len 5 room 1046
> 10:29:51.0802305 h4_recv: Complete data
> 10:29:51.0802395 hci_recv_frame: hci0 type 4 len 7
> 10:29:51.0802505 hci_rx_task: hci0
> 10:29:51.0802615 hci_event_packet: hci0 evt 0x13
> 10:29:51.0802745 hci_num_comp_pkts_evt: hci0 num_hndl 1
> 10:29:51.0835815 hci_tx_task: hci0 acl 3 sco 9
> 10:29:51.0836385 hci_sched_acl: hci0
> 10:29:51.0836495 hci_low_sent: conn 00000000 quote 0
> 10:29:51.0836615 hci_sched_sco: hci0
> 10:29:51.0836735 hci_low_sent: conn 00000000 quote 0
> 
> The penultimate healthy (?) exchange, which contains the hardware error:
> 
> 10:29:54.4645405 l2cap_sock_sendmsg: sock c7177340, sk c72a24a0
> 10:29:54.4646345 l2cap_chan_send: sk c72a24a0 len 506
> 10:29:54.4646865 hci_send_acl: hci0 conn c738c660 flags 0x0
> 10:29:54.4646985 hci_send_acl: hci0 frag c74d92c0 len 196
> 10:29:54.4647105 hci_send_acl: hci0 frag c71b6220 len 196
> 10:29:54.4647225 hci_send_acl: hci0 frag c74d9440 len 130
> 10:29:54.4647345 hci_tx_task: hci0 acl 4 sco 9
> 10:29:54.4647455 hci_sched_acl: hci0
> 10:29:54.4647545 hci_low_sent: conn c738c660 quote 4
> 10:29:54.4647655 hci_sched_acl: skb c74d92c0 len 196
> 10:29:54.4647765 hci_send_frame: hci0 type 2 len 196
> 10:29:54.4647875 hci_uart_send_frame: hci0: type 2 len 196
> 10:29:54.4647995 h4_enqueue: hu c7ced400 skb c74d92c0
> 10:29:54.4648115 hci_uart_tx_wakeup:
> 10:29:54.4648205 hci_sched_acl: skb c71b6220 len 196
> 10:29:54.4648325 hci_send_frame: hci0 type 2 len 196
> 10:29:54.4648435 hci_uart_send_frame: hci0: type 2 len 196
> 10:29:54.4648555 h4_enqueue: hu c7ced400 skb c71b6220
> 10:29:54.4648665 hci_uart_tx_wakeup:
> 10:29:54.4648755 hci_sched_acl: skb c74d9440 len 130
> 10:29:54.4648865 hci_send_frame: hci0 type 2 len 130
> 10:29:54.4649085 hci_uart_send_frame: hci0: type 2 len 130
> 10:29:54.4649205 h4_enqueue: hu c7ced400 skb c74d9440
> 10:29:54.4649325 hci_uart_tx_wakeup:
> 10:29:54.4649615 hci_low_sent: conn 00000000 quote 0
> 10:29:54.4649725 hci_sched_sco: hci0
> 10:29:54.4649815 hci_low_sent: conn 00000000 quote 0
> 10:29:54.4649925 hci_uart_tty_wakeup:
> 10:29:54.4650015 hci_uart_tx_wakeup:
> 10:29:54.4731195 h4_recv: hu c7ced400 count 4 rx_state 0 rx_count 0
> 10:29:54.4731785 h4_recv: Event packet
> 10:29:54.4731885 h4_recv: Event header: evt 0x10 plen 1
> 10:29:54.4732025 h4_check_data_len: len 1 room 1046
> 10:29:54.4732135 h4_recv: Complete data
> 10:29:54.4732235 hci_recv_frame: hci0 type 4 len 3
> 10:29:54.4732335 hci_rx_task: hci0
> 10:29:54.4732445 hci_event_packet: hci0 evt 0x10
> 10:29:54.5151125 h4_recv: hu c7ced400 count 8 rx_state 0 rx_count 0
> 10:29:54.5151715 h4_recv: Event packet
> 10:29:54.5151815 h4_recv: Event header: evt 0x13 plen 5
> 10:29:54.5151965 h4_check_data_len: len 5 room 1046
> 10:29:54.5152075 h4_recv: Complete data
> 10:29:54.5152165 hci_recv_frame: hci0 type 4 len 7
> 10:29:54.5152275 hci_rx_task: hci0
> 10:29:54.5152385 hci_event_packet: hci0 evt 0x13
> 10:29:54.5152525 hci_num_comp_pkts_evt: hci0 num_hndl 1
> 10:29:54.5184605 hci_tx_task: hci0 acl 3 sco 9
> 10:29:54.5185165 hci_sched_acl: hci0
> 10:29:54.5185285 hci_low_sent: conn 00000000 quote 0
> 10:29:54.5185405 hci_sched_sco: hci0
> 10:29:54.5185525 hci_low_sent: conn 00000000 quote 0
> 
> 10:29:54.5545355 l2cap_sock_sendmsg: sock c7177340, sk c72a24a0
> 10:29:54.5546305 l2cap_chan_send: sk c72a24a0 len 506
> 10:29:54.5546835 hci_send_acl: hci0 conn c738c660 flags 0x0
> 10:29:54.5546955 hci_send_acl: hci0 frag c71b6220 len 196
> 10:29:54.5547075 hci_send_acl: hci0 frag c74d92c0 len 196
> 10:29:54.5547195 hci_send_acl: hci0 frag c74d9440 len 130
> 10:29:54.5547315 hci_tx_task: hci0 acl 3 sco 9
> 10:29:54.5547415 hci_sched_acl: hci0
> 10:29:54.5547505 hci_low_sent: conn c738c660 quote 3
> 10:29:54.5547625 hci_sched_acl: skb c71b6220 len 196
> 10:29:54.5547735 hci_send_frame: hci0 type 2 len 196
> 10:29:54.5547845 hci_uart_send_frame: hci0: type 2 len 196
> 10:29:54.5547965 h4_enqueue: hu c7ced400 skb c71b6220
> 10:29:54.5548085 hci_uart_tx_wakeup:
> 10:29:54.5548165 hci_sched_acl: skb c74d92c0 len 196
> 10:29:54.5548285 hci_send_frame: hci0 type 2 len 196
> 10:29:54.5548395 hci_uart_send_frame: hci0: type 2 len 196
> 10:29:54.5548515 h4_enqueue: hu c7ced400 skb c74d92c0
> 10:29:54.5548625 hci_uart_tx_wakeup:
> 10:29:54.5548715 hci_sched_acl: skb c74d9440 len 130
> 10:29:54.5548825 hci_send_frame: hci0 type 2 len 130
> 10:29:54.5548945 hci_uart_send_frame: hci0: type 2 len 130
> 10:29:54.5549175 h4_enqueue: hu c7ced400 skb c74d9440
> 10:29:54.5549285 hci_uart_tx_wakeup:
> 10:29:54.5549575 hci_sched_sco: hci0
> 10:29:54.5549665 hci_low_sent: conn 00000000 quote 0
> 10:29:54.5549775 hci_uart_tty_wakeup:
> 10:29:54.5549865 hci_uart_tx_wakeup:
> 
> The first 'bad' exchange.  The following pattern is repeated many times
> in the log file.
> 
> 10:29:54.6440825 l2cap_sock_sendmsg: sock c7177340, sk c72a24a0
> 10:29:54.6441405 l2cap_chan_send: sk c72a24a0 len 506
> 10:29:54.6441935 hci_send_acl: hci0 conn c738c660 flags 0x0
> 10:29:54.6442055 hci_send_acl: hci0 frag c71b6220 len 196
> 10:29:54.6442175 hci_send_acl: hci0 frag c74d92c0 len 196
> 10:29:54.6442295 hci_send_acl: hci0 frag c74d9440 len 130
> 10:29:54.6442415 hci_tx_task: hci0 acl 0 sco 9
> 10:29:54.6442515 hci_sched_acl: hci0
> 10:29:54.6442605 hci_sched_sco: hci0
> 10:29:54.6442695 hci_low_sent: conn 00000000 quote 0

the "hci_num_comp_pkts_evt: hci0 num_hndl 1" is missing here and this
means that the flow is suspended and we can't send HCI commands or data
anymore. You may run into an memory problem if you keep sending and the
hardware never wakes up again, but the question is why the hardware
never wakes up?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
