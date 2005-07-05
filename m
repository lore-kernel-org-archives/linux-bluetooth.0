Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: ville.tervo@nokia.com
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1120549277.30194.55.camel@localhost.localdomain>
References: <1120490370.30194.50.camel@localhost.localdomain>
	 <1120490944.10273.164.camel@pegasus>
	 <1120549277.30194.55.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1120551291.10273.204.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: rfcomm oops
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
Date: Tue, 05 Jul 2005 10:14:51 +0200

Hi Ville,

> > > I found reproducible way to make rfcomm layer oops. I attached oops and
> > > some notes how they were produced. I used several Nokia phones and IBM
> > > T40 laptop in these tests.
> > 
> > if the attached patch makes it go away, then I know what it is. Actually
> > I introduced that problem when I tried to fix another bug with buggy
> > phones that can't disconnect their DLCI 0 even if they established it.
> 
> Look like this patch helps. I tested with i386 and arm.

this is what I expected. It is one step back, but it is better then
getting an oops every time.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
