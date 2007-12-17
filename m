Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1197853845.8050.63.camel@aeonflux>
References: <1194365925.15726.19.camel@cookie.hadess.net>
	<1194374872.15726.32.camel@cookie.hadess.net>
	<1197853845.8050.63.camel@aeonflux>
Date: Mon, 17 Dec 2007 01:30:10 +0000
Message-Id: <1197855010.26210.285.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Add filters to device selection
	(was	Re:	[PATCH]	allow the chooser widget to show search as
	an afterthought)
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


On Mon, 2007-12-17 at 02:10 +0100, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > > The current device selection widget doesn't allow to show the search
> > > button after the widget has been created, which is a bit of a pain.
> > > 
> > > The attached patch shows the search button by default in the test
> > > application and fixes the above problem.
> > 
> > The attached patch adds 2 (optional) drop-downs to show only devices
> > matching a certain filter.
> > 
> > - Add properties about whether to show the category filter, and the
> > device filter, and whether to show/hide those selections
> > - Make bluetooth_type_to_string return const (as they are const) and
> > mark those strings for translations
> > - Add a category enum to bluetooth-device-selection.h
> > - Add the ability to pass NULL to bluetooth_client_get_model_with_filter
> > (to get a list of known devices on the default adapter, but without
> > hiding the bonded, and otherwise not discovered yet devices)
> 
> sorry for the delay. Patch looks very good. The layout of the boxes and
> buttons are not so good. That still needs some improvement. We might
> also need some status indication if we are scanning at the moment or
> not. Something like MacOS does. Anyway patch has been applied. Thanks.

It's still missing:

> - make the drop-downs look better

I've been told the drop-downs look alright, but the search button looks
out of place. See below.

> - convenience functions to change the filters programmatically (eg.
> gnome-phone-manager would default to showing phones)

That's fairly straight forward, but we'd need the stuff below to be done
first.

> - add more category filters (would require client.[ch] changes), such
> as
> "Recent devices", and "Discovered devices".

I'm not sure how we can guess those though, any ideas.

About the widget now.

Do we want to use it in places like the "bonded devices", or "input
devices" treeviews in the prefs? I'd say yes, as it's pretty easy to
turn on/off some columns, and show only a certain type of objects.
If we don't want to share this tree, we'd need to export a few
functions, so that not as much code is duplicated.

As for the search. I've been told that the search button looks out of
place (and it does), but the main reason for having it is to show the
user that a search is in progress, as well as allowing the user to start
a search if one finished without the user finding a specific device
(which could happen more often than not).

We could replace it with a programmatic way of making the backend (in
client.[ch]) search all the time when the front-end program requires it.
For example, the "Browse Device..." dialogue could search continuously,
as its job is to find devices. The other (more static) treeviews such as
the ones in the preferences wouldn't call that function.

What do you think?

Cheers


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
