Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hci_create_connection assuming timeout too soon
From: Marcel Holtmann <marcel@holtmann.org>
To: Steven Singer <steven.singer@csr.com>
Cc: Andreas Gaufer <andreas.gaufer@blue-cell-networks.com>,
   Bluez Devel <bluez-devel@lists.sourceforge.net>
In-Reply-To: <40CDA70D.7010008@csr.com>
References: <20040609154824.531c71b8.Andreas.Gaufer@blue-cell-networks.com>
	 <1087033515.4306.0.camel@pegasus>  <40CDA70D.7010008@csr.com>
Content-Type: text/plain
Message-Id: <1087230215.13792.38.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 14 Jun 2004 18:23:35 +0200

Hi Steven,

> There are two potentially large delays, you've identified just one - the
> page timeout. By default this is just over 5 seconds, but it could be
> raised as high as 41 seconds.
> 
> The page timeout, however, is applied only over the initial baseband
> connection. Before the connection complete event can be reported to the
> host, the LMP negotiation also has to take place. This can include
> authentication and pairing. In theory, the whole LMP negotiation should
> be bounded by a 30 second timeout, but, in practice I suspect it's better
> to err on the cautious side.
> 
> Normally, this isn't a problem as you just wait for the connection
> complete event and it'll give a success or failure code. However, I
> understand that you want to detect non-responsive host controllers.

the kernel uses a connect timeout of 40 seconds. This was working fine
in the past.

> > your change is me too much at the moment. I simply changed the timeout
> > to 25000 for the hcitool cc command.
> 
> If you want just a rough figure that'll probably work, I'd suggest
> assuming that the page timeout is about 10 seconds and allow the full
> 30 seconds LMP timeout. That'd give a 40 second timeout.
> 
> If you wanted to be sure, then somwhere above 71 seconds is better, but
> to be really, really sure I suspect 2 minutes is better still.
> 
> If this is too long, then I suggest a shorter timeout on the command
> status event. This event should always be reported promptly. You
> could get away with a one second timeout on that followed by a two
> minute timeout on the connection complete event.

I fully agree with you, but the "hcitool cc ..." is more for debugging
as for daily use. If people rely on it I can't help them, because in
general a ACL link should only be created by the kernel and not from
userspace. And this means the L2CAP layer would cause the Bluetooth core
to create the ACL link.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
