Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SDP service example
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Mischke <survivor@uni-paderborn.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <40F70E09.7010300@uni-paderborn.de>
References: <40F70E09.7010300@uni-paderborn.de>
Content-Type: text/plain
Message-Id: <1089959906.4517.55.camel@pegasus>
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
Date: Fri, 16 Jul 2004 08:38:26 +0200

Hi Stefan,

> I'm looking for a small example to show me how to write my own SDP 
> service? Particularly, I'd like to know where exactly the service 
> functions of my new service are bound to SDP. I looked into the souce 
> code, but I couldn't find it. I almost suppose SDP just provides the 
> L2CAP channel id where the new service is listening or how does it work? 
> Sorry, I'm not so much into this Linux developer thing and I have not 
> yet found any good documentation. I'm also looking for docs how this 
> Linux/Unix socket interface stuff works (preferably in German ;-). Yes, 
> I checked the manpages, but they are not quite explanatory.

look at the source code of pand, dund or sdptool.

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
