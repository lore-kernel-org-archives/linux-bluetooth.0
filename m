Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: George Fankhauser <gfa@sensaco.com>
Message-ID: <loom.20050110T223207-471@post.gmane.org>
References: <loom.20050109T210055-110@post.gmane.org> <1105305890.8637.5.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: Issues with multiple (concurrent) rfcomm connections
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 10 Jan 2005 21:41:17 +0000 (UTC)

Marcel Holtmann <marcel <at> holtmann.org> writes:

> 
> Hi George,
> 
> > I just ran across an issue with setting up multiple rfcomm connections 
from a 
> > linux laptop with kernel 2.4.28-mh1 using an Anycom USB-120 dongle with 
Silicon 
> > Wave chipset.
> > 
> > I just tried to maintain 2 connections to 2 seperate commercial rs232 

[...]

> > 
> > I wonder whether this problem is known, or related to Silicon Wave. Could 
> > anyone try this with a CSR based system?
> 
> try to reproduce it with a 2.6.10-mh1 kernel.
> 

Marcel

you're right, 2.6.10-mh works fine; no problems and reasonably fast 
reconnects after all kinds of reset, power loss, etc. Very well done!

also, it seems to be independent of SiW or CSR chip set... (changed the bt
adapter too...)

Is there a chance to seperate this issue and have it back-ported to 2.4?

best regards
George



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
