Return-Path: <jikos@jikos.cz>
Date: Wed, 16 May 2007 11:29:45 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Satyam Sharma <satyam.sharma@gmail.com>
cc: Marcel Holtmann <marcel@holtmann.org>, Greg KH <gregkh@suse.de>,
        Jeremy Fitzhardinge <jeremy@goop.org>, maxk@qualcomm.com,
        bluez-devel@lists.sourceforge.net, Cedric Le Goater <clg@fr.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Subject: Re: 2.6.21-rc7: BUG: sleeping function called from invalid context
 at net/core/sock.c:1523
In-Reply-To: <a781481a0705110629n7c7130c1x3a89fa958b271f20@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0705161124030.25986@twin.jikos.cz>
References: <462D1B09.9050005@goop.org>  <Pine.LNX.4.64.0704232257090.20657@twin.jikos.cz>
  <Pine.LNX.4.64.0704261625410.20657@twin.jikos.cz>
 <a781481a0705110629n7c7130c1x3a89fa958b271f20@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, 11 May 2007, Satyam Sharma wrote:

> (later)
> I Googled a bit to see if this problem was faced elsewhere in the kernel
> too. Saw the following commit by Ingo Molnar
> (9883a13c72dbf8c518814b6091019643cdb34429):
> -	lock_sock(sock->sk);
> +	local_bh_disable();
> +	bh_lock_sock_nested(sock->sk);
> 	rc = selinux_netlbl_socket_setsid(sock, sksec->sid);
> -	release_sock(sock->sk);
> +	bh_unlock_sock(sock->sk);
> +	local_bh_enable();
> Is it _really_ *this* simple?

Hi Satyam,

actually this *seems* to be proper solution also for our case, thanks for 
pointing this out. I will think about it once again, do some more tests 
with this locking scheme, and will let you know.

Thanks,

-- 
Jiri Kosina
