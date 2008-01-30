Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1201626119.6218.15.camel@violet>
References: <1201227720.2389.17.camel@cookie.hadess.net>
	<1201626119.6218.15.camel@violet>
Date: Wed, 30 Jan 2008 17:31:29 +0000
Message-Id: <1201714289.2389.227.camel@cookie.hadess.net>
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


On Tue, 2008-01-29 at 18:01 +0100, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > Some time ago I had problems with client.c's architecture. It would
> > allow me to easily report completed discoveries without causing crashes.
> > 
> > The attached patch moves all the static variables into the main
> > BluetoothClient object, and instead of return a new object when using
> > _new() we return an existing instance of the client.
> > 
> > This makes no changes to the external API for the BluetoothClient, and
> > should work just as well as older versions did.
> 
> patch has been applied. Don't really see the difference, but I am okay
> with doing it this way.
> 
> > A couple of bugs I found in client.c:
> > - launch test-client with a dongle inserted, remove and reinsert the
> > dongle, the bdaddr of the device is not set anymore
> > - launch test-client without a dongle inserted, insert it, the bdaddr is
> > not set and there's no children to the adapter (although there are if
> > inserted when started)

Both of those are a race:
When the AdapterAdded signal is launched in hcid, the address isn't
available yet. It is available when "ModeChanged" has been launched
though.

hcid_dbus_register_device() setups the structures, and launched
AdapterAdded, but the address is only set when hcid_dbus_start_device()
is called (and the ModeChanged signal is launched).

How do you think we should be handling that? I would think we should
make GetAddress fail if the data isn't available yet, or hack around it
in client.c and only setup the adapters when the mode changes.

Cheers


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
