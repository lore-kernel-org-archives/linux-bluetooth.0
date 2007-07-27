Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185550243.2848.46.camel@cookie.hadess.net>
References: <1185475756.3641.329.camel@cookie.hadess.net>
	<1185481079.3641.339.camel@cookie.hadess.net>
	<1185527921.2848.1.camel@cookie.hadess.net>
	<1185550243.2848.46.camel@cookie.hadess.net>
Date: Fri, 27 Jul 2007 19:09:31 +0200
Message-Id: <1185556171.13228.26.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] bluez-gnome:
	"search"	button	for	the	device selection
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

> > > > For comments (but pretty much finished), to give you an idea of the way
> > > > it'd work. The search button starts a discovery on the default adapter,
> > > > and becomes unsensitive.
> > > > 
> > > > The search button becomes sensitive again when all discoveries
> > > > (including those possibly launched on other adapters) are finished.
> > > 
> > > Updated patch against current CVS.
> > > 
> > > Renames show_status to show_bonded, as per the property. Adds a property
> > > to show/hide the search button, and a way for applications hiding the
> > > search button to automatically start the search.
> > > 
> > > I'm just not certain about the client.c changes for tracking the last
> > > discovery.
> > 
> > Updated patch to avoid tracking the number of discoveries, it's not
> > useful as we only handle discovery on the default adapter.
> 
> Another updated patch.
> 
> Fixes the device selection's search button in the wizard, and adds
> support to the bonding code in the client to handle the "NULL" adapter
> we pass it.

patch has been applied. However I am not okay with some of the callback
names, but we can fix that later.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
