Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4500A151.9040300@xmission.com>
Date: Thu, 07 Sep 2006 16:46:41 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <554C5F4C5BA7384EB2B412FD46A3BAD10135633A@pdsmsx411.ccr.corp.intel.com>	<44FE42C7.7030100@xmission.com>	<44FE95CE.1090502@palmsource.com>	<1157647703.16404.2.camel@localhost>	<45007741.8020506@xmission.com>
	<1CA2256D-7196-4EE3-AFA5-7EF0BD526D2B@pepper.com>
In-Reply-To: <1CA2256D-7196-4EE3-AFA5-7EF0BD526D2B@pepper.com>
Subject: Re: [Bluez-devel] Big patch to a2dpd
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

Michael

> This new version works great.  Has anyone been able to watch a movie  
> with mplayer?  Playing audio is just fine.  Playing a movie -- the  
> video can not keep up.  Any hints?

latency is pretty bad. if it's at least consistent, you could try the
mplayer prefs to delay the video for whatever fraction of a second it's
off by.

which set is this? i've noticed latency was worse on some of the first
sets out there. we have introduced a lot of latency too with using a
sound server.

brad


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
