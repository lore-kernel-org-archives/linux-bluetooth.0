Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Mon, 13 Nov 2006 17:03:42 +1000
References: <200610231025.51818.denis.kenzior@trolltech.com>
	<200611091149.13916.denis.kenzior@trolltech.com>
	<1163399836.26272.25.camel@localhost>
In-Reply-To: <1163399836.26272.25.camel@localhost>
MIME-Version: 1.0
Message-Id: <200611131703.43151.denis.kenzior@trolltech.com>
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

> I simply was too lazy to do the full conversion. Thanks for fixing my
> laziness ;)
>
> The only thing that I am not fully agree with is the encoding attribute
> for string. I have to check up on the best way to achieve the support of
> binary strings.
>

>>From what I read, this is the preferred way, but I'm definitely open to 
suggestions.

> The current XML format is for both, but it makes some assumptions and
> simplifications. In 99% of the use cases this is enough and for the
> other 1% you have to deal with the binary format. And this is totally
> fine in case of easy use.

Ok, cool.  I'm just worried about code duplication and maintenance of multiple 
formats.  E.g. looking at the new service framework (which is something that 
we're very interested in for instance), it takes a binary formatted sdp 
record.  Would there also be a version for XML?  

> Actually it should be enough to have support for libexpat and libxml2
> since one of these is required by D-Bus anyway. So I would start with
> libexpat for now. It should be common/sdp-expat.c and I will create the
> autoconf magic around it.

Ok, I will work on a parser based on expat.

Regards,
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
