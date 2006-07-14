Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20060714080333.GA10043@lst.de>
References: <20060708185833.GA7917@lst.de>
	<1152798551.4838.14.camel@localhost>  <20060714080333.GA10043@lst.de>
Date: Fri, 14 Jul 2006 11:10:33 +0200
Message-Id: <1152868233.25660.8.camel@localhost>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net, maxk@qualcomm.com
Subject: Re: [Bluez-devel] [PATCH] bluetooth: use kthread_ API
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

Hi Christoph,

> > thanks for the patch. It is in my -mh patch now for further testing.
> > What about RFCOMM. No fun in touching that one?
> 
> Actually I'm pretty sure I had a patch for that aswell.  Unfortunately
> the box I have the kthread patches on doesn't seem to boot currently.
> You'll get the rfcomm patch when I return from Ottawa.

I am releasing a 2.6.17-mh4 before the OLS. You might wanna base it on
that one to avoid merge conflicts. See you in Ottawa.

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
