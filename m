Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Juha =?iso-8859-1?B?WXJq9mzk?= <juha.yrjola@iki.fi>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20050120090340.GA9719@salvia.homeip.net>
References: <20050119224400.GA7881@salvia.homeip.net> <1106180379.8190.146.camel@pegasus> <20050120003408.GA8619@salvia.homeip.net> <1106182874.8190.166.camel@pegasus>
Mime-Version: 1.0
In-Reply-To: <1106182874.8190.166.camel@pegasus>
Subject: Re: [Bluez-devel] [PATCH] Fix too-many-keys-pressed error in hidp/core.c
Content-Type: text/plain; charset=us-ascii
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
Date: Thu, 20 Jan 2005 11:03:40 +0200

Hi,

On Thu, Jan 20, 2005 at 02:01:13AM +0100, Marcel Holtmann wrote:

> > 1106180983.027061 > ACL data: handle 0x0029 flags 0x02 dlen 14
> >     L2CAP(d): cid 0x0041 len 10 [psm 0]
> >       A1 01 00 00 14 1A 08 15 00 00 
> > 1106180983.047059 > ACL data: handle 0x0029 flags 0x02 dlen 14
> >     L2CAP(d): cid 0x0041 len 10 [psm 0]
> >       A1 01 00 00 01 01 01 01 01 01 
> > 1106180983.267020 > ACL data: handle 0x0029 flags 0x02 dlen 14
> >     L2CAP(d): cid 0x0041 len 10 [psm 0]
> >       A1 01 00 00 14 1A 08 15 00 00 
> 
> this looks weird and even the 't' is still missing in that dump.

Yes, weird it is.  The 't' is missing because the keyboard is not able to
detect it anymore, because four other keys are being pressed (due to the
design of the keyboard, which allows only certain keys being detected at the
same time).  The keyboard only detects the condition "too many keys pressed",
hence the 0x01 packet.

> Is this a general behaviour? Do we see the same on other keyboard?

I have only the diNovo, and it does this every time.  A brief search through
the ML archives revealed:

http://sourceforge.net/mailarchive/message.php?msg_id=8762071

It seems that at least other Logitech keyboards express similiar behaviour.

I believe my patch is the least intrusive fix for handling the odd packet.

Cheers,
Juha


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
