Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Jorge A." =?ISO-8859-1?Q?Gonz=E1lez?= <egrojorge@terra.es>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1086041772.4690.9.camel@pegasus>
References: <40BBAC4D.2070403@cc.hut.fi>  <1086041772.4690.9.camel@pegasus>
Content-Type: text/plain
Message-Id: <1086094686.25098.11.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-users] weird problem with rfcomm
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
Date: Tue, 01 Jun 2004 14:58:06 +0200

I have a very strange problem with rfcomm:

I have a "rfcomm listen hci0" waiting for a connection running in my
uclinux machine.

When other device (a PDA or a linux PC) tries to connect to it, it
doesn't connect... until another device also tries to connect, and then
the first device that was trying to connect gets the connection and they
can transmit fine.

Has anyone had a similar situation when you need to "help" with another
device to do the connection??

In the other way, (connecting to another waiting device) the connection
works without problem.


There are times when it doesnt have this problem, but when the problem
appears, it doesnt works normally until a reset.

Any hint or idea about the problem???

Lot of thanks!!

Jorge



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
