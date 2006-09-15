Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <450AADD1.2040300@vasmac.com>
References: <45015406.60208@vasmac.com> <1158321334.5233.13.camel@localhost>
	<450AADD1.2040300@vasmac.com>
Date: Fri, 15 Sep 2006 15:46:51 +0200
Message-Id: <1158328011.5233.30.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] hcid dbus patches
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

Hi Jose,

> >> Here are a couple of patches that implement the following
> >> commands in dbus-test:
> >> GetRemoteClass
> >> GetRemoteServiceHandles
> >> GetRemoteServiceRecord
> >>
> >> This required modifications to dbus-sdp.c. The problem was
> >> that the call to dbus_message_get_args in this file used a NULL
> >> pointer for the error structure. This patch adds a pointer in
> >> the same way that dbus-adapter.c calls dbus_messsage_get_args.
> >> The end result is that both GetRemoteService* calls now seem
> >> to work.
> >>     
> >
> > I am not following that argument. If we don't care about the error code,
> > then why should we fill one it. If this is a problem, then the problem
> > is in the D-Bus low-level library or the Python bindings.
> 
> This was my first hack with dbus. I haven't read the docs so
> I'm not sure how it all works. I just noticed that the code in
> dbus-adapter.c is working so put the same changes on dbus-sdp.c
> and it worked.
> 
> I don't think the patch to dbus-sdp.c should be put in. Someone
> with more dbus expertise should fix it. The patch to dbus-test
> is simple and adds the new commands.

every patch is welcome, but for this one, I simply don't see the need.
For me it looks like D-Bus is at fault here and maybe updating your
D-Bus installation and the Python bindings might fix this.

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
