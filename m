Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: James Cameron <james.cameron@hp.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] setting inquiry and inquiry_scan parameters
Message-ID: <20041209225645.GB27468@hp.com>
References: <5f30e26104120912237f20ea80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5f30e26104120912237f20ea80@mail.gmail.com>
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
Date: Fri, 10 Dec 2004 09:56:45 +1100

On Thu, Dec 09, 2004 at 02:23:33PM -0600, Jeff Wilson wrote:
> I realize this post is over 9 months old, but I'm trying to write an
> application that does these very kinds of things.  Can someone tell me
> more about the specifics of how to tweak these numbers?  I'm guessing
> it's related to HCI ... ?

It's in the man page for hciconfig, the inqparams keyword.  It took me a
while to figure out experimentally what paging and inquiry were; they
weren't explained in the man page.  But I ended up with my application
modifying the inquiry responsiveness in expectation of a connection.  My
application was two Debian add-on packages for setting up a poor-mans
wireless IP using two dongles.

http://quozl.linux.org.au/bluetooth/

e.g. my quozl-bluez-server package increases the paging and inquiry rate
in anticipation of a connection, in a per-package hotplug.sh script;

	hciconfig hci0 pageparams 18:512
	hciconfig hci0 inqparams 18:512

then once the connection arrives, the dev-up.sh script returns the
parameters to what I once found they were;

	hciconfig hci0 pageparams 18:2048
	hciconfig hci0 inqparams 18:2048

I've no idea what the side effects may be, but it made it more
responsive.

No doubt an application can do what hciconfig does if it needs to.
Check the source.

-- 
James Cameron                         http://quozl.netrek.org/
HP Open Source, Volunteer             http://opensource.hp.com/
PPTP Client Project, Release Engineer http://pptpclient.sourceforge.net/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
