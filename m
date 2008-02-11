Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1202693028.3491.112.camel@cookie.hadess.net>
References: <1202692346.7664.129.camel@violet>
	<1202693028.3491.112.camel@cookie.hadess.net>
Date: Mon, 11 Feb 2008 02:31:08 +0100
Message-Id: <1202693468.7664.135.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [BlueZ-Announce] Release of
	bluez-libs-3.26	and	bluez-utils-3.26
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

> > this is an update release of the new stable versions of the Bluetooth
> > library and the utilities. This release is actually a cleanup release
> > and the first step towards the BlueZ 4.0 generation.
> > 
> > With this release all services are switched on by default and all old
> > school daemons are disabled. So all package maintainers, please keep
> > this in mind and adjust your packages.
> > 
> > The sources can be found at http://www.bluez.org/download.html
> 
> Which daemons do you call "old school"? Is this pand/dund?

yes. All this hidd, pand, dund etc. stuff that is more hacking around
than actually doing something.

> Can we get rid of the tick boxes in the properties services tab now? :)

Actually we will, but not so quickly. We have to re-design parts of the
service infrastructure for 4.0 and then we see.

Btw. you need to update gnome-user-share since the obex-data-server-0.1
API now uses DBUS_TYPE_OBJECT_PATH and no strings anymore.

And I am thinking about simply adding the support for FTP to bluez-gnome
since the dependencies of gnome-user-share are a little bit too much.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
