Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] running 2 rfcomm modules simultaneously
From: Marcel Holtmann <marcel@holtmann.org>
To: David Mackie <D.Mackie@ru.ac.za>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040901130123.GB31321@rucus.ru.ac.za>
References: <20040901130123.GB31321@rucus.ru.ac.za>
Content-Type: text/plain
Message-Id: <1094998092.5695.19.camel@pegasus>
Mime-Version: 1.0
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
Date: Sun, 12 Sep 2004 16:08:12 +0200

Hi David,

> Is it possiable to have two rfcomm modules loaded at the same time, each one
> with a different PSM values? What I was attempting to do was to modify
> rfcomm/core.c and recompile it into a new module, but it seems it is not as
> simple as that as can be seen by this kernel Oops while unloading the
> module.
> 
> Sep  1 01:16:12 warped l2cap_sock_kill: sk deec6380 state 9
> Sep  1 01:16:12 warped l2cap_sock_destruct: sk deec6380
> Sep  1 01:16:12 warped Unable to handle kernel NULL pointer dereference at
> virtual address 00000004
> Sep  1 01:16:12 warped printing eip:
> Sep  1 01:16:12 warped c020496e
> Sep  1 01:16:12 warped *pde = 00000000
> Sep  1 01:16:12 warped Oops: 0002 [#1]
> Sep  1 01:16:12 warped PREEMPT 
> 
> Has anyone done something like this before?

this is not possible this way. It needs more changes to provide such a
functionality and you must keep it inside the RFCOMM module. Why do you
need it?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
