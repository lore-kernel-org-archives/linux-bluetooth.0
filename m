Return-Path: <pb@nexus.co.uk>
Subject: Re: [Bluez-devel] Writing a bluetooth mouse driver...
From: Philip Blundell <pb@nexus.co.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Keith Pemberton <kbpember@cox.net>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1079352208.3405.26.camel@pegasus>
References: <1079350703.4317.7.camel@linuxcomp.gatep5.net>
	 <1079352208.3405.26.camel@pegasus>
Content-Type: text/plain
Message-Id: <1079359127.21325.3.camel@mill.nexus.co.uk>
Mime-Version: 1.0
Date: Mon, 15 Mar 2004 13:58:47 +0000
List-ID: <bluez-devel.lists.sourceforge.net>

On Mon, 2004-03-15 at 12:03, Marcel Holtmann wrote:
> messages. The transport protocol is HIDP and than you need of course a
> HID parser, which is the biggest part.

I spoke with Vojtech last year about moving the HID parser from the USB
code into the input subsystem, so that it could be shared with
Bluetooth.  He seemed happy with that in principle, and I don't think it
would be very difficult to implement, but I haven't had time to actually
write a patch yet.

p.
