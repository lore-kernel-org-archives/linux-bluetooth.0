Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] H5 3 wire UART connect problem 
In-reply-to: <f16b04cf05070102493b480412@mail.gmail.com> 
References: <f16b04cf050630083549f68fef@mail.gmail.com> <1120157509.15397.152.camel@pegasus> <f16b04cf05070102493b480412@mail.gmail.com>
Message-ID: <15935.1120213339@csr.com>
From: Peter Stephenson <pws@csr.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 01 Jul 2005 11:22:19 +0100

hariharan veerappan wrote:
> As per Silicon wave datasheet the 3 WIRE UART is compatible with BCSP.
> May we have to follow the H4 UART or BCSP one for our development.

Definitely follow the existing BCSP code.  You should find you can
adapt it for 3WU with a minimum of difficulty.  Some of the constants
are different (British humour doesn't always travel well) but otherwise
the core design is very similar.  3WU has some weird additional options,
but you probably don't need those.

-- 
Peter Stephenson <pws@csr.com>                  Software Engineer
CSR PLC, Churchill House, Cambridge Business Park, Cowley Road
Cambridge, CB4 0WZ, UK                          Tel: +44 (0)1223 692070


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

**********************************************************************



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
