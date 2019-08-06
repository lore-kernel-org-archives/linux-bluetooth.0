Return-Path: <SRS0=gGyw=WC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7BAC31E40
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Aug 2019 09:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B0620651
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Aug 2019 09:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kactRKtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732409AbfHFJ4i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Aug 2019 05:56:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38839 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732262AbfHFJ4i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Aug 2019 05:56:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id az7so37633244plb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Aug 2019 02:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U2aUtVD8/MpA94Ks4Op5DFTmpoWAEdD/4dfm9zLQUIE=;
        b=kactRKtYlZF0OC/kf92bjnzhBRu8g+X3MCLzIjYlPoOuPDATKDr2wLugvdZBLy+E1n
         2XPPLJcqbAZuZdF43+OTqnZvYxKs1FfNekHXCFu2NzHOchGCf/eyRNe5Bi8nTg68zrEt
         eRZgbdBa/UmLjN5RoWxVCrC8PjVIPd0JIbGEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U2aUtVD8/MpA94Ks4Op5DFTmpoWAEdD/4dfm9zLQUIE=;
        b=Ap7hJxYJ5bd9uMJGZbNbK678liCvu9Ia9R+CVwoT6n8q5D1nEbJTYbo2L+WO19UtKB
         /LjD29IBfztscSp5w0y8VOsAihfrsAkgKQrAiikjQLCg9C2hQRs7QcMFRG2L5VhF68bR
         g5KoTO4Mic/rhGY//zLB9+B8v11rJetWt48QV9qwDD/MFY3inb01cbgChJE9TD36px4H
         YUbR+0G56yIpspoUAtQ6p++B1m3r/fIU8Uh2/0MaCertj39q30PXjACM2RpNvNG9riQF
         TxxoNqIW/DrPTt8RBUL4AACIPHSXMP4ekSHkL0yZKIb0NecItFNR/M/qMSHivCtMWQ8b
         V80w==
X-Gm-Message-State: APjAAAW1tA+6LEm+33tu63Tp9lqWS8un5BHhiw42K5RoMxpWCBvm6P6T
        mdem4ZeqrGWHA6OcvA6Ap9UlQQ==
X-Google-Smtp-Source: APXvYqxJIl0J5TDR3DY7hvfrmUT8ClwdVwyOrlMrhjDYzIJfhI20695Nyc5kg/4l8+G1B4IS7o6atQ==
X-Received: by 2002:a17:902:2be6:: with SMTP id l93mr2413969plb.0.1565085397566;
        Tue, 06 Aug 2019 02:56:37 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3db2:76bf:938b:be05])
        by smtp.gmail.com with ESMTPSA id y23sm90419457pfo.106.2019.08.06.02.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 02:56:36 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        tientzu@chromium.org, bgodavar@codeaurora.org,
        hemantg@codeaurora.org, rjliao@codeaurora.org
Subject: [PATCH] Bluetooth: btqca: release_firmware after qca_inject_cmd_complete_event
Date:   Tue,  6 Aug 2019 17:56:29 +0800
Message-Id: <20190806095629.88769-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

commit 32646db8cc28 ("Bluetooth: btqca: inject command complete event
during fw download") added qca_inject_cmd_complete_event() for certain
qualcomm chips. However, qca_download_firmware() will return without
calling release_firmware() in this case.

This leads to a memory leak like the following found by kmemleak:

unreferenced object 0xfffffff3868a5880 (size 128):
  comm "kworker/u17:5", pid 347, jiffies 4294676481 (age 312.157s)
  hex dump (first 32 bytes):
    ac fd 00 00 00 00 00 00 00 d0 7e 17 80 ff ff ff  ..........~.....
    00 00 00 00 00 00 00 00 00 59 8a 86 f3 ff ff ff  .........Y......
  backtrace:
    [<00000000978ce31d>] kmem_cache_alloc_trace+0x194/0x298
    [<000000006ea0398c>] _request_firmware+0x74/0x4e4
    [<000000004da31ca0>] request_firmware+0x44/0x64
    [<0000000094572996>] qca_download_firmware+0x74/0x6e4 [btqca]
    [<00000000b24d615a>] qca_uart_setup+0xc0/0x2b0 [btqca]
    [<00000000364a6d5a>] qca_setup+0x204/0x570 [hci_uart]
    [<000000006be1a544>] hci_uart_setup+0xa8/0x148 [hci_uart]
    [<00000000d64c0f4f>] hci_dev_do_open+0x144/0x530 [bluetooth]
    [<00000000f69f5110>] hci_power_on+0x84/0x288 [bluetooth]
    [<00000000d4151583>] process_one_work+0x210/0x420
    [<000000003cf3dcfb>] worker_thread+0x2c4/0x3e4
    [<000000007ccaf055>] kthread+0x124/0x134
    [<00000000bef1f723>] ret_from_fork+0x10/0x18
    [<00000000c36ee3dd>] 0xffffffffffffffff
unreferenced object 0xfffffff37b16de00 (size 128):
  comm "kworker/u17:5", pid 347, jiffies 4294676873 (age 311.766s)
  hex dump (first 32 bytes):
    da 07 00 00 00 00 00 00 00 50 ff 0b 80 ff ff ff  .........P......
    00 00 00 00 00 00 00 00 00 dd 16 7b f3 ff ff ff  ...........{....
  backtrace:
    [<00000000978ce31d>] kmem_cache_alloc_trace+0x194/0x298
    [<000000006ea0398c>] _request_firmware+0x74/0x4e4
    [<000000004da31ca0>] request_firmware+0x44/0x64
    [<0000000094572996>] qca_download_firmware+0x74/0x6e4 [btqca]
    [<000000000cde20a9>] qca_uart_setup+0x144/0x2b0 [btqca]
    [<00000000364a6d5a>] qca_setup+0x204/0x570 [hci_uart]
    [<000000006be1a544>] hci_uart_setup+0xa8/0x148 [hci_uart]
    [<00000000d64c0f4f>] hci_dev_do_open+0x144/0x530 [bluetooth]
    [<00000000f69f5110>] hci_power_on+0x84/0x288 [bluetooth]
    [<00000000d4151583>] process_one_work+0x210/0x420
    [<000000003cf3dcfb>] worker_thread+0x2c4/0x3e4
    [<000000007ccaf055>] kthread+0x124/0x134
    [<00000000bef1f723>] ret_from_fork+0x10/0x18
    [<00000000c36ee3dd>] 0xffffffffffffffff

Make sure release_firmware() is called aftre
qca_inject_cmd_complete_event() to avoid the memory leak.

Fixes: 32646db8cc28 ("Bluetooth: btqca: inject command complete event during fw download")
Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/bluetooth/btqca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 2221935fac7e..8f0fec5acade 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -344,7 +344,7 @@ static int qca_download_firmware(struct hci_dev *hdev,
 	 */
 	if (config->dnld_type == ROME_SKIP_EVT_VSE_CC ||
 	    config->dnld_type == ROME_SKIP_EVT_VSE)
-		return qca_inject_cmd_complete_event(hdev);
+		ret = qca_inject_cmd_complete_event(hdev);
 
 out:
 	release_firmware(fw);
-- 
2.22.0.770.g0f2c4a37fd-goog

