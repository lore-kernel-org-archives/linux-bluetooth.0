Return-Path: <linux-usb-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <7BCD17BB75C4464D866EB5A20D5E889E987F70@HYD-MKD-MBX01.wipro.com>
From: <rao.shalini@wipro.com>
To: <bluez-devel@lists.sourceforge.net>,
   <linux-usb-devel@lists.sourceforge.net>
Subject: [linux-usb-devel] problem in linux 2.6.9-11
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
Date: Sun, 25 Sep 2005 16:21:14 +0530
List-ID: <bluez-devel.lists.sourceforge.net>

Hi,

Since 3 months we have been using RHEL4 and recently we have upgraded to
RHEL 4 Update1 with kernel 2.6.9-11. We are working on USB mobiles and
tried to use usb-serial module which is available. But we are facing
problem with this modules as given below.

We are using Kermit application to write AT command to the Mobile, if AT
command is given it works fine. But its giving problem, when mobile is
charging and tried to give AT+CFUN=3D0 to turn off the mobile, after =
this
we are not able to open the device until we disconnect and connect it
again.=20

Since this AT+CFUN=3D0 is very much relevant in our application we =
should
be able to do this without any problem.

One more observation on usbserial module which is working fine with
linux kernel 2.6.5-11, whereas with kernel 2.6.9-11 is giving kernel
panic for disconnect function.=20
=20
Please give us suggestions on this.


Thanks,

Shalini G=20



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
