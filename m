Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Ned Lowe" <ned@nedlowe.co.uk>
To: <bluez-users@lists.sourceforge.net>
Message-ID: <000101c44b92$64dcb1f0$0202a8c0@chumpi>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [Bluez-users] Connects... Then disconnects
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
Date: Sun, 6 Jun 2004 07:49:17 +0100

Dear all,

I was hoping you could help me with a rather annoying problem I am
experiencing.

I have just set up the Belkin F8T003 Bluetooth USB Adapter under
Mandrake 10.0.  I am trying to connect (not simultaneously) to two
machines, one XP and the other an Apple PowerBook.

I can connect from Linux to my XP box no problem:

rfcomm connect rfcomm0 xx:xx:xx...

I can *see* my Apple PowerBook Bluetooth adapter from Linux and
vice-versa, and can pair from the PowerBook.  However if I run the above
command:

rfcomm connect rfcomm0 yy:yy:yy...

for the PowerBook connection, then I get:

Can't connect RFCOMM socket: Connection refused

The funny thing is that the PowerBook connection listing shows a
connection being established for about one second, then loses it.

Any ideas?

Thanks a lot,
Ned Lowe



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
