Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: "Xavier Garreau" <x.garreau@prim-time.fr>, Stephen Crane <steve.crane@rococosoft.com>
Subject: Re: [Bluez-devel] [ANN] Zaurus BlueZ kernel packages for ROM v3.10
References: <1054908696.4791.157.camel@baroque.rococosoft.com>
	<1055156207.4791.301.camel@baroque.rococosoft.com>
	<005f01c3302e$ca3537a0$0181a8c0@zaz1>
In-Reply-To: <005f01c3302e$ca3537a0$0181a8c0@zaz1>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Message-Id: <200306282005.08403.justin-qt@affinix.com>
Reply-To: Justin Karneges <justin-qt-dated-1058094956.869933@affinix.com>
From: Justin Karneges <justin-qt@affinix.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 28 Jun 2003 20:05:08 -0700
Content-Type: text/plain; CHARSET=iso-8859-1

Hi,

I'm working towards easy Bluetooth on the Zaurus.  I have a bluez GUI tool and 
qtopia dialer plugin in the works.

However, getting bluez installed was never easy.  In the past, I was using the 
ipks available at bluez.sf.net, which were never very complete.

Today, I sought to remedy this, and tried cross compiling modules and the 
libs/utilities.  I ran into a heap of trouble, and then discovered this 
thread.  I'm glad someone else is looking into this stuff too. :)

My original goal was to get this working with kernel 2.4.6, but I'm not sure 
how realistic that is.  I didn't know about the new sharp ROM until today, 
which I have now installed.  I guess it is acceptable to work with this as a 
target, and considering it comes with kernel 2.4.18, it should make a lot of 
things easier.

Xavier's package looks good.  The only flaw I think is that it does not set up 
/etc/bluetooth.

I'd like to see some secrets shared.  Could Steve or Xavier respond to me here 
or on the list, so that we can make something more official?

-Justin

On Wednesday 11 June 2003 08:33 am, Xavier Garreau wrote:
> > > kernel modules into one big package. I like to see the kernel stuff
> > > seperated from the userspace tools.
> >
> > Yeah me too. Particularly because it's much easier to build the
> > user-space tools with a cross-compiler.
>
> Not in this release.
>
> > I will think about doing this if I get some time. For now, I have
> > uploaded the latest basic user-space binaries separately to
> > ftp://rococosoft.com/pub/zaurus with instructions for installing them in
> > the right places. It would not be too hard to write packaging scripts
> > for them --- indeed this is something anyone could do using the
> > ipkg-build script; volunteers?
>
> I did it : http://fichiers.xgarreau.org/zaurus/bluez_2.4.18_arm.ipk
>
> It installs the files in the right directories, make the symlinks, try to
> guess what card it is and bring device up.
>
> Please keep me informed of new builds so that i keep the package up to
> date.


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
