Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3967360605082120543847e56d@mail.gmail.com>
From: Robert Brewer <rwb123@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] pairing problem - please help
In-Reply-To: <43005ADB.9040400@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <39673606050813203174545cc1@mail.gmail.com>
	 <42FEDEBA.8060007@xmission.com>
	 <396736060508141923370a6662@mail.gmail.com>
	 <43005ADB.9040400@ubuntu.com>
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
Date: Sun, 21 Aug 2005 23:54:29 -0400

A new post on bluez-devel has answered my question.
The summary is /var/lib/bluetooth/<bd-addr>/linkkeys needed
to be removed.  That solved the problem for me, I am=20
now able to pair my headset under Linux again.

http://sourceforge.net/mailarchive/forum.php?thread_id=3D7999370&forum_id=
=3D1881

Unfortunately Logitech support has been of very little help
for my headset... they pointed me to their standard FAQ list
for WinXP... finally I dragged out of them that the headset
can only pair with 1 device at a time, but no more technical
details than that.

-Rob
--=20
Robert W. Brewer


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
