Return-Path: <cyrus@holtmann.org>
Message-ID: <477F9481.2040505@gmail.com>
Date: Sat, 05 Jan 2008 23:30:25 +0900
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
To: Al Viro <viro@ZenIV.linux.org.uk>
References: <20071228173203.GA20690@boogie.lpds.sztaki.hu>
	<a8e1da0712290007o168a730cw923055ad2c265d84@mail.gmail.com>
	<20080102151642.GA7273@boogie.lpds.sztaki.hu>
	<20080105075039.GF27894@ZenIV.linux.org.uk>
In-Reply-To: <20080105075039.GF27894@ZenIV.linux.org.uk>
Cc: Greg KH <greg@kroah.com>, Gabor Gombas <gombasg@sztaki.hu>,
	bluez-devel@lists.sf.net, linux-kernel@vger.kernel.org
Subject: Re: [Bluez-devel] Oops involving RFCOMM and sysfs
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

Hello.

Al Viro wrote:
> sysfs_get_dentry(),
>                 mutex_lock(&parent->d_inode->i_mutex);
> hitting parent->d_inode either NULL or very close to it, depending on your
> .config; most likely NULL, if offset of i_mutex is 0xb8 in your build.
> That's plausible - 0xb8 is what you'd get on UP build without spinlock
> debugging, lockdep, etc.
> 
> Assuming that this is what we get, everything looks explainable - we
> have sysfs_rename_dir() calling sysfs_get_dentry() while the parent
> gets evicted.  We don't have any exclusion, so while we are playing
> silly buggers with lookups in sysfs_get_dentry() we have parent become
> negative; the rest is obvious...

That part of code is walking down the sysfs tree from the s_root of
sysfs hierarchy and on each step parent is held using dget() while being
referenced, so I don't think they can turn negative there.

> AFAICS, the locking here is quite broken and frankly, sysfs_get_dentry()
> and the way it plays with fs/namei.c are ucking fugly.

Can you elaborate a bit?  The locking in sysfs is unconventional but
that's mostly from necessity.  It has dual interface - vfs and driver
model && vfs data structures (dentry and inode) are too big to always
keep around, so it basically becomes a small distributed file system
where the backing data can change asynchronously.

> Could you stick
> 	if (!parent->d_inode)
> 		printk(KERN_WARNING "sysfs locking blows: %s",
> 			parent->d_name.name);
> right before
>                 mutex_lock(&parent->d_inode->i_mutex);
>                 dentry = lookup_one_noperm(cur->s_name, parent);
>                 mutex_unlock(&parent->d_inode->i_mutex);
> in sysfs_get_dentry() (fs/sysfs/dir.c) and verify that it does, indeed,
> trigger?

Yes, please.

Thanks.

-- 
tejun

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
