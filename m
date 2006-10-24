Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Tue, 24 Oct 2006 18:09:56 +1000
References: <200610231025.51818.denis.kenzior@trolltech.com>
	<200610241647.20895.denis.kenzior@trolltech.com>
	<1161681395.10866.148.camel@aeonflux.holtmann.net>
In-Reply-To: <1161681395.10866.148.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Message-Id: <200610241809.56581.denis.kenzior@trolltech.com>
Subject: Re: [Bluez-devel] Proposed DTD
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

Marcel,

> > Yes, the encoding is only relevant for the <text[8,16,32]> fields.  The
> > rest of the attributes should not have it (this is hard to express in a
> > DTD.)
>
> then don't express it at all. Leave it out. An XML file can be valid
> based on its DTD, but still be rejected when stuff is not passing the
> semantic requirements.

I'd rather leave it, encoding attribute is optional anyway, and as you said 
it'll only happen for HID profile.  Might as well treat the entire thing as a 
data blob.  

> If I can get an XML parser that only deals with this specific DTD and is
> not using expat at all, I am willing to include it right away and make
> sdptool use it.

Cool.  I will be unable to work on this for a few weeks, so if nobody steps up 
till then I'll see what I can do.  In the interest of getting something 
working quickly and generating feedback, would you be willing to introduce a 
dependency on expat for hcid? The XML infrastructure really belongs in the 
new dbus API anyway.   

-Denis

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
