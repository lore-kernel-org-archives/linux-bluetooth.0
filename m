Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Jan 2008 19:41:58 -0800 (PST)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Tejun Heo <htejun@gmail.com>
In-Reply-To: <478D75BD.1010805@gmail.com>
Message-ID: <alpine.LFD.1.00.0801151928380.2806@woody.linux-foundation.org>
References: <478D74A6.7000206@gmail.com> <478D75BD.1010805@gmail.com>
MIME-Version: 1.0
Cc: Gabor Gombas <gombasg@sztaki.hu>, Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	bluez-devel@lists.sourceforge.net, Al Viro <viro@ZenIV.linux.org.uk>
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



On Wed, 16 Jan 2008, Tejun Heo wrote:
>
> * sysfs_move_dir() has an extra dput() on success path.

Are you sure? How did this ever work?

Also, looking at this, I think the "how did this ever work" question is 
answered by "it didn't", but I also think there are still serious problems 
there. Look at

	again:
	        mutex_lock(&old_parent->d_inode->i_mutex);
	        if (!mutex_trylock(&new_parent->d_inode->i_mutex)) {
	                mutex_unlock(&old_parent->d_inode->i_mutex);
	                goto again;
	        }

and wonder what happen sif old_parent == new_parent. Is that trying to 
avoid an ABBA deadlock? Normally you'd do it by ordering the locks, or by 
taking a third lock to guarantee serialization at a higher level (ie the 
"s_vfs_rename_mutex" on the VFS layer)

I'd like to apply these two patches, but I really want to get more of an 
ack for them from somebody like Al, or at least more of an explanation for 
why it's all the right thing.

			Linus

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
