Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Jul 2012 14:23:10 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/8] bluetooth: /proc/net/ entries for bluetooth
 protocols
Message-ID: <20120711112308.GA3044@aemeltch-MOBL1>
References: <20120618082826.GA2898@aemeltch-MOBL1>
 <20120629.020253.963694178693689545.yamato@redhat.com>
 <20120710140400.GA15795@aemeltch-MOBL1>
 <20120711.135831.1712662939552441872.yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120711.135831.1712662939552441872.yamato@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Masatake,

On Wed, Jul 11, 2012 at 01:58:31PM +0900, Masatake YAMATO wrote:
> (The patch sets are rebased to bluetooth-next. Unnecessary white
> spaces are trimmed.)
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

I've tested the patch and it creates entries in /proc/net

BTW: Shall lsof be able to identify l2cap protocol?

for l2test it prints: "can't identify protocol"

Best regards 
Andrei Emeltchenko  

