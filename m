Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A954BC4708C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Dec 2022 01:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiLFBXx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Dec 2022 20:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiLFBX0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Dec 2022 20:23:26 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29F21EC67
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Dec 2022 17:23:25 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d3so12494075plr.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Dec 2022 17:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fi2bsjulIyd9jI+GzTDgQYTOMk+6i0IWxJUAz5Meqtg=;
        b=IqOi7h3AsyN3rN5ImSXhfo9+SbU55VQg7wgQcdP9cLt5AiiiQSR6ZD9D2/+CIEcDK1
         DIRB4NyTO3ujd5cMuogBiPv2ui0CnMt9U7EY4XzgCrPTpeirbNhCSY5+prSffivJJItJ
         TLSJcQjZe+YHxmX3Xi0OXwB5uRaNQLWU5Fx7citQQXFYEQLnO6Hyqb+O41dgY4f+pkTR
         q9V2VhpKsZ2mk99GoqtNPwmnoYa/47gWkBIkt+ANdvgY5hw4oMr0GYfNKm9UUZvr+ga1
         jrDawwWZOb8TOm5KHtGVRoCCxmebqta1lu/K3lz1dBxEfsxC+l3NQyxQmhcPymamhSb0
         fPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fi2bsjulIyd9jI+GzTDgQYTOMk+6i0IWxJUAz5Meqtg=;
        b=uFq9iVacRrA/mlXNuzj9gai5VrzMUdZ+wKmFuVLHzfnL8HMlANKRTOZNSZOYXqBsB/
         6LZ7obx6Kpd3cwQVaAGOrKvTp2gPE/jMdqSDm7McUA/cWSr10KOwK6JBhoyQlACYrUP9
         F0htZ67ng/4OwVcGOHGoptEHIVm2/NLSHJi5DHxA7f/9vQS3Hx6K3lTQ9ddVw86/siKw
         pft36Io0Z8GYL+0ZrbE7N2rOS/5Uo5/qanGhxm5LSh6de6/Xg4i6WjVyCk8iIM8bOJTp
         6AsJMYsWuelal39Gv37PPo4OAkxsUD4SY+v93dZBszlgTRXZz2b82cLLjj7W8R/3xPZJ
         TEpA==
X-Gm-Message-State: ANoB5pl3llr8lKUHiWTs3AdSfiDiYhVV3eCZnLlP51NG3OZV2EUs2Mn9
        Gcdsk38tE09v9JejzTvuCe3Ag/6nr/xvjYCa
X-Google-Smtp-Source: AA0mqf5p1qHEi5rtkwWkPpiKdinNN7myjln/hIcIbgalpqIC5Dd3f1+HHQl+1qEyFsiabKgUQeQO/w==
X-Received: by 2002:a17:903:1c3:b0:189:e91b:c35 with SMTP id e3-20020a17090301c300b00189e91b0c35mr1677258plh.173.1670289804883;
        Mon, 05 Dec 2022 17:23:24 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b00189812a5397sm11127485plb.180.2022.12.05.17.23.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 17:23:24 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_conn: Fix crash on hci_create_cis_sync
Date:   Mon,  5 Dec 2022 17:23:23 -0800
Message-Id: <20221206012323.3684462-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When attempting to connect multiple ISO sockets without using
DEFER_SETUP may result in the following crash:

BUG: KASAN: null-ptr-deref in hci_create_cis_sync+0x18b/0x2b0
Read of size 2 at addr 0000000000000036 by task kworker/u3:1/50

CPU: 0 PID: 50 Comm: kworker/u3:1 Not tainted
6.0.0-rc7-02243-gb84a13ff4eda #4373
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.0-1.fc36 04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x19/0x27
 kasan_report+0xbc/0xf0
 ? hci_create_cis_sync+0x18b/0x2b0
 hci_create_cis_sync+0x18b/0x2b0
 ? get_link_mode+0xd0/0xd0
 ? __ww_mutex_lock_slowpath+0x10/0x10
 ? mutex_lock+0xe0/0xe0
 ? get_link_mode+0xd0/0xd0
 hci_cmd_sync_work+0x111/0x190
 process_one_work+0x427/0x650
 worker_thread+0x87/0x750
 ? process_one_work+0x650/0x650
 kthread+0x14e/0x180
 ? kthread_exit+0x50/0x50
 ret_from_fork+0x22/0x30
 </TASK>

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3287b2ca789e..d3e542c2fc3e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1879,7 +1879,7 @@ static int hci_create_cis_sync(struct hci_dev *hdev, void *data)
 			continue;
 
 		/* Check if all CIS(s) belonging to a CIG are ready */
-		if (conn->link->state != BT_CONNECTED ||
+		if (!conn->link || conn->link->state != BT_CONNECTED ||
 		    conn->state != BT_CONNECT) {
 			cmd.cp.num_cis = 0;
 			break;
-- 
2.37.3

