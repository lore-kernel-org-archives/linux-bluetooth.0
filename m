Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] syntax for advertising a service with specific
	uuid
From: Marcel Holtmann <marcel@holtmann.org>
To: Nikita Tovstoles <Nikita.Tovstoles@Sun.COM>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <409032AC.4020906@sun.com>
References: <40902623.8060509@sun.com> <1083190769.4000.90.camel@pegasus>
	 <409032AC.4020906@sun.com>
Content-Type: text/plain
Message-Id: <1083192495.4000.100.camel@pegasus>
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
Date: Thu, 29 Apr 2004 00:48:15 +0200

Hi Nikita,

> >I prefer you read the manpage of sdptool. The get command needs the
> >record handle of the previous created record.
> >  
> >
> "man sdptool" returns nothing. the only thing i can look at is "sdptool 
> --help". if that's not what you were referring to, where is sdptool's 
> manpage?
> 
> %sdptool add --help
>  add [--channel] service

come on, check you MANPATH or look at the CVS

http://cvs.sourceforge.net/viewcvs.py/bluez/utils/tools/sdptool.1?view=markup

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
