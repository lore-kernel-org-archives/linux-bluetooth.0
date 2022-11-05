Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CA8C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Nov 2022 19:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiKETFy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 5 Nov 2022 15:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKETFx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 5 Nov 2022 15:05:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F21A9583
        for <linux-bluetooth@vger.kernel.org>; Sat,  5 Nov 2022 12:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667675096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fMzdSVUxKzfJHte4Vux2hVjWJ41SsNMVC7KP71E/b/A=;
        b=Bsp4D4uY4xKa+28fS1YcocwuX1C0agJ8JSBM7TmWF1oC/kD/KsK7Pk+iXyvfARg7EJ9IsK
        Oey28NYVV/ueCjmUtc270buPXBYjwOA0rKUEy3PYwCcvq/8M+r/JUo58HVAyFg72G3nPZ9
        0F6TQXoWIZjVc4xUn6qjKJchhgKaqNU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-640-f8isVAiePUidgjzGrxktSg-1; Sat, 05 Nov 2022 15:04:55 -0400
X-MC-Unique: f8isVAiePUidgjzGrxktSg-1
Received: by mail-pl1-f199.google.com with SMTP id s15-20020a170902ea0f00b00187050232fcso5877444plg.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 05 Nov 2022 12:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMzdSVUxKzfJHte4Vux2hVjWJ41SsNMVC7KP71E/b/A=;
        b=uEbf1mR5OCZX2tdQUJO8lsGjSAehifTUro5jTIGNMEJVsm5M2vQM7ISJnh9odzotDZ
         0BMu5tHJ2A9TKnQ8s/8C1/8rY0Z5Sda0aBd7binmSTo2oPZy1Gn1vrJC3lDU79b2dfVm
         +bdXXzICl0gBdRu/RVw3eCdsAu0GVoysqRebWY/SYBfjIbUXt1L8LTDNKeytDceg+86l
         mRDM6wutKJXdVZNFJmJDSKecRhNnk5u4Xj/4lCGwI71aKfDd/YTV19Ch/VzlVKHjxN/D
         /2GjQwefH06cPS8Do9bMa2LKjvLvHI1u6zm3YXCBXPE4s4fbd++mtT0Rluus4F9SWn3f
         ZrOQ==
X-Gm-Message-State: ACrzQf0WEwAf/13kmLd+LOOLix/f447vXJiRLaXV7WquXTR6H1v0fbvU
        OlWrkj068Qo1l/5qr2BU9ym7nZLyYuuL64G6XBGnfomyVFSUPGw7ZMlYxsofFaP3NiVtyE94bxg
        CAaLY+17wyLhypRsTq4XfavgFu0pV
X-Received: by 2002:a05:6a00:a8c:b0:558:991a:6691 with SMTP id b12-20020a056a000a8c00b00558991a6691mr42009590pfl.53.1667675093778;
        Sat, 05 Nov 2022 12:04:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5D2hSXvk8kyWEGa1X5jowmFyC1fJpWFKAKj5E4KNYRak6FWEYFFNtXoe78WT4AeqLosIE1tA==
X-Received: by 2002:a05:6a00:a8c:b0:558:991a:6691 with SMTP id b12-20020a056a000a8c00b00558991a6691mr42009574pfl.53.1667675093464;
        Sat, 05 Nov 2022 12:04:53 -0700 (PDT)
Received: from ryzen.. ([240d:1a:c0d:9f00:fc9c:8ee9:e32c:2d9])
        by smtp.gmail.com with ESMTPSA id jd10-20020a170903260a00b00185507b5ef8sm2009003plb.50.2022.11.05.12.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 12:04:53 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Shigeru Yoshida <syoshida@redhat.com>,
        syzbot+19a9f729f05272857487@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: Fix use-after-free read in hci_cmd_timeout()
Date:   Sun,  6 Nov 2022 04:04:46 +0900
Message-Id: <20221105190446.1324053-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot reported use-after-free in hci_cmd_timeout() [1].  The scenario
for the issue is as follows:

Task                                    Workqueue
----------------------------------------------------------------------
hci_dev_open_sync
  ...
  hci_dev_init_sync  <- failed
  ...
  if (hdev->sent_cmd)
    kfree_skb(hdev->sent_cmd)
                                        hci_cmd_timeout
                                          ...
                                          if (hdev->sent_cmd)
                                            sent = hdev->sent_cmd->data
                                                   ^^ UAF occurred
    hdev->sent_cmd = NULL

When hci_dev_init_sync() failed, hci_dev_open_sync() frees
hdev->send_cmd and set it to NULL.  However, hci_cmd_timeout() can run
just after freeing hdev->sent_cmd because hdev->cmd_timer is not
canceled.

This patch fixes the issue by canceling hdev->cmd_timer before freeing
hdev->sent_cmd.

Link: https://syzkaller.appspot.com/bug?id=cb23ebfc8f304f510fb717cb783fe8b496c7ffb1 [1]
Reported-by: syzbot+19a9f729f05272857487@syzkaller.appspotmail.com
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/bluetooth/hci_sync.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 76c3107c9f91..a011065220e4 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4696,6 +4696,7 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 			hdev->flush(hdev);
 
 		if (hdev->sent_cmd) {
+			cancel_delayed_work_sync(&hdev->cmd_timer);
 			kfree_skb(hdev->sent_cmd);
 			hdev->sent_cmd = NULL;
 		}
-- 
2.38.1

