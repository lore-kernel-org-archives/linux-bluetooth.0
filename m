Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0609181548170.7570@redbean.intranet.gw-instruments.de>
References: <Pine.LNX.4.63.0609181548170.7570@redbean.intranet.gw-instruments.de>
Date: Mon, 18 Sep 2006 16:20:15 +0200
Message-Id: <1158589215.25125.12.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] CVS access ?
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

Hi Peter,

> may be I'm only stupid, but I can noot get anything from the CVS as 
> published on www.bluez.org. 
> 
> pewi@Zuccini:~/bluez$ cvs -d:pserver:anonymous@cvs.bluez.org:/cvsroot/bluez login
> Logging in to :pserver:anonymous@cvs.bluez.org:2401/cvsroot/bluez
> CVS password: 
> pewi@Zuccini:~/bluez$ cvs -d:pserver:anonymous@cvs.bluez.org:/cvsroot/bluez rls -P -R
> cvs [rls aborted]: server does not support rls
> pewi@Zuccini:~/bluez$ cvs -d:pserver:anonymous@cvs.bluez.org:/cvsroot/bluez co -P kernel
> cvs checkout: Updating kernel
> cvs checkout: Updating kernel/bnep
> cvs checkout: Updating kernel/core
> cvs checkout: Updating kernel/doc
> cvs checkout: Updating kernel/drivers
> cvs checkout: Updating kernel/include
> cvs checkout: Updating kernel/misc
> cvs checkout: Updating kernel/rfcomm
> pewi@Zuccini:~/bluez$ ls
> pewi@Zuccini:~/bluez$ ls -l
> total 0
> 
> ?????????
> 
> Any hints what I'm doing wrong here ?? 

you are doing nothing wrong, but the kernel repository got cleared a
long time ago. We are not using it anymore.

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
