Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] ipaq 1945
From: Marcel Holtmann <marcel@holtmann.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
Cc: Peter Stephenson <pws@csr.com>, bluez-users@lists.sourceforge.net
In-Reply-To: <320075ff040928064645f3c7b0@mail.gmail.com>
References: <320075ff040925153753850d92@mail.gmail.com>
	 <1096153758.7719.12.camel@pegasus>
	 <320075ff040926011212538dac@mail.gmail.com>
	 <003001c4a3ba$d064fba0$8696a8c0@marcy>
	 <320075ff0409270050bbaf228@mail.gmail.com>
	 <1096371841.4950.5.camel@notepaq>
	 <320075ff04092805251ce925e6@mail.gmail.com>
	 <200409281319.i8SDJkQt011868@news01.csr.com>
	 <320075ff040928064645f3c7b0@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1096381075.4621.8.camel@notepaq>
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
Date: Tue, 28 Sep 2004 16:17:55 +0200

Hi Nigel,

> I have it all woring but unrelatedly my box crashes in the bnep driver
> when the device disconnects... I get this on the console :
> 
> Debug: sleeping function called from invalid context ad
> include/asm/semaphore.h:119
> in_atomic():1, irqs_disabled():0
>  __night_sleep+
>  sysfs_hash_and_remove
>  br_sysfs_removeif
>  br_del_if
>  br_device_event
>  notifier_call_chain
>  unregister_netdevice+0x170/0x2ac
>  unregister_netdev+0x18/0x30
>  bnep_session+0x7ab/0x860 [bnep]
>  schedule_tail+0x1e/0x70
>  ret_from_fork+0x6/0x14
>  default_wake_function+0x0/0x20
>  bnep_session+0x0/0x860 [bnep]
>  kernel_thread_helper+0x5/0x14
> 
> I suspect it's a problem with the bnep module rather than anything
> specific to the BlueZ stack..

maybe a problem in the bridge code. Use the latest 2.6.9-rc2-bk14 and
see if this crashes or not.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
