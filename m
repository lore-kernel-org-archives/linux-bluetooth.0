Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1214831713.6764.8.camel@bongo>
References: <1214593557.6131.26.camel@bongo>
	<1214605438.11537.0.camel@violet.holtmann.net>
	<1214831713.6764.8.camel@bongo>
Date: Mon, 30 Jun 2008 16:06:36 +0200
Message-Id: <1214834796.11537.42.camel@violet.holtmann.net>
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

> > looks nice. However you have to break this up into pieces for. Sent
> > small patches and I can quickly review and commit them.
> 
> Here's a patch to add callback support to many of the common/client
> calls.
> 
> It also adds a new function: bluetooth_client_cancel_call().  This
> cancels the last client call made for the given adapter/address.
> 
> Admittedly, it would be fancier if, for example,
> bluetooth_client_create_bonding() gave back a handle which could be used
> to cancel its call, rather than just keeping track of the last one.

it only makes sense for the create bonding call, because the others
can't really be canceled. So my proposal is to leave the others out of
this change and implement create_bonding and cancel_bonding.

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
