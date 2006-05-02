Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <a3b1b800605020306t7a8f55cag75ccff8757c93741@mail.gmail.com>
From: "Jan Benes" <jbenes@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] hci_inquiry length problems
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
Date: Tue, 2 May 2006 12:06:38 +0200

Hello,
I'm calling hci_inquiry periodically with a len of 4x 1,2 sec. But it
seems the function ignores this and goes always for about 8-15
seconds. If there are around 20 devices, it even takes way too long
(over a minute). I've noticed the same behaviour with the command line
tool "hcitool scan". What's wrong? I have a MSI dongle (with a
broadcom chipset I believe).

PS: I've chcecked the code for the hci_inquire but the len parameter
is jsut passed to the ioctl function.

thanks


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
