Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Mitsu Hadeishi <mitsu@syntheticzero.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200403022202.19259.mitsu@syntheticzero.com>
Subject: [Bluez-devel] Suspend/resume issues with bluez
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 2 Mar 2004 22:02:19 -0500

Hi, just thought I'd run this issue past you folks.  I'm running the bluez 
stack and utilities from Debian unstable on kernel 2.4.22-x1 (Xandros Desktop 
2) on a Thinkpad T40p.  It seems to run fine when I first boot; I am able to 
discover other devices, they can discover me.  I am a newbie trying to use 
this protocol stack; so I haven't yet gotten any applications to work yet.  
However, it seems to function, basically.

The problem is bluez never seems to work again after a suspend/resume.  I have 
tried shutting down the Bluetooth card (you can do with with Fn-F5 on a 
Thinkpad) before suspending, as well as doing hciconfig hci0 down, and even 
rmmod rfcomm, rmmod hci_usb (rmmod l2cap never seems to work) before 
suspending, and then modprobe them back afterwards.  Though my machine does 
not hang or crash when coming back from suspend, the Bluetooth card never 
works again.  hciconfig -a prints nothing.

Interestingly, before I installed the bluez stack, whenever I hit Fn-F5 it 
would freeze my machine.  Now, it doesn't freeze it, but correctly toggles 
the little LED saying Bluetooth is active/inactive.  When bluez is working, 
Fn-F5 makes hciconfig -a report the device there, then Fn-F5 again will make 
hciconfig -a report nothing.  But after a suspend/resume, Fn-F5 will *still* 
toggle the Bluetooth LED, but hciconfig -a never shows a card.

Rebooting the system causes bluez to work again.

Mitsu
-- 
http://www.syntheticzero.com/



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
