Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <8a8adccc0712161443w7ba67743jc06515240cfdf83d@mail.gmail.com>
References: <8a8adccc0712161309m29c70a45x212bead7a823d808@mail.gmail.com>
	<1197841650.8050.39.camel@aeonflux>
	<8a8adccc0712161443w7ba67743jc06515240cfdf83d@mail.gmail.com>
Date: Mon, 17 Dec 2007 01:58:23 +0100
Message-Id: <1197853103.8050.52.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Beautify about dialog
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

Hi Jaap,

> > > * about dialog code is simpler
> >
> > you can't use gtk_dialog_run for the applet's about dialog. It will
> > block and thus block all PIN requests. The current code is this way for
> > a reason.
> 
> Didn't know that. I now use g_object_set which also reduces the amount
> of code considerably.

I don't think that this makes it any easier to read. The trade a big
block of function with a big big block of properties. Don't see the
advantage in it.

> > > * email address and URLs are clickable
> >
> > Send a separate patch for this.
> 
> It's still in the same patch, because the patches change stuff in the
> same function
> 
> These two function calls in about_callback do the trick
> 
> 	gtk_about_dialog_set_url_hook (about_dialog_handle_url_cb, NULL, NULL);
> 	gtk_about_dialog_set_email_hook (about_dialog_handle_email_cb, NULL, NULL);

Then send a patch for it and I can apply it in step. Sending me a big
bunch in one go doesn't make me gonna review it and apply it. Simple
patches go in quicker.

> > > * Makes sure that every window gets a bluetooth window icon
> >
> > This should be already working. And if it is missing somewhere, I need a
> > separate patch for it.
> 
> The credits window didn't have it.
> 
> The call:
> gtk_window_set_default_icon_name ("stock_bluetooth");
> makes sure that any window at least gets an icon

That is fair enough. Send a patch for it.

>         g_set_application_name (_("Bluetooth Applet"));
> makes sure that the about dialog always says "Bluetooth Applet" no
> matter which version of GTK you have installed. (In GTK 2.12 the name
> attribute was changed)

I am against this. I was _not_ using g_set_application_name on purpose,
because I don't see its advantage. If the GTK changes its attributes,
then this is a GTK bug. The GTK 2.x version should be ABI and API
compatible. File a report against GTK 2.12 on this one.

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
