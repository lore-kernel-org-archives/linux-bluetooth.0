Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Fernando Capitulino <lcapitulino@conectiva.com.br>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <42B1DA59.6040608@conectiva.com.br>
References: <42B1DA59.6040608@conectiva.com.br>
Content-Type: text/plain
Message-Id: <1118957041.8980.101.camel@pegasus>
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
Date: Thu, 16 Jun 2005 23:24:01 +0200

Hi Luiz,

> I sent this patch some days ago, but I saw that my e-mail client
> took the bluez-users address. Hopes to not annoy you sending it
> again (to the right place now).
> 
> rfcomm program does not return proper error codes to the environment,
> this makes hard to use it from a shell script or from another program.
> 
> Here goes a patch to fix it. I didn't have much time to test it, so
> any feedback is welcome.
> 
> - Changes functions to return -1 on error and 0 on success
> - Adds missing error checks
> - Adds missing error messages
> - Fixes rfcomm exit() return codes

I don't see the advantages from changing "exit(1)" into "return -1".
This doesn't fix program error codes.

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
