Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <6835906b04091701465c5e3c7c@mail.gmail.com>
From: Daniel Scott <danieljamesscott@gmail.com>
Reply-To: Daniel Scott <danieljamesscott@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] MS Optical Desktop for bluetooth - Stops working after a time
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
Date: Fri, 17 Sep 2004 09:46:48 +0100

Hello,

I am using the MS Optical Desktop for Bluetooth (to great success) on
Fedora Core 2, kernel . I do have a minor problem though.

The mouse and keyboard work fine. The problem is that after they are
left inactive for ~30 seconds, they seem to disconnect or 'power save'
and it takes a while for the connection to be re-established. Altering
the 'timeout' using something like:

hidd -t 10

does not help.

Any ideas?

Another minor problem is that I tend to leave my system running
constantly, after ~2 days, the mouse stops working and will not
restart, I have tried replacing the batteries, reconnecting the
devices and restarting the hci0 device (hciconfig hci0 down, hciconfig
hci0 up).

Would restarting hidd help, I cannot find a 'clean' way to shut it
down and I will try killing it and restarting it the next time that it
happens. The only solution that I currently have is a reboot.

Thanks for your time, as I said, they are only minor problems so,
don't worry about it too much.

Thanks,

Dan Scott


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
