Return-Path: <cyrus@holtmann.org>
Message-ID: <478D74A6.7000206@gmail.com>
Date: Wed, 16 Jan 2008 12:06:14 +0900
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Gabor Gombas <gombasg@sztaki.hu>,
	Al Viro <viro@ZenIV.linux.org.uk>, bluez-devel@lists.sf.net
Subject: [Bluez-devel] [PATCH 2.6.24-rc7 1/2] sysfs: make sysfs_lookup()
 return ERR_PTR(-ENOENT) on failed lookup
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

sysfs tries to keep dcache a strict subset of sysfs_dirent tree by
shooting down dentries when a node is removed, that is, no negative
dentry for sysfs.  However, the lookup function returned NULL and thus
created negative dentries when the target node didn't exist.

Make sysfs_lookup() return ERR_PTR(-ENOENT) on lookup failure.  This
fixes the NULL dereference bug in sysfs_get_dentry() discovered by
bluetooth rfcomm device moving around.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 fs/sysfs/dir.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: work/fs/sysfs/dir.c
===================================================================
--- work.orig/fs/sysfs/dir.c
+++ work/fs/sysfs/dir.c
@@ -678,8 +678,10 @@ static struct dentry * sysfs_lookup(stru
 	sd = sysfs_find_dirent(parent_sd, dentry->d_name.name);
 
 	/* no such entry */
-	if (!sd)
+	if (!sd) {
+		ret = ERR_PTR(-ENOENT);
 		goto out_unlock;
+	}
 
 	/* attach dentry and inode */
 	inode = sysfs_get_inode(sd);

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
