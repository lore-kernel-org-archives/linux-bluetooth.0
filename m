Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: David Mackie <D.Mackie@ru.ac.za>
To: bluez-users@lists.sourceforge.net
Message-ID: <20040901130123.GB31321@rucus.ru.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] running 2 rfcomm modules simultaneously
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
Date: Wed, 1 Sep 2004 15:01:23 +0200

Is it possiable to have two rfcomm modules loaded at the same time, each one
with a different PSM values? What I was attempting to do was to modify
rfcomm/core.c and recompile it into a new module, but it seems it is not as
simple as that as can be seen by this kernel Oops while unloading the
module.

Sep  1 01:16:12 warped l2cap_sock_kill: sk deec6380 state 9
Sep  1 01:16:12 warped l2cap_sock_destruct: sk deec6380
Sep  1 01:16:12 warped Unable to handle kernel NULL pointer dereference at
virtual address 00000004
Sep  1 01:16:12 warped printing eip:
Sep  1 01:16:12 warped c020496e
Sep  1 01:16:12 warped *pde = 00000000
Sep  1 01:16:12 warped Oops: 0002 [#1]
Sep  1 01:16:12 warped PREEMPT 

Has anyone done something like this before?

Thanks,

Dave



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
