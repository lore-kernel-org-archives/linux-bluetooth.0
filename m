Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 1 Oct 2007 15:40:23 +0200
From: Andreas Gaufer <Andreas.Gaufer@bluecellnetworks.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20071001154023.53e57c49@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.63.0708241410030.12067@redbean.intranet.gw-instruments.de>
References: <2EB6297382462046A9427D7324788A480217D35A@MCLNEXVS06.resource.ds.bah.com>
	<8de6c3e20708231340j439ca230i487e816693149441@mail.gmail.com>
	<1187964393.5121.10.camel@matthias.BEYONDSOFT.local>
	<Pine.LNX.4.63.0708241410030.12067@redbean.intranet.gw-instruments.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary=Multipart_Mon__1_Oct_2007_15_40_23_+0200_zwD2TIEQhBtLbL1a
Subject: [Bluez-devel] [PATCH]Re:  multithreaded name resolution
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--Multipart_Mon__1_Oct_2007_15_40_23_+0200_zwD2TIEQhBtLbL1a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 24 Aug 2007 14:14:53 +0200 (CEST)
Peter Wippich <pewi@gw-instruments.de> wrote:

> 
> Hi Matthias,
> 
> On Fri, 24 Aug 2007, Matthias Becker wrote:
> 
> > Hi,
> > 
> > I tried to read the name of different devices parallel using multi
> > threading, but without success. If there is one bluetooth device I works
> > (as there is no real multi threading). If there are who devices, the
> > same name is reported for both devices. In another test with 6 devices
> > hci_read_remote_name returned something <0 so I did not get any name at
> > all.
> 
> this won't work. Asking for the name of a device is some sort of 
> connection setup, and most (all ?) Bt chips do not allow / can not handle 
> parallel connection setups (even though parallel connections are 
> possible). 
> 
> So don't try further, the problem is outside your code (and even BlueZ). 
> 

That's not true, the reported behavior is produced by bluez-libs. I already
sent a patch to fix it and will attach that patch again to this mail.

Please let me know if that Patch fixes your problem Matthias.

Greetings

Andy

See also:
http://thread.gmane.org/gmane.linux.bluez.devel/12491
--Multipart_Mon__1_Oct_2007_15_40_23_+0200_zwD2TIEQhBtLbL1a
Content-Type: application/octet-stream;
	name=bluez-libs-3.19-EVT_REMOTE_NAME_REQ_COMPLETE.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=bluez-libs-3.19-EVT_REMOTE_NAME_REQ_COMPLETE.patch

ZGlmZiAtdXIgYmx1ZXotbGlicy0zLjE5LU9SRy9zcmMvaGNpLmMgYmx1ZXotbGlicy0zLjE5L3Ny
Yy9oY2kuYwotLS0gYmx1ZXotbGlicy0zLjE5LU9SRy9zcmMvaGNpLmMJMjAwNy0xMC0wMSAxMTow
NjoxOC4wMTM0Nzk1NzYgKzAyMDAKKysrIGJsdWV6LWxpYnMtMy4xOS9zcmMvaGNpLmMJMjAwNy0x
MC0wMSAxNToxOTozNi4zMDE5ODg1MjggKzAyMDAKQEAgLTEwMTAsNiArMTAxMCw4IEBACiAJd2hp
bGUgKHRyeS0tKSB7CiAJCWV2dF9jbWRfY29tcGxldGUgKmNjOwogCQlldnRfY21kX3N0YXR1cyAg
ICpjczsKKwkJZXZ0X3JlbW90ZV9uYW1lX3JlcV9jb21wbGV0ZSAqcm47CisJCXJlbW90ZV9uYW1l
X3JlcV9jcCAqY3A7CiAKIAkJaWYgKHRvKSB7CiAJCQlzdHJ1Y3QgcG9sbGZkIHA7CkBAIC0xMDc0
LDYgKzEwNzYsMjEgQEAKIAkJCW1lbWNweShyLT5ycGFyYW0sIHB0ciwgci0+cmxlbik7CiAJCQln
b3RvIGRvbmU7CiAKKwkJY2FzZSBFVlRfUkVNT1RFX05BTUVfUkVRX0NPTVBMRVRFOgorCisJCQlp
ZiAoaGRyLT5ldnQgIT0gci0+ZXZlbnQpCisJCQkJYnJlYWs7CisKKwkJCXItPnJsZW4gPSBNSU4o
bGVuLCByLT5ybGVuKTsKKwkJCW1lbWNweShyLT5ycGFyYW0sIHB0ciwgci0+cmxlbik7CisKKwkJ
CXJuID0gci0+cnBhcmFtOworCQkJY3AgPSByLT5jcGFyYW07CisKKwkJCWlmIChiYWNtcCgmcm4t
PmJkYWRkciwmY3AtPmJkYWRkcikgPT0gMCkKKwkJCQlnb3RvIGRvbmU7CisJCQljb250aW51ZTsK
KwogCQlkZWZhdWx0OgogCQkJaWYgKGhkci0+ZXZ0ICE9IHItPmV2ZW50KQogCQkJCWJyZWFrOwo=

--Multipart_Mon__1_Oct_2007_15_40_23_+0200_zwD2TIEQhBtLbL1a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--Multipart_Mon__1_Oct_2007_15_40_23_+0200_zwD2TIEQhBtLbL1a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Multipart_Mon__1_Oct_2007_15_40_23_+0200_zwD2TIEQhBtLbL1a--
