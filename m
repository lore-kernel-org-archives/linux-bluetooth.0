Return-Path: <cyrus@holtmann.org>
Date: Sat, 5 Jan 2008 07:50:39 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Gabor Gombas <gombasg@sztaki.hu>
Message-ID: <20080105075039.GF27894@ZenIV.linux.org.uk>
References: <20071228173203.GA20690@boogie.lpds.sztaki.hu>
	<a8e1da0712290007o168a730cw923055ad2c265d84@mail.gmail.com>
	<20080102151642.GA7273@boogie.lpds.sztaki.hu>
Mime-Version: 1.0
In-Reply-To: <20080102151642.GA7273@boogie.lpds.sztaki.hu>
Cc: htejun@gmail.com, bluez-devel@lists.sf.net,
	linux-kernel@vger.kernel.org
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

On Wed, Jan 02, 2008 at 04:16:42PM +0100, Gabor Gombas wrote:
> Heh, it seems talking about a bug makes it trigger:
> 
> Jan  2 16:05:45 twister kernel: Unable to handle kernel NULL pointer dereference at 00000000000000b8 RIP: 
> Jan  2 16:05:45 twister kernel:  [<ffffffff804720a5>] mutex_lock+0x10/0x1d
 
> So the patch referenced above does not help. But I've found a very easy
> way to trigger the bug:
> 
> - do a "cat /dev/zero > /dev/rfcomm0"
> - switch the phone off
> - switch the phone on, and the kernel oopses

sysfs_get_dentry(),
                mutex_lock(&parent->d_inode->i_mutex);
hitting parent->d_inode either NULL or very close to it, depending on your
.config; most likely NULL, if offset of i_mutex is 0xb8 in your build.
That's plausible - 0xb8 is what you'd get on UP build without spinlock
debugging, lockdep, etc.

Assuming that this is what we get, everything looks explainable - we
have sysfs_rename_dir() calling sysfs_get_dentry() while the parent
gets evicted.  We don't have any exclusion, so while we are playing
silly buggers with lookups in sysfs_get_dentry() we have parent become
negative; the rest is obvious...

AFAICS, the locking here is quite broken and frankly, sysfs_get_dentry()
and the way it plays with fs/namei.c are ucking fugly.

Could you stick
	if (!parent->d_inode)
		printk(KERN_WARNING "sysfs locking blows: %s",
			parent->d_name.name);
right before
                mutex_lock(&parent->d_inode->i_mutex);
                dentry = lookup_one_noperm(cur->s_name, parent);
                mutex_unlock(&parent->d_inode->i_mutex);
in sysfs_get_dentry() (fs/sysfs/dir.c) and verify that it does, indeed,
trigger?

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
