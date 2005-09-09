Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <8a8ea833050909011724f3fcc8@mail.gmail.com>
From: d B <apemaia@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Lost connection and caching
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
Date: Fri, 9 Sep 2005 10:17:54 +0200

Hi all,

I'm using hcitool and bluez libraries to develop a simple application
on PDA and laptop.

I have noticed this behaviour:
I pair two dongles so I can retrieve information such as RSSI, Link quality=
....
If I extract the USB dongle from the laptop, the other one continues
providing  RSSI information, and hcitool con show me that the
connection is still alive.
Only after 10 secs  it recognize the disconnection. I guess there is
cache mechanism.
Where can I get more info about that?
Is there possible to force a refresh when I retrieve connection information=
?


best regards,
dB


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
