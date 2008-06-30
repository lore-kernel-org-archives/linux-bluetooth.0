Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1214841475.6764.37.camel@bongo>
References: <1214593557.6131.26.camel@bongo>
	<1214605438.11537.0.camel@violet.holtmann.net>
	<1214831713.6764.8.camel@bongo>
	<1214834796.11537.42.camel@violet.holtmann.net>
	<1214841475.6764.37.camel@bongo>
Date: Mon, 30 Jun 2008 18:03:00 +0200
Message-Id: <1214841780.11537.48.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Wizard patch
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

Hi Michael,

> > > It also adds a new function: bluetooth_client_cancel_call().  This
> > > cancels the last client call made for the given adapter/address.
> [snip]
> > it only makes sense for the create bonding call, because the others
> > can't really be canceled. So my proposal is to leave the others out of
> > this change and implement create_bonding and cancel_bonding.
> 
> Except that one of my other patches adds a new cancelable function
> _connect().  So we would need maybe specific cancel_bonding and
> cancel_connect functions.

sounds good to me. The bonding case is special since it can only do one
at a time.

> But why can't the others be canceled?  Just on the assumption that the
> DBus communication will be so fast as to not really allow time for
> canceling?  Or that by the time you send the message, it's all said and
> done anyway?  I don't understand the nitty gritty details of dbus async
> communication.
> 
> I figured that as a matter of principle, if you have an async API like
> this, it ought to allow for canceling because the very nature of async
> suggests a period of time in which your program is doing other things,
> one of which could conceivably trigger a cancel.

It will give you no advantage whatsoever. So not worth it.

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
