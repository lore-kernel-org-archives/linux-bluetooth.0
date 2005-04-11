Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Add sdptool option for browsing with
	L2CAP_UUID
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1598723318.20050407211922@andric.com>
References: <381006269.20050404171656@andric.com>
	 <1112714837.12406.51.camel@notepaq>  <1542380074.20050407140838@andric.com>
	 <1112881490.9047.73.camel@pegasus>  <1598723318.20050407211922@andric.com>
Content-Type: text/plain
Message-Id: <1113236556.9655.60.camel@pegasus>
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
Date: Mon, 11 Apr 2005 18:22:36 +0200

Hi Dimitry,

> > Maybe we should add somekind of short name to UUID translation function,
> > because the numeric values are hard to remember.
> 
> Here's an easy hack: I reused the existing uuid16_names array for
> looking up (partial) matches.  You can also get a list of recognized
> names.  If you think it would be nicer to add a separate name list
> (i.e. made from the names in sdp.h), let me know.

this is really a hack ;)

I think that we need a special table for this, where we add short names
(and I mean short) for some UUIDs. Maybe it is enough to look up the
core protocol names like L2CAP, RFCOMM and OBEX. This would then also
make the --l2cap option obsolete. You can use "--uuid l2cap" for it.

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
