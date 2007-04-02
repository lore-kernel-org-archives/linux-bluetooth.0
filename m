Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4604B9F2.5040808@xmission.com>
References: <45FE8B0B.20500@xmission.com>
	<1174486267.15638.25.camel@aeonflux.holtmann.net>
	<4604B9F2.5040808@xmission.com>
Date: Mon, 02 Apr 2007 17:36:38 +0200
Message-Id: <1175528198.5815.362.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] new sco flowcontrol patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Brad,

> > The biggest thing however is hci_sched_sco(). This function is ugly as
> > hell and basically unreadable. Please use break or continue instead of
> > cascaded if clauses. I am not gonna review this piece of the patch until
> > that is fixed.
> 
> I fixed a few whitespace problems and changed hci_sched_sco so it didn't 
> get deep into nested if's. How does it look now?

please also fix the other coding style issues. Some comments and a lot
of if clauses are violating the whitespace requirements. It is "if ("
and not "if(". It is also "(char *) &val" and not "(char *)&val".

And the code in sco_sock_queue_rcv_skb() is bad. We don't initialize
variables if not really needed. In this case if skb_queue_len() check
fails simply call return -ENOMEM. Strip the label and call return 0 at
the end of the function. Don't make the code more complex than it
actually is.

And no forward declaration of sco_sock_queue_rcv_skb() if not really
needed.

Why are we using SCO_TXBUFS and not reuse SO_SNDBUF since the value is
directly mapped to sk_sndbuf. Same applies to sk_rcvbuf.

And why do we have to do "c->tx_timer.function = hci_sco_tx_timer" over
and over again. Isn't it enough if we set the timer function once after
init of the timer.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
