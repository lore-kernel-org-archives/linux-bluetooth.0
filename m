Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Various questions
From: Marcel Holtmann <marcel@holtmann.org>
To: Christoph Torens <c.torens@web.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <opsf3esskzeocfdv@debian>
References: <opsf3esskzeocfdv@debian>
Content-Type: text/plain
Message-Id: <1098183563.24465.4.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 19 Oct 2004 12:59:23 +0200

Hi Christoph,

> PAN uses the bnep protocol layer. Is bnep based on rfcomm?
> I think not, because I don't need to load rfcomm.o when using pand.
> But looking at the figure from
> http://www.rvs.uni-bielefeld.de/~heiko/bluetooth/bluetooth.pdf
> (page 6) you can get this idea. (From  
> http://www.holtmann.org/linux/bluetooth/)
> (There are some other sources, too)

this graphic is wrong. The BNEP layer is on top of L2CAP and not on top
of RFCOMM. Take a look at my slides from www.bluez.org/talks.html for a
correct protocol stack overview.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
