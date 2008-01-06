Return-Path: <cyrus@holtmann.org>
Message-ID: <478037F8.8020103@gmail.com>
Date: Sun, 06 Jan 2008 11:07:52 +0900
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
To: Al Viro <viro@ZenIV.linux.org.uk>
References: <20071228173203.GA20690@boogie.lpds.sztaki.hu>
	<a8e1da0712290007o168a730cw923055ad2c265d84@mail.gmail.com>
	<20080102151642.GA7273@boogie.lpds.sztaki.hu>
	<20080105075039.GF27894@ZenIV.linux.org.uk>
	<477F9481.2040505@gmail.com>
	<20080105194510.GK27894@ZenIV.linux.org.uk>
In-Reply-To: <20080105194510.GK27894@ZenIV.linux.org.uk>
Cc: Gabor Gombas <gombasg@sztaki.hu>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, ebiederm@xmission.com,
	bluez-devel@lists.sf.net
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

Hello,

Al Viro wrote:
> On Sat, Jan 05, 2008 at 11:30:25PM +0900, Tejun Heo wrote:
>>> Assuming that this is what we get, everything looks explainable - we
>>> have sysfs_rename_dir() calling sysfs_get_dentry() while the parent
>>> gets evicted.  We don't have any exclusion, so while we are playing
>>> silly buggers with lookups in sysfs_get_dentry() we have parent become
>>> negative; the rest is obvious...
>> That part of code is walking down the sysfs tree from the s_root of
>> sysfs hierarchy and on each step parent is held using dget() while being
>> referenced, so I don't think they can turn negative there.
> 
> Turn?  Just what stops you from getting a negative (and unhashed) from
> lookup_one_noperm() and on the next iteration being buggered on mutex_lock()?

Right, I haven't thought about that.  When sysfs_get_dentry() is called,
@sd is always valid so unless there was existing negative dentry, lookup
is guaranteed to return positive dentry, but by populating dcache with
negative dentry before a node is created, things can go wrong.  I don't
think that's what's going on here tho.  If that was the case, the
while() loop looking up the next sd to lookup (@cur) should have blown
up as negative dentry will have NULL d_fsdata which doesn't match any sd.

I guess what's needed here is d_revalidate() as other distributed
filesystems do.  I'll test whether this can be actually triggered and
prepare a fix.  Thanks a lot for pointing out the problem.

>>> AFAICS, the locking here is quite broken and frankly, sysfs_get_dentry()
>>> and the way it plays with fs/namei.c are ucking fugly.
>> Can you elaborate a bit?  The locking in sysfs is unconventional but
>> that's mostly from necessity.  It has dual interface - vfs and driver
>> model && vfs data structures (dentry and inode) are too big to always
>> keep around, so it basically becomes a small distributed file system
>> where the backing data can change asynchronously.
> 
> ... with all fun that creates.  As it is, you have those async changers
> of backing data using VFS locking _under_ sysfs locks via lookup_one_noperm()
> and yet it needs sysfs_mutex inside sysfs_lookup().  So you can't have
> sysfs_get_dentry() under it.  So you don't have exclusion with arseloads
> of sysfs tree changes in there.  Joy...

There are two locks.  sysfs_rename_mutex and sysfs_mutex.
sysfs_rename_mutex is above VFS locks while sysfs_mutex is below VFS
locks.  sysfs_rename_mutex() protects against move/rename which can
change the ancestry of a held sysfs_dirent while sysfs_mutex protects
the sd hierarchy itself.  Locking can be wrong if sysfs_rename_mutex
locking is missing from the places where ancestry of a held sd can
change but I can't find one ATM.  If I'm missing your point again, feel
free to scream at me.  :-)

As it's unnecessarily unintuitive, there's a pending change to rename
sysfs_rename_mutex and use it to protect the whole tree structure to
make locking simpler while using sysfs_mutex to guard VFS access such
that the locking hierarchy plainly becomes sysfs_rename_mutex - VFS
locks - sysfs_mutex where all internal sysfs structure is protected by
the outer mutex and the inner one just protects VFS accesses.

> Frankly, with the current state of sysfs the last vestiges of arguments
> used to push it into the tree back then are dead and buried.  I'm not
> blaming you, BTW - the shitpile *did* grow past the point where its
> memory footprint became far too large and something needed to be done.
> Unfortunately, it happened too late for that something being "get rid
> of the entire mess" and now we are saddled with it for good.

Yeah, it's too late to get rid of sysfs and regardless implementation
ugliness, which BTW I think has improved a lot during last six or so
months, it's now pretty useful and important to drivers, so I guess the
only option is trying hard to make it better.

Oh, BTW, the ugly lookup_one_noperm() can be removed if LOOKUP_NOPERM
flag is added.  The only reason sysfs_lookup() uses the specialized
lookup is to avoid permission check.

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
