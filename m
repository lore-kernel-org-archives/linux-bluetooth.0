Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <451A1A54.3020903@brainhub.org>
Date: Tue, 26 Sep 2006 23:29:40 -0700
From: Andrey Jivsov <bluetooth@brainhub.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Microsoft IntelliMouse with kernel 2.6.18 and
 patch-2.6.18-mh1 is broken (fix provided)
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

Here is my report on successfully configuring IntellMiouse. Also it's a 
bug report on latest bluez patch that breaks this mouse.


Microsoft IntelliMouse Explorer for Bluetooth had decent support in 
older version of kernel patch, I believe patch-2.6.15-mh2. I could use 
scroll wheel and additional buttons. The only issues that I could not 
solve satisfactory were smooth activation from sleep, on boot, and 
after a timeout. "Smooth" means without reseting the mouse every time by 
pressing small button on its bottom.

I decided to give a try to the latest kernel 2.6.18 with Fedora Core 5 
and patch-2.6.18-mh1 with latest bluez tools. The start appeared 
promising: unpatched kernel 2.6.18 with FC5 and bluez 2.25 enables 
IntelliMouse via Boot protocol with the resumption from sleep working! 
This is an improvement from earlier versions. This doesn't bring the 
closure, though, because the boot protocol lacks the support for scroll 
wheel and additional buttons.

I upgraded to bluez 3.5 but this didn't make any difference. I then 
patched the kernel with patch-2.6.18-mh1. This killed the mouse:  the 
cursor would not move.

I finally was able to solve the problem by using the  previous 
patch-2.6.15-mh2 against the 2.6.18 kernel with minor cleanup.  The 
patch is here:

    http://www.brainhub.org/patch-2.6.18-mh1aj.bz2

Note that it will produce a few harmless warnings.

The above steps result in fully functional IntelliMouse.

Here is the rest of steps needed to fix the resumption from the sleep.

* set this in the rc.local:

      /usr/local/sbin/hcid
      /usr/local/bin/hidd -t 10 --connect 00:50:F2:E8:E0:71 --server
      /usr/local/sbin/hciconfig hci0 down
      usleep 500000
      /usr/local/sbin/hciconfig hci0 up


* Set this in the "sleep script":
     before sleep:
      /usr/local/bin/hidd --killall
      echo disable > /proc/acpi/ibm/bluetooth
      /sbin/rmmod hci_usb

    after sleep:
      /sbin/modprobe hci_usb
      echo enable > /proc/acpi/ibm/bluetooth

Sleep steps above may not be needed at all with your hardware and 
distribution.

Many people suggested to use "hidd --connect 00:50:F2:E8:E0:71" alone. 
It never work for me. Seems like hciconfig hci0 down/up made the difference.

I hope this helps.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
