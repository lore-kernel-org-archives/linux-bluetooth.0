Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jason Van Patten <jvp@lateapex.net>
Message-Id: <200309121505.h8CF5fW04857@localhost.lateapex.net>
To: bluez-users@lists.sourceforge.net
Reply-To: jvp@lateapex.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] IBM Thinkpad A31p and Bluetooth
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 12 Sep 2003 11:05:41 -0400 (EDT)

Hi folks -

I'm trying to get the Bluez bluetooth drivers working in kernel 2.4.22 on my
new IBM Thinkpad A31p.  The laptop has a built-in (miniPCI?) bluetooth
controller in it, but I'm uncertain of the brand/model/etc.

# lsmod
Module                  Size  Used by    Tainted: P  
hci_usb                 9752   0  (unused)
rfcomm                 38080   0  (unused)
l2cap                  19948   1  [rfcomm]
sco                    11084   0  (unused)
bluez                  40676   0  [hci_usb rfcomm l2cap sco]

# hciconfig status
Can't get device info: No such device

# cd /usr/src/linux
# find . -name bluetooth.o -print
# 

Any ideas as to what I can try?  Perhaps I've missed a step or something?

Thanks.

jas
-- 
Jason Van Patten
AOL IM: Jason VP 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
