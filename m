Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Gareth Reakes <gareth@apache.org>
To: bluez-users@lists.sourceforge.net
Message-ID: <20031128011412.C61007@minotaur.apache.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] Bthid question
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
Date: Fri, 28 Nov 2003 01:24:00 -0800 (PST)

Hey,
	in Marcels version of bthid it seem we go around the while in the
worker method until __io_canceled. At this point we then close the sockets
with a sleep in between them to avoid the ACL connection problem. I added
in some sleeps into Peters code and this made no difference. After looking
into this further (by putting debug at every close statement), a close is
not called after

} else if (!nbytes) {
syslog (LOG_NOTICE, "EOF on Interrupt channel");
shut_down (EXIT_SUCCESS);
}


and my mouse thinks this ACL connection is still open. I have 2 questions:


1)When __io_canceled is true, is this the same as (or at least a case of)
when the above code is called (IE when the mouse goes to sleep)?

2)Why is it in Marcels bthid code that the control and interrupt channels
are shut down in different a order depending on if __io_canceled is true
or not?



Cheers,

Gareth


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
