Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] keys under 2.6.5 and bthid
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200404200044.02565.cijoml@volny.cz>
References: <200404200032.51458.cijoml@volny.cz>
	 <1082414314.4403.84.camel@pegasus>  <200404200044.02565.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1082415057.4403.87.camel@pegasus>
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
Date: Tue, 20 Apr 2004 00:50:58 +0200

Hi Michal,

> > as the error says, this is a XFree86 bug and not a kernel bug ;)
> 
> Hmmm but I don't understand, why this doesn't happens under 2.4?

in 2.6 the input subsystem is fully integrated and it now handles more
than USB mice and keyboards. Even hardware components like PS/2 must go
through the input subsystem to deliver their events.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
