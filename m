Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ca2c963d0604181906o5410e592i6aa80464e3cf79c7@mail.gmail.com>
From: "Rohit Chaudhri" <rohit.chaudhri@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] BlueZ on devices with Broadcom chipset
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
Date: Tue, 18 Apr 2006 21:06:37 -0500

Hello,
I am using BlueZ on a few embedded linux (2.4.20 kernel) devices that
have the Broadcom chipset. When doing device discovery I see that most
BT devices in the vicinity get detected, however everytime some of my
devices running BlueZ on the broadcom chipset donot get detected, all
the devices are very close to each other, i.e within coverage.
Looking at the BlueZ website I found that there is a bluez-firmware
package available. Do I need to do a firmware upgrade on my devices to
resolve this problem? If so, can some one please tell me how to apply
the firmware upgrade on the device? I've downloaded and built the
bluez-firmware package and I have a .hex & .bin file in my
install-dir, however I don't understand how to apply the firmware
upgrade to the chipset.
Would appreciate any help regarding this.

Thanks!


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
