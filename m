Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076519103.2696.58.camel@pegasus>
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
	 <1076519103.2696.58.camel@pegasus>
Content-Type: text/plain
Message-Id: <1076538332.31726.29.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Wed, 11 Feb 2004 23:25:32 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

On Wed, 2004-02-11 at 18:05, Marcel Holtmann wrote:
> But I also think that we should make is possible to list and configure
> previous attached devices. So they can change settings and attach the
> device later.

Agreed. This is the intention of (4) - (10), see below.

> >    3. Permanently configure device status (up/down).
> Agreed. Put "reset" to this list.

Uhu? Permanent reset? ;)

> Maybe a flag for auto-up on/off per device would be nice.

What do you mean?

The intention was that when a device is permanently configured "down",
it will be kept down regardless of reboots etc. It will only go up after
using the other option, configuring it permanently "up". Then it will be
kept up by hcid, after reboot etc. This is equivalent with having the
"autoinit" option available per device, i.e. in the "device" parameter
section.

> I don't think that we need that. The pairing mode from hcid can go away
> and we should use multi every time.

I agree with the once/multi thing. But isn't it useful to be able to
disable/enable pairing, i.e. deny/accept all pairing requests?

> >    7. List permanently stored configurations.
> >    8. Remove permanently stored configurations.
> What do you mean by permanently stored configurations?

I mean what you asked above: Make it possible to list and configure
previous attached devices. :) A "permanent configuration" is equivalent
to having a configuration like "device 00:00:00:00:00:00 { ... }" in
hcid.conf. (I know you want to have this in another database, but it
would still be "equivalent" with this.)

> But we also need a method to set an alias name for a remote device.

Agreed, see (6) below.

> >   12. Perform av device scan (this will also update the name cache).
> We need something, but I am not sure how to do this. Let's put it at the
> bottom of the list.

Something is needed when a user wants to request a pairing procedure
through DBus. I suspect the user would like to select a device to pair
with first, i.e. do a scan.

> The pairing procedure should work in background and if a PIN is needed a
> PIN helper window should be opened. Maybe you should look at the
> bluez-pin program on the internet and the D-Bus extensions for hcid.

What do you mean? I suppose an application DBus callback would be needed
to handle PIN requests.

> The one-time PIN method is what I really want to have. So an application
> can provide a previous entered PIN and send it to hcid. The hcid will
> use this for the next PIN request (and don't call a PIN helper) and then
> forget the PIN.

This sounds a bit strange. Isn't the PIN an on-demand thing? I mean, the
user expects to enter the PIN which will be used for the current pairing
procedure?

Here's an updated list:

   1. List devices currently attached.
   2. Get info on devices currently attached (address, name,
      manufacturer, type etc.)
   3. Reset a device.
   4. Permanently configure device status (up/down).
   5. Permanently configure device name.
   6. Permanently configure remote device name (alias).
   7. Permanently configure device discoverability.
   8. Permanently configure pair mode (accept multi, or deny all).
   9. List permanently stored configurations.
  10. Remove permanently stored configurations.
  11. List devices which are paired.
  12. Remove devices which are paired.
  13. Request the name for a device address, if available in
      the name cache.
  14. Perform a pairing procedure (will update the name cache too).
  15. Provide a one-time PIN during a pairing procedure.
  16. Perform av device scan (this will also update the name cache).

Fredrik
