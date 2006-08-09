Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0608021302130.6321@redbean.intranet.gw-instruments.de>
References: <200608011329.03106.denis.kenzior@trolltech.com>
	<1154488406.3905.37.camel@aeonflux.holtmann.net>
	<Pine.LNX.4.63.0608021302130.6321@redbean.intranet.gw-instruments.de>
Date: Thu, 10 Aug 2006 00:09:34 +0200
Message-Id: <1155161374.4492.15.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Patch: GetRemoteClass
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

> > > Attached is a patch to get remote class of device information as a uint32.  
> > > This introduces a new method with signature:
> > > uint32 GetRemoteClass(string address), which returns the class of device 
> > > information encoded as a 32 bit integer.
> > > 
> > > The reasoning is that some applications might want to rely on their own 
> > > conversion routines for the Major, Minor and Service class attributes, and 
> > > thus the DBUS GetRemoteMajorClass, GetRemoteMinorClass, etc methods that 
> > > return strings are not useful.
> > 
> > the patch is clean. So before I apply it and so extend the API, does
> > someone else thinks it is useful to have?
> > 
> I'm currently not using the DBUS API, but I think this would be something 
> very usefull. 

that's fair enough. I applied the patch to the CVS now.

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
