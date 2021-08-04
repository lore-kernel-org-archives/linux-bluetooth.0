Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15398C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 17:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC4CE60EE9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 17:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhHDRft (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 13:35:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:15800 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229869AbhHDRft (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 13:35:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="193566303"
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="193566303"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 10:35:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="585531029"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga001.fm.intel.com with ESMTP; 04 Aug 2021 10:35:32 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: Fix race condition in handling NOP command
Date:   Wed,  4 Aug 2021 23:09:39 +0530
Message-Id: <20210804173939.25496-1-kiran.k@intel.com>
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
is not cancelled and  second NOP is dequeued and sent to controller.

While waiting for an event for second NOP command, work scheduled on
cmd_timer for first NOP can get scheduled, resulting in sending third
NOP command not waiting for an event for second NOP. This might cause
issues at controller side (like memory overrun, controller going
unresponsive) resulting in hci tx timeouts, hardware errors etc.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 net/bluetooth/hci_event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ea7fc09478be..14dfbdc8b81b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3271,8 +3271,7 @@ static void hci_remote_features_evt(struct hci_dev *hdev,
 static inline void handle_cmd_cnt_and_timer(struct hci_dev *hdev,
 					    u16 opcode, u8 ncmd)
 {
-	if (opcode != HCI_OP_NOP)
-		cancel_delayed_work(&hdev->cmd_timer);
+	cancel_delayed_work(&hdev->cmd_timer);
 
 	if (!test_bit(HCI_RESET, &hdev->flags)) {
 		if (ncmd) {
-- 
2.17.1

