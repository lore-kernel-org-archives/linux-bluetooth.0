Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Edd Dumbill <edd@usefulinc.com>
To: bluez-users@lists.sourceforge.net
Message-Id: <1086618157.32217.54.camel@saag>
Mime-Version: 1.0
Content-Type: text/plain
Subject: [Bluez-users] Nokia SU-1B digital pen
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
Date: Mon, 07 Jun 2004 15:22:37 +0100

I just succeeded in getting one of these pens paired with Linux, running
BlueZ.  Here's a write-up of what I did:
http://usefulinc.com/edd/blog/contents/2004/06/07-nokia-su-1b/read

I basically made a hacky misuse of dund to emulate the modem of a
cellphone, which the pen needs to contact in order to get
manuf/model/version information.  The writeup contains a link to the
hack.

After pairing, it works fine with regular OBEX PUSH.

-- Edd




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
