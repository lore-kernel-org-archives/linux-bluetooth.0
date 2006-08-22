Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000f01c6c59e$67014940$9d0cc70a@dlh.st.com>
References: <000f01c6c59e$67014940$9d0cc70a@dlh.st.com>
Date: Tue, 22 Aug 2006 07:54:27 +0200
Message-Id: <1156226067.3956.57.camel@aeonflux.holtmann.net>
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

> > please follow the names, I just introduced for the libraray. 
> > They don't
> > have to match, but I prefer if they do. The structs for 
> > setting the host
> > to host controller flow control are also not needed. Only the 
> > OCF value.
> 
> But actually, set controller to host flow control requires a parameter to
> tell which flow control we want to set. ACL, SCO or both. So a uint8_t
> parameter is required and hence the struct.

we don't send it from the kernel, do we? And even if we do, please check
the HCI Write Scan Enable command.

> > And the number of completed packets struct is variable. Please compare
> > the number of completed packets events.
> 
> But a variable sized host number of completed packets command is required if
> we are sending number of completed packets for more than one connection
> handle in the same command, which is not the case currently.

Even if we don't do it at the moment, this doesn't mean that we mess up
the kernel with wrong structs.

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
