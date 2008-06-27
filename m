Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1214593557.6131.26.camel@bongo>
References: <1214593557.6131.26.camel@bongo>
Date: Sat, 28 Jun 2008 00:23:58 +0200
Message-Id: <1214605438.11537.0.camel@violet.holtmann.net>
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

> I have attached a patch against 0.27 (it applies cleanly against CVS) to
> complete the wizard in the bluez-gnome source tree.
> 
> Here's what my patch does in summary, details below:
> Wizard dialog shows list of device types we know how to handle (only
> mouse/keyboard/headset right now).  Then, it tries to connect to the
> appropriate bluetooth dbus service and trust the device.  Basically the
> same code steps the Properties -> Services tab does, but more
> wizardy.  :)
> 
> I made changes to cleanup the wizard interface (removed a couple of
> pages that had low signal/noise ratio) and made several of the
> bluetooth_client capable of giving feedback about the operation via a
> callback.

looks nice. However you have to break this up into pieces for. Sent
small patches and I can quickly review and commit them.

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
