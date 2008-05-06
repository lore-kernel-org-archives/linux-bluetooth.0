Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1210066588.2755.27.camel@cookie.hadess.net>
References: <1210038664.15029.20.camel@violet.holtmann.net>
	<4820230F.2060306@suse.de> <1210066588.2755.27.camel@cookie.hadess.net>
Date: Tue, 06 May 2008 14:26:53 +0200
Message-Id: <1210076813.15029.25.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [BlueZ-Announce] Release of
	bluez-libs-3.31	and	bluez-utils-3.31
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

> > > this is an update release of the new stable versions of the Bluetooth
> > > library and the utilities. This release fixes various bugs from the
> > > plugin transition and introduces the first attempts of creating a
> > > Bluetooth helper library for GLib.
> > > 
> > > Currently the full service infrastructure is still available, but with
> > > the next release this might change. So please prepare yourself it.
> > 
> > Might be an issue with my build, but i get this
> > 
> > hcid[32361]: Can't load plugin: /usr/lib64/bluetooth/plugins/libserial.so:
> > undefined symbol: g_ascii_isxdigit
> > 
> > I did not change anything in the build system (apart from removing
> > "--enable-glib" again).
> 
> This should make "make distcheck" barf out if there are missing symbols
> in eglib that are used by plugins.

so we broke the eglib based build two times in a row now. Both times non
intentional. And that is the major reason why eglib goes away when we
are ready for 4.0 and that will be soon. It simply takes too much
resources to maintain a GLib replacement. Nowadays it is not a big deal
to cross-compile GLib for your embedded system. You will need for other
applications anyway.

However the idea with -no-undefined is good. Never realized that we can
do that. I should read manual pages more often :)

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
