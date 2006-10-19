Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200610191334.25362.denis.kenzior@trolltech.com>
References: <200610191334.25362.denis.kenzior@trolltech.com>
Date: Thu, 19 Oct 2006 11:12:33 +0200
Message-Id: <1161249153.27710.5.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] SDP over XML
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

> I've been playing around with the idea of encapsulating SDP information over 
> XML.  The primary aim was to enable things like sdptool or hcid to be able to 
> exchange SDP records in an open format.  It would also enable for 
> applications to register arbitrary SDP records without relying on the sdp 
> library (it is GPLed and thus not useable to some people)

any SDP record registration will have to go over D-Bus in the future and
it will come along with the service registration feature. However none
of this has been set into to stone yet.

> I wrote some code for producing and parsing XML SDP records.  The aim would be 
> to replace the current hcid GetRemoteServiceRecord method with something that 
> produces XML, and also to have something like a RegisterServiceRecord that 
> would take either a string description (e.g. OPUSH) and 
> RegisterServiceRecordXML that would take an XML string.  

The RegisterService... part is under discussion at the moment and I have
no idea how the final outcome will look like. I am okay with having an
additional method that returns the SDP service record in XML format, but
first you would have to define the DTD for it and we have to agree on
it.

> Additionally, a lot of the code that is currently in sdptool.c could be 
> refactored into XML files, and it would be much more trivial to add new 
> profiles (e.g. as an XML template instead of a function inside sdptool)

The record add function of sdptool is actually more a development thing,
than something you should use in real applications. However I am against
adding a dependency on a XML parsing library to sdptool.

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
