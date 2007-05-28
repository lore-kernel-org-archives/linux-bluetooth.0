Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1180304568.3030.26.camel@cookie.hadess.net>
References: <20060222091231.GM19185@null.research.nokia.com>
	<1140607245.4519.7.camel@localhost>
	<20060222125425.GQ19185@null.research.nokia.com>
	<20060224110357.GT19185@null.research.nokia.com>
	<1141188501.29216.1.camel@localhost>
	<1180265456.3030.9.camel@cookie.hadess.net>
	<1180268229.21432.63.camel@aeonflux.holtmann.net>
	<1180277003.3030.18.camel@cookie.hadess.net>
	<1180304568.3030.26.camel@cookie.hadess.net>
Date: Mon, 28 May 2007 10:40:23 +0200
Message-Id: <1180341623.21432.99.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Soft lockup
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

> > Works with 2.6.22-rc3 (for a meaning of works, my code doesn't seem to
> > work, but that's a different matter).
> 
> I forgot to mention that the serial service doesn't seem to create any
> physical devices (ie. test-serial doesn't create a /dev/rfcomm0 despite
> it being the return value of the ConnectService function).

that looks like an udev problem. It should create the device nodes.

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
