Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <446208DD.1050207@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP  and VDP for BlueZ
References: <20060510151310.29728.qmail@web26907.mail.ukl.yahoo.com>
In-Reply-To: <20060510151310.29728.qmail@web26907.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 10 May 2006 09:38:05 -0600

javier

> On the other hand, I'd like to know if you had studied the Video
> Distribution Profile (VDP). At first, my objetives were to develop the
> A2DP or, if it was already implemented, the VDP. Therefore, I'm
> interested in knowing if you have implemented something similar to
> a2play for A2DP.

I have not read much about vdp. At least it uses a common codec (h.263)
so you won't have to write codec code I think.

There are no vdp devices out there so you would have to write the sender
and the receiver to see results.

I would suggest you write your stuff as a new app "vplay" that is
modeled after a2play (and vrecv modeled after a2recv).

Brad


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
