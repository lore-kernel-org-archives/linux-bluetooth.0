Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HIDP backport for 2.4
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Frey <mfrey@pepper.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <9A44A69C-DF28-11D8-B83A-00039390D626@pepper.com>
References: <1090054739.4558.2.camel@pegasus>
	 <1090759952.4791.91.camel@pegasus>
	 <9A44A69C-DF28-11D8-B83A-00039390D626@pepper.com>
Content-Type: text/plain
Message-Id: <1090864026.29589.1.camel@pegasus>
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
Date: Mon, 26 Jul 2004 19:47:06 +0200

Hi Michael,

> I get the following build errors.  I am using MontaVista Linux 2.4.20
> 
> In file included from core.c:46:
> hidp.h:72: warning: no semicolon at end of struct or union
> hidp.h:72: error: parse error before '*' token

this one is easy. Remove the __user from that line. It is only useful in
a 2.6 kernel.

> core.c: In function `hidp_session':
> core.c:344: error: structure has no member named `nice'

Remove that line and try again. Maybe the MontaVista kernel has a
special backport.

> core.c: In function `hidp_get_connlist':
> core.c:598: error: dereferencing pointer to incomplete type
> core.c:603: error: dereferencing pointer to incomplete type
> core.c:606: error: dereferencing pointer to incomplete type
> core.c:608: error: dereferencing pointer to incomplete type

These are related to error number one.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
