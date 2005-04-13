Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Thomas Nemeth <thomas.nemeth@betatech.fr>
Message-ID: <loom.20050413T144754-221@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Logitech MX900 and hid2hci/hidp
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 13 Apr 2005 13:03:40 +0000 (UTC)

Hi ! 
 
I've got a quite big problem. I need to make a logitech mouse MX900 work 
with a 2.4.20 kernel (because my customer ask me to : he don't want to 
change the kernel because of validation his company has made). 
 
I got the 2.4.20 sources and the config used by my customer, applyed the 
-mh18 patch to it, selected all bluetooth drivers and input core, usb stuff... 
Compiled it, installed it and its modules, all went ok. 
 
When I modprobe hidp (after all other needed modules), all seems ok. I run 
hid2hci and it reports to have successfully switched device 046d:c705 to HCI 
mode. 
 
Anyway, hcid does not report hci0 (I only have 1 bluetooth device by now) 
beeing seen neither configured. hcitool scan reports : 
"Device is not available: Success" witch is a bit strange. 
 
I have all the /dev stuff needed (I think) : 
/dev/usb/hiddev* 
/dev/input/uinput (just in case) 
(can't remember if I created some other device) 
 
I mounted /proc/bus/usb too... 
 
I looked at the hcitool sources, bluetooth library and found that the 
HCIGETDEVLIST ioctl command gave no results. So the problem seems to be 
between hidp, hcid and hid2hci... 
 
Is there any mean to make this mouse work with a 2.4.20 ? 
Did I miss something ? 
 
Thank you in advance... 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
