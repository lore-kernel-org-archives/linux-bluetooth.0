Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076510103.6281.162.camel@kalkyl.roxen.com>
References: <1076265358.2670.36.camel@pegasus>
	 <1076266267.14742.38.camel@akka.yeti.nocrew.org>
	 <1076267396.2670.58.camel@pegasus>
	 <1076275689.14742.93.camel@akka.yeti.nocrew.org>
	 <1076277250.6869.24.camel@pegasus>
	 <1076278554.14742.112.camel@akka.yeti.nocrew.org>
	 <1076279508.6869.54.camel@pegasus>
	 <1076280612.14742.147.camel@akka.yeti.nocrew.org>
	 <1076282343.6869.65.camel@pegasus>
	 <1076284317.14742.179.camel@akka.yeti.nocrew.org>
	 <1076287085.6869.70.camel@pegasus>
	 <1076311376.14742.202.camel@akka.yeti.nocrew.org>
	 <1076321200.6869.75.camel@pegasus>
	 <1076322129.5263.28.camel@kalkyl.roxen.com>
	 <1076323138.6869.93.camel@pegasus>
	 <1076502776.6281.81.camel@kalkyl.roxen.com>
	 <1076506129.2777.83.camel@pegasus>
	 <1076510103.6281.162.camel@kalkyl.roxen.com>
Content-Type: text/plain
Message-Id: <1076519103.2696.58.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 11 Feb 2004 18:05:04 +0100

Hi Fredrik,

> Here are some basic requirements, I think, for a Gnome Bluetooth Configuration
> tool:
> 
>    1. List devices currently attached.
>    2. Get info on devices currently attached (address, name, manufacturer,
>       type etc.)

Agreed.

But I also think that we should make is possible to list and configure
previous attached devices. So they can change settings and attach the
device later.

>    3. Permanently configure device status (up/down).

Agreed. Put "reset" to this list.

Maybe a flag for auto-up on/off per device would be nice.

>    4. Permanently configure device name.
>    5. Permanently configure device discoverability (Iscan? Pscan? Which?)

Agreed.

>    6. Permanently configure pair mode (allow/disallow).

I don't think that we need that. The pairing mode from hcid can go away
and we should use multi every time.

If a specific service like PAN requests a pairing or not is out of scope
for the current interface. These a service specific settings.

>    7. List permanently stored configurations.
>    8. Remove permanently stored configurations.

What do you mean by permanently stored configurations?

>    9. List devices which are paired.
>   10. Remove devices which are paired.

Agreed.

>   11. Request the name for a device address, if available in the name cache.

Agreed.

But we also need a method to set an alias name for a remote device.

>   12. Perform av device scan (this will also update the name cache).

We need something, but I am not sure how to do this. Let's put it at the
bottom of the list.

Don't worry about the name cache. That is a very easy task for hcid.

>   13. Perform a pairing procedure (will update the name cache too).
>   14. Provide a one-time PIN during a pairing procedure.

The pairing procedure should work in background and if a PIN is needed a
PIN helper window should be opened. Maybe you should look at the
bluez-pin program on the internet and the D-Bus extensions for hcid.

The one-time PIN method is what I really want to have. So an application
can provide a previous entered PIN and send it to hcid. The hcid will
use this for the next PIN request (and don't call a PIN helper) and then
forget the PIN.

> (1) and (2) can possibly be solved without DBus, but the rest will require it.

It is possible, but we won't have it. D-Bus for everything ;)

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
