Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1180277003.3030.18.camel@cookie.hadess.net>
References: <20060222091231.GM19185@null.research.nokia.com>
	<1140607245.4519.7.camel@localhost>
	<20060222125425.GQ19185@null.research.nokia.com>
	<20060224110357.GT19185@null.research.nokia.com>
	<1141188501.29216.1.camel@localhost>
	<1180265456.3030.9.camel@cookie.hadess.net>
	<1180268229.21432.63.camel@aeonflux.holtmann.net>
	<1180277003.3030.18.camel@cookie.hadess.net>
Date: Sun, 27 May 2007 23:22:48 +0100
Message-Id: <1180304568.3030.26.camel@cookie.hadess.net>
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

On Sun, 2007-05-27 at 15:43 +0100, Bastien Nocera wrote:
> Hey Marcel,
> 
> On Sun, 2007-05-27 at 14:17 +0200, Marcel Holtmann wrote:
> > > Here's what I could capture from the i386 crash:
> > > BUG warning at lib/kref.c:32/kref_get()
> > 
> > any chance you can test a 2.6.22-rc3 kernel. We fixed some potential
> > problems in RFCOMM and Greg pushed some driver model changes that might
> > make this go away. I really have no idea what triggers this at the
> > moment. However I would like to see a simple reproducer.
> 
> Works with 2.6.22-rc3 (for a meaning of works, my code doesn't seem to
> work, but that's a different matter).

I forgot to mention that the serial service doesn't seem to create any
physical devices (ie. test-serial doesn't create a /dev/rfcomm0 despite
it being the return value of the ConnectService function).

Is that normal?

-- 
Bastien Nocera <hadess@hadess.net> 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
