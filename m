Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C852C001B0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 17:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjFWRTT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 13:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjFWRS6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 13:18:58 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079732706
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 10:18:50 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4QnkVJ6tNqz49QDV;
        Fri, 23 Jun 2023 20:18:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1687540729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QE7Wmh8DHA08SHAlsY8fqP2kmIzXClUV+WNikrrqgyk=;
        b=tmBRrTobEEIeTo4161+MupKTVCLHyskrePBnvYS7HyK+of8ufakcmxCEIv7rmN0B510K1H
        Tw3TzxXP74XKAkOlnoxNhDxb5pNNEy7qIJwoGd+a9tI35GCZIWgTEmGq8mez4cJgf84fQi
        vhmxpoqVfE+rPXQ9eqid1kmo/s4hYV+hktZGUPZ2/r4Nd6IbMeXVfLYvW8QjJm5iIyuxgp
        NQ7DjCDsnJeC8FKoJKcxhJ8iz0Dx8WH7ZNXCWgsFAJ9dAgBe+LEw9hCrlba0OM1M9CS0VL
        p1MRJ74Y9T89PDGX1ChCERedxUnxoyS0xOOQDRnpu9q5g10OoEgZ+oKMAW+bPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1687540729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QE7Wmh8DHA08SHAlsY8fqP2kmIzXClUV+WNikrrqgyk=;
        b=l8XUDU3/DZezpJZNGfADiPH/Sn8QUbIntNZycQ4ljE1Ox1w/RI+39bpFMo8R7A5sAlp4cg
        +tt8spX/mb51RGa39QKrXEAYqPE9b4QaFod7Cb+nMRyEeG1grdJ1HFrvv/xk7/39TQLiMQ
        DT0+P2D/9YWsU9vKC9xX2/Bw5Yf0+mx7wMqDCZ6IXzZsAY5jzyCNApKvjyK0kL4TQlulnP
        CxCblIYoDhDfndv2iIYFLcO8qU9yUqzXbUtFzxImN/swNMny9chKy+XcaXxGC1KwwXG0aW
        IgMH9dM3zcq0PwKQdPSPD+AFM+F+oKIXKYTX7dTkSO72kVh4FZS7KXIGWVnUIA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1687540729; a=rsa-sha256;
        cv=none;
        b=k457qJ+TtKKYDEoi0cYM9YWqVUsbroQDqddnJnDycbEXJq135v6YzrcyaoAC4smtaLcIsU
        jmPpgkZoTCoesQI97vvsng514Na6U8wgDVeIa4Qdb1la55oRCX/duHjJk8mYE2AuuH1Pvx
        FoyJnRUy8lOPyL0a12CaqfwOBi7hNMNNk3+Dyb4f0y+H8AplI72OPhJYvxHvReZso/QKzP
        mzMSPfOtvh5YuMAo8kFV447ISGSyLEQE720u3oUF0/uXPfji10XHF5L9zeYsguOZiN0uIv
        XRuhQmlQpyQf0KfnO8RH4ez7Dag2F/0C0/eqycmoPStoKT4K5Azbhhbr1renRw==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH RFC 4/5] Bluetooth: ISO: fix use-after-free in __iso_sock_close
Date:   Fri, 23 Jun 2023 20:18:41 +0300
Message-ID: <9fc59119ddbed06455cc8056ddf3c9968fd3ad11.1687525956.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1687525956.git.pav@iki.fi>
References: <cover.1687525956.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

__iso_sock_close calls hci_conn_del without hci_dev_lock, which is
invalid and results to use-after-free under suitable conditions.  But
the lock cannot be taken here because of lock ordering hci_dev_lock >
lock_sock > iso_conn_lock.

Instead, take hci_conn_get temporarily, and delete the connection
after lock_sock is released later on, if it is still alive.

Also do iso_conn_del, so that we don't leak the iso_conn.

Log:
==================================================================
hci_chan_list_flush:2769: hcon ffff8880356b9000
hci_le_remove_cig:952: hci0: handle 0x00
hci_dev_put:1487: hci0 orig refcnt 9
iso_chan_del:156: sk ffff888010918800, conn ffff888004daee00, err 104
iso_chan_del:156: sk ffff888010918800, conn 0000000000000000, err 103
BUG: KASAN: slab-use-after-free in iso_conn_del (net/bluetooth/iso.c:211) bluetooth
Write of size 8 at addr ffff8880356b99f0 by task kworker/u5:1/1073

Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
Workqueue: hci0 hci_cmd_sync_work [bluetooth]
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:108)
print_report (mm/kasan/report.c:352 mm/kasan/report.c:462)
? __virt_addr_valid (./include/linux/mmzone.h:1901 ./include/linux/mmzone.h:1997 arch/x86/mm/physaddr.c:65)
? iso_conn_del (net/bluetooth/iso.c:211) bluetooth
kasan_report (mm/kasan/report.c:574)
? iso_conn_del (net/bluetooth/iso.c:211) bluetooth
iso_conn_del (net/bluetooth/iso.c:211) bluetooth
hci_conn_hash_flush (./include/net/bluetooth/hci_core.h:1872 net/bluetooth/hci_conn.c:2576) bluetooth
hci_dev_close_sync (net/bluetooth/hci_sync.c:5043) bluetooth
? __pfx_hci_dev_close_sync (net/bluetooth/hci_sync.c:4974) bluetooth
hci_set_powered_sync (net/bluetooth/hci_sync.c:5433 net/bluetooth/hci_sync.c:5441) bluetooth
? __pfx_hci_set_powered_sync (net/bluetooth/hci_sync.c:5437) bluetooth
? set_powered_sync (net/bluetooth/mgmt.c:1369) bluetooth
? __pfx_set_powered_sync (net/bluetooth/mgmt.c:1367) bluetooth
hci_cmd_sync_work (net/bluetooth/hci_sync.c:306) bluetooth
process_one_work (kernel/workqueue.c:2410)
? __pfx_process_one_work (kernel/workqueue.c:2300)
? __pfx_do_raw_spin_lock (kernel/locking/spinlock_debug.c:113)
? mark_held_locks (kernel/locking/lockdep.c:4240)
worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2553)
? __pfx_worker_thread (kernel/workqueue.c:2495)
kthread (kernel/kthread.c:379)
? __pfx_kthread (kernel/kthread.c:332)
ret_from_fork (arch/x86/entry/entry_64.S:314)
</TASK>

Allocated by task 2372:
kasan_save_stack (mm/kasan/common.c:46)
kasan_set_track (mm/kasan/common.c:52)
__kasan_kmalloc (mm/kasan/common.c:374 mm/kasan/common.c:383)
hci_conn_add (./include/linux/slab.h:559 ./include/linux/slab.h:680 net/bluetooth/hci_conn.c:1002) bluetooth
hci_bind_cis (net/bluetooth/hci_conn.c:1920) bluetooth
iso_connect_cis (net/bluetooth/iso.c:383) bluetooth
iso_sock_connect (net/bluetooth/iso.c:890) bluetooth
__sys_connect (./include/linux/file.h:44 net/socket.c:2021)
__x64_sys_connect (net/socket.c:2027)
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)

Freed by task 2372:
kasan_save_stack (mm/kasan/common.c:46)
kasan_set_track (mm/kasan/common.c:52)
kasan_save_free_info (mm/kasan/generic.c:523)
__kasan_slab_free (mm/kasan/common.c:238 mm/kasan/common.c:200 mm/kasan/common.c:244)
__kmem_cache_free (mm/slub.c:1807 mm/slub.c:3786 mm/slub.c:3799)
device_release (drivers/base/core.c:2489)
kobject_put (lib/kobject.c:683 lib/kobject.c:714 ./include/linux/kref.h:65 lib/kobject.c:731)
__iso_sock_close (net/bluetooth/iso.c:665) bluetooth
iso_sock_release (net/bluetooth/iso.c:686 net/bluetooth/iso.c:1473) bluetooth
__sock_release (net/socket.c:654)
sock_close (net/socket.c:1399)
__fput (fs/file_table.c:322)
task_work_run (kernel/task_work.c:180)
exit_to_user_mode_prepare (./include/linux/resume_user_mode.h:49 kernel/entry/common.c:171 kernel/entry/common.c:204)
syscall_exit_to_user_mode (kernel/entry/common.c:130 kernel/entry/common.c:299)
do_syscall_64 (arch/x86/entry/common.c:87)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)

The buggy address belongs to the object at ffff8880356b9000
which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 2544 bytes inside of
freed 4096-byte region [ffff8880356b9000, ffff8880356ba000)
==================================================================

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/iso.c | 50 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 84d238d0639a..ea0209fb9872 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -626,7 +626,38 @@ static void iso_conn_defer_reject(struct hci_conn *conn)
 	hci_send_cmd(conn->hdev, HCI_OP_LE_REJECT_CIS, sizeof(cp), &cp);
 }
 
-static void __iso_sock_close(struct sock *sk)
+static void iso_conn_del_hci_conn(struct iso_conn *conn, struct hci_conn **del)
+{
+	/* Lock ordering forbids taking hdev->lock, postpone hci_conn_del */
+	iso_conn_lock(conn);
+	if (conn->hcon) {
+		hci_conn_get(conn->hcon);
+		hci_dev_hold(conn->hcon->hdev);
+		*del = conn->hcon;
+		conn->hcon = NULL;
+	}
+	iso_conn_unlock(conn);
+}
+
+static void iso_conn_del_hci_conn_finish(struct hci_conn *hcon)
+{
+	struct hci_dev *hdev;
+
+	if (!hcon)
+		return;
+
+	hdev = hcon->hdev;
+	hci_dev_lock(hdev);
+	if (hci_conn_is_alive(hdev, hcon)) {
+		iso_conn_del(hcon, ECONNRESET);
+		hci_conn_del(hcon);
+	}
+	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
+	hci_conn_put(hcon);
+}
+
+static void __iso_sock_close(struct sock *sk, struct hci_conn **del_conn)
 {
 	BT_DBG("sk %p state %d socket %p", sk, sk->sk_state, sk->sk_socket);
 
@@ -659,11 +690,8 @@ static void __iso_sock_close(struct sock *sk)
 		 * needs to be removed so just call hci_conn_del so the cleanup
 		 * callback do what is needed.
 		 */
-		if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags) &&
-		    iso_pi(sk)->conn->hcon) {
-			hci_conn_del(iso_pi(sk)->conn->hcon);
-			iso_pi(sk)->conn->hcon = NULL;
-		}
+		if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags))
+			iso_conn_del_hci_conn(iso_pi(sk)->conn, del_conn);
 
 		iso_chan_del(sk, ECONNRESET);
 		break;
@@ -680,11 +708,14 @@ static void __iso_sock_close(struct sock *sk)
 /* Must be called on unlocked socket. */
 static void iso_sock_close(struct sock *sk)
 {
+	struct hci_conn *del_conn = NULL;
+
 	iso_sock_clear_timer(sk);
 	lock_sock(sk);
-	__iso_sock_close(sk);
+	__iso_sock_close(sk, &del_conn);
 	release_sock(sk);
 	iso_sock_kill(sk);
+	iso_conn_del_hci_conn_finish(del_conn);
 }
 
 static void iso_sock_init(struct sock *sk, struct sock *parent)
@@ -1418,6 +1449,7 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 static int iso_sock_shutdown(struct socket *sock, int how)
 {
 	struct sock *sk = sock->sk;
+	struct hci_conn *del_conn = NULL;
 	int err = 0;
 
 	BT_DBG("sock %p, sk %p, how %d", sock, sk, how);
@@ -1447,7 +1479,7 @@ static int iso_sock_shutdown(struct socket *sock, int how)
 	}
 
 	iso_sock_clear_timer(sk);
-	__iso_sock_close(sk);
+	__iso_sock_close(sk, &del_conn);
 
 	if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime &&
 	    !(current->flags & PF_EXITING))
@@ -1457,6 +1489,8 @@ static int iso_sock_shutdown(struct socket *sock, int how)
 	release_sock(sk);
 	sock_put(sk);
 
+	iso_conn_del_hci_conn_finish(del_conn);
+
 	return err;
 }
 
-- 
2.41.0

