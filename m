Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
From: Jui-Hao Chiang <windtracekimo@gmail.com>
Date: Fri, 22 Aug 2008 14:03:09 +0000 (UTC)
Message-ID: <loom.20080822T132657-838@post.gmane.org>
References: <loom.20080822T022926-635@post.gmane.org>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Problem automatic flush timeout
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

Hi,
What I found in net/bluetooth/hci_core.c and net/bluetooth/hci_event.c are
(1) the "Flush Occured Event" (ocf 0x11) is not handled in hci_event
(2) while the user socket keeps pushing the data via 
l2cap_sock_sendmsg->l2cap_do_send->hci_send_acl
->hci_sched_tx->hci_tx_task->hci_sched_acl

Eventually it stops in hci_sched_acl when checking hdev->acl_cnt.
I consider that hdev->acl_cnt means: "the number of ACL packet we can push to
hci_usb".

Thus, I think the possible way to handle this event is to
(1) add in "include/net/bluetooth/hci.h"
#define HCI_EV_FLUSH_OCCURED 0x11
(2) catch the event in hci_event_packet, and do the following (same as
hci_num_comp_pkts_evt)
if ((++ hdev->acl_cnt) > hdev->acl_pkts) hdev->acl_cnt = hdev->acl_pkts;
(3) decrement the conn->sent by
atomic_sub(count, &conn->sent);

Please correct me if I am wrong.

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
