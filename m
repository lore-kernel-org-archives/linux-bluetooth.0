Return-Path: <cyrus@holtmann.org>
Message-ID: <478DA86F.10905@gmail.com>
Date: Wed, 16 Jan 2008 15:47:11 +0900
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <478D74A6.7000206@gmail.com> <478D75BD.1010805@gmail.com>
	<alpine.LFD.1.00.0801151928380.2806@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.00.0801151928380.2806@woody.linux-foundation.org>
Cc: Gabor Gombas <gombasg@sztaki.hu>, Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	bluez-devel@lists.sourceforge.net, Al Viro <viro@ZenIV.linux.org.uk>,
	cornelia.huck@de.ibm.com
Subject: Re: [Bluez-devel] [PATCH 2.6.24-rc7 2/2] sysfs: fix bugs in
	sysfs_rename/move_dir()
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

Linus Torvalds wrote:
> 
> On Wed, 16 Jan 2008, Tejun Heo wrote:
>> * sysfs_move_dir() has an extra dput() on success path.
> 
> Are you sure? How did this ever work?

I'm pretty sure.  I've seen dentry blowing up due to early release &&
compared it with older code.  It was my mistake during restructuring
error path.  The only user of sysfs_move_dir() was S390 Cornelia works
on (cc'd).  Cornelia is usually very good at spotting and debugging
sysfs bugs.  Dunno how it got slipped this time.

> Also, looking at this, I think the "how did this ever work" question is 
> answered by "it didn't",

Before dput() bug was introduced, it worked although error handling path
was broken.

> but I also think there are still serious problems 
> there. Look at
> 
> 	again:
> 	        mutex_lock(&old_parent->d_inode->i_mutex);
> 	        if (!mutex_trylock(&new_parent->d_inode->i_mutex)) {
> 	                mutex_unlock(&old_parent->d_inode->i_mutex);
> 	                goto again;
> 	        }
> 
> and wonder what happen sif old_parent == new_parent. Is that trying to 
> avoid an ABBA deadlock?

It will fall in infinite loop if old_parent == new_parent and for the
question, I suppose so.  Cornelia, right?

> Normally you'd do it by ordering the locks, or by 
> taking a third lock to guarantee serialization at a higher level (ie the 
> "s_vfs_rename_mutex" on the VFS layer)

sysfs currently doesn't depend on VFS locking.  VFS locking is done just
to keep VFS layer happy.  sysfs_dirent hierarchy is protected by
sysfs_mutex and renaming/moving are protected by sysfs_rename_mutex.  As
both ops are under rename_mutex, I think the above code just can grab
both mutexes in any order.  It's probably a remnant of the days when
sysfs used VFS locking to protect internal structures.

s390 was the only user of the move interface till now and through all
the recent sysfs change, it didn't receive enough attention other than
Cornelia's testing.  Eventually, I think sysfs_rename_dir() and
sysfs_move_dir() should be merged into sysfs_move() but for the current
two users, I don't see anything wrong with the locking.

Thanks.

-- 
tejun

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
