Return-Path: <cyrus@holtmann.org>
Message-ID: <47824415.80703@gmail.com>
Date: Tue, 08 Jan 2008 00:24:05 +0900
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
To: Gabor Gombas <gombasg@sztaki.hu>
References: <20071228173203.GA20690@boogie.lpds.sztaki.hu>
	<a8e1da0712290007o168a730cw923055ad2c265d84@mail.gmail.com>
	<20080102151642.GA7273@boogie.lpds.sztaki.hu>
	<20080105075039.GF27894@ZenIV.linux.org.uk>
	<20080107141300.GB12763@boogie.lpds.sztaki.hu>
In-Reply-To: <20080107141300.GB12763@boogie.lpds.sztaki.hu>
Content-Type: multipart/mixed; boundary="------------080309060701040302010706"
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
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
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080309060701040302010706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Gabor Gombas wrote:
> Hi,
> 
> On Sat, Jan 05, 2008 at 07:50:39AM +0000, Al Viro wrote:
> 
>> Could you stick
>> 	if (!parent->d_inode)
>> 		printk(KERN_WARNING "sysfs locking blows: %s",
>> 			parent->d_name.name);
>> right before
>>                 mutex_lock(&parent->d_inode->i_mutex);
>>                 dentry = lookup_one_noperm(cur->s_name, parent);
>>                 mutex_unlock(&parent->d_inode->i_mutex);
>> in sysfs_get_dentry() (fs/sysfs/dir.c) and verify that it does, indeed,
>> trigger?
> 
> Here it is:
> 
> Jan  7 14:35:43 twister kernel: sysfs locking blows: acl001BAFE1624D<1>Unable to handle kernel NULL pointer dereference at 00000000000000b8 RIP: 

Does the attached patch fix the problem?

-- 
tejun

--------------080309060701040302010706
Content-Type: text/x-patch;
 name="kill-extra-put-in-sysfs_move_dir.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="kill-extra-put-in-sysfs_move_dir.patch"

diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index 3371629..4e7f3bf 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -878,7 +878,6 @@ again:
 	error = 0;
 	d_add(new_dentry, NULL);
 	d_move(old_dentry, new_dentry);
-	dput(new_dentry);
 
 	/* Remove from old parent's list and insert into new parent's list. */
 	sysfs_unlink_sibling(sd);

--------------080309060701040302010706
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------080309060701040302010706
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------080309060701040302010706--
