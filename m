Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Mar 2008 05:06:49 -0700 (PDT)
From: panca sorin <psihozefir@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <785953.33651.qm@web32608.mail.mud.yahoo.com>
Subject: [Bluez-users] HowTo configure bnep and PANU
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1449482357=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1449482357==
Content-Type: multipart/alternative; boundary="0-222900005-1206014809=:33651"

--0-222900005-1206014809=:33651
Content-Type: text/plain; charset=us-ascii

Hello!
I just installed the 3.28 version of bluez-utils and co. I have a Sony Ericsson K800i 3G cell phone and I'm using it to connect to the Intenet over a USB cable. I want to use Bluetooth instead of that cable. I successfully managed to access phone's memory over Bluetooth and to transfer files. I'm running a vanilla kernel 2.6.23.16 and Gentoo on my amd64 laptop. I have a Bluetooth USB dongle.

The phone is configured to act as a router (i.e has two network interfaces, one connected to the Internet and one connected to my laptop using USB transport). Also, this phone is acting as a NAP while it is providing an Internet connection over Bluetooth. This role is not changable.

Issue #1
I reconfigured the kernel to have support for my dongle and for Bluetooth stack, including BNEP support compiled as module. The module is loaded but the /dev/bnep0 device doesn't exist. AFAIK, udev is supposed to create the device file once the module is loaded, or should I do that?

Issue #2
There is a HOWTO Network on your site that states that "PANU support isn't implemented yet".
I configured the network.service to be autostart.enable=true and configured it to act as PANU. Is the HowTo outdated or not? Let's say I can manage to pass over issue #1. Will I be able to configure the Bluetooth network to act as PANU (I'm not a programmer so I won't be able to write code)?

Thank you in advance for your help!

Sorin.
 



      ____________________________________________________________________________________
Looking for last minute shopping deals?  
Find them fast with Yahoo! Search.  http://tools.search.yahoo.com/newsearch/category.php?category=shopping
--0-222900005-1206014809=:33651
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><div>Hello!<br>I just installed the 3.28 version of bluez-utils and co. I have a Sony Ericsson K800i 3G cell phone and I'm using it to connect to the Intenet over a USB cable. I want to use Bluetooth instead of that cable. I successfully managed to access phone's memory over Bluetooth and to transfer files. I'm running a vanilla kernel 2.6.23.16 and Gentoo on my amd64 laptop. I have a Bluetooth USB dongle.<br><br>The phone is configured to act as a router (i.e has two network interfaces, one connected to the Internet and one connected to my laptop using USB transport). Also, this phone is acting as a NAP while it is providing an Internet connection over Bluetooth. This role is not changable.<br><br>Issue #1<br>I reconfigured the kernel to have support for my dongle and for Bluetooth stack,
 including BNEP support compiled as module. The module is loaded but the /dev/bnep0 device doesn't exist. AFAIK, udev is supposed to create the device file once the module is loaded, or should I do that?<br><br>Issue #2<br>There is a HOWTO Network on your site that states that "PANU support isn't implemented yet".<br>I configured the network.service to be autostart.enable=true and configured it to act as PANU. Is the HowTo outdated or not? Let's say I can manage to pass over issue #1. Will I be able to configure the Bluetooth network to act as PANU (I'm not a programmer so I won't be able to write code)?<br><br>Thank you in advance for your help!<br><br>Sorin.<br> </div></div><br>



      <hr size=1>Never miss a thing.  <a href="http://us.rd.yahoo.com/evt=51438/*http://www.yahoo.com/r/hs"> Make Yahoo your homepage.</a></body></html>
--0-222900005-1206014809=:33651--


--===============1449482357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1449482357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1449482357==--
