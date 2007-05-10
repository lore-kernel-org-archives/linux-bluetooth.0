Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200705100719.36399.akohlsmith-bluez@benshaw.com>
References: <4641DA61.8040709@tao-group.com>
	<1178780976.25565.6.camel@aeonflux.holtmann.net>
	<1178784111.10803.27.camel@localhost.localdomain>
	<200705100719.36399.akohlsmith-bluez@benshaw.com>
Date: Thu, 10 May 2007 14:57:57 +0200
Message-Id: <1178801877.25565.114.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] API documentation?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Andrew,

> > all. Most probably, the footprint is too large for memory-restricted
> > systems. Because of that and the fact there are very few (if any)
> > projects for embedded systems that use d-bus it's hardly worth the
> > effort to port it. Bluez has worked quite well for embedded systems with
> > older versions, but since it ignores the demands of embedded systems
> > it's probably better to use a different bluetooth stack.
> 
> This would be my response as well.  Marcel has purposely made it difficult to 
> locate older versions of BlueZ in the (IMO) misguided attempt to force 
> everyone to test and use the new stuff.  I can see WHY he's chosen to use 
> d-bus, but yes; it's seems to be unsuitable for light embedded systems and 
> you're probably better off with another stack.  There aren't many uses for a 
> message bus in small embedded systems.

D-Bus is the solution for a generic IPC between applications or daemons
and the size of the system doesn't matter. I never said that D-Bus is
perfect, but it is time that all the embedded people that complain about
D-Bus actually start fixing it. Believe it or not, D-Bus is the way to
go for shrinking the memory footprint in your embedded systems, because
all applications will use the same IPC.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
