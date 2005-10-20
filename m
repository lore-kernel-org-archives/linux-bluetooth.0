Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Make RemoteName D-BUS method non-blocking
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051020070532.GA20546@localhost.localdomain>
References: <20051019140715.GA15123@localhost.localdomain>
	 <1129762736.2241.18.camel@blade>
	 <20051020070532.GA20546@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1129794748.2241.26.camel@blade>
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
Date: Thu, 20 Oct 2005 09:52:28 +0200

Hi Johan,

> > Even if I repeat myself, but I take this whitespace thing serious and
> > you should tell your editor to visualize tabs and spaces for you.
> 
> I do too. Were there some whitespace problems with my patch? (I couldn't
> find any)

I think your patches were fine. It was Claudio introducing them again
after I cleaned them up.

> > Why don't you set rq.event to EVT_CMD_STATUS?
> 
> Because hci_send_req has a switch statement which handles the
> EVT_CMD_STATUS case separately and would never reach the case where it
> tests for hdr->evt == r->event.

This looks like a bug to me. We should check r->event == EVT_CMD_STATUS
and then exit nicely.

> Attached is a new patch which should apply cleanly to CVS.

Do you think the status parameter is needed? Is it not better to send
two different responses? One for the success case and one for the
failure case.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
