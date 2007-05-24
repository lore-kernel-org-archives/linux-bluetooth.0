Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1180019017.3151.15.camel@cookie.hadess.net>
References: <1179933855.3629.75.camel@cookie.hadess.net>
	<1179935471.19944.6.camel@aeonflux.holtmann.net>
	<1180019017.3151.15.camel@cookie.hadess.net>
Date: Thu, 24 May 2007 17:20:23 +0200
Message-Id: <1180020023.21432.7.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: twaugh@redhat.com
Subject: Re: [Bluez-devel] CUPS plugin discovery bits
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

> > > Here's a patch against CVS bluez-utils to add discovery to the CUPS
> > > backend. With this, it means that most CUPS front-end will be able to
> > > list visible printers when adding a new one, be it through the web
> > > interface or other front-ends (like Fedora' system-config-printer).
> > > 
> > > It adds D-Bus and glib as dependencies for the backend (not that it
> > > matters that much...).
> > 
> > it actually does. We provide an eGlib for embedded systems and so when
> > compiled with GLib, we only use that function subset.
> > 
> > And second you use the GLib D-Bus bindings. I am not willing to create
> > these dependencies for a "daemon" package.
> 
> The dependency is already optional (and if not, I can make it so).
> 
> I've looked at what using dbus directly would entail, and I'm not sure
> that's a good use of my (or anyone's) time. The code would be much more
> complicated than it would need to be, and certainly not any more
> readable.

you can use a lot of helpers from common/libhelper.a to make the
integration with D-Bus really simple. Of course low-level code might is
a little bit more complex, but for me it is not less readable actually.

> In the worst case, how about moving the cups plugin to another module?

I am not maintaining another package.

> > Actually that is the reason why we wanna go
> > for a printing service in the future.
> 
> I still haven't heard the benefits, or features that service would have.
> 
> Unless you want to pass data from a client, over dbus to this printing
> service, which I don't think is a good idea given the potential size of
> the data being passed over.
> 
> If anyone is involved with that, a draft API would be appreciated.

We are not at that point. It was an idea that came of at the last BlueZ
developer meeting. However it might be bogus and we don't do it. I can
tell you more once we actually do start working on it. So no real
details on it so far.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
