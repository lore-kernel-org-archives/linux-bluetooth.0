Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Daniel Vollmer <maven@maven.de>
Reply-To: Daniel Vollmer <maven@maven.de>
Message-ID: <167432047.20040823200031@maven.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Bluetooth Intellimouse Explorer not working after reboot
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 23 Aug 2004 20:00:31 +0200

Hello bluez-users,

I am quite unsure where to report this problem, I suspect it's in
the init-scripts, but neither am I sure it is a bug so I haven't
filed one against bluez-utils.

I'm using an Microsoft Intellimouse Explorer for Bluetooth with
debian/unstable (kernel 2.6.8-mh1 on a Dell Inspiron with internal
bluetooth) and it works fine. But if I reboot the system, the mouse is
not working anymore and I find the following (repeated) in my kern.log:
kernel: hci_acldata_packet: hci0 ACL packet for unknown connection handle 46

The mouse starts workin again if I remove and reinsert its batteries.
I suspect the HID connection is not properly severed on shutting down
the system.

-- 
Best regards,
    Daniel.                         http://www.maven.de
[Jesus saves...Passes to Moses..Shoots....Scores!]



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
