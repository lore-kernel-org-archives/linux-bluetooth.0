Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <416F8FE1.7060509@avantwave.com>
From: mike <mikelee@avantwave.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] About serial interface bluetooth module
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
Date: Fri, 15 Oct 2004 16:52:49 +0800

Dear All

    I am new to bluez, Here are some questions on serial driver 
hci_uart.And i am using Fedora2 with bluez-lib-2.10 bluez-util-2.10

    I am now using a serial bluetooth module, after i install bluez-lib 
and bluez-util. I can see the rfcomm,l2cap,bluetooth module is loaded. 
but no hci_uart module.
    and when i use hciattach /dev/ttyS0......... to attach the serial 
module, it fail and reply "Initialization timed out". After i insmod 
hci_uart.ko from /lib/module . It is just the same.

    The module is work well in MS window and the cable is checked. am i 
use wrong version or any steps i missed?


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
