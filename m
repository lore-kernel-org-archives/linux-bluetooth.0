Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: John McCorquodale <mcq@cacr.caltech.edu>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20040716051048.GA31365@viz.cacr.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] BCSP initialization timed out
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
Date: Thu, 15 Jul 2004 22:10:48 -0700

I know this is a FAQ, but I'm a heartless, uncaring Microsoft-loving newbie
treehugging republican commie meat-eating gun-toting american imperialist
frustrated by the crappy broken list search operation which doesn't even
find the last time I asked the question, so I'm asking it again.  I'm just 
trying to get the facts and status straight before harassing Other People
to try to figure this thing out.

FAQ: "BCSP initialization timed out" with 2.6 serial_cs

As I understand it, the bluez opinion on this problem is "something changed
with the serial driver from 2.4 to 2.6, and it's broken now and the problem
isn't our fault so we're not going to think about it"

I anticipate, if I try to go to kernel types and say this, that their response
will be something to the effet of "every other serial device works fine in
2.6, bluez is broken and the problem isn't our fault so we're not going to
think about it"

In an attempt to avoid this impasse, could those of y'all who know this
hardware pause for a moment and try to imagine what might be weird about 
the Uarts in question, and maybe offer some constructive shots in the dark
about what might make a Socket Communications bluetooth CF card different
than a normal 16550?

A quick run of od -x shows that the device really does deliver different
data in 2.4 and 2.6 -- the 2.6 version never sends the 0xc0 that hciattach
seems to be waiting for, so there really is something different going on
but I'm trying to avoid a complete shot in the dark and wholesale reading
of the whole serial implementations in both kernel verions, which is
tantamount in time and complexity to just rewriting the thing anyway.

Alternatively, if somebody could just recommend a CF card that works in
2.6, I'll pitch this one in the trash and get on with life.

-mcq


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
