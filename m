Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <064f01c8de1d$9af192c0$6701a8c0@freqonedev>
References: <064f01c8de1d$9af192c0$6701a8c0@freqonedev>
Date: Sat, 05 Jul 2008 19:07:29 +0200
Message-Id: <1215277649.4349.5.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] A thought about Adapter.CreatePairedDevice
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

Hi David,

> Currently CreatePairedDevice requires the remote device address, plus 
> the Object Path of a pairing agent (interface org.bluez.Agent), plus a 
> string listing the pairing capabilities.
> 
> If an agent for the Adapter is already registered, this is redundant at 
> best, and confusing at worst.

no it is not. The CreatePairedDevice is mostly used from the UI part
that setups a Bluetooth device (aka wizard). This wants to re-direct the
PIN/passkey dialogs. So this makes total sense. The default agent from
RegisterAgent takes care of all the other cases. Like remote device
connects to us and wants to pair.

> In my mucking around with my Agent (see my other manifesto...), I tried 
> an experiment to see if it was possible to make a method polymorphic, 
> and I found that DBus has no objections.  It introspects well (although 
> d-feet does not recognizes only the first definition), and when I send a 
> message using dbus-send, dbus routes the incoming message to the version 
> of the Method with a matching signature.  Sweet.
> 
> So, my suggestion is: in adapter.c in setting up the adapter_methods 
> table, add an additional method definition sort of like the following:
> 
> +++++
> /* starting at line 4257 */
> static GDBusMethodTable adapter_methods[] = {
> ...
>  { "CreatePairedDevice", "sos", "o", create_paired_device,
>       G_DBUS_METHOD_FLAG_ASYNC},
>  { "CreatePairedDevice", "s", "o", create_paired_device_noagnt,
>       G_DBUS_METHOD_FLAG_ASYNC},
> ...
> }

While the low-level D-Bus bindings allow this, most high-level bindings
don't and thus we are not doing this.

You can try to give CreatePairedDevice an invalid agent path and then it
should fallback to the default one.

Regards

Marcel



-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
