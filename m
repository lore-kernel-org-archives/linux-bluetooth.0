Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <61103.80.109.89.243.1176072887.squirrel@webmail.uni-ak.ac.at>
Date: Mon, 9 Apr 2007 00:54:47 +0200 (CEST)
From: gerhard.ramsebner@uni-ak.ac.at
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] piscan
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

linux-2.6.20.5@i686
glibc-2.3.6
bluz-libs-3.9
bluez-utils-3.9
Device is an usb brick.

I have 'iscan enable;' and 'pscan enable;' in my device section of
/etc/bluetooth/hcid.conf but a hciconfig check shows that the last value
given overrides the first one. So I have to set it manually: 'hciconf hci0
piscan'.

There is also a pairing issue.
Mac OS 10.4.9 refuses to add it to the list of known devices when the
value of 'security' is not set to 'auto'. (pairing failes) When I change
the value to 'user' afterwards Mac OS doesn't ask me for the key although
the connection gets established. (As far as I know Mac OS does not rememer
it's value.)

Watch out for vicious Easter eggs!


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
