Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Thinkpad 560x with pnpbios and bluez
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <57050.194.59.120.11.1103013222.squirrel@194.59.120.11>
References: <36763.194.59.120.11.1101982344.squirrel@thalreit.dyndns.org>
	 <1101987478.15615.112.camel@pegasus>
	 <48456.194.59.120.11.1102056209.squirrel@194.59.120.11>
	 <1102057135.7350.66.camel@pegasus>
	 <34315.194.59.120.11.1102057863.squirrel@194.59.120.11>
	 <1102060352.7350.68.camel@pegasus>
	 <58223.194.59.120.11.1102589549.squirrel@194.59.120.11>
	 <1102590194.9988.121.camel@pegasus>
	 <57050.194.59.120.11.1103013222.squirrel@194.59.120.11>
Content-Type: text/plain
Message-Id: <1103013754.2143.70.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 14 Dec 2004 09:42:34 +0100

Hi Volker,

> >> patching file net/bluetooth/af_bluetooth.c
> >> patching file net/bluetooth/bnep/core.c
> >> Hunk #12 FAILED at 472.
> >> Hunk #13 succeeded at 494 (offset -2 lines).
> >> Hunk #14 succeeded at 564 (offset -2 lines).
> >> Hunk #15 succeeded at 585 (offset -2 lines).
> >> 1 out of 15 hunks FAILED -- saving rejects to file
> >> net/bluetooth/bnep/core.c.rej
> >
> > This is a problem. Look at the net/bluetooth/bnep/core.c.rej file.
> >
> this is core.c.rej:
> ***************
> *** 453,468 ****
> 
>         BT_DBG("");
> 
> -         daemonize(); reparent_to_init();
> 
> -         sprintf(current->comm, "kbnepd %s", dev->name);
> -
> -         sigfillset(&current->blocked);
>         flush_signals(current);
> 
>         current->nice = -15;
> 
> -         set_fs(KERNEL_DS);
> 
>         init_waitqueue_entry(&wait, current);
>         add_wait_queue(sk->sleep, &wait);
> --- 472,487 ----
> 
>         BT_DBG("");
> 
> +       daemonize(); reparent_to_init();
> 
> +       sprintf(current->comm, "kbnepd %s", dev->name);
> +
> +       sigfillset(&current->blocked);
>         flush_signals(current);
> 
>         current->nice = -15;
> 
> +       set_fs(KERNEL_DS);
> 
>         init_waitqueue_entry(&wait, current);
>         add_wait_queue(sk->sleep, &wait);
> --

this part of the -mh patch does only whitespace and tabbing cleanup.
Since there is no real code change you don't need this hunk. However
don't ask me what the -ac patch is doing that this rejects.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
