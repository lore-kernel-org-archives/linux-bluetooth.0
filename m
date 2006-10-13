Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <452EF9E8.6020304@xmission.com>
Date: Thu, 12 Oct 2006 20:28:56 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <452E84DA.9090307@free.fr> <452E99E8.6070406@vasmac.com>
In-Reply-To: <452E99E8.6070406@vasmac.com>
Subject: Re: [Bluez-devel] [PATCH] Updated sco flow control feature
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

Jose

> The problem I'm running into now is with dynamic isochronous
> allocation. By default my driver sets interface 1 to use alternative 0
> (i.e. no bandwidth). When the SCO is opened, this is changed to
> alternative 2. All this works great. It's when the SCO is closed or
> a second SCO is opened that causes problems as the bandwidth
> needs to be reallocated.

You're encountering something we need to address anyway for multiple sco
connections. I haven't had a very clear understanding of the alt
setting. It seems that we were setting it to 2 and leaving it there but
maybe it is actually going between 0 and 2 dynamically.

What is a decent uart-connected csr platform to test sco on? I have a
gumstix and a csr module but I'm still struggling the specs at
http://www.semiconductorstore.com/pdf/Bluegiga/esite_wt12.pdf

Brad



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
