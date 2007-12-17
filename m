Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1197847447.26210.268.camel@cookie.hadess.net>
References: <8a8adccc0712161309m29c70a45x212bead7a823d808@mail.gmail.com>
	<1197841650.8050.39.camel@aeonflux>
	<8a8adccc0712161443w7ba67743jc06515240cfdf83d@mail.gmail.com>
	<1197847447.26210.268.camel@cookie.hadess.net>
Date: Mon, 17 Dec 2007 02:03:01 +0100
Message-Id: <1197853381.8050.58.camel@aeonflux>
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

Hi Bastien,

> > > > Attached patch does the following
> > > >
> > > > * about dialog code is simpler
> > >
> > > you can't use gtk_dialog_run for the applet's about dialog. It will
> > > block and thus block all PIN requests. The current code is this way for
> > > a reason.
> > 
> > Didn't know that. I now use g_object_set which also reduces the amount
> > of code considerably.
> 
> You can still use gtk_show_about_dialog(). It removes the close
> callback, and makes sure that only one dialogue shows up, and removes a
> lot of boiler-plate code (it doesn't use a separate main loop like
> gtk_dialog_run does). The gtk_dialog_run avoidance in the callbacks is
> still needed.

not sure why I haven't done it that way. Maybe it was not available when
I wrote the initial version. However now the requirements are GTK 2.10
or later. So if we can simplify code, I am all for it.

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
