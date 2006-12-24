Return-Path: <akpm@osdl.org>
Date: Sat, 23 Dec 2006 17:12:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, marcel@holtmann.org,
        maxk@qualcomm.com, bluez-devel@lists.sourceforge.net
Subject: Re: ext3-related crash in 2.6.20-rc1
Message-Id: <20061223171228.120ac8a6.akpm@osdl.org>
In-Reply-To: <20061223234305.GA1809@elf.ucw.cz>
References: <20061223234305.GA1809@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

On Sun, 24 Dec 2006 00:43:05 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> I got this nasty oops while playing with debugger. Not sure if that is
> related; it also might be something with bluetooth; I already know it
> corrupts memory during suspend, perhaps it corrupts memory in some
> error path?
> 
>  
> 
> 								Pavel
> 
> 
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> PM: Removing info for bluetooth:acl00803715A329
> e1000: eth0: e1000_watchdog: NIC Link is Down
> e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
> e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
> e1000: eth0: e1000_watchdog: NIC Link is Down
> e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
> e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
> ------------[ cut here ]------------
> kernel BUG at fs/buffer.c:1235!

get thee to fs/buffer.c:1235.  You'll see that someone somewhere forgot to
reenable local interrupts.

Were you using gdb at the time?  A fix for something like that was merged
into mainline yesterday.

The slab errors which you're reporting in later emails will almost surely
be unrelated to this.
