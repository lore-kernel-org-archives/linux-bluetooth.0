Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Fix too-many-keys-pressed error in
	hidp/core.c
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20050120090340.GA9719@salvia.homeip.net>
References: <20050119224400.GA7881@salvia.homeip.net>
	 <1106180379.8190.146.camel@pegasus>
	 <20050120003408.GA8619@salvia.homeip.net>
	 <1106182874.8190.166.camel@pegasus>
	 <20050120090340.GA9719@salvia.homeip.net>
Content-Type: text/plain
Message-Id: <1106470008.8112.9.camel@pegasus>
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
Date: Sun, 23 Jan 2005 09:46:48 +0100

Hi Juha,

> > > 1106180983.027061 > ACL data: handle 0x0029 flags 0x02 dlen 14
> > >     L2CAP(d): cid 0x0041 len 10 [psm 0]
> > >       A1 01 00 00 14 1A 08 15 00 00 
> > > 1106180983.047059 > ACL data: handle 0x0029 flags 0x02 dlen 14
> > >     L2CAP(d): cid 0x0041 len 10 [psm 0]
> > >       A1 01 00 00 01 01 01 01 01 01 
> > > 1106180983.267020 > ACL data: handle 0x0029 flags 0x02 dlen 14
> > >     L2CAP(d): cid 0x0041 len 10 [psm 0]
> > >       A1 01 00 00 14 1A 08 15 00 00 
> > 
> > this looks weird and even the 't' is still missing in that dump.
> 
> Yes, weird it is.  The 't' is missing because the keyboard is not able to
> detect it anymore, because four other keys are being pressed (due to the
> design of the keyboard, which allows only certain keys being detected at the
> same time).  The keyboard only detects the condition "too many keys pressed",
> hence the 0x01 packet.
> 
> > Is this a general behaviour? Do we see the same on other keyboard?
> 
> I have only the diNovo, and it does this every time.  A brief search through
> the ML archives revealed:
> 
> http://sourceforge.net/mailarchive/message.php?msg_id=8762071
> 
> It seems that at least other Logitech keyboards express similiar behaviour.

I tested it with my Microsoft and Apple keyboards. It seems that both of
them take 5 keys before they result in too many keys are pressed, but
this event still occurs.

Since Apple uses the Broadcom chip and Logitech/Microsoft uses CSR this
seems not to be unique to the Bluetooth software on the keyboard. So it
must be inside the specification or all of these keyboards simple share
the same keyboard chip. Has anyone some detailed information for me
about this?

> I believe my patch is the least intrusive fix for handling the odd packet.

I think we should add a patch for this, but I don't like the way you did
it. Checking for the end value of a for-loop is not a good programming
practice. Using memcmp() here should be a lot better and cleaner.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
