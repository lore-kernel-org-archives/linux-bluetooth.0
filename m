Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Device specific pins
From: Marcel Holtmann <marcel@holtmann.org>
To: Eugene Crosser <crosser@average.org>
Cc: Dave Henriksen <dhenriksen@optibrand.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075187139.9727.29.camel@pccross.average.org>
References: <1075153448.2906.2.camel@linux.local>
	 <1075151423.25442.135.camel@pegasus>
	 <1075187139.9727.29.camel@pccross.average.org>
Content-Type: text/plain
Message-Id: <1075212653.12766.13.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 27 Jan 2004 15:10:53 +0100

Hi Eugene,

> Do you think it might be right to leave "low level" PIN management as it
> is now, via an executable helper?  It is very much the same way as
> kernel "hotplug" works.  So it can stay the same even if hcid eventually
> becomes a kernel thread.
> 
> The "real" PIN management, with the database, GUI prompt boxes etc.
> could be isolated from the BT stack, helper executable being the only
> interface.
> 
> E.g., a Gnome or KDE applet could listen on a unix domain socket.  The
> helper, when invoked, would try to talk over this socket, and if the
> latter is not present or nobody listens on it, default to preexisting
> database.  This way, both fancy GUI dialogues and unattended operation
> could be implemented rather easily.
> 
> Sorry if I say stupid or trivial things, I did not really try to learn
> how these things are currently done in Blues..

the answer for all this stuff will be D-BUS.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
