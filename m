Return-Path: <cyrus@holtmann.org>
Message-ID: <478D75BD.1010805@gmail.com>
Date: Wed, 16 Jan 2008 12:10:53 +0900
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <478D74A6.7000206@gmail.com>
In-Reply-To: <478D74A6.7000206@gmail.com>
Cc: Greg KH <greg@kroah.com>, Gabor Gombas <gombasg@sztaki.hu>,
	Al Viro <viro@ZenIV.linux.org.uk>, bluez-devel@lists.sf.net
Subject: [Bluez-devel] [PATCH 2.6.24-rc7 2/2] sysfs: fix bugs in
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

sysfs_rename/move_dir() have the following bugs.

* On dentry lookup failure, kfree() is called on ERR_PTR() value.
* sysfs_move_dir() has an extra dput() on success path.

Fix them.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 fs/sysfs/dir.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: work/fs/sysfs/dir.c
===================================================================
--- work.orig/fs/sysfs/dir.c
+++ work/fs/sysfs/dir.c
@@ -783,6 +783,7 @@ int sysfs_rename_dir(struct kobject * ko
 	old_dentry = sysfs_get_dentry(sd);
 	if (IS_ERR(old_dentry)) {
 		error = PTR_ERR(old_dentry);
+		old_dentry = NULL;
 		goto out;
 	}
 
@@ -850,6 +851,7 @@ int sysfs_move_dir(struct kobject *kobj,
 	old_dentry = sysfs_get_dentry(sd);
 	if (IS_ERR(old_dentry)) {
 		error = PTR_ERR(old_dentry);
+		old_dentry = NULL;
 		goto out;
 	}
 	old_parent = old_dentry->d_parent;
@@ -857,6 +859,7 @@ int sysfs_move_dir(struct kobject *kobj,
 	new_parent = sysfs_get_dentry(new_parent_sd);
 	if (IS_ERR(new_parent)) {
 		error = PTR_ERR(new_parent);
+		new_parent = NULL;
 		goto out;
 	}
 
@@ -880,7 +883,6 @@ again:
 	error = 0;
 	d_add(new_dentry, NULL);
 	d_move(old_dentry, new_dentry);
-	dput(new_dentry);
 
 	/* Remove from old parent's list and insert into new parent's list. */
 	sysfs_unlink_sibling(sd);

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
