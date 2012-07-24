Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jul 2012 16:15:27 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/8] bluetooth: /proc/net/ entries for bluetooth
 protocols
Message-ID: <20120724131520.GC11981@aemeltch-MOBL1>
References: <20120629.020253.963694178693689545.yamato@redhat.com>
 <20120710140400.GA15795@aemeltch-MOBL1>
 <20120711.135831.1712662939552441872.yamato@redhat.com>
 <20120724.220831.1797978247249215593.yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120724.220831.1797978247249215593.yamato@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Masatake,

On Tue, Jul 24, 2012 at 10:08:31PM +0900, Masatake YAMATO wrote:
> (I have got no reply since 11th Jul. So I resend this mail here.
>  Please, review this patch and merge it if no problem.)
> 
> (The patch sets are rebased to bluetooth-next. Unnecessary white
>  spaces are trimmed.)
> 
> lsof command can tell the type of socket processes are using.
> Internal lsof uses inode numbers on socket fs to resolve the type of
> sockets. Files under /proc/net/, such as tcp, udp, unix, etc provides
> such inode information.
> 
> Unfortunately bluetooth related protocols don't provide such inode
> information. This patch series introduces /proc/net files for the protocols.
> 
> This patch against af_bluetooth.c provides facility to the implementation
> of protocols. This patch extends bt_sock_list and introduces two exported
> function bt_procfs_init, bt_procfs_cleanup.
> 
> The type bt_sock_list is already used in some of implementation of
> protocols. bt_procfs_init prepare seq_operations which converts
> protocol own bt_sock_list data to protocol own proc entry when the
> entry is accessed.
> 
> What I, lsof user, need is just inode number of bluetooth
> socket. However, people may want more information. The bt_procfs_init
> takes a function pointer for customizing the show handler of
> seq_operations.
>  
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>

Tested-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com> 

Best regards 
Andrei Emeltchenko 
