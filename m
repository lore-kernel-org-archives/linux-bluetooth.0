Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <37f261b0601282344k416742d1j@mail.gmail.com>
From: Hugo van der Merwe <hugovdm@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <37f261b0601120821t3b0449f4me94b7b73707d49a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <37f261b0601090736w6d7157d6x6ea876ecafb3572e@mail.gmail.com>
	 <37f261b0601120320n516e7466ld95aa0b2d1ac9f83@mail.gmail.com>
	 <37f261b0601120821t3b0449f4me94b7b73707d49a8@mail.gmail.com>
Subject: [Bluez-users] Re: Two "identical" laptops, same phone, one works, one doesn't
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
Date: Sun, 29 Jan 2006 09:44:19 +0200

For the record, for future reference by other people having similar
problems, I've solved this problem, with the help of a tip from a
friend. He said I should wipe /var/lib/bluetooth/* to start from
scratch. That solved the problem.

Very odd, iirc: the bluetooth directory contained one directory, which
was the bdaddr of a second phone I tested, not the one I'm now using
with the laptop. Surprised that /var/lib/bluetooth/* could have
anything to do with it then...

Anyway, the tip of wiping /var/lib/bluetooth/* was as a solution to
the "Can't connect RFCOMM socket: Connection refused" error message.

Thanks,
Hugo


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
