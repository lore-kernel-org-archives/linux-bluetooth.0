Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PF_BLUETOOTH AF_BLUETOOTH redefinitions
From: Marcel Holtmann <marcel@holtmann.org>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Achim Bohnet <ach@mpe.mpg.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1074794987.1707.214.camel@localhost>
References: <200401221347.32481.ach@mpe.mpg.de>
	 <1074776673.3071.4.camel@pegasus>  <200401221434.10203.ach@mpe.mpg.de>
	 <1074794987.1707.214.camel@localhost>
Content-Type: text/plain
Message-Id: <1074811114.3071.47.camel@pegasus>
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
Date: Thu, 22 Jan 2004 23:38:34 +0100

Hi Max,

> Actually sys/socket.h didn't have PF_\AF_ BLUETOOTH defined up till now
> I guess. Mine for example (latest Fedora 1) still doesn't. Looks like
> GLIBC folks pulled Bluetooth related things into standard headers. Which
> is cool. We'll just have to #ifdef defines that may clash.

first, the file for this definitions is bits/socket.h which is included
by sys/socket.h of course. I checked my GLIBC from Debian Sid (Unstable)
which is libc6-2.3.2.ds1-11 and indeed it contains the PF_/AF_BLUETOOTH
defines. Now that the GLIBC folks included these defines, you must
include sys/socket.h before you include bluetooth/bluetooth.h. Otherwise
the compiler will complain with redefines.

I checked some more of the socket related include files and it seems
that it ok to include sys/socket.h from other include files. For example
netinet/in.h. Actually I don't like the idea to include too much files
from another header file. What do you think?

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
