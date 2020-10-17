Return-Path: <SRS0=DAWq=DY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE85C433E7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Oct 2020 11:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5980E206DC
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Oct 2020 11:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="fqNV8nK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437439AbgJQLZJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Oct 2020 07:25:09 -0400
Received: from aer-iport-1.cisco.com ([173.38.203.51]:17083 "EHLO
        aer-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437368AbgJQLZD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Oct 2020 07:25:03 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Oct 2020 07:25:01 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2586; q=dns/txt; s=iport;
  t=1602933901; x=1604143501;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zWAOklSiEfjiqk5mXCjpJfjnz/5ID4xXFtRMOk57nFw=;
  b=fqNV8nK4OHX0k0Q1psIVvLdcJ6tcTJln+wEnx7rqFmhZgM9JgFDlPAV4
   Hl8XMIHCbU1z8+6pBLSbifbJdWVg7x4yys6NppbcuFjI7dkvaVSZyMZrm
   sLMviGsL1SH5ue13kn3Gq9PlVIZzug7tzIfzhOkfyGnFYThcmoIxhldHQ
   I=;
X-IronPort-AV: E=Sophos;i="5.77,386,1596499200"; 
   d="scan'208";a="30426180"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 17 Oct 2020 11:17:45 +0000
Received: from omidtbo-desktop.rd.cisco.com ([10.47.76.142])
        by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id 09HBHjRG009620;
        Sat, 17 Oct 2020 11:17:45 GMT
From:   =?UTF-8?q?Ole=20Bj=C3=B8rn=20Midtb=C3=B8?= <omidtbo@cisco.com>
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        =?UTF-8?q?Ole=20Bj=C3=B8rn=20Midtb=C3=B8?= <omidtbo@cisco.com>
Subject: [PATCH] Bluetooth: hidp: use correct wait queue when removing ctrl_wait
Date:   Sat, 17 Oct 2020 13:15:44 +0200
Message-Id: <20201017111544.2838773-1-omidtbo@cisco.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.47.76.142, [10.47.76.142]
X-Outbound-Node: aer-core-1.cisco.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

A different wait queue was used when removing ctrl_wait than when adding
it. This effectively made the remove operation without locking compared
to other operations on the wait queue ctrl_wait was part of. This caused
issues like below where dead000000000100 is LIST_POISON1 and
dead000000000200 is LIST_POISON2.

 list_add corruption. next->prev should be prev (ffffffc1b0a33a08), \
	but was dead000000000200. (next=ffffffc03ac77de0).
 ------------[ cut here ]------------
 CPU: 3 PID: 2138 Comm: bluetoothd Tainted: G           O    4.4.238+ #9
 ...
 ---[ end trace 0adc2158f0646eac ]---
 Call trace:
 [<ffffffc000443f78>] __list_add+0x38/0xb0
 [<ffffffc0000f0d04>] add_wait_queue+0x4c/0x68
 [<ffffffc00020eecc>] __pollwait+0xec/0x100
 [<ffffffc000d1556c>] bt_sock_poll+0x74/0x200
 [<ffffffc000bdb8a8>] sock_poll+0x110/0x128
 [<ffffffc000210378>] do_sys_poll+0x220/0x480
 [<ffffffc0002106f0>] SyS_poll+0x80/0x138
 [<ffffffc00008510c>] __sys_trace_return+0x0/0x4

 Unable to handle kernel paging request at virtual address dead000000000100
 ...
 CPU: 4 PID: 5387 Comm: kworker/u15:3 Tainted: G        W  O    4.4.238+ #9
 ...
 Call trace:
  [<ffffffc0000f079c>] __wake_up_common+0x7c/0xa8
  [<ffffffc0000f0818>] __wake_up+0x50/0x70
  [<ffffffc000be11b0>] sock_def_wakeup+0x58/0x60
  [<ffffffc000de5e10>] l2cap_sock_teardown_cb+0x200/0x224
  [<ffffffc000d3f2ac>] l2cap_chan_del+0xa4/0x298
  [<ffffffc000d45ea0>] l2cap_conn_del+0x118/0x198
  [<ffffffc000d45f8c>] l2cap_disconn_cfm+0x6c/0x78
  [<ffffffc000d29934>] hci_event_packet+0x564/0x2e30
  [<ffffffc000d19b0c>] hci_rx_work+0x10c/0x360
  [<ffffffc0000c2218>] process_one_work+0x268/0x460
  [<ffffffc0000c2678>] worker_thread+0x268/0x480
  [<ffffffc0000c94e0>] kthread+0x118/0x128
  [<ffffffc000085070>] ret_from_fork+0x10/0x20
  ---[ end trace 0adc2158f0646ead ]---

Signed-off-by: Ole Bjørn Midtbø <omidtbo@cisco.com>
---
 net/bluetooth/hidp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index bef84b95e2c4..ac98e3b37ab4 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -1290,7 +1290,7 @@ static int hidp_session_thread(void *arg)
 
 	/* cleanup runtime environment */
 	remove_wait_queue(sk_sleep(session->intr_sock->sk), &intr_wait);
-	remove_wait_queue(sk_sleep(session->intr_sock->sk), &ctrl_wait);
+	remove_wait_queue(sk_sleep(session->ctrl_sock->sk), &ctrl_wait);
 	wake_up_interruptible(&session->report_queue);
 	hidp_del_timer(session);
 
-- 
2.26.2

