Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: O Plameras <oscarp@acay.com.au>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   shemminger@osdl.org
In-Reply-To: <415C8B5B.3060400@acay.com.au>
References: <E1CA5Ze-0006Iu-R6@paris.servershost.net>
	 <cjad82$qji$1@sea.gmane.org> <1096371695.4950.2.camel@notepaq>
	 <cje512$kj5$1@sea.gmane.org> <1096494023.6380.0.camel@pegasus>
	 <415C8B5B.3060400@acay.com.au>
Content-Type: text/plain
Message-Id: <1096617235.5403.3.camel@notepaq>
Mime-Version: 1.0
Subject: [Bluez-users] Re: pand freezes upon disconnect
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
Date: Fri, 01 Oct 2004 09:53:56 +0200

Hi,

> I made more tests. I put the results here hoping it
> might assist point to the problem.
> 
> I found the ff:
> 
> 1. Installed bluez NAP server on another Linux-2.6.8.1-mm4-mh2
> with nobridge-router-nofirewall-bluez. Result: When client
> disconnects the server does NOT FREEZE.
> 
> 2. Installed bluez NAP server on various versions of
> Linux-2.6.8.1-mm4-mh1 && mh2; Linux-2.6.8.1-mh1 && mh2 on
> bridge-router-firewall-bluez.
> 
> When client disconnects the server FREEZES in any combination.
> 
> 3. Using any setup in item 2, I can disconnect a client without
> freezing the server if I disable bluetooth by "rmmod" up till
> uhci_hcd at the server first. Then, I reloaded the modules
> to restart pand server so I get the client reconnected
> successfully.
> 
> With these processes, I got the following logs on the server:
> 
> br0: port 3(bnep0) entering disabled state
> Debug: sleeping function called from invalid context at 
> include/asm/semaphore.h:119
> in_atomic():1, irqs_disabled():0
>   [<c011a45f>] __might_sleep+0x9f/0xb0
>   [<c01841cb>] sysfs_hash_and_remove+0x2b/0x108
>   [<ccaff5b8>] br_sysfs_removeif+0x18/0x20 [bridge]
>   [<ccafc671>] br_del_if+0x31/0x56 [bridge]
>   [<ccafd51a>] br_device_event+0xba/0xe0 [bridge]
>   [<c01273a8>] notifier_call_chain+0x18/0x40
>   [<c02c723e>] unregister_netdevice+0x13e/0x236
>   [<c025a82f>] unregister_netdev+0xf/0x20
>   [<cc974c00>] bnep_session+0x6f0/0x790 [bnep]
>   [<c0105d32>] ret_from_fork+0x6/0x14
>   [<c01197c0>] default_wake_function+0x0/0x10
>   [<cc974510>] bnep_session+0x0/0x790 [bnep]
>   [<c010429d>] kernel_thread_helper+0x5/0x18

I think this is a problem in the Linux bridge code. Please report this
to the bridge mailing list or the netdev mailing list.

Stephen, do you have an idea or a patch for it?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
