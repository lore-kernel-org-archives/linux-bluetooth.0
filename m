Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200610241647.20895.denis.kenzior@trolltech.com>
References: <200610231025.51818.denis.kenzior@trolltech.com>
	<200610241547.36330.denis.kenzior@trolltech.com>
	<1161677612.10866.138.camel@aeonflux.holtmann.net>
	<200610241647.20895.denis.kenzior@trolltech.com>
Date: Mon, 30 Oct 2006 14:27:17 +0100
Message-Id: <1162214837.24333.69.camel@localhost>
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

> > Can also provide an example XML record for a really simple serial port
> > profile. This will help to see how it looks like.
> >
> > Anyone willing to write a really specific and simple XML parser to
> > convert these XML files into sdp_record_t structures. And or course a
> > function that converts this structure back to XML.
> 
> Attached is a sample of OPUSH profile.  Attached also is the code to generate 
> one of these and parse one of these as well (you can use attached sdptool 
> patch to play with it)
> 
> The code is still pretty raw, but it should at least get us started.

to get this started, I like to see the method

string GetRemoteServiceRecordAsXML(string address, uint32 handle)

from the org.bluez.Adapter interface gets implemented and make it using
the simple service-record.dtd I put into the CVS.

I choose to simplify the DTD a lot. After having a discussion about XML
and binary representation from the SDP part of the specification, I am
pretty certain, that we should support both. The binary representation
will cover all tasks ever possible with SDP and it is the default. For
convenience we will additionally support XML as record description, but
it will only cover up to 90% of all cases, but it will be simpler to use
and easier to understand and that should be fine.

This means that all length fields are not represented in XML. They will
be chosen automatically as needed. The same applies to the UUID. So it
leaves only int* and uint* where the actual size will be taken care of
as part of the type name.

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
