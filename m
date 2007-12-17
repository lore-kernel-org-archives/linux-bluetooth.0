Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1194374872.15726.32.camel@cookie.hadess.net>
References: <1194365925.15726.19.camel@cookie.hadess.net>
	<1194374872.15726.32.camel@cookie.hadess.net>
Date: Mon, 17 Dec 2007 02:10:45 +0100
Message-Id: <1197853845.8050.63.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Add filters to device selection (was
	Re:	[PATCH]	allow the chooser widget to show search as an
	afterthought)
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

Hi Bastien,

> > The current device selection widget doesn't allow to show the search
> > button after the widget has been created, which is a bit of a pain.
> > 
> > The attached patch shows the search button by default in the test
> > application and fixes the above problem.
> 
> The attached patch adds 2 (optional) drop-downs to show only devices
> matching a certain filter.
> 
> - Add properties about whether to show the category filter, and the
> device filter, and whether to show/hide those selections
> - Make bluetooth_type_to_string return const (as they are const) and
> mark those strings for translations
> - Add a category enum to bluetooth-device-selection.h
> - Add the ability to pass NULL to bluetooth_client_get_model_with_filter
> (to get a list of known devices on the default adapter, but without
> hiding the bonded, and otherwise not discovered yet devices)

sorry for the delay. Patch looks very good. The layout of the boxes and
buttons are not so good. That still needs some improvement. We might
also need some status indication if we are scanning at the moment or
not. Something like MacOS does. Anyway patch has been applied. Thanks.

Regards

Marcel



-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
