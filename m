Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076539335.3041.28.camel@pegasus>
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
	 <1076538332.31726.29.camel@akka.yeti.nocrew.org>
	 <1076539335.3041.28.camel@pegasus>
Content-Type: text/plain
Message-Id: <1076540221.31726.39.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Wed, 11 Feb 2004 23:57:01 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

On Wed, 2004-02-11 at 23:42, Marcel Holtmann wrote:
> I tought you meant up/down as real actions.

Yes, that too. Set the device up/down as well as keep it up/down. That's
what the user expects from the GUI buttons up/down.

> Why? If you want to deny a paring, you can click cancel on the PIN
> request.

Well, you might want to avoid DOS PIN attacks by evil neighbours.

> So lets combine these with (1) and (2). How to present it, is a problem
> of the UI.

(1) and (2) is about current devices, that may or may not be configured.
This is about list/remove configurations, that may or may not have
devices attached. It's not the same thing, really.

> The pairing procedure should be run automaticly on the fist connect, so
> we shouldn't care about it.

Uh? You do need a scan to find other devices, don't you?

> Yes. Please look at the code that RedHat already ships.

Sure.

> It sounds somekind weird, but it will help in some cases.

I don't understand why. :)

Fredrik
