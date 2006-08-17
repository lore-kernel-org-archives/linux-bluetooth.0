Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000f01c6c1ef$306137e0$9d0cc70a@dlh.st.com>
References: <000f01c6c1ef$306137e0$9d0cc70a@dlh.st.com>
Date: Thu, 17 Aug 2006 15:45:51 +0200
Message-Id: <1155822351.4075.136.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Host Controller to Host Flow Control
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

Hi Mayank,

> > to start something we can do this. Remember that the kernel 
> > then have to
> > track these commands to see if it has to use host controller to host
> > flow control or not.
> > 
> 
> Hmmm.... I think I understand now why you were insisting this to be done at
> the kernel side.
> Because if we set flow control from user side then it will be difficult to
> inform the kernel about this.
> I'll try both things (setting flow control and sending host no of completed
> packets) from kernel side only.

it is not that complicated. We have to do this for a lot of commands
that you can use from userspace and the kernel has to detect its
execution. You might wanna do it anyway so you should have a look at the
examples in hci_event.c inside the kernel code.

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
