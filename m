Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
From: Marcel Holtmann <marcel@holtmann.org>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001c01c4a021$b21545c0$1a01010a@baked>
References: <001c01c4a021$b21545c0$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1095804444.5762.21.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 22 Sep 2004 00:07:24 +0200

Hi Daryl,

> Looks like the rfcomm part isn't quite there. The accept queue doesn't fill
> up, but the use count still increases. And /proc/bluetooth/rfcomm still
> lists all of the closed sockets.
> 
> I added rfcomm_sock_close() and rfcomm_sock_kill() right after your addition
> to rfcomm_sk_state_change() and it seems to work. The affects of
> rfcomm_sock_alloc() (called by ...connect_ind()) needed to be dealt with. I
> changed it as follows:
> 
> --- mh_sock.c	2004-09-21 14:21:36.000000000 -0700
> +++ sock.c	2004-09-21 14:21:47.000000000 -0700
> @@ -104,8 +104,11 @@
>  			rfcomm_session_getaddr(d->session,
> &bluez_pi(sk)->src, NULL);
>  		sk->state_change(sk);
>  	} else {
> -		if (d->state == BT_CLOSED)
> +		if (d->state == BT_CLOSED) {
>  			bluez_accept_unlink(sk);
> +			rfcomm_sock_close(sk);
> +			rfcomm_sock_kill(sk);
> +		}
>  		parent->data_ready(parent, 0);
>  	}
>  
> I am not sure about the possible negative side effects of this. What do you
> think?

what I think is that we have two different bugs here. We may solved the
first one now, which wasn't a module reference count bug. The second now
increases the module reference count and don't decreases it correctly.
Since the RFCOMM implementation is much more complex, because of its
support for TTY and sockets as end user interfaces, we need to find out
if the socket functions are involved or the core/TTY functions.

At the moment I think calling ...sock_close() and ...sock_kill() in that
function is wrong. However I am not 100% sure.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
