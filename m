Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] dtl1_cs suspend bug
From: Marcel Holtmann <marcel@holtmann.org>
To: Justin Karneges <justin-qt@affinix.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200309232306.30064.justin-qt@affinix.com>
References: <200309220408.04569.justin-qt@affinix.com>
	<200309231648.12696.justin-qt@affinix.com>
	<1064367347.1620.67.camel@pegasus>
	<200309232306.30064.justin-qt@affinix.com>
Content-Type: text/plain
Message-Id: <1064396202.1619.116.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 24 Sep 2003 11:36:36 +0200

Hi Justin,

> So Affix goes through some sort of serial library, while Bluez writes to the 
> UART directly?  I noticed calls like outb() in bluez, but no such calls in 
> Affix, which probably explains some things..

at the time I have looked at the code it was even worse. But in general
they like to represent the UART as a serial interface ttyS16 or so and
use a ldisc for the Nokia transport protocol.

> > The register/unregister should also work with BlueZ, but you must make
> > sure that the UART is in the correct state, as I said previous.
> 
> Right.  I tried Affix tonight, and it does not properly function after a 
> 'cardctl reset' either.  However, it can be solved by typing 'btctl down ; 
> btctl up'.  This looks more like a bug in their hci side of things.  In any 
> case, the UART gets reset to the correct state somehow and the driver works.
> 
> Now how to figure out what they are doing so we can have this in Bluez (minus 
> the hci bug of course :)).

Maybe you should ask Socket for the specs of the Nokia card. Last time
they send me a NDA which I can't accept. Now they have the Rev. G card
on the market and these old cards are not built anymore. Maybe they make
the specs public if someone asks. Put me on CC if you write to them.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
