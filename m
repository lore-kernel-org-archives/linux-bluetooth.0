Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3F66141E.6050201@libcon.net>
From: =?ISO-8859-1?Q?Fredrik_Hallg=E5rde?= <fredrik@libcon.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Anyone using a NEC e606 and BlueZ?
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
Date: Mon, 15 Sep 2003 21:33:50 +0200

Hi!

I have serious problems keeping the ppp-connection via bluetooth.
The system is as follows:
mh3-patched Linux 2.4.21
IOGEAR GBU-301 (USB BC2033)
NEC e606 (3G/UMTS) Mobile

Using bluefw I get hci0 working.
Binding with rfcomm works.
I connect with rp3-config (RedHat ppp-dialer config)
the connection comes up, setting routing etc.
after a few moments (10-30 sec) te connection dies.

After that the bluetooth device seems stop working...


Any ideas? Any part of BlueZ kernelpatches I must have? (I think I 
didn't put i zero-packets) Should I post any specific dumps/logfiles?


TIA

Fredrik

-- 
********************
Fredrik Hallgårde
fredrik@libcon.net




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
