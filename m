Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076506129.2777.83.camel@pegasus>
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
Content-Type: text/plain
Message-Id: <1076510103.6281.162.camel@kalkyl.roxen.com>
Mime-Version: 1.0
Date: Wed, 11 Feb 2004 15:35:03 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

ons 2004-02-11 klockan 14.28 skrev Marcel Holtmann:
> I think we should summarise what tasks an UI have to do and then design
> a D-Bus interface from it.

Here are some basic requirements, I think, for a Gnome Bluetooth Configuration
tool:

   1. List devices currently attached.
   2. Get info on devices currently attached (address, name, manufacturer,
      type etc.)
   3. Permanently configure device status (up/down).
   4. Permanently configure device name.
   5. Permanently configure device discoverability (Iscan? Pscan? Which?)
   6. Permanently configure pair mode (allow/disallow).
   7. List permanently stored configurations.
   8. Remove permanently stored configurations.
   9. List devices which are paired.
  10. Remove devices which are paired.
  11. Request the name for a device address, if available in the name cache.
  12. Perform av device scan (this will also update the name cache).
  13. Perform a pairing procedure (will update the name cache too).
  14. Provide a one-time PIN during a pairing procedure.

(1) and (2) can possibly be solved without DBus, but the rest will require it.

Fredrik
