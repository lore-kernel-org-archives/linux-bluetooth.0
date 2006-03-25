Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <001201c65019$a757a020$6280a8c0@clytemnestra>
From: "Alec Myers" <alec@fridge-news.co.uk>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Bluez-users] Debian: rfcomm connection at boot: how?
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
Date: Sat, 25 Mar 2006 14:37:27 -0000

A question from a Linux novice. I have bluez installed and working fine on 
Debian (3.1r1).

I manually create a connection to my remote device with

   hcitool cc xx:xx:xx:xx:xx:xx

then hook it up to /dev/rfcomm0 with

    rfcomm bind 0 xx:xx:xx:xx:xx:xx 1

I'd like these two commands to execute at boot up. Is it possible to put 
them in, for instance, /etc/default/bluez-utils ? If so, what would the 
syntax be? If not then what's the 'right' way to do it? Do I need to write a 
shell script and install it with rc-update etc?

Many thanks! 




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
