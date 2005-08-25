Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: <bluez-users@lists.sourceforge.net>
From: Russell Senior <seniorr@aracnet.com>
Message-ID: <86wtmajyvx.fsf@coulee.tdb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] rfcomm bind as unpriveledged user?
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
Date: 24 Aug 2005 23:48:02 -0700


Is it possible to rfcomm bind as an unpriveledged user?  My naive
attempts, e.g.:

  $ rfcomm bind 0 xx:xx:xx:xx:xx:xx
  Can't create device: Operation not permitted

... are obviously not working.  Works fine as root.

This is on a Debian/unstable box, custom-compiled vanilla kernel
v2.6.12.4, with udev 0.068-1.

Any hints?

Thanks!

-- 
Russell Senior         ``I have nine fingers; you have ten.''
seniorr@aracnet.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
