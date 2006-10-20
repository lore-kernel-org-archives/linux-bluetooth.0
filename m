Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <9307f5f20610200330s5f867c41h2dc0096c6d4e5458@mail.gmail.com>
References: <200610191334.25362.denis.kenzior@trolltech.com>
	<1161249153.27710.5.camel@localhost>
	<9307f5f20610200330s5f867c41h2dc0096c6d4e5458@mail.gmail.com>
Date: Fri, 20 Oct 2006 12:41:52 +0200
Message-Id: <1161340912.27585.53.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] SDP over XML
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

Hi Paolo,

> > The record add function of sdptool is actually more a development thing,
> > than something you should use in real applications. However I am against
> > adding a dependency on a XML parsing library to sdptool.
> >
> libdbus already pulls the expat xml parser as a dependency, so since
> you've made D-Bus a mandatory requirement using libexpat wouldn't
> require end users to install any additional packages

you only need D-Bus for hcid and not sdptool. And D-Bus has support for
two different XML parsers.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
