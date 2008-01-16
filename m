Return-Path: <cyrus@holtmann.org>
Message-ID: <478DB0E1.7090401@gmail.com>
Date: Wed, 16 Jan 2008 16:23:13 +0900
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
To: Al Viro <viro@ZenIV.linux.org.uk>
References: <478D74A6.7000206@gmail.com> <478D75BD.1010805@gmail.com>
	<alpine.LFD.1.00.0801151928380.2806@woody.linux-foundation.org>
	<20080116035224.GW27894@ZenIV.linux.org.uk>
In-Reply-To: <20080116035224.GW27894@ZenIV.linux.org.uk>
Cc: Gabor Gombas <gombasg@sztaki.hu>, Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	bluez-devel@lists.sourceforge.net,
	Linus Torvalds <torvalds@linux-foundation.org>
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

Hello.

Al Viro wrote:
> No ACK is coming until we get something resembling analysis of locking
> scheme.  Which won't happen until we at least get the "what callers are
> allowed to do" written down, damnit.

I agree that sysfs needs further clean up.  As I wrote in the earlier
thread, sysfs has been under constant flux of cleanups and updates
although it has slowed down recently due to the hazy number of libata
bugs.  For example, several months ago with buggy dentry / inode
reclamation, sysfs could trigger pretty cryptic oopses under memory
pressure and locking was more awkward and buggy.

The two posted patches are bug fixes for apparent bugs which can be
triggered by the current two users of the interface.  AFAICS, locking
there is weird but correct for the current two users.  If you can find
any problem there, please lemme know.  We shouldn't hold this type of
fixes for future clean ups.

> As it is, I'm more than inclined
> to propose ripping kobject_move() out, especially since it has only two
> users - something s390-specific and rfcomm, with its shitloads of problems
> beyond just sysfs interaction.

Can you please elaborate?  All sysfs problems discovered by the rfcomm
are fixed by the posted patches.  Dave Young has a patch waiting for
verification by the tester.  Furthermore, even if we rip out
kobject_move() in the future, I don't think -rc7 is the right time to do it.

I posted some patches a while back which did sysfs locking
reorganization, separation from and proper layering with kobject /
driver model.  There were some disagreements regarding the interface and
I got struck by load of ATA bugs.  I'll dig it up and give it another
shot in a few weeks.

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
