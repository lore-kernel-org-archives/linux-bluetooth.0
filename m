Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <8a8adccc0712181352u1d802bfava194bf372cb5f232@mail.gmail.com>
References: <8a8adccc0712161309m29c70a45x212bead7a823d808@mail.gmail.com>
	<1197841650.8050.39.camel@aeonflux>
	<8a8adccc0712161443w7ba67743jc06515240cfdf83d@mail.gmail.com>
	<1197847447.26210.268.camel@cookie.hadess.net>
	<1197853381.8050.58.camel@aeonflux>
	<8a8adccc0712162315v53bf668et553413d6dbc81551@mail.gmail.com>
	<1197918266.8050.90.camel@aeonflux>
	<8a8adccc0712181352u1d802bfava194bf372cb5f232@mail.gmail.com>
Date: Wed, 19 Dec 2007 00:22:17 +0100
Message-Id: <1198020137.8050.203.camel@aeonflux>
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

> > > > > > > > Attached patch does the following
> > > > > > > >
> > > > > > > > * about dialog code is simpler
> > > > > > >
> > > > > > > you can't use gtk_dialog_run for the applet's about dialog. It will
> > > > > > > block and thus block all PIN requests. The current code is this way for
> > > > > > > a reason.
> > > > > >
> > > > > > Didn't know that. I now use g_object_set which also reduces the amount
> > > > > > of code considerably.
> > > > >
> > > > > You can still use gtk_show_about_dialog(). It removes the close
> > > > > callback, and makes sure that only one dialogue shows up, and removes a
> > > > > lot of boiler-plate code (it doesn't use a separate main loop like
> > > > > gtk_dialog_run does). The gtk_dialog_run avoidance in the callbacks is
> > > > > still needed.
> > > >
> > > > not sure why I haven't done it that way. Maybe it was not available when
> > > > I wrote the initial version. However now the requirements are GTK 2.10
> > > > or later. So if we can simplify code, I am all for it.
> > > >
> > > Attached two patches
> > >
> > > One uses gtk-show-about-dialog
> >
> > fix the coding style for this one. I can already see that it messes up
> > the whitespaces. We use tabs and no whitespace in front of the ( in
> > function declarations.
> 
> Attached patch with coding style fixup attached

I don't see the advantage of this patch. Especially with this ugly ifdef
for the program-name bug, I decided to not apply it. Especially the
license crap is not worth doing it. There is no need that the UI shows
the license in the about dialog.

You can still fill in the code for the URL and email hooks to make the
actually work. I didn't bother so far, because the default screen thing
seem to be wrong. You should use the screen where the actual about
dialog is present. However I am not so deep into GDK to tell what is the
correct way here.

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
