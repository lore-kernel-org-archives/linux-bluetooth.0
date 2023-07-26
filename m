Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7F8C41513
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 21:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjGZVZg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjGZVZe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 17:25:34 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEF22696
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 14:25:27 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RB6Pc5v2Pz49Q8v;
        Thu, 27 Jul 2023 00:25:24 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1690406724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMgCNiowYcVwTJgtBDh2A83DyXYyukMEAHg7jcthnoU=;
        b=qzxtCh0D4+ZFSRUzhS0PIHiOTuk0mvkA03JSPFnxIz7f1n54g5sOrmLCrh7mEmEcFSXdoj
        u7kX2BEgQQq4AXzaiwdk6XOq0tWcoanctHydNsR8Bky2NVWPqFeQ3Fsmx37bzjbR9kUciV
        8TElYVJr289GGFgHduV7azqO0wAGsRCLhzcxRs8LqdwMNZCp6ttLCh+eXAXBfsXLMXuQpm
        y3wesvKgY0U9zi69W+v+EWUCkdfVhIaMOWI32DHRTuYF+f0OV9YZadJXa1uLprpUOChcvI
        xlXN8OOeF2XOFqlH91feFr7QBpiSc27tSdHTr3JCUKTB18BOGaagBKQZqVm5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1690406724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMgCNiowYcVwTJgtBDh2A83DyXYyukMEAHg7jcthnoU=;
        b=iX5EHdPt8iwj4+G0nhEDcoQwju1w24BY8hbbBL8e3fMHHjCi7pXfNlMxkRxkZJF+NmueFu
        i/ErLQYKhKZkzm/aoFNh0X8UKvnB7UEyN+sVZqQMNZLSk8T24Sz14qfjtXePjnh+whRaC+
        0XCK0IYeSagIasAXYWFsZDlbpUM5QPVSu/XwYsUhXPh1LLeQb2ikBD7evzbQjNWyaodGFB
        ZFNe2g8Ej7TrG7qnOOPOaR3LH8yS5mwj3WVzVsB3Rc2vnsdOHs8/7cksMuri321FX6CJpC
        ur2G+3rgMKdwCnyuz+6ecGefgM+zgz59M9hye/Sjgq/qb8VHDN3aElGP8WnRZQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1690406724; a=rsa-sha256;
        cv=none;
        b=dJ0uRat+vU2kVTR1DZPYyCL5bUXhgTp+uWB3OOY//i83NN5xvN4nEDUDZ9i3l/eYfprULz
        KivjmIltIUNbF0EiM/SsEWzZyiAODF+8CWbCImL3ZsnziKDBYVN31RJEFbPBKh4VxZHXsw
        0MLhK3s7AE8i6uYYMcISS6fKUQgLpg4CUuXyWY4uogRypq+RUFZHiL3LthbCNhRbpf9ux4
        0V8xJsfclBCofQI73/SiKRmr36z2Ebr5OKT++SMTFUMxf5BtArT90Ku9++1gX8iJ8u1sqB
        HGk3cTt6Y3p75kv2S7kEaGqqc9pxhKVx+G8XNCtRx4mtkBQ8m24zAly0d+MXyQ==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/5] sco-tester: test local and remote disconnecting simultaneously
Date:   Thu, 27 Jul 2023 00:25:16 +0300
Message-ID: <42624101a0b94ad773f4f58f94910f3e8ab8beaa.1690405564.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690405564.git.pav@iki.fi>
References: <cover.1690405564.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Demonstrate a kernel race condition when remote side disconnects at the
same time as local side tries to cancel the connection. I.e.

	[controller] > HCI Synchronous Connect Complete
	[controller] > HCI Disconnection Complete (from remote)
	[user] shutdown(sco_socket)
	[kernel] hci_conn_abort(SCO handle)
	[kernel] > HCI Create Connection Cancel
	[kernel] < HCI Synchronous Connect Complete
	[kernel] < HCI Disconnect Complete
	[controller] < HCI Create Connection Cancel
	[controller] > HCI Command Status (Create Connection Cancel)
	[kernel] < HCI Command Status (Create Connection Cancel)

and then we get BUG: KASAN: slab-use-after-free in hci_conn_failed when
hci_conn_abort tries to delete the same connection a second time.

This type of crash is probably not limited to the sequence here, but for
this one it was possible to get the timing right in the emulator.

Add a test that hits this in the emulator environment (pretty narrow
window to hit on real hardware):

eSCO Simultaneous Disconnect - Failure
---

Notes:
    ==================================================================
    BUG: KASAN: slab-use-after-free in hci_conn_failed+0x25/0x190
    Read of size 8 at addr ffff8880029e1958 by task kworker/u3:2/35
    
    CPU: 0 PID: 35 Comm: kworker/u3:2 Not tainted 6.5.0-rc1-00520-gf57f797eebfe #152
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
    Workqueue: hci0 hci_cmd_sync_work
    Call Trace:
     <TASK>
     print_report+0xce/0x620
     ? __virt_addr_valid+0xd8/0x160
     ? hci_conn_failed+0x25/0x190
     kasan_report+0xd5/0x110
     ? hci_conn_failed+0x25/0x190
     hci_conn_failed+0x25/0x190
     hci_abort_conn_sync+0x23b/0x370
     ? __pfx_hci_abort_conn_sync+0x10/0x10
     ? __pfx_lock_acquire+0x10/0x10
     ? __pfx_abort_conn_sync+0x10/0x10
     ? __pfx_abort_conn_sync+0x10/0x10
     hci_cmd_sync_work+0x125/0x200
     process_one_work+0x4ee/0x8f0
     ? __pfx_process_one_work+0x10/0x10
     ? __kthread_parkme+0x5f/0xe0
     ? mark_held_locks+0x1a/0x90
     worker_thread+0x8c/0x630
     ? __kthread_parkme+0xc5/0xe0
     ? __pfx_worker_thread+0x10/0x10
     kthread+0x17c/0x1c0
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x2b/0x50
     </TASK>
    
    Allocated by task 31:
     kasan_save_stack+0x33/0x60
     kasan_set_track+0x24/0x30
     __kasan_kmalloc+0x8f/0xa0
     hci_conn_add+0xa8/0xad0
     hci_connect_sco+0x1cf/0x6e0
     sco_sock_connect+0x1a2/0x600
     __sys_connect+0x1a2/0x1d0
     __x64_sys_connect+0x3b/0x50
     do_syscall_64+0x47/0x90
     entry_SYSCALL_64_after_hwframe+0x6c/0xd6
    
    Freed by task 32:
     kasan_save_stack+0x33/0x60
     kasan_set_track+0x24/0x30
     kasan_save_free_info+0x2b/0x50
     __kasan_slab_free+0xfa/0x150
     __kmem_cache_free+0xab/0x200
     device_release+0x58/0xf0
     kobject_put+0xee/0x310
     hci_disconn_complete_evt+0x276/0x3a0
     hci_event_packet+0x54b/0x800
     hci_rx_work+0x2a4/0xae0
     process_one_work+0x4ee/0x8f0
     worker_thread+0x8c/0x630
     kthread+0x17c/0x1c0
     ret_from_fork+0x2b/0x50
    
    Last potentially related work creation:
     kasan_save_stack+0x33/0x60
     __kasan_record_aux_stack+0x94/0xa0
     insert_work+0x2d/0x150
     __queue_work+0x2f1/0x610
     queue_delayed_work_on+0x88/0x90
     sco_chan_del+0x117/0x230
     sco_sock_shutdown+0x109/0x230
     __sys_shutdown+0xb4/0x130
     __x64_sys_shutdown+0x29/0x40
     do_syscall_64+0x47/0x90
     entry_SYSCALL_64_after_hwframe+0x6c/0xd6
    
    The buggy address belongs to the object at ffff8880029e1000
     which belongs to the cache kmalloc-4k of size 4096
    The buggy address is located 2392 bytes inside of
     freed 4096-byte region [ffff8880029e1000, ffff8880029e2000)
    
    The buggy address belongs to the physical page:
    page:ffffea00000a7800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29e0
    head:ffffea00000a7800 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
    flags: 0x4000000000010200(slab|head|zone=1)
    page_type: 0xffffffff()
    raw: 4000000000010200 ffff8880010424c0 ffffea0000063010 ffffea00000a8610
    raw: 0000000000000000 0000000000020002 00000001ffffffff 0000000000000000
    page dumped because: kasan: bad access detected
    
    Memory state around the buggy address:
     ffff8880029e1800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
     ffff8880029e1880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
    >ffff8880029e1900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                        ^
     ffff8880029e1980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
     ffff8880029e1a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
    ==================================================================

 tools/sco-tester.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index 44606328a..f3de42c7b 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -29,6 +29,7 @@
 
 #include "src/shared/tester.h"
 #include "src/shared/mgmt.h"
+#include "src/shared/util.h"
 
 struct test_data {
 	const void *test_data;
@@ -37,6 +38,7 @@ struct test_data {
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
 	unsigned int io_id;
+	int sk;
 	bool disable_esco;
 	bool enable_codecs;
 };
@@ -225,6 +227,7 @@ static void test_data_free(void *test_data)
 			break; \
 		user->hciemu_type = HCIEMU_TYPE_BREDRLE; \
 		user->io_id = 0; \
+		user->sk = -1; \
 		user->test_data = data; \
 		user->disable_esco = _disable_esco; \
 		user->enable_codecs = _enable_codecs; \
@@ -250,6 +253,10 @@ static const struct sco_client_data connect_failure = {
 	.expect_err = EOPNOTSUPP
 };
 
+static const struct sco_client_data connect_failure_reset = {
+	.expect_err = ECONNRESET
+};
+
 const uint8_t data[] = {0, 1, 2, 3, 4, 5, 6, 7, 8};
 
 static const struct sco_client_data connect_send_success = {
@@ -650,6 +657,8 @@ static void test_connect(const void *test_data)
 		return;
 	}
 
+	data->sk = sk;
+
 	io = g_io_channel_unix_new(sk);
 	g_io_channel_set_close_on_unref(io, TRUE);
 
@@ -745,6 +754,52 @@ static void test_connect_offload_msbc(const void *test_data)
 end:
 	close(sk);
 }
+
+static bool hook_simult_disc(const void *msg, uint16_t len, void *user_data)
+{
+	const struct bt_hci_evt_sync_conn_complete *ev = msg;
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost;
+
+	tester_print("Simultaneous disconnect");
+
+	if (len != sizeof(struct bt_hci_evt_sync_conn_complete)) {
+		tester_test_failed();
+		return true;
+	}
+
+	/* Disconnect from local and remote sides at the same time */
+	bthost = hciemu_client_get_host(data->hciemu);
+	bthost_hci_disconnect(bthost, le16_to_cpu(ev->handle), 0x13);
+
+	shutdown(data->sk, SHUT_RDWR);
+
+	return true;
+}
+
+static bool hook_delay_cmd(const void *data, uint16_t len, void *user_data)
+{
+	tester_print("Delaying emulator response...");
+	g_usleep(250000);
+	tester_print("Delaying emulator response... Done.");
+	return true;
+}
+
+static void test_connect_simult_disc(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	/* Kernel shall not crash, but <= 6.5-rc1 crash */
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_EVT,
+					BT_HCI_EVT_SYNC_CONN_COMPLETE,
+					hook_simult_disc, NULL);
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_CMD,
+					BT_HCI_CMD_CREATE_CONN_CANCEL,
+					hook_delay_cmd, NULL);
+
+	test_connect(test_data);
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -767,6 +822,10 @@ int main(int argc, char *argv[])
 	test_sco("eSCO mSBC - Success", &connect_success, setup_powered,
 							test_connect_transp);
 
+	test_sco("eSCO Simultaneous Disconnect - Failure",
+					&connect_failure_reset, setup_powered,
+					test_connect_simult_disc);
+
 	test_sco_11("SCO CVSD 1.1 - Success", &connect_success, setup_powered,
 							test_connect);
 
-- 
2.41.0

