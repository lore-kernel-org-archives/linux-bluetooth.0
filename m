Return-Path: <cyrus@holtmann.org>
Message-ID: <5c1c70820804292308n63620353sc9b5224e962817c8@mail.gmail.com>
Date: Wed, 30 Apr 2008 15:38:45 +0930
From: "Pooyan McSporran" <duckfreezone@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] Kernel warnings
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I have been doing some testing of a bluetooth application using 4
BT2.0 class 1 radios (via a powered USB hub), on a 2.6.24.4 system.
(Vanilla kernel on a x86 Gentoo system).  Occasionally I'd see these
in the kernel log:

Apr 30 14:20:32 localhost sysfs: duplicate filename 'acl001237424A6A'
can not be created
Apr 30 14:20:32 localhost WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Apr 30 14:20:32 localhost Pid: 776, comm: btaddconn Not tainted 2.6.24.4v03 #1
Apr 30 14:20:32 localhost [<c0177c2a>] sysfs_add_one+0x54/0xb7
Apr 30 14:20:32 localhost [<c0178775>] sysfs_create_link+0x9a/0xe5
Apr 30 14:20:32 localhost [<c0177756>] sysfs_add_file+0x47/0x65
Apr 30 14:20:32 localhost [<c0201532>] bus_add_device+0x94/0xde
Apr 30 14:20:32 localhost [<c0200575>] device_add+0x23a/0x43e
Apr 30 14:20:32 localhost [<d0841324>] add_conn+0x0/0x67 [bluetooth]
Apr 30 14:20:32 localhost [<d0841341>] add_conn+0x1d/0x67 [bluetooth]
Apr 30 14:20:32 localhost [<c011e9ab>] run_workqueue+0x6b/0xdf
Apr 30 14:20:32 localhost [<c029f012>] schedule+0x1f3/0x20d
Apr 30 14:20:32 localhost [<c011ef9f>] worker_thread+0x0/0x81
Apr 30 14:20:32 localhost [<c011f013>] worker_thread+0x74/0x81
Apr 30 14:20:32 localhost [<c0121441>] autoremove_wake_function+0x0/0x35
Apr 30 14:20:32 localhost [<c01212ea>] kthread+0x36/0x5c
Apr 30 14:20:32 localhost [<c01212b4>] kthread+0x0/0x5c
Apr 30 14:20:32 localhost [<c0102f13>] kernel_thread_helper+0x7/0x10
Apr 30 14:20:32 localhost =======================
Apr 30 14:20:32 localhost add_conn: Failed to register connection device

I'm finding it hard to reliably reproduce this behaviour, but I'm
fairly sure it was when I was trying to connect many devices via SPP
connections.  I'm happy to try harder to reproduce it if it is indeed
a real problem, but if it's just noise then I'm equally happy to
ignore it :)

A search of the archives shows that this was a problem in older
versions of the kernel, but those messages imply it shouldn't be
happening in this version of the kernel.  I plan to try it on 2.6.25
soon.

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
