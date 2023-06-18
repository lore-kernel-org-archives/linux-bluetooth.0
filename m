Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE34EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Jun 2023 22:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjFRWEt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Jun 2023 18:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFRWEs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Jun 2023 18:04:48 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32351CD
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Jun 2023 15:04:47 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4Qkn4Y2sbwz102K;
        Mon, 19 Jun 2023 01:04:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1687125885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X/zoD4MyYd5/2Mg9N/+4q9JSavxoMAJw/auAh/ka+1s=;
        b=U0hbsn/lYtHRQTdS603gHMdYOYZ9VI3zBvrGOcB8AdTBJkiK3zk6X+bQBXGzgYoXTAuy1T
        L0+yYi7I4QBQqIy5LlIYuP5Z/nJSCN+nN+V8YZc+Yy++AIH6NzPN5TBBk2O+NABvlXkgcG
        bUU/wMWHRueqnG7oNSW4EATb2MkWs2U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1687125885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X/zoD4MyYd5/2Mg9N/+4q9JSavxoMAJw/auAh/ka+1s=;
        b=OwruX8LF3gGhwiPkNRxmlhwiOqnAh7jGjF4ho1i/nkfImhGH7B5YWQzOJkluBon3ZGuxw2
        9OjYWQPgMnoQ1U/KqK+HwabuoEFj9AxwRWbojVlhT9SeZYbQSWJSKSO7k5AwzU3XL1Tr5r
        3WE0lQRdl0MjbUmtPy+ZYnH5yTXntR8=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1687125885; a=rsa-sha256; cv=none;
        b=MgfujAMKc/Hv7fIlZKzbt7PN80AyfcV7cXZByZgiNPD+0DhOKBf+OSAHd7911J45tuwdMa
        bEFxENFWB8jktRUILfosWIiimYTtmDTkqYzE3QB6JW9VZaVzuXU7gY8kn8D9yruqoSFmtt
        eLsfQdGUcxH4fTNTegS7V8jhQFxki4Q=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>, josephsih@chromium.org,
        mmandlik@google.com
Subject: [PATCH v3 2/3] Bluetooth: hci_event: call disconnect callback before deleting conn
Date:   Mon, 19 Jun 2023 01:04:32 +0300
Message-ID: <b545640ae3bb0c3c09d6f17e0d88d80f441f8fb6.1687115142.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1687115142.git.pav@iki.fi>
References: <cover.1687115142.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In hci_cs_disconnect, we do hci_conn_del even if disconnection failed.

ISO, L2CAP and SCO connections refer to the hci_conn without
hci_conn_get, so disconn_cfm must be called so they can clean up their
conn, otherwise use-after-free occurs.

ISO:
==========================================================
iso_sock_connect:880: sk 00000000eabd6557
iso_connect_cis:356: 70:1a:b8:98:ff:a2 -> 28:3d:c2:4a:7e:da
...
iso_conn_add:140: hcon 000000001696f1fd conn 00000000b6251073
hci_dev_put:1487: hci0 orig refcnt 17
__iso_chan_add:214: conn 00000000b6251073
iso_sock_clear_timer:117: sock 00000000eabd6557 state 3
...
hci_rx_work:4085: hci0 Event packet
hci_event_packet:7601: hci0: event 0x0f
hci_cmd_status_evt:4346: hci0: opcode 0x0406
hci_cs_disconnect:2760: hci0: status 0x0c
hci_sent_cmd_data:3107: hci0 opcode 0x0406
hci_conn_del:1151: hci0 hcon 000000001696f1fd handle 2560
hci_conn_unlink:1102: hci0: hcon 000000001696f1fd
hci_conn_drop:1451: hcon 00000000d8521aaf orig refcnt 2
hci_chan_list_flush:2780: hcon 000000001696f1fd
hci_dev_put:1487: hci0 orig refcnt 21
hci_dev_put:1487: hci0 orig refcnt 20
hci_req_cmd_complete:3978: opcode 0x0406 status 0x0c
... <no iso_* activity on sk/conn> ...
iso_sock_sendmsg:1098: sock 00000000dea5e2e0, sk 00000000eabd6557
BUG: kernel NULL pointer dereference, address: 0000000000000668
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP PTI
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
RIP: 0010:iso_sock_sendmsg (net/bluetooth/iso.c:1112) bluetooth
==========================================================

L2CAP:
==================================================================
hci_cmd_status_evt:4359: hci0: opcode 0x0406
hci_cs_disconnect:2760: hci0: status 0x0c
hci_sent_cmd_data:3085: hci0 opcode 0x0406
hci_conn_del:1151: hci0 hcon ffff88800c999000 handle 3585
hci_conn_unlink:1102: hci0: hcon ffff88800c999000
hci_chan_list_flush:2780: hcon ffff88800c999000
hci_chan_del:2761: hci0 hcon ffff88800c999000 chan ffff888018ddd280
...
BUG: KASAN: slab-use-after-free in hci_send_acl+0x2d/0x540 [bluetooth]
Read of size 8 at addr ffff888018ddd298 by task bluetoothd/1175

CPU: 0 PID: 1175 Comm: bluetoothd Tainted: G            E      6.4.0-rc4+ #2
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x5b/0x90
 print_report+0xcf/0x670
 ? __virt_addr_valid+0xf8/0x180
 ? hci_send_acl+0x2d/0x540 [bluetooth]
 kasan_report+0xa8/0xe0
 ? hci_send_acl+0x2d/0x540 [bluetooth]
 hci_send_acl+0x2d/0x540 [bluetooth]
 ? __pfx___lock_acquire+0x10/0x10
 l2cap_chan_send+0x1fd/0x1300 [bluetooth]
 ? l2cap_sock_sendmsg+0xf2/0x170 [bluetooth]
 ? __pfx_l2cap_chan_send+0x10/0x10 [bluetooth]
 ? lock_release+0x1d5/0x3c0
 ? mark_held_locks+0x1a/0x90
 l2cap_sock_sendmsg+0x100/0x170 [bluetooth]
 sock_write_iter+0x275/0x280
 ? __pfx_sock_write_iter+0x10/0x10
 ? __pfx___lock_acquire+0x10/0x10
 do_iter_readv_writev+0x176/0x220
 ? __pfx_do_iter_readv_writev+0x10/0x10
 ? find_held_lock+0x83/0xa0
 ? selinux_file_permission+0x13e/0x210
 do_iter_write+0xda/0x340
 vfs_writev+0x1b4/0x400
 ? __pfx_vfs_writev+0x10/0x10
 ? __seccomp_filter+0x112/0x750
 ? populate_seccomp_data+0x182/0x220
 ? __fget_light+0xdf/0x100
 ? do_writev+0x19d/0x210
 do_writev+0x19d/0x210
 ? __pfx_do_writev+0x10/0x10
 ? mark_held_locks+0x1a/0x90
 do_syscall_64+0x60/0x90
 ? lockdep_hardirqs_on_prepare+0x149/0x210
 ? do_syscall_64+0x6c/0x90
 ? lockdep_hardirqs_on_prepare+0x149/0x210
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7ff45cb23e64
Code: 15 d1 1f 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 80 3d 9d a7 0d 00 00 74 13 b8 14 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 89 54 24 1c 48 89
RSP: 002b:00007fff21ae09b8 EFLAGS: 00000202 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007ff45cb23e64
RDX: 0000000000000001 RSI: 00007fff21ae0aa0 RDI: 0000000000000017
RBP: 00007fff21ae0aa0 R08: 000000000095a8a0 R09: 0000607000053f40
R10: 0000000000000001 R11: 0000000000000202 R12: 00007fff21ae0ac0
R13: 00000fffe435c150 R14: 00007fff21ae0a80 R15: 000060f000000040
 </TASK>

Allocated by task 771:
 kasan_save_stack+0x33/0x60
 kasan_set_track+0x25/0x30
 __kasan_kmalloc+0xaa/0xb0
 hci_chan_create+0x67/0x1b0 [bluetooth]
 l2cap_conn_add.part.0+0x17/0x590 [bluetooth]
 l2cap_connect_cfm+0x266/0x6b0 [bluetooth]
 hci_le_remote_feat_complete_evt+0x167/0x310 [bluetooth]
 hci_event_packet+0x38d/0x800 [bluetooth]
 hci_rx_work+0x287/0xb20 [bluetooth]
 process_one_work+0x4f7/0x970
 worker_thread+0x8f/0x620
 kthread+0x17f/0x1c0
 ret_from_fork+0x2c/0x50

Freed by task 771:
 kasan_save_stack+0x33/0x60
 kasan_set_track+0x25/0x30
 kasan_save_free_info+0x2e/0x50
 ____kasan_slab_free+0x169/0x1c0
 slab_free_freelist_hook+0x9e/0x1c0
 __kmem_cache_free+0xc0/0x310
 hci_chan_list_flush+0x46/0x90 [bluetooth]
 hci_conn_cleanup+0x7d/0x330 [bluetooth]
 hci_cs_disconnect+0x35d/0x530 [bluetooth]
 hci_cmd_status_evt+0xef/0x2b0 [bluetooth]
 hci_event_packet+0x38d/0x800 [bluetooth]
 hci_rx_work+0x287/0xb20 [bluetooth]
 process_one_work+0x4f7/0x970
 worker_thread+0x8f/0x620
 kthread+0x17f/0x1c0
 ret_from_fork+0x2c/0x50
==================================================================

Fixes: b8d290525e39 ("Bluetooth: clean up connection in hci_cs_disconnect")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v3: no changes
    v2: call disconn_cfm for all conn types, as L2CAP also crashes.
        Correct commit in Fixes tag.

 net/bluetooth/hci_event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c184edc3cdf4..9d0f76ff9bbe 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2784,6 +2784,9 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 			hci_enable_advertising(hdev);
 		}
 
+		/* Inform sockets conn is gone before we delete it */
+		hci_disconn_cfm(conn, HCI_ERROR_UNSPECIFIED);
+
 		goto done;
 	}
 
-- 
2.41.0

