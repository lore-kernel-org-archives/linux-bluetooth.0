Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hci_request
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050424004443.31751.8@@vodafone.es>
References: <20050424004443.31751.8@@vodafone.es>
Content-Type: text/plain
Message-Id: <1114516247.10706.224.camel@pegasus>
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
Date: Tue, 26 Apr 2005 13:50:47 +0200

Hi Oliver,

do you really think that reposting the same email makes it more likely
that you get an answer. Please read this first:

http://www.catb.org/~esr/faqs/smart-questions.html

> Well I am trying to understand the full blueZ Stack,
> and i stopped in in hci_core.c the function " __hci_request(...) " line 121
> 
> In this portion of code
> 
> #####
> 	DECLARE_WAITQUEUE(wait, current);
> 	int err = 0;
> 
> 	BT_DBG("%s start", hdev->name);
> 
> 	hdev->req_status = HCI_REQ_PEND;
> 
> 	add_wait_queue(&hdev->req_wait_q, &wait);
> 	set_current_state(TASK_INTERRUPTIBLE);
> 
> 	req(hdev, opt);
> 	schedule_timeout(timeout);
> 
> 	remove_wait_queue(&hdev->req_wait_q, &wait);
> 
> 	if (signal_pending(current))
> 		return -EINTR;
> ######
> 
> So:

The book Linux Device Drivers would be a good thing to read first.

> The task who calls the hci_request keeps blocked in add_wait_queue(..) call.
> Which is unblocked by the hci_req_complete() call which is calling when 
> processing an event.

Who said that? This is not blocking.

> After unblocking req() call proceeds and awaits at least the timeout 
> specified schedule_timeout() ... after that the tast is removed form the 
> device queue.

The req() is also not blocking. Only schedule_timeout() is blocking
until hci_req_complete().

> Then what is checking signal_pending(current) call ? 

It checks for pending signals.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
