Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Eugene Crosser <crosser@average.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Edd Dumbill <edd@usefulinc.com>
In-Reply-To: <1073475736.6998.9.camel@pccross.average.org>
References: <1073475736.6998.9.camel@pccross.average.org>
Content-Type: multipart/mixed; boundary="=-TCaJ8M1x4bNI/YhzMX/6"
Message-Id: <1073477754.2508.135.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: Reproducible kernel oops on PPP session start
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 07 Jan 2004 13:15:54 +0100


--=-TCaJ8M1x4bNI/YhzMX/6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Eugene,

> I have stock 2.6.0 kernel, fairly recent Bluez utilities and MSI USB
> Bluetooth dongle.  I have dund running, and if I try to start a PPP
> session from a handheld shortly after the previous one has terminated, I
> get kernel oops, pretty much every time.
> 
> Funny and probably unrelated thing is that the Palm (TT3) from which the
> session was initiated often soft-resets itself in a minute after such
> event...
> 
> Oops included (manually typed in from a photo of the screen).
> Tell me if I can help in further investigation.

to be sure that this is not a problem with the different proc code in
2.6 apply the attached patch and try again.

Edd, try this too for your lockup.

Regards

Marcel


--=-TCaJ8M1x4bNI/YhzMX/6
Content-Disposition: attachment; filename=patch-l2cap-no-proc
Content-Type: text/x-patch; name=patch-l2cap-no-proc; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -urN linux-2.6.0/net/bluetooth/l2cap.c linux-2.6.0-mh/net/bluetooth/l2cap.c
--- linux-2.6.0/net/bluetooth/l2cap.c	2003-12-18 03:59:05.000000000 +0100
+++ linux-2.6.0-mh/net/bluetooth/l2cap.c	2004-01-07 13:10:42.000000000 +0100
@@ -2027,83 +2027,6 @@
 }
 
 /* ---- Proc fs support ---- */
-#ifdef CONFIG_PROC_FS
-static void *l2cap_seq_start(struct seq_file *seq, loff_t *pos)
-{
-	struct sock *sk;
-	struct hlist_node *node;
-	loff_t l = *pos;
-
-	read_lock_bh(&l2cap_sk_list.lock);
-
-	sk_for_each(sk, node, &l2cap_sk_list.head)
-		if (!l--)
-			goto found;
-	sk = NULL;
-found:
-	return sk;
-}
-
-static void *l2cap_seq_next(struct seq_file *seq, void *e, loff_t *pos)
-{
-	(*pos)++;
-	return sk_next(e);
-}
-
-static void l2cap_seq_stop(struct seq_file *seq, void *e)
-{
-	read_unlock_bh(&l2cap_sk_list.lock);
-}
-
-static int  l2cap_seq_show(struct seq_file *seq, void *e)
-{
-	struct sock *sk = e;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
-
-	seq_printf(seq, "%s %s %d %d 0x%4.4x 0x%4.4x %d %d 0x%x\n",
-			batostr(&bt_sk(sk)->src), batostr(&bt_sk(sk)->dst), 
-			sk->sk_state, pi->psm, pi->scid, pi->dcid, pi->imtu,
-			pi->omtu, pi->link_mode);
-	return 0;
-}
-
-static struct seq_operations l2cap_seq_ops = {
-	.start  = l2cap_seq_start,
-	.next   = l2cap_seq_next,
-	.stop   = l2cap_seq_stop,
-	.show   = l2cap_seq_show 
-};
-
-static int l2cap_seq_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &l2cap_seq_ops);
-}
-
-static struct file_operations l2cap_seq_fops = {
-	.owner	 = THIS_MODULE,
-	.open    = l2cap_seq_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release,
-};
-
-static int  __init l2cap_proc_init(void)
-{
-        struct proc_dir_entry *p = create_proc_entry("l2cap", S_IRUGO, proc_bt);
-        if (!p)
-                return -ENOMEM;
-	p->owner     = THIS_MODULE;
-        p->proc_fops = &l2cap_seq_fops;
-        return 0;
-}
-
-static void __exit l2cap_proc_cleanup(void)
-{
-        remove_proc_entry("l2cap", proc_bt);
-}
-
-#else /* CONFIG_PROC_FS */
-
 static int  __init l2cap_proc_init(void)
 {
         return 0;
@@ -2113,7 +2036,6 @@
 {
         return;
 }
-#endif /* CONFIG_PROC_FS */
 
 static struct proto_ops l2cap_sock_ops = {
 	.family  =      PF_BLUETOOTH,

--=-TCaJ8M1x4bNI/YhzMX/6--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
