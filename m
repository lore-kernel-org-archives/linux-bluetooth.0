Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Add sdptool option for browsing with
	L2CAP_UUID
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <381006269.20050404171656@andric.com>
References: <381006269.20050404171656@andric.com>
Content-Type: text/plain
Message-Id: <1112714837.12406.51.camel@notepaq>
Mime-Version: 1.0
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
Date: Tue, 05 Apr 2005 17:27:17 +0200

Hi Dimitry,

> Some phones (e.g. Samsung D500, Motorola MPx220, and possibly some
> other Windows Mobile models) don't return any services if you ask them
> for the public browse group.  You notice this, when "sdptool browse
> xx:xx:xx:xx:xx:xx" returns immediately, without any output.
> 
> It turns out that the Windows XP Bluetooth browser asks for
> L2CAP_UUID, which *does* work for all the phones I've tested.
> 
> So I've made this simple patch, that adds a `-l' or `--l2cap' command
> line option to sdptool, to use the L2CAP_UUID for browsing, instead of
> PUBLIC_BROWSE_GROUP.

the patch is applied to the CVS. Maybe we should add another one to
browse any UUID in general. Something like "--uuid 0x0003" for example.

A small nitpick about the coding style. The braces around context.group
are not needed and normally we don't use them.

	sdp_uuid16_create(&(context.group), L2CAP_UUID);

I also realized that you only followed the example above that creates
the public browse group context (which I fixed now). So please keep that
in mind the next time.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
