Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hidd weirdness under 2.4.20
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <D041B252-43B9-11D9-9BD7-00039390D626@pepper.com>
References: <D041B252-43B9-11D9-9BD7-00039390D626@pepper.com>
Content-Type: text/plain
Message-Id: <1101929973.15615.32.camel@pegasus>
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
Date: Wed, 01 Dec 2004 20:39:33 +0100

Hi Michael,

> I am currently running with great success the hidd patch for 2.4.20 
> from Marcel.  However when using a bluetooth mouse and keyboard, I get 
> the following message from the kernel.
> 
> keyboard.c: can't emulate rawmode for keycode 272
> keyboard.c: can't emulate rawmode for keycode 272
> keyboard.c: can't emulate rawmode for keycode 272
> keyboard.c: can't emulate rawmode for keycode 272
> 
> This seems to happen quite often, and sometimes I get extra characters 
> typed into my system randomly.
> 
> Has anyone else seen this?  What could be causing this?

this is keycode out of the PS/2 range. What device are you using?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
