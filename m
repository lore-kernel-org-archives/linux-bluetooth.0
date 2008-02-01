Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1201867867.2389.318.camel@cookie.hadess.net>
References: <1201227720.2389.17.camel@cookie.hadess.net>
	<1201626119.6218.15.camel@violet>
	<1201714289.2389.227.camel@cookie.hadess.net>
	<1201791472.2389.275.camel@cookie.hadess.net>
	<1201801687.2389.286.camel@cookie.hadess.net>
	<1201862766.2389.302.camel@cookie.hadess.net>
	<1201867867.2389.318.camel@cookie.hadess.net>
Date: Fri, 01 Feb 2008 13:23:56 +0100
Message-Id: <1201868636.6218.189.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] client.c cleanup
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

> > > About the hcid bug, should GetInfo fail when the bdaddr for the device
> > > isn't available, or should it just give out empty information?
> > 
> > Patch to allow GetAddress to fail, and don't add the information that's
> > not available to the GetInfo dict.
> 
> Updated patch.
> 
> This one allows GetInfo and GetAddress to fail if there's no valid
> bdaddr, and fixes the discussed coding style issues.

patch has been committed. Thanks.

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
