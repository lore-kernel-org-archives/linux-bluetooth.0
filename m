Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <452EF797.1070708@xmission.com>
Date: Thu, 12 Oct 2006 20:19:03 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <452E84DA.9090307@free.fr>
In-Reply-To: <452E84DA.9090307@free.fr>
Subject: Re: [Bluez-devel] [PATCH] Updated sco flow control feature
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

Fabien

> You will find attached an updated version of the patch against
> 2.6.18-mh4, as well as a sample test program that shows the flow control
> stuff is really working.

I'm glad you're hacking at this still and I hope we are converging on
something that everyone agrees on.

> Random notes :
> I tryed to enable number of completed packets events for synchronous
> connections,
> to get rid of all the timer stuff, however it didn't succeed.

How does this idea that didn't work out compare to the approach Jose is
discussing? From what I've seen they both seem to be considering the
problem at a lower level.

FYI, on the topic of plugins... I am writing up new documentation (using
the ubuntu wiki for now... don't hate me). I'm moving emphasis away from
the old "btsco" daemon method for sco audio. The sco alsa plugin detail
in the wiki is only a placeholder currently but I want to flesh it out soon.

https://help.ubuntu.com/community/BluetoothAudio

Brad


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
