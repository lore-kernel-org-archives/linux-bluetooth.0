Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Oliver <urnen@vodafone.es>
Message-Id: <20050424004443.31751.8@@vodafone.es>
Mime-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain;
 charset="iso-8859-15"
Subject: [Bluez-devel] hci_request
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
Date: Sun, 24 Apr 2005 00:44:43 +0200

Hi all in list

Well I am trying to understand the full blueZ Stack,
and i stopped in in hci_core.c the function " __hci_request(...) " line 121

In this portion of code

#####
	DECLARE_WAITQUEUE(wait, current);
	int err = 0;

	BT_DBG("%s start", hdev->name);

	hdev->req_status = HCI_REQ_PEND;

	add_wait_queue(&hdev->req_wait_q, &wait);
	set_current_state(TASK_INTERRUPTIBLE);

	req(hdev, opt);
	schedule_timeout(timeout);

	remove_wait_queue(&hdev->req_wait_q, &wait);

	if (signal_pending(current))
		return -EINTR;
######

So:

The task who calls the hci_request keeps blocked in add_wait_queue(..) call.
Which is unblocked by the hci_req_complete() call which is calling when 
processing an event.

After unblocking req() call proceeds and awaits at least the timeout 
specified schedule_timeout() ... after that the tast is removed form the 
device queue.

Is my mind as mixed as i think? am i right? did i understand it well?

Then what is checking signal_pending(current) call ? 

Thanks in advance, and begging for corrections

Oliver




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
