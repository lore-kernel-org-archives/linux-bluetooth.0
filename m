Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Scott Gilliland <gtg902r@mail.gatech.edu>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1124406281.16439.8.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] current state of Microsoft bluetooth mouse (scroll wheel)
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
Date: Thu, 18 Aug 2005 19:04:40 -0400

I've got a "Microsoft Intellimouse Explorer for Bluetooth", and while it
does mouse properly, neither the scroll wheel or the extra buttons work.
I've just patched my kernel with patch-2.6.12-mh2.gz from
http://www.bluez.org/patches.html, and I have bluetooth-utils 18.1, but
still no luck. I get nothing out of /dev/input/mice for those buttons or
the scroll wheel. 

hidd --show output:
00:0D:3A:A3:C2:5A HID Boot Device [0000:0000] connected [boot-protocol]

Does any one have any clues? Do I need to grab something out of the
bitkeeper repository where the patch came from?

Thanks for any help,
Scott G.



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
