Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <408C4D8D.7090104@yahoo.com.au>
From: Zi Ming GAO <zimgao@yahoo.com.au>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] can't get bthid
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
Date: Mon, 26 Apr 2004 09:45:17 +1000

Hey guys,
    The problem i'm having is i get the follow error when i try to start 
bthid,

Can't connect to HID service: No such file or directory

Now the bluetooth i'm using is the logitech MX900 with the logitech 
bluetooth dodge. The software i'm using are lib2 and utils2 both from 
the cvs. I managed to get hid2hci working and from the 
/proc/bus/usb/devices i can tell the hub is in bluetooth mode. Running 
"hciconfig hci0 up" to bring the bluetooth interface up, which works 
fine. "hcid" also ran fine. I could manually linked up the mouse with 
the hub by using "hcitool cc <mouse address>". Other command such as 
"hcitool scan" "hcitool inq" all works fine.

I had problems previously getting hid2hci working. And it's due to the 
fact that i'm running on a customised linux and i forgot to enable usb 
raw hid access. anyway ... under my dev i have
/dev/misc/uinput
/dev/input/hid/hiddev[0..15]
and also other rfcomms and other bluetooth essentials under /dev
i also updated modprobe.inf with bluetooth alias from other posts

from what i understand bthid should be accessing the uinput device ...
is there other devices that bthid requires???
because the error message looks like i'm missing a devices file somewhere
or probably forgot to compiled in something necessory ...

anyway any help will be appreciated ... thanks ...


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
