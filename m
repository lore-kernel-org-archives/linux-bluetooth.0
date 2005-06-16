Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Fernando Capitulino <lcapitulino@conectiva.com.br>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <42B1E63F.204@conectiva.com.br>
References: <42B1DA59.6040608@conectiva.com.br>
	 <1118957041.8980.101.camel@pegasus>  <42B1E63F.204@conectiva.com.br>
Content-Type: text/plain
Message-Id: <1118959732.8980.107.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: [RESEND] - Fixes rfcomm program error codes.
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
Date: Fri, 17 Jun 2005 00:08:52 +0200

Hi Luiz,

> > I don't see the advantages from changing "exit(1)" into "return -1".
> > This doesn't fix program error codes.
> 
>  Sure, but actually, the functions are returning -1, while main()
> checks this return value and does return 'exit(1)' on error. So, this
> patch fixes the error codes.
> 
>  I guess you're speaking about some changes from 'exit(1)' to 'return -1'
> I've made. I did that change, as I changed some 'return -errno' or added
> proper return value to void functions.
> 
>  I saw that most programs (but not all) in the utils package calls exit(1)
> directly in the functions when an error happens. IMHO, making functions
> return -1 (instead of aborting directly) is pretty better because: 1) system
> calls and libc follows that standard; 2) it's easier to copy and paste functions
> in other programs; and 3) your program has only one exit point (in main()).
> 
> But of course, maybe it's not an issue, and if you wants to, I can change it to
> exit in functions directly.

lets keep it using "exit(1)". It is an historic issue. Send a patch for
the few cases we did it wrong.

And btw I support people copying the code, but I also like to see that
people understand what the code does. If they have to change "exit(1)"
to have proper return values in their own code, they at least looked at
the code once.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
