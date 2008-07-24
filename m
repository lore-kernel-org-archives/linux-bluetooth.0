Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
From: Jui-Hao Chiang <windtracekimo@gmail.com>
Date: Thu, 24 Jul 2008 18:46:00 +0000 (UTC)
Message-ID: <loom.20080724T182719-946@post.gmane.org>
References: <loom.20080724T175951-14@post.gmane.org>
	<50b40ba70807241118y79325efene53bde2612e8c783@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] About socket interface
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Nick Pelly <npelly <at> gmail.com> writes:

> 
> The HCI event that triggers this is the Connection Request Event 0x04,
probably handled in hci_event.c


Thanks for the response. But I haven't seen any code inside hci_event_packet to
notify the user socket. (Maybe I am blind..)
In scotest program, there is a debug message below accept(), so that I know when
it is returned from the accept() call. 
>>From my tracing, I thought the user accept() will eventually wait inside
sco_sock_accept(), which keeps itself in the wait queue. And I guess the
function return of sco_sock_accept will eventually executing the next line of
accept() in user program (printing the message). But the accept() returns
earlier than the sco_sock_accept() as the following message.

hci_event_packet: hci0 evt 0x4 <== the SCO connection request comes !!!!
hci_conn_request_evt: hci0 Connection request: EE:E9:63:67:11:00 type 0x0
sco_connect_ind: hdev hci0, bdaddr EE:E9:63:67:11:00
hci_conn_add: hci0 dst EE:E9:63:67:11:00
hci_usb_notify: hci0 evt 1
hci_conn_add_sysfs: conn d45db800
.... (omit..)
hci_event_packet: hci0 evt 0x1b
__recv_frame: hci0 type 4 data dfa75670 count 6
__recv_frame: new packet len 6
hci_rx_task: hci0
hci_event_packet: hci0 evt 0xf
hci_cs_link_ctl: hci0 ocf 0x9
hci_cs_link_ctl: hci0 Command status: ogf LINK_CTL ocf 9 status 0
scotest[5844]: Connect from 00:11:67:63:E9:EE [handle 2, class 0x080104]
<=== user accept() Has returned !!!!
scotest[5844]: Receiving ...
.... (omit..)
bt_accept_unlink: sk f53e1800 state 1
sco_sock_accept: new socket f53e1800 <== sco_sock_accept() will return !!!!

Jui-Hao


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
