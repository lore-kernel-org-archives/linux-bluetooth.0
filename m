Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Fri, 20 Oct 2006 11:27:15 +1000
References: <200610191334.25362.denis.kenzior@trolltech.com>
	<1161249153.27710.5.camel@localhost>
In-Reply-To: <1161249153.27710.5.camel@localhost>
MIME-Version: 1.0
Message-Id: <200610201127.15801.denis.kenzior@trolltech.com>
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

Marcel,

On Thursday 19 October 2006 19:12, Marcel Holtmann wrote:
> any SDP record registration will have to go over D-Bus in the future and
> it will come along with the service registration feature. However none
> of this has been set into to stone yet.
>

I'd be very interested in learning what has been proposed so far for doing 
this.  We'd be very much interested in a flexible architecture, allowing us 
to specify dynamic records.  E.g. things like Handsfree profile requires SDP 
records with supported features attributes.  This is something that we just 
cannot do currently with the existing infrastructure.

> The RegisterService... part is under discussion at the moment and I have
> no idea how the final outcome will look like. I am okay with having an
> additional method that returns the SDP service record in XML format, but
> first you would have to define the DTD for it and we have to agree on
> it.

I shall work on forming a DTD.  It most likely will closely follow the BlueZ 
type structure.  Should I work on the patch for registering/unregistering XML 
SDP records against hcid as well?

>
> > Additionally, a lot of the code that is currently in sdptool.c could be
> > refactored into XML files, and it would be much more trivial to add new
> > profiles (e.g. as an XML template instead of a function inside sdptool)
>
> The record add function of sdptool is actually more a development thing,
> than something you should use in real applications. However I am against
> adding a dependency on a XML parsing library to sdptool.
>

I completely agree.  However, up to this point sdptool has been the only way 
to develop "real applications."  Using sdp library directly is not an option 
for us.  

> Regards
>
> Marcel

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
