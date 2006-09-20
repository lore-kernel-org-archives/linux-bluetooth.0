Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4510A272.6000402@vasmac.com>
Date: Tue, 19 Sep 2006 22:07:46 -0400
From: Jose Vasconcellos <jose@vasmac.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="------------090004010808090007020603"
Subject: [Bluez-devel] SCO flow control patches
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090004010808090007020603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Last May, Fabien Chevalier posted some SCO flow control patches
(now included in bluetooth-alsa). I've tried these in Ubuntu 6.06
(based on kernel 2.6.15.7) without much luck. My problem is that
packets are sent every 50ms. Anyone else tried these?

I do agree that it should be the responsibility of the driver to take
care of any timing issues. But it's not clear to me why this is not
done in the hci_usb driver.

Jose

--------------090004010808090007020603
Content-Type: text/x-vcard; charset=utf-8;
 name="jose.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="jose.vcf"

begin:vcard
fn:Jose Vasconcellos
n:Vasconcellos;Jose
org:Vas & Mac Enterprises LLC
adr:;;P.O. Box 567;Red Bank;NJ;07701;USA
email;internet:jose@vasmac.com
title:Managing Member and CTO
tel;work:+1 732 978 4680 x102
tel;fax:+1 206 888 6951
url:http://www.vasmac.com
version:2.1
end:vcard


--------------090004010808090007020603
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------090004010808090007020603
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------090004010808090007020603--
