Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] can't get bthid
From: Marcel Holtmann <marcel@holtmann.org>
To: Zi Ming GAO <zimgao@yahoo.com.au>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <408C4D8D.7090104@yahoo.com.au>
References: <408C4D8D.7090104@yahoo.com.au>
Content-Type: text/plain
Message-Id: <1082937237.28880.109.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 26 Apr 2004 01:53:58 +0200

Hi,

>     The problem i'm having is i get the follow error when i try to start 
> bthid,
> 
> Can't connect to HID service: No such file or directory

you must start a bthid daemon instance with "bthid -d" first.

> Now the bluetooth i'm using is the logitech MX900 with the logitech 
> bluetooth dodge. The software i'm using are lib2 and utils2 both from 
> the cvs. I managed to get hid2hci working and from the 
> /proc/bus/usb/devices i can tell the hub is in bluetooth mode. Running 
> "hciconfig hci0 up" to bring the bluetooth interface up, which works 
> fine. "hcid" also ran fine. I could manually linked up the mouse with 
> the hub by using "hcitool cc <mouse address>". Other command such as 
> "hcitool scan" "hcitool inq" all works fine.

Don't play with "hcitool cc". The HCI connection is created automaticly
when needed.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
