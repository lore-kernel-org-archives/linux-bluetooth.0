Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5f30e2610609041513o8a2709bifd465e61e946261@mail.gmail.com>
References: <5f30e2610609021024j205f6a51id3d4b3c0f9129a3e@mail.gmail.com>
	<1157318936.32195.9.camel@aeonflux.holtmann.net>
	<5f30e2610609041513o8a2709bifd465e61e946261@mail.gmail.com>
Date: Tue, 05 Sep 2006 11:53:29 +0200
Message-Id: <1157450009.4206.2.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] off-by-one bugfix for sdp_data_alloc
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

Hi Jeff,

> Oh, I get it.  I was looking at where it was published
> (sdp_set_info_attr), but now I see where it's queried (from `sdptool
> browse`).  So maybe this patch is more appropriate.

we can try this. Patch is in the CVS now.

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
