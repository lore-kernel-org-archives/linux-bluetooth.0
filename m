Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <57050.194.59.120.11.1103013222.squirrel@194.59.120.11>
In-Reply-To: <1102590194.9988.121.camel@pegasus>
References: <36763.194.59.120.11.1101982344.squirrel@thalreit.dyndns.org>
    <1101987478.15615.112.camel@pegasus>
    <48456.194.59.120.11.1102056209.squirrel@194.59.120.11>
    <1102057135.7350.66.camel@pegasus>
    <34315.194.59.120.11.1102057863.squirrel@194.59.120.11>
    <1102060352.7350.68.camel@pegasus>
    <58223.194.59.120.11.1102589549.squirrel@194.59.120.11>
    <1102590194.9988.121.camel@pegasus>
Subject: Re: [Bluez-users] Thinkpad 560x with pnpbios and bluez
From: "Volker Jahns" <volker@thalreit.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
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
Date: Tue, 14 Dec 2004 09:33:42 +0100 (CET)

Marcel, can you help out on this one:

>> OK, here's what I did:
>> --
>> tar xvjf linux-2.4.22.tar.bz2
>> cd linux-2.4.22
>> zcat ../patch-2.4.22-ac4.gz |patch -p1
>> --
>> This is all good, and also leads to working kernel w/ pnpbios support
>> :-)
>>
>> But then:
>> --
>> zcat ../patch-2.4.22-mh7.gz |patch -p1
>> patching file arch/sparc64/kernel/ioctl32.c
>> patching file CREDITS
>> Hunk #2 succeeded at 2655 (offset 6 lines).
>
> the CREDITS file can be ignored.
>


...

>> patching file net/bluetooth/af_bluetooth.c
>> patching file net/bluetooth/bnep/core.c
>> Hunk #12 FAILED at 472.
>> Hunk #13 succeeded at 494 (offset -2 lines).
>> Hunk #14 succeeded at 564 (offset -2 lines).
>> Hunk #15 succeeded at 585 (offset -2 lines).
>> 1 out of 15 hunks FAILED -- saving rejects to file
>> net/bluetooth/bnep/core.c.rej
>
> This is a problem. Look at the net/bluetooth/bnep/core.c.rej file.
>
this is core.c.rej:
***************
*** 453,468 ****

        BT_DBG("");

-         daemonize(); reparent_to_init();

-         sprintf(current->comm, "kbnepd %s", dev->name);
-
-         sigfillset(&current->blocked);
        flush_signals(current);

        current->nice = -15;

-         set_fs(KERNEL_DS);

        init_waitqueue_entry(&wait, current);
        add_wait_queue(sk->sleep, &wait);
--- 472,487 ----

        BT_DBG("");

+       daemonize(); reparent_to_init();

+       sprintf(current->comm, "kbnepd %s", dev->name);
+
+       sigfillset(&current->blocked);
        flush_signals(current);

        current->nice = -15;

+       set_fs(KERNEL_DS);

        init_waitqueue_entry(&wait, current);
        add_wait_queue(sk->sleep, &wait);
--
I don't understand this syntax, sorry.


-- 
Volker Jahns, volker@thalreit.de



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
