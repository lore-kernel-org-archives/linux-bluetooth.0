Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17072C4338F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Aug 2021 23:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA1EE61283
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Aug 2021 23:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhHOXeN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Aug 2021 19:34:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:10512 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230124AbhHOXeL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Aug 2021 19:34:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10077"; a="215770530"
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="215770530"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2021 16:33:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="461873575"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga007.jf.intel.com with ESMTP; 15 Aug 2021 16:33:37 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mmandlik@google.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth: Fix race condition in handling NOP command
Date:   Mon, 16 Aug 2021 05:07:47 +0530
Message-Id: <20210815233747.6969-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For NOP command, need to cancel work scheduled on cmd_timer,
on receiving command status or commmand complete event.

Below use case might lead to race condition multiple when NOP
commands are queued sequentially:

hci_cmd_work() {
   if (atomic_read(&hdev->cmd_cnt) {
            .
            .
            .
      atomic_dec(&hdev->cmd_cnt);
      hci_send_frame(hdev,...);
      schedule_delayed_work(&hdev->cmd_timer,...);
   }
}

On receiving event for first NOP, the work scheduled on hdev->cmd_timer
is not cancelled and second NOP is dequeued and sent to controller.

While waiting for an event for second NOP command, work scheduled on
cmd_timer for the first NOP can get scheduled, resulting in sending third
NOP command (sending back to back NOP commands). This might
cause issues at controller side (like memory overrun, controller going
unresponsive) resulting in hci tx timeouts, hardware errors etc.

The fix to this issue is to cancel the delayed work scheduled on
cmd_timer on receiving command status or command complete event for
NOP command (this patch handles NOP command same as any other SIG
command).

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
Acked-by: Manish Mandlik <mmandlik@google.com>
---
 net/bluetooth/hci_event.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 38decf474f31..f07c9c3726fe 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3310,11 +3310,9 @@ static void hci_remote_features_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
-static inline void handle_cmd_cnt_and_timer(struct hci_dev *hdev,
-					    u16 opcode, u8 ncmd)
+static inline void handle_cmd_cnt_and_timer(struct hci_dev *hdev, u8 ncmd)
 {
-	if (opcode != HCI_OP_NOP)
-		cancel_delayed_work(&hdev->cmd_timer);
+	cancel_delayed_work(&hdev->cmd_timer);
 
 	if (!test_bit(HCI_RESET, &hdev->flags)) {
 		if (ncmd) {
@@ -3689,7 +3687,7 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		break;
 	}
 
-	handle_cmd_cnt_and_timer(hdev, *opcode, ev->ncmd);
+	handle_cmd_cnt_and_timer(hdev, ev->ncmd);
 
 	hci_req_cmd_complete(hdev, *opcode, *status, req_complete,
 			     req_complete_skb);
@@ -3790,7 +3788,7 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		break;
 	}
 
-	handle_cmd_cnt_and_timer(hdev, *opcode, ev->ncmd);
+	handle_cmd_cnt_and_timer(hdev, ev->ncmd);
 
 	/* Indicate request completion if the command failed. Also, if
 	 * we're not waiting for a special event and we get a success
-- 
2.17.1

