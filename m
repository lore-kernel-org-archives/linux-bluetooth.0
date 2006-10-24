Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200610241708.52995.denis.kenzior@trolltech.com>
References: <200610231025.51818.denis.kenzior@trolltech.com>
	<200610241547.36330.denis.kenzior@trolltech.com>
	<1161677612.10866.138.camel@aeonflux.holtmann.net>
	<200610241708.52995.denis.kenzior@trolltech.com>
Date: Tue, 24 Oct 2006 11:13:03 +0200
Message-Id: <1161681183.10866.144.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
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

Hi Denis,

> > I am also not sure that the encoding attribute is needed. If you wanna
> > encode binary data in text elements (at the moment only HID does this)
> > then you can use \000 style encoding to do so.
> 
> Perhaps you mean the '&#00;' style escapes?  This is feasible, except that 
> expat assumes attributes do not contain raw data (it returns an array of 
> const char * and assumes it is null terminated).  Thus we would need to 
> switch text* (and perhaps url*?) elements to be something like:
> 
> <!ELEMENT text (#PCDATA)>
> 
> or find another parser.  

we do the parsing of the string by ourself. You only have to do that for
binary strings anyway. And they are expected only in the HID profile so
far. So that shouldn't be that big problem.

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
