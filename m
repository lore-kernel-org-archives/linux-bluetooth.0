Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@nokia.com>
In-Reply-To: <20070918081557.GA13401@localhost>
References: <46EEBC41.80401@silicom.fr>  <20070918081557.GA13401@localhost>
Date: Tue, 18 Sep 2007 10:27:07 +0200
Message-Id: <1190104027.5525.128.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>,
        Fabien Chevalier <fchevalier@silicom.fr>
Subject: Re: [Bluez-devel] [PATCH] Fix bogus avdtp error codes management
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Johan,

> > While trying to fix this cross case issue, i came with an issue with the 
> > way error codes are handled
> > in avdtp.c.
> > The issue is basically that the part of the code that retrieves the 
> > exact error value is never executed
> > due to premature return.
> 
> Looks fine to me if it works. However, I'd like to hear some comment
> from Marcel as well. At least my connect(2) manpage implies that a
> non-blocking connect should always produce a POLLOUT on connection
> completion regardless if the result was failure or success. So it seems
> bluez may be behaving differently than other socket types in this
> respect.

if that is so, then we have to fix the kernel. Can someone write me a
simple reproducer or better send me a patch for the kernel.

Regards

Marcel




-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
