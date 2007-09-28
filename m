Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 28 Sep 2007 08:54:38 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Pierre-Yves Paulus <py@idlum.be>
Message-ID: <20070928085438.4eb5a38f@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <46FBF17A.6030009@idlum.be>
References: <46F92364.3080603@idlum.be> <46F952BD.4010009@redhat.com>
	<46FA5E2E.3010300@idlum.be>
	<20070927085658.1c66f1c8@gondolin.boeblingen.de.ibm.com>
	<46FBC1AE.4020404@idlum.be> <46FBF17A.6030009@idlum.be>
Mime-Version: 1.0
Cc: BlueZ@sc8-sf-spam2.sourceforge.net,
        development <bluez-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [Bluez-devel] Warnings and Oops on 2.6.23-rc6 while activily
 using rfcomm links (mm/slab.c)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Thu, 27 Sep 2007 20:07:54 +0200,
Pierre-Yves Paulus <py@idlum.be> wrote:

> Another one below, complete log from power-up to reboot, with some bugs =

> and one Oops. I only trimmed the numerous "l2cap_recv_acldata" and "ACL =

> packet for unknown connection handle" lines which always fill up the log.

Hmm, looked at it, but currently I can't see what's wrong from a driver
core perspective...


> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> BUG kmalloc-128: Poison overwritten
> -------------------------------------------------------------------------=
----
> =

> INFO: 0xc5734f28-0xc5734f40. First byte 0x6a instead of 0x6b
> INFO: Allocated in rfcomm_dev_ioctl+0xbd/0x4e6 [rfcomm] age=3D6110 cpu=3D=
0 =

> pid=3D3677
> INFO: Freed in rfcomm_dev_destruct+0x59/0x65 [rfcomm] age=3D3157 cpu=3D0 =

> pid=3D3927
> INFO: Slab 0xc10ae680 used=3D21 fp=3D0xc5734f20 flags=3D0x400000c2
> INFO: Object 0xc5734f20 @offset=3D3872 fp=3D0xc57342c0
> =

> Bytes b4 0xc5734f10:  05 00 00 00 f8 23 0f 00 5a 5a 5a 5a 5a 5a 5a 5a =

> ....=F8#..ZZZZZZZZ
>    Object 0xc5734f20:  6b 6b 6b 6b 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b =

                                                 ^^

This looks suspiciously like someone tried to decrease a refcount on a
freed kobject. Unfortunately, we only see this after the fact with slub
debugging turned on :( So could you please turn it off again (but leave
kobject debugging on) and try with the following silly debug patch:

---
 lib/kobject.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- linux-2.6.orig/lib/kobject.c
+++ linux-2.6/lib/kobject.c
@@ -502,8 +502,12 @@ static void kobject_release(struct kref =

  */
 void kobject_put(struct kobject * kobj)
 {
-	if (kobj)
+	if (kobj) {
+		if (!atomic_read(&kobj->kref.refcount))
+			pr_debug("%s: kobject %s@%p already has zero refcount!\n",
+				 __FUNCTION__, kobj->name, kobj);
 		kref_put(&kobj->kref, kobject_release);
+	}
 }
 =

 =


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
