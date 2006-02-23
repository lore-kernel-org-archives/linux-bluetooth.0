Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Message-ID: <E64BAD5A8AD46740828069A678D9DD73011B03@netbe01.net.unimis>
From: "Al" <Al_chane@issc.com.tw>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] ISSC USB dongle can't ping with size 1000
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
Date: Thu, 23 Feb 2006 16:44:48 +0800

Hi,

    I have the same problem as below which was posted last month.

>   I started to play with the ping size. 'ping -s 900' works, 'ping -s =
1000'
> kills the PAN connection. There was hope! Then I played with MTU (on =
both
> sides): 'ifconfig bnep0 mtu 1000' solves all my problems (default is
> 1500)!!! With this setting I've a rock solid 75 kByte/s transfer rate =
over
> ftp. A mtu of 1017 still works, 1018 definitely kills the connection.=20

     I wonder if there is other solutions to this problem cause the =
above solution needs to set MTU to 1000 on both sides.=20

     I try ISSC dongle with IVT software as NAP on Windows XP. Ping with =
size
1500 works fine. It seems ISSC chip has some problems to work with =
BlueZ, in
addition to adding HCI_RESET.

Thanks for helps,

Al=20



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
