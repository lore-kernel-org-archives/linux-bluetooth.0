Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185565304.2848.56.camel@cookie.hadess.net>
References: <1185475756.3641.329.camel@cookie.hadess.net>
	<1185481079.3641.339.camel@cookie.hadess.net>
	<1185527921.2848.1.camel@cookie.hadess.net>
	<1185550243.2848.46.camel@cookie.hadess.net>
	<1185556171.13228.26.camel@violet>
	<1185561572.2848.54.camel@cookie.hadess.net>
	<1185562953.13228.32.camel@violet>
	<1185565304.2848.56.camel@cookie.hadess.net>
Date: Fri, 27 Jul 2007 22:16:17 +0200
Message-Id: <1185567377.13228.38.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel]
	[PATCH]	bluez-gnome:	"search"	button	for	the	device selection
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

Hi Hadess,

> > > > patch has been applied. However I am not okay with some of the callback
> > > > names, but we can fix that later.
> > > 
> > > Let me know what you want renamed to what, and I'll fix it up.
> > 
> > I disabled the search button support. I crashes the applet. Main issue
> > is your handling of starting and stopping discover process and then
> > listening for the complete signal to change the button state. That is
> > wrong we have to track the state for an adapter being in discovery or
> > not inside the tree model. Otherwise we end up with a lot of race
> > condition. We also need to check if an adapter is already running a
> > discovery or is using periodic inquiry.
> 
> How else do you want to implement it? What's the backtrace from the
> applet that you've seen?

the Bluetooth client should exists only once per application. We don't
need multiple. So it is needed that we create that object only once and
then keep it alive until end of application.

We also need to track the status of the discovery procedure inside the
tree store. Then we only have to check for that there. The tree store
has a reference count and so we can't run into problems there.

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
