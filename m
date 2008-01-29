Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1201227720.2389.17.camel@cookie.hadess.net>
References: <1201227720.2389.17.camel@cookie.hadess.net>
Date: Tue, 29 Jan 2008 18:01:59 +0100
Message-Id: <1201626119.6218.15.camel@violet>
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

> Some time ago I had problems with client.c's architecture. It would
> allow me to easily report completed discoveries without causing crashes.
> 
> The attached patch moves all the static variables into the main
> BluetoothClient object, and instead of return a new object when using
> _new() we return an existing instance of the client.
> 
> This makes no changes to the external API for the BluetoothClient, and
> should work just as well as older versions did.

patch has been applied. Don't really see the difference, but I am okay
with doing it this way.

> A couple of bugs I found in client.c:
> - launch test-client with a dongle inserted, remove and reinsert the
> dongle, the bdaddr of the device is not set anymore
> - launch test-client without a dongle inserted, insert it, the bdaddr is
> not set and there's no children to the adapter (although there are if
> inserted when started)
> - launch test-client with a dongle inserted, remove it, add another one,
> the set of known devices underneath hasn't changed
> 
> All those problems exist in the old version of client.c, and I intend on
> fixing them, as well as making the search button work as expected in the
> device selection widget.

Send patches when you figured it out :)

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
