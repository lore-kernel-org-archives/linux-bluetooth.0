Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Work on L2CAP retransmission and flow control
	support
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1110899091.11567.12.camel@mammoth.research.nokia.com>
References: <1110898225.9818.2.camel@pegasus>
	 <1110899091.11567.12.camel@mammoth.research.nokia.com>
Content-Type: text/plain
Message-Id: <1110902900.9818.8.camel@pegasus>
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
Date: Tue, 15 Mar 2005 17:08:20 +0100

Hi Imre,

> Yes I'm dealing with RFC. It's more or less ready, I'm still doing some
> SMP bugfixing..

that are good news. Let's include it (at least into my -mh patches) and
see if we can wipe them out.

> Could you tell me what are the parts that are affected?

Basically everywhere. I like to get rid of some forward declarations for
some functions. This will result in moving functions inside the code and
in this case most patches won't apply anymore. The other thing is that
the code stills needs some additional whitespace cleanups.

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
