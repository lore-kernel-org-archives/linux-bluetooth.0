Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 25 Dec 2006 17:55:42 +0100
From: Filippo Giunchedi <filippo@esaurito.net>
To: Bram Stolk <bram@sara.nl>
Message-ID: <20061225165542.GA970@esaurito.net>
References: <1167052771.5265.7.camel@suske>
MIME-Version: 1.0
In-Reply-To: <1167052771.5265.7.camel@suske>
Cc: pkg-bluetooth-maintainers@lists.alioth.debian.org,
        bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [Pkg-bluetooth-maintainers] dbus dependency
	introduces unwanted X11 dependency
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi, [upstream CCed]

On Mon, Dec 25, 2006 at 02:19:31PM +0100, Bram Stolk wrote:
> Hi there,
> 
> 
> I'm currently running bluez-utils version 2.25-1
> 
> Upgrading to 3.7-1 gives me the following problem:
> 
> I have a server running Debian/testing.
> I want to keep this server completely free from XWindow stuff.

on a clean etch system the installation of bluez-utils brings in the following
packages:

dbus libbluetooth2 libdbus-1-3 libexpat1 libx11-6 libx11-data libxau6 libxdmcp6
x11-common

the only x-related stuff is the x11 client libraries and x11-common, totalling
4MB of diskspace, you won't be able to run an X server with any of those
packages.

> 
> However, this server is to act as a bluetooth accesspoint using
> the PAN profile, and the pand deamon.
> 
> This works fine with version 2.25-1 of bluez-utils/
> 
> With the new version, dbus gets pulled in. Why?
> Isn't libdbus enough?

starting with bluez 3.x most of the functionality has been moved to dbus, which
is used among other things for pinhelper functionalities.
and no, libdbus isn't enough unless I'm missing something, bluez (hcid) needs to
register to the local dbus.

> 
> And with dbus, X11 is introduced.

not exactly, a small part of an X11 client is introduced.

> 
> This is so ugly...
> 
> It should be possible to run pand without the X11 burden.
> It used to be possible in the past, but not anymore.

I'm not sure if it makes any sense to have bluetooth daemons splitted in its own
package. 

thanks for your report,
filippo

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
