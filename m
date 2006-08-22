Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000201c6c59b$5735bc60$9d0cc70a@dlh.st.com>
References: <000201c6c59b$5735bc60$9d0cc70a@dlh.st.com>
Date: Tue, 22 Aug 2006 07:39:21 +0200
Message-Id: <1156225161.3956.46.camel@aeonflux.holtmann.net>
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

> > I've noticed you sent a diff against hci.h from bluez-libs and not the
> > one in the kernel, so please check that.
> 
> Oops. My mistake. Here is the diff for the one in the kernel.

please follow the names, I just introduced for the libraray. They don't
have to match, but I prefer if they do. The structs for setting the host
to host controller flow control are also not needed. Only the OCF value.
And the number of completed packets struct is variable. Please compare
the number of completed packets events.

> > One other thing is that you
> > have to be careful with endianess issues (please check your patch
> > against hci_core.c).
> 
> Which one do you mean in particular? 0x0008 or connection handle?

Every parameter that is uint16 needs an endian conversation.

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
