Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] baswap neccesity
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <cruhvs$fj5$1@sea.gmane.org>
References: <cruhvs$fj5$1@sea.gmane.org>
Content-Type: text/plain
Message-Id: <1105388822.8652.53.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 10 Jan 2005 21:27:02 +0100

Hi,

> I'm reading rctest.c:
> In do_connect function, a call to bswap is used just before the connect 
> call:
> 	baswap(&rem_addr.rc_bdaddr, strtoba(svr));
> 
> In the server, baswap is again called just after the accept call
> 
> Why is it neccesary? Why does the server listening at the other side 
> expect addresses in such byte ordering?

this is part of the specification. The textual representation and the
over-air BD_ADDR is swapped.

However the code above has a memory leak. Where do you found it?

> mmm, again thank you for your time (sometimes I feel like trying to slow 
> down a bit your work would enable me to get up to date, but it's 
> useless, the rate of events is dramatic and you always reemerge... ;-) )

Sorry for that ;)

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
