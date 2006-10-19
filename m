Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 19 Oct 2006 12:13:31 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200610191334.25362.denis.kenzior@trolltech.com>
Message-ID: <Pine.LNX.4.63.0610191205320.29304@redbean.intranet.gw-instruments.de>
References: <200610191334.25362.denis.kenzior@trolltech.com>
MIME-Version: 1.0
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

On Thu, 19 Oct 2006, Denis KENZIOR wrote:

> I've been playing around with the idea of encapsulating SDP information over 
> XML.  The primary aim was to enable things like sdptool or hcid to be able to 
> exchange SDP records in an open format.  It would also enable for 
> applications to register arbitrary SDP records without relying on the sdp 
> library (it is GPLed and thus not useable to some people)
> 
> I wrote some code for producing and parsing XML SDP records.  The aim would be 
> to replace the current hcid GetRemoteServiceRecord method with something that 
> produces XML, and also to have something like a RegisterServiceRecord that 
> would take either a string description (e.g. OPUSH) and 
> RegisterServiceRecordXML that would take an XML string.  
> 
> Additionally, a lot of the code that is currently in sdptool.c could be 
> refactored into XML files, and it would be much more trivial to add new 
> profiles (e.g. as an XML template instead of a function inside sdptool)
> 
> Before I continue, I'd like to get some feedback on the direction I should 
> take.  What would be most useful to BlueZ?  Would there be any interest in a 
> patch against hcid that does this?

In my opinion anything which replaces the current SDP record handling 
would be great. I've tried to count the mallocs and frees done just for 
registering a single service record,..... gave up somewhere in the middle. 

I remember there was an implementation which uses XML in the past, 
but I think this was not for Bluez. May be XML is a little bit of an 
overkill, but on the other hand it is a well established and flexible data 
format.  

Short answer: yes. 

Ciao, 

Peter 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
