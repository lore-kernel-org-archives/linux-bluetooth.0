Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Catalin Drula <catalin.drula@imag.fr>
Message-ID: <loom.20050325T100311-440@post.gmane.org>
References: <loom.20050324T175954-608@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Re: Host to Host Controller flow control
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
Date: Fri, 25 Mar 2005 09:11:23 +0000 (UTC)

Catalin Drula <catalin.drula <at> imag.fr> writes:

> I wanted to take a shot at implementing host-to-controller flow control for
> Bluez. Before I start, it'd be great to have your thoughts on this.

Hi Marcel,

I've been looking over the code in hci_core.c and hci_event.c, in particular,
hci_tx_task, hci_sched_acl, hci_sched_sco, hci_low_sent and 
hci_num_comp_pkts_evt.

It seems like we're already doing host to host controller flow control, 
as far as I could tell. At the very least, we're correctly keeping track 
of the number of free slots in the controller's buffers and we're never
overflowing it. Also hci_low_sent always selects the connection with the
most completed packets so there seems to be some balancing done there. 
Could you point out what is missing (the reason this item is on the TODO list)?

Thanks,

Catalin



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
