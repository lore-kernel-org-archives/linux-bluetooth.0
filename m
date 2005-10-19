Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Make RemoteName D-BUS method non-blocking
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051019140715.GA15123@localhost.localdomain>
References: <20051019140715.GA15123@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1129762736.2241.18.camel@blade>
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
Date: Thu, 20 Oct 2005 00:58:56 +0200

Hi Johan,

> Here's a patch which does a similar change RemoteName as my previous
> patch did to Inquiry. For the user to be able to know if the name
> request fails because of e.g. page timeout I have added a status
> paramer to the signal and forced the signal to be always sent (not just
> when evt->status == 0).

I like to have this patch in, but it didn't apply cleanly. This might be
my fault, because I did some coding style cleanups while I was without
Internet and committed them today.

Even if I repeat myself, but I take this whitespace thing serious and
you should tell your editor to visualize tabs and spaces for you. This
will make developing a lot easier.

> There is one problem when using hci_send_req with the inquiry and remote
> name HCI commands: they don't generate a command complete event, only a
> command status event. This means that hci_send_req will fail with
> ETIMEDOUT (I didn't notice it earlier since the UI status is immediately
> updated by the InquiryStarted signal). Using hci_send_cmd is also not
> (IMHO) an option since a failure status in the command status event
> should be detected and handled properly.

Why don't you set rq.event to EVT_CMD_STATUS?

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
