Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PF_BLUETOOTH AF_BLUETOOTH redefinitions
From: Max Krasnyansky <maxk@qualcomm.com>
To: Achim Bohnet <ach@mpe.mpg.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200401221434.10203.ach@mpe.mpg.de>
References: <200401221347.32481.ach@mpe.mpg.de>
	 <1074776673.3071.4.camel@pegasus>  <200401221434.10203.ach@mpe.mpg.de>
Content-Type: text/plain
Message-Id: <1074794987.1707.214.camel@localhost>
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
Date: Thu, 22 Jan 2004 10:09:48 -0800

On Thu, 2004-01-22 at 05:34, Achim Bohnet wrote:
> > > hci.h may be due to old g++2.94.4 used on debian.  No idea about a workaround :(
> > 
> > include "sys/socket.h" before you include "bluetooth/bluetooth.h".
> 
> Hi Marcel,
> 
> That one solution, but why isn't it done by bluetooth.h itself?  Makes it header order
> independent, and fixes _once and forever_ annoying warnings like that.
> (that was my last try to convience you, promised ;)
Actually sys/socket.h didn't have PF_\AF_ BLUETOOTH defined up till now
I guess. Mine for example (latest Fedora 1) still doesn't. Looks like
GLIBC folks pulled Bluetooth related things into standard headers. Which
is cool. We'll just have to #ifdef defines that may clash.

> What about condition[0] etc in hci.h.  Should this be contition[] etc?
> 
> ach@allee(0) ~ $ fgrep '[0]' /usr/include/bluetooth/hci.h
>         uint8_t         condition[0];
>         uint8_t         data[0];
>         struct hci_dev_req dev_req[0];  /* hci_dev_req structures */
>         struct hci_conn_info conn_info[0];
>         struct hci_conn_info conn_info[0];

No those should be [0] no []. I'm not sure why your GCC does not like
them.

Max



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
