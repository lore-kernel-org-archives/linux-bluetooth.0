Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Edd Dumbill <edd@usefulinc.com>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1124658001.1592.21.camel@saag.bunker.heddley.com>
Mime-Version: 1.0
Subject: [Bluez-users] [Fwd: Bug#322732: bluez-utils: rfcomm bind fails with obscure
 error message]
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
Date: Sun, 21 Aug 2005 22:00:01 +0100

A suggestion from a Debian user.

-------- Forwarded Message --------
> From: Peter Hicks <peter.hicks@poggs.co.uk>
> Reply-To: Peter Hicks <peter.hicks@poggs.co.uk>,
> 322732@bugs.debian.org
> To: Debian Bug Tracking System <submit@bugs.debian.org>
> Subject: Bug#322732: bluez-utils: rfcomm bind fails with obscure error
> message
> Date: Fri, 12 Aug 2005 15:16:03 +0100
> 
> Package: bluez-utils
> Version: 2.18-1
> Severity: wishlist
> 
> Hello
> 
> When the 'rfcomm' kernel module isn't compiled with CONFIG_BT_RFCOMM_TTY
> enabled, 'rfcomm bind' will fail with an obscure error message, "Can't
> create device: Operation not supported".  It does this when it's trying to
> bind to a device in /dev.
> 
> Could this be changed to report something more useful, such as "Check
> rfcomm.ko is compiled with TTY support"?
> 
> 
> Peter.



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
