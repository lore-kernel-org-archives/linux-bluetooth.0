Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: "Jaap A. Haitsma" <jaap@haitsma.org>
In-Reply-To: <8a8adccc0712161246y3f435aefwdb6c92c464d19f96@mail.gmail.com>
References: <8a8adccc0709020615m38389d6axe49041f8fbe18c4b@mail.gmail.com>
	<1188768824.24968.9.camel@violet>
	<8a8adccc0712161246y3f435aefwdb6c92c464d19f96@mail.gmail.com>
Date: Sun, 16 Dec 2007 22:49:12 +0100
Message-Id: <1197841752.8050.42.camel@aeonflux>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] Bluez build system
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

> With a couple of months delay but here it is.
> 
> Attached you find autogen.sh. Just put this file in the gnome
> directory of bluez and gnome-bluetooth can be build with jhbuild. NOTE
> you need to have the package gnome-common installed. gnome-common
> contains common scripts and macros to make developing GNOME apps
> easier

that is not gonna happen since even if it is called bluez-gnome, it can
be build and used without GNOME. Its only dependency is GTK+. So
depending on gnome-common is not an option.

> The files bootstrap and bootstrap-configure can be removed because
> autogen.sh is now doing that job.

I actually like bootstrap and bootstrap-configure, because they do
exactly the right job for the developers.

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
