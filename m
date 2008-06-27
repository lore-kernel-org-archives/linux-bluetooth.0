Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1214593557.6131.26.camel@bongo>
References: <1214593557.6131.26.camel@bongo>
Date: Fri, 27 Jun 2008 23:44:07 +0100
Message-Id: <1214606647.4435.71.camel@cookie.hadess.net>
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

On Fri, 2008-06-27 at 15:05 -0400, Michael Terry wrote:
> Hello, all!
> 
> I have attached a patch against 0.27 (it applies cleanly against CVS) to
> complete the wizard in the bluez-gnome source tree.

-	item = gtk_menu_item_new_with_label(_("Setup New Device"));
+	item = gtk_menu_item_new_with_label(_("Connect New Device..."));

This is wrong, as we'll probably want to plug in more setup for future
device types. For example, when adding a phone, we'll want to check
whether it supports SyncML, and automatically set it up in the sync
program.

The setup_services() service call shouldn't be needed, as all the
services are enabled by default.

In bluetooth_client_available_services(), you also need to add joypads,
and every other input devices to that list.

+			// If caller didn't specify a forced type, determine it from device
info

Don't use C++-style comments.

I personally don't really like adding setup calls in client.c, which
should really only be used for discovery.

The rest looks alright to me, looking over it quickly.

Cheers


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
