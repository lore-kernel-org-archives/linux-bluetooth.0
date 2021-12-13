Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7DFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Dec 2021 21:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhLMV1E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Dec 2021 16:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243117AbhLMV0x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Dec 2021 16:26:53 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F726C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Dec 2021 13:26:53 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id x5so16162460pfr.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Dec 2021 13:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fCOmWKEfH+JMS5IpmeCoTZQmdGsrry79PJCrAalq+Gg=;
        b=Cza5vapEJPlsBAyBYx8atFEnIgGBSV1ph5Us98sQkX7fCYqsLzD41rwFn++uJs58sB
         kiKlCNG7/BGP0Mf5XfOT1NbELyZMCVr/ZGdLfaUJ76wc4qtK3N5rkxeWdVYiG+k1zt2c
         sAWKy5KIj1Wu9F2bmAwfIkXxhypAZv6E7w8Pks++zxfqoi98K51smalnCBaHHigJUcJB
         UxV1LTBZui8Wmx9BXTQ5HIon6JfN5YiDYSmDVRHNeAPjU9Z4PoGOJu1rez0Osak5DIUu
         Q/gFV+IEyT3cNmVt4ilYmP4yUi4NGU62KNeUK0bZcMmDxUFLPyuwWet94amZkSzouAm6
         U93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fCOmWKEfH+JMS5IpmeCoTZQmdGsrry79PJCrAalq+Gg=;
        b=sZFCtD9CHJikjoP9fG68HmbKZtv90+dJRDVyYZQvGVXWMe8EcmrVV9bjFGj/WN/LZA
         JqLFBcOW3A6u3VIJY6EZZVHD92vt5Q/LhJriij6gE/yiYUjn8QOmRZjO24xPCg7LgHFa
         HK1C/tKF2W5MCAszXF/27/GoEtZjzv+qNjhlK+r6185CK5k9P0JiH69MiRYo2LG4BaTd
         RH5Dxx2L1aR6kCEkTLmbtrSXHslirfwlh6LB9LeJHsMHqRmQMMciv4yeIt2kM283OeE+
         d8P8N9ZFf6hZbRKZ8m++lHY+LadViljsWPltPq5vhAUiq+qPiO10SEFMNJMpXlBl6BZs
         nM4g==
X-Gm-Message-State: AOAM532OROHTlH3712RLY89U7nRt+x2x2XB2p5UhpIe0zt2M+dHU9iY3
        084psBseC9/q8QTq/79LYH9EenpvSzg=
X-Google-Smtp-Source: ABdhPJzOCFAAcFztf1gInA2a2ZD9NmEL9WLCzzZ5++AsnFyP1p3MPoF7zeeAyXFPTbjj4EnTBA3r6A==
X-Received: by 2002:a62:1d09:0:b0:4a2:82d7:17a5 with SMTP id d9-20020a621d09000000b004a282d717a5mr701770pfd.64.1639430812338;
        Mon, 13 Dec 2021 13:26:52 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f7sm13112672pfj.41.2021.12.13.13.26.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 13:26:51 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: mgmt: Fix mgmt_device_found panic
Date:   Mon, 13 Dec 2021 13:26:50 -0800
Message-Id: <20211213212650.2067066-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following buffer overflow when Class of Device is
missing:

skbuff: skb_over_panic: text:ffffffff8b70f8c0 len:335 put:163
head:ffff888001388000 data:ffff888001388006 tail:0x155 end:0xc0
dev:<NULL>
kernel BUG at net/core/skbuff.c:113!
invalid opcode: 0000 [#1] PREEMPT KASAN PTI
CPU: 0 PID: 51 Comm: kworker/u3:2 Not tainted
5.16.0-rc1-14427-g77755dc54f9e-dirty #2795
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-6.fc35
04/01/2014
Workqueue: hci0 hci_rx_work
RIP: 0010:skb_panic+0xc7/0xc9
Code: 89 f0 48 c7 c7 00 d7 d5 8b 55 48 8b 74 24 18 4d 89 f9 56 48 8b 54
24 18 4c 89 e6 52 48 8b 44 24 18 4c 89 ea 50 e8 80 ac fd ff <0f> 0b 48
c7 c6 60 e0 d5 8b 48 c7 c7 9
RSP: 0018:ffff88800181fa08 EFLAGS: 00010286
RAX: 0000000000000088 RBX: ffff88800197c600 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffed1000303f34
RBP: ffffffff8bd5d6c0 R08: 0000000000000088 R09: ffff88800181f6a7
R10: ffffed1000303ed4 R11: 0000000000000001 R12: ffffffff8bd5dfa0
R13: ffffffff8b70f8c0 R14: 00000000000000a3 R15: ffff888001388000
FS:  0000000000000000(0000) GS:ffffffff8c097000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f235d05519d CR3: 00000000018c8000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? mgmt_device_found+0x5c0/0x680
 skb_put.cold+0x1f/0x1f
 mgmt_device_found+0x5c0/0x680
 ? kasan_unpoison+0x23/0x50
 ? mgmt_set_local_name_complete+0x1d0/0x1d0
 ? hci_inquiry_cache_update+0x51/0x3e0
 hci_extended_inquiry_result_evt+0x2e9/0x3d0
 ? hci_inquiry_result_evt+0x280/0x280
 ? mutex_unlock+0x7a/0xc0
 ? mutex_lock+0xd0/0xd0
 ? bt_dbg_get+0x10/0x10
 hci_event_packet+0x4a7/0x720
 ? hci_inquiry_result_evt+0x280/0x280
 ? hci_encrypt_change_evt+0x970/0x970
 ? skb_release_data+0x9d/0x230
 hci_rx_work+0x134/0x450
 ? read_word_at_a_time+0xe/0x20
 ? strscpy+0xb5/0x190
 process_one_work+0x435/0x690
 worker_thread+0x2c7/0x7e0
 ? process_one_work+0x690/0x690
 kthread+0x20e/0x240
 ? set_kthread_struct+0x80/0x80
 ret_from_fork+0x22/0x30
 </TASK>
---[ end trace 6885a67d9b75dd49 ]---
RIP: 0010:skb_panic+0xc7/0xc9
Code: 89 f0 48 c7 c7 00 d7 d5 8b 55 48 8b 74 24 18 4d 89 f9 56 48 8b 54
24 18 4c 89 e6 52 48 8b 44 24 18 4c 89 ea 50 e8 80 ac fd ff <0f> 0b 48
c7 c6 60 e0 d5 8b 48 c7 c7 9
RSP: 0018:ffff88800181fa08 EFLAGS: 00010286
RAX: 0000000000000088 RBX: ffff88800197c600 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffed1000303f34
RBP: ffffffff8bd5d6c0 R08: 0000000000000088 R09: ffff88800181f6a7
R10: ffffed1000303ed4 R11: 0000000000000001 R12: ffffffff8bd5dfa0
R13: ffffffff8b70f8c0 R14: 00000000000000a3 R15: ffff888001388000
FS:  0000000000000000(0000) GS:ffffffff8c097000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f235d05519d CR3: 00000000018c8000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Fixes: 2023db7e3a343 ("Bluetooth: mgmt: Make use of mgmt_send_event_skb in MGMT_EV_DEVICE_FOUND")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4e1557281956..3326d9459dd3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9601,7 +9601,7 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 
 	/* Allocate skb. The 5 extra bytes are for the potential CoD field */
 	skb = mgmt_alloc_skb(hdev, MGMT_EV_DEVICE_FOUND,
-			     sizeof(ev) + eir_len + scan_rsp_len + 5);
+			     sizeof(*ev) + eir_len + scan_rsp_len + 5);
 	if (!skb)
 		return;
 
@@ -9633,7 +9633,7 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 
 		eir_len += eir_append_data(eir_cod, 0, EIR_CLASS_OF_DEV,
 					   dev_class, 3);
-		skb_put_data(skb, eir_cod, eir_len);
+		skb_put_data(skb, eir_cod, sizeof(eir_cod));
 	}
 
 	if (scan_rsp_len > 0)
-- 
2.33.1

