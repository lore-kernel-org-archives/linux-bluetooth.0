Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Michael Klose <mk@pottklose.de>
Message-ID: <loom.20040929T233953-766@post.gmane.org>
References: <loom.20040926T103741-961@post.gmane.org> <1096359475.4684.31.camel@notepaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: Connect printer via bluetooth printer adaper
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 29 Sep 2004 21:47:32 +0000 (UTC)

Marcel Holtmann <marcel <at> holtmann.org> writes:

> 
> Hi Michael,
> 
> > I use Debian 3.1. The connection between usb bt dongle and bt printer adapter
> > works. (hcitool scan delivers correct address of bt printer adapter, l2ping
> > works alls well).
> > 
> > How do I set up the printer (cups), so that bt connection will be used.
> 
> install the bluez-cups package and then setup a printer with your CUPS
> manager or whatever you use and type in the URI for that. For example to
> use a printer with BD_ADDR aa:bb:cc:dd:ee:ff the URI will be
> bluetooth://aabbccddeeff/

Thank you marcel,

but that I tried. I installed bluez-cup 2.9-4 from testing, and tried to add a
printer using a browser via http://localhost:631.
No Bluetooh protocol is offered. So I choosed "ldp/lpr host or printer" and
enter the URI according to your example.

Client error and protocol not know error followed. When I use the KDE Setup, the
same

/usr/lib/cups/backend/bluetooth exists. printers.conf does not exist but is not
really necessary - as far as I understood the documentation - as long as I type
in the URI directly.
But even if I use your examples of printers.conf (found a newsgroup posting of
you) - the same

So...

Any further idea?

Again Many thanks in advance

Best regards

Michael



> 
> Regards
> 
> Marcel
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> Project Admins to receive an Apple iPod Mini FREE for your judgement on
> who ports your project to Linux PPC the best. Sponsored by IBM.
> Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
> 






-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
