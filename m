Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200611131703.43151.denis.kenzior@trolltech.com>
References: <200610231025.51818.denis.kenzior@trolltech.com>
	<200611091149.13916.denis.kenzior@trolltech.com>
	<1163399836.26272.25.camel@localhost>
	<200611131703.43151.denis.kenzior@trolltech.com>
Date: Mon, 13 Nov 2006 08:17:45 +0100
Message-Id: <1163402265.26272.29.camel@localhost>
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

> > The current XML format is for both, but it makes some assumptions and
> > simplifications. In 99% of the use cases this is enough and for the
> > other 1% you have to deal with the binary format. And this is totally
> > fine in case of easy use.
> 
> Ok, cool.  I'm just worried about code duplication and maintenance of multiple 
> formats.  E.g. looking at the new service framework (which is something that 
> we're very interested in for instance), it takes a binary formatted sdp 
> record.  Would there also be a version for XML?  

yes, there will be a XML version for registering SDP records. However
someone has to write it.

> > Actually it should be enough to have support for libexpat and libxml2
> > since one of these is required by D-Bus anyway. So I would start with
> > libexpat for now. It should be common/sdp-expat.c and I will create the
> > autoconf magic around it.
> 
> Ok, I will work on a parser based on expat.

Add the function prototypes to common/sdp-xml.h and the actual
implementation to common/sdp-expat.c and an implementation that returns
an error to common/sdp-dummy.c to make it compile with systems where the
Expat library is not available.

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
