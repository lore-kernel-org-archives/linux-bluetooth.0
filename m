Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200610241647.20895.denis.kenzior@trolltech.com>
References: <200610231025.51818.denis.kenzior@trolltech.com>
	<200610241547.36330.denis.kenzior@trolltech.com>
	<1161677612.10866.138.camel@aeonflux.holtmann.net>
	<200610241647.20895.denis.kenzior@trolltech.com>
Date: Tue, 24 Oct 2006 11:16:35 +0200
Message-Id: <1161681395.10866.148.camel@aeonflux.holtmann.net>
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

> > > Based on your feedback a new DTD specification.  Hopefully it is getting
> > > closer.
> >
> > looks good. However the text about hex encoded is not needed. All number
> > based values can be either in hex or decimal or whatever. We will use
> > the standard encoding to detect it. For example if it starts with 0x
> > then it is hex, otherwise it is decimal.
> 
> Yes, the encoding is only relevant for the <text[8,16,32]> fields.  The rest 
> of the attributes should not have it (this is hard to express in a DTD.)

then don't express it at all. Leave it out. An XML file can be valid
based on its DTD, but still be rejected when stuff is not passing the
semantic requirements.

> > I am also not sure that the encoding attribute is needed. If you wanna
> > encode binary data in text elements (at the moment only HID does this)
> > then you can use \000 style encoding to do so.
> 
> This does not seem to be supported by expat, unless I'm missing something.  I 
> also want to expand encoding to eventually have a base64 option, for space 
> saving.  
> 
> How would this work, do you mean to just recognize if a character starts with 
> \0xxx - Octal
> \xx - Hex?

Use the same logic as printf() is using for example.

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

If I can get an XML parser that only deals with this specific DTD and is
not using expat at all, I am willing to include it right away and make
sdptool use it.

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
