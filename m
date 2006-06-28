Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20060628T033626-329@post.gmane.org>
References: <loom.20060628T033626-329@post.gmane.org>
Date: Wed, 28 Jun 2006 09:28:18 +0200
Message-Id: <1151479698.9544.1.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] cross-compiling bluez-utils.3.1
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

Hi Robert,

> I seem to be having problems with the latest version of bluez-utils.  It seems
> that dbus is a required component of the 3.1 release; which isn't cross-compile
> friendly (the dbus build complains about cross-compiling) -- a previous version
> of bluez-utils (2.21) is.  In the 2.21 release there was an option to compile
> without dbus, is there a work around for the 3.1/if so, how?  If not, any
> suggestions about cross-compiling the stock bluez-utils.3.1 (including dbus as
> necessary) for an ARM processor?

the D-Bus library is mandatory now. Hence the new major version number.

Regards

Marcel



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
