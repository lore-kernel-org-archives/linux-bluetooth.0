Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <5.1.0.14.2.20020920105722.07b85a80@mail1.qualcomm.com>
To: bluez-devel@lists.sourceforge.net
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Cc: david LIBAULT <david.libault@inventel.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Subject: [Bluez-devel] PPP IP address from DHCP
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchives/forum.php?forum=bluez-devel>
Date: Fri, 20 Sep 2002 16:01:06 -0700

Hi Folks,

I thought a bit about how to implement IP address assignment in dund and 
want to share some
ideas. We could come up with some ugly hack just like other people did. But 
I think we can
have a better solution.

New ISC DHCP server (http://www.isc.org/products/DHCP/dhcp-v3.html) 
provides so called OMAPI interface. That interface allows external app to 
connect to the running server, client and
relay daemons and modify their's parameters, alter database, etc on the fly.
For example you can create new host or subnet over OMAPI. So 'dund' could 
use OMAPI to request
a new lease from DHCP server.
Unfortunately lease creation over OMAPI is no yet implemented :(. They 
implemented everything but
the lease (darn it). But, OMAPI it's the right way to go if we want robust 
and clean interface to
DHCP.

We should talk to DHCP guys and see what their plans are. I looked at the 
latest CVS version
but did see any omapi/lease related changes. I personally don't have time 
for this stuff
and was hopping that someone on the list could work on it.

Any volunteers ?



Max

http://bluez.sf.net
http://vtun.sf.net



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
