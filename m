Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44FE42C7.7030100@xmission.com>
Date: Tue, 05 Sep 2006 21:38:47 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <554C5F4C5BA7384EB2B412FD46A3BAD10135633A@pdsmsx411.ccr.corp.intel.com>
In-Reply-To: <554C5F4C5BA7384EB2B412FD46A3BAD10135633A@pdsmsx411.ccr.corp.intel.com>
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
Content-Type: multipart/mixed; boundary="===============0207396591=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0207396591==
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit

Lea

> Yes. I prefer modifying alsa_transfer_raw(), which makes the framework logic consistent. How do you think about it? 

I'm not familiar with this new stuff, but it seems that the return
values were commented out for some reason and maybe forgotten. If
Frederic has no problems with the change to alsa_transfer_raw, I'll do
it that way.

Brad


--===============0207396591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0207396591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0207396591==--
