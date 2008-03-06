Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1204752334.2640.74.camel@cookie.hadess.net>
References: <1204752334.2640.74.camel@cookie.hadess.net>
Date: Thu, 06 Mar 2008 11:48:38 +0100
Message-Id: <1204800518.13254.1.camel@californication>
Mime-Version: 1.0
Cc: Tim Waugh <twaugh@redhat.com>
Subject: Re: [Bluez-devel] CUPS backend fixes
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

Hi Bastien,

> A few fixes, spotted by Tim Waugh.
> 
> - Use CUPS error codes:
> https://bugzilla.redhat.com/show_bug.cgi?id=435082
> - Output STATE information (we still need to do that when we add retry
> support):
> https://bugzilla.redhat.com/show_bug.cgi?id=435083
> - Use DEVICE_URI envvar if available:
> https://bugzilla.redhat.com/show_bug.cgi?id=435080
> - Also add better error reporting from hcrp_print() and spp_print()

the patch has been applied. However I had to fix up the coding style and
actually fix an issue within the error handling in one of the loops. If
gcc gives you a warning about an uninitialized variable, please don't
ignore it. Most of the times there is something behind it.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
