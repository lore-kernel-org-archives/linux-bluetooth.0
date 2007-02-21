Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: CIJOML <cijoml@volny.cz>
In-Reply-To: <200702212224.47446.cijoml@volny.cz>
References: <200702212224.47446.cijoml@volny.cz>
Date: Wed, 21 Feb 2007 23:06:39 +0100
Message-Id: <1172095599.7403.45.camel@violet>
Mime-Version: 1.0
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Phis in /proc/bus/input/devices same for all
	devices?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Michal,

> I use 2.6.20-mh1 patch and would like to differ devices based on Phis, but it 
> is the same for all devices??
> 
> I: Bus=0005 Vendor=045e Product=007c Version=0035
> N: Name="Microsoft Five Button Mouse"
> P: Phys=00:0D:88:8E:AB:2F
> S: Sysfs=/class/input/input19
> H: Handlers=mouse1 event6
> B: EV=7
> B: KEY=1f0000 0 0 0 0 0 0 0 0
> B: REL=103
> 
> I: Bus=0005 Vendor=045e Product=007b Version=0039
> N: Name="Microsoft Bluetooth keyboard"
> P: Phys=00:0D:88:8E:AB:2F
> S: Sysfs=/class/input/input20
> H: Handlers=kbd event7
> B: EV=12000b
> B: KEY=10f80 44007 ffe01878 800d7ff febeffdf f3cfffff ffffffff fffffffe
> B: ABS=700 0
> B: LED=107
> 
> I: Bus=0005 Vendor=046d Product=b3e3 Version=2503
> N: Name="Logitech Bluetooth Mediapad"
> P: Phys=00:0D:88:8E:AB:2F
> S: Sysfs=/class/input/input21
> H: Handlers=kbd event8
> B: EV=12000f
> B: KEY=7fff 2c3027 bf004440 0 0 1 10f80 8807c007 ffe67bfa d9415fff febeffdf 
> ffefffff ffffffff fffffffe
> B: REL=40
> B: ABS=301 0
> B: LED=1f
> 
> Shouldn't be there it's BDADDR?

please post this question to LKML. I am not sure that is the right
approach. Currently we fill in phys and uniq like this:

        strncpy(hid->phys, batostr(&src), 64);
        strncpy(hid->uniq, batostr(&dst), 64);

Maybe the input or HID subsystem should be changed to also export the
uniq values to udev.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
