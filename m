Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1214852035.6764.40.camel@bongo>
References: <1214593557.6131.26.camel@bongo>
	<1214605438.11537.0.camel@violet.holtmann.net>
	<1214831713.6764.8.camel@bongo>
	<1214834796.11537.42.camel@violet.holtmann.net>
	<1214841475.6764.37.camel@bongo>
	<1214841780.11537.48.camel@violet.holtmann.net>
	<1214852035.6764.40.camel@bongo>
Date: Tue, 01 Jul 2008 03:10:53 +0200
Message-Id: <1214874653.11537.69.camel@violet.holtmann.net>
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

> > > Except that one of my other patches adds a new cancelable function
> > > _connect().  So we would need maybe specific cancel_bonding and
> > > cancel_connect functions.
> > 
> > sounds good to me. The bonding case is special since it can only do one
> > at a time.
> 
> OK, attached is callback2.diff, which only allows canceling a create_bonding call.  Updated other patches to follow.

please only change create_bonding and leave the others alone. Also you
cast a little bit too much for my taste. For example void pointers need
to extra cast.

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
