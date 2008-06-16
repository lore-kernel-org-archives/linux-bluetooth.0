Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <b32d44000806161421k58d4f107m4961ccac72a5bb8b@mail.gmail.com>
References: <b32d44000806161327u680c290au54fd21f2fef1d58e@mail.gmail.com>
	<1213649948.21932.37.camel@violet.holtmann.net>
	<b32d44000806161421k58d4f107m4961ccac72a5bb8b@mail.gmail.com>
Date: Mon, 16 Jun 2008 23:37:01 +0200
Message-Id: <1213652221.21932.42.camel@violet.holtmann.net>
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

> > the SDP part has always been the weak point in every Bluetooth stack.
> > Our server side it pretty good, but it seems the client one is really
> > bad and I must admit that I never looked into in that in details.
> 
> I'm concerned that hcid is also vulnerable to this (which would make
> it both a server and a client problem?).

in theory it is, but you have to trigger a SDP client transaction first
and it is almost impossible to do this remotely. Yes, I can think of
tricks on how to do that, but that is besides the point here.

> > Changing the API is really a problem here. We can't do that. At least
> > not that easily. We can extend the API with more safe calls and then
> > slowly move over the clients.
> 
> That sounds good.  I can write safe versions of the parsing routines
> and move everything I can find over to the new API; old clients will
> still work with the old (unsafe) API.  This may present some
> maintenance challenges since there will be 2x parsing code, but it is
> better than leaving security holes everywhere.

You can have the old API call the new one with a NULL parameter and yes,
it might be confusing, but it is better than breaking the API.

Please use the BlueZ coding style when doing the patch and have small
pieces. I am not going to review the whole think as once. Please send
small updates. It is faster this way.

> Is bluez.org currently down?  I can't seem to get at the latest version...

Yeah. The server lost its routing information. I am working on it.

Use the CVS at bluez.sf.net or the GIT clone at git.infradead.org since
patches against the last release are outdated.

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
