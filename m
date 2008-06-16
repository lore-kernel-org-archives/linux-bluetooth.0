Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <b32d44000806161327u680c290au54fd21f2fef1d58e@mail.gmail.com>
References: <b32d44000806161327u680c290au54fd21f2fef1d58e@mail.gmail.com>
Date: Mon, 16 Jun 2008 22:59:08 +0200
Message-Id: <1213649948.21932.37.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] SDP payload processing vulnerability
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

Hi Glenn,

> The SDP parsing code blindly trusts string length fields in incoming
> SDP packets, exposing reliant applications to over-the-wireless memory
> manipulation attacks.   An attacker need only send a malformed
> response to an SDP query to take advantage of this.

the SDP part has always been the weak point in every Bluetooth stack.
Our server side it pretty good, but it seems the client one is really
bad and I must admit that I never looked into in that in details.

> This is most apparent in file bluez-libs-3.30/src/sdp.c, lines 988,
> 994, 1002 (see below).  Also elsewhere in the code where input
> pointers are advanced without checking bytes remaining to be parsed.
> The root of the problem is that in bluez-libs-3.30/src/sdp.c:1125, the
> function sdp_extract_pdu() takes a buffer to parse (in) and a pointer
> to a length field (out), but it does not take an incoming length field
> (in).
> 
> Attached is a patch to fix this issue.  Basically I added a
> "bytesleft" argument to all of the SDP payload processing routines;
> length fields are checked
> against the number of remaining bytes to ensure the parser doesn't run
> past the end of the packet, or do crazy things like malloc two gigs of
> memory.  This touches a lot of places, and changes the external API
> for SDP payload processing, but I don't see any other way to do this
> -- the parser MUST be aware of the incoming packet size in order for
> this to be secure.

Changing the API is really a problem here. We can't do that. At least
not that easily. We can extend the API with more safe calls and then
slowly move over the clients.

Regards

Marcel



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
