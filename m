Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20050112212555.GA5572@bougret.hpl.hp.com>
References: <20050112183806.GE31615@bougret.hpl.hp.com>
	 <1105561978.7961.140.camel@pegasus>
	 <20050112212555.GA5572@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1105571707.7961.152.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: out of range
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
Date: Thu, 13 Jan 2005 00:15:07 +0100

Hi Jean,

> > I had your patch in my -mh patches for some time, but then it got out of
> > sync with the mainline development and I dropped it. However I want your
> > patch inside the kernel, but I still don't like the way of notification.
> > What do you think about setting sk->sk_err with an error code like we do
> > for the reliable feature that detects ACL packet errors. Even if the HCI
> > events itself are global I like to do the notification through the
> > socket interfaces of L2CAP and RFCOMM. Comments?
> 
> 	I'm afraid I'm not familiar with the sk->sk_err stuff. My
> assumption is that a write/read would return the error. Yep, I think
> that would be much simpler/smoother/straightforward for most
> applications, as most applications don't open HCI sockets.

my neither, but Max introduced it for the L2CAP reliable check that was
needed for the Bluetooth qualification. I think we can also use it for
detecting ACL stalls or the reason why a connection is terminated.

> 	However, I was personally using this feature with BNEP sockets
> (i.e. monitoring PAN), and pand doesn't do any read/write on the L2CAP
> socket once the BNEP connection is established. So, in this case, the
> HCI event makes more sense.

I don't know if select() or poll() also returns the error value from
sk->sk_err, but if then this is maybe a nice way and we can keep the
handling inside the application without the need of root rights for the
special HCI events.

Anyone who volunteers for writing a patch for it?

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
