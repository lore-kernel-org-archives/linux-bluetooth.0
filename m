Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040805013335.GA13608@bougret.hpl.hp.com>
References: <20040805013335.GA13608@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1091976547.2773.29.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: [PATCH 2.6] link trigger for AODV and +
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
Date: Sun, 08 Aug 2004 16:49:08 +0200

Hi Jean,

> 	This is a patch I wrote a couple of months back, and I would
> like to submit it for inclusion in the BlueZ stack. The reason I think
> we should include that is that the patch has minimal footprint and
> offer a feature unavailable by other means...
> 
> 	The idea is that this patch add an event that is trigger when
> a connection is likely to fail, but before the connection get
> disconnected. This is similar to the TxDrop iwevent implemented for
> 802.11 (in Wireless Extensions).
> 	In many cases, you don't want to use LinkSupervisionTimeout,
> because it disconnect the connection before you have time to take
> corrective action (i.e. game over).
> 	The main use is for Ad-Hoc routing protocol (mesh) such as
> AODV. In the litterature, this is called a "link trigger". I can give
> you real world example of people using the TxDrop iwevent in AODV
> implementations.
> 	Another example would be to use this event to generate a
> warning to the user that his connection is about to drop. Because
> LinkSupervisionTimeout is so large, most users would be able to use
> this warning to get back into range or away from the interferer
> without loosing the connection.
> 	I could go at lenght on why this is useful and why this is the
> way to implement it, but I don't want to waste your time.

no problem, I got the point. However I am not sure about applying your
patch. I don't like the way the event is propagated. It is a connection
related event and so I like to send it to the sockets that are using
that ACL connection. Or at least I should introduce the per device stack
internal events.

Another question is, do we need a compile option for it? Is there any
disadvantage to compile it always and disable by default?

> 	Patch has been tested in kernel from 2.6.1 to 2.6.8. I also
> have a patch for 2.4.X. Please apply...

I would include it into my next -mh patch for testing, but the 2.4
series should be closed for new features.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
