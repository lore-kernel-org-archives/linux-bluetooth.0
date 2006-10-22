Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <453BAAFC.1090206@vasmac.com>
Date: Sun, 22 Oct 2006 13:31:40 -0400
From: Jose Vasconcellos <jose@vasmac.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <452E84DA.9090307@free.fr>	<452E99E8.6070406@vasmac.com>	<452FBC82.1080901@free.fr>	<452FDC44.90803@vasmac.com>	<45310A24.1000604@free.fr>	<453114A0.50503@vasmac.com>
	<453B9F4D.7080504@free.fr>
In-Reply-To: <453B9F4D.7080504@free.fr>
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

Hi Fabien,

You need to get the IEEE 802.15.1 specification. Go to here:
http://standards.ieee.org/getieee802/802.15.html
Section 11.4 talks about HCI flow control. I don't see that
this facility is optional. In the case of USB, it's different
because another mechanism exists for flow control.

Has anyone every used SCO with a UART link?

Jose


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
