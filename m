Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C54ECAAD2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Sep 2022 00:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbiIBA1W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 20:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbiIBA1V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 20:27:21 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDD395ADE
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 17:27:20 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id z3-20020a17090abd8300b001fd803e34f1so4004470pjr.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Sep 2022 17:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=sNx64mG9XeE6HyPYXQSn8k/iXLoWHAOBZBM7roZm538=;
        b=kKn0jsNP13YF+/i6SaAjZUtRzdQ+C6ZJVlLYgB4wlRwwX7Ry7X+f8kamLuddVVFXb9
         nTyM+/JqU7v+r93wAsdvbdhqP7FzabXzHsdg1FPlXYZH2cvYwkPFzxXWrc4IMfgtJlun
         MLHjVOSgwRoAjXnHI3Q5/V/9pnMWSY3YE94MJWCvMmkp3mrIhnY4FfVMQ7D53wdQxuIv
         q/v0Ofu4mPTvP2/0hkbZO5TqOMsjgvZHDqEk8IK3ZeWmjgyzC7lbEMzG49sX3OMhTcCb
         K9pVCLmFvwPwm2QBrKhHMuNONvWqexMDDxZyQAvjF9BYNCcowUpng879dZXttx6bfbCs
         9kTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=sNx64mG9XeE6HyPYXQSn8k/iXLoWHAOBZBM7roZm538=;
        b=t7GhA0O1vabfbEDTStwvFwghj/3EtvpPXRGRIkXEGOrHlfMjE2WuXJKvtTQkMJUwW5
         0+NlRPDWHEHCwKfwzBv6eaLRc/eZIfoShT+BQPjHCayzoKHkKEHtZYWa8rJUiXzHTodL
         TKc2KUBhJncBGzcw6bqOKJ6ny4CgI1noeE+KJvqWW/Jf8iZwnJrP3Lsg01oJRDL+WYun
         a7ba/O/nE/1GfLxGR7SsLfxiq8uw7c0Jt78hugvMptCkyKJeDkmrbIjE8s2/XT9PMUOW
         2bpl7wmrphfqJHFekIsN07drClv5gVHmRXZjW31xaa3nRuFEWTm7nCq9W0IzkMsyMQo9
         Hwnw==
X-Gm-Message-State: ACgBeo1a3zsJe/1zRje3621xkR0mMV0Oco2ctq0dwVuyv4BZFrIGvb9G
        IkaxB4oekK90k8MDRk0HTR31zjEk80A=
X-Google-Smtp-Source: AA6agR4bFOM2b6mrOHKLnA7TOF0OGa93TgrbaLROfy0cgRGMJEW5mrvGPPZSFD7cPeWhue9sDikB5A==
X-Received: by 2002:a17:90a:e655:b0:1fe:4ec3:aba with SMTP id ep21-20020a17090ae65500b001fe4ec30abamr1823100pjb.182.1662078439154;
        Thu, 01 Sep 2022 17:27:19 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l10-20020a63da4a000000b0042c0ffa0e62sm137154pgj.47.2022.09.01.17.27.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 17:27:18 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Fix hci_read_buffer_size_sync
Date:   Thu,  1 Sep 2022 17:27:17 -0700
Message-Id: <20220902002717.1823748-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_read_buffer_size_sync shall not use HCI_OP_LE_READ_BUFFER_SIZE_V2
sinze that is LE specific, instead it is hci_le_read_buffer_size_sync
version that shall use it.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216382
Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index fa433896ddc7..41b6d19c70b0 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3339,12 +3339,6 @@ static const struct hci_init_stage amp_init2[] = {
 /* Read Buffer Size (ACL mtu, max pkt, etc.) */
 static int hci_read_buffer_size_sync(struct hci_dev *hdev)
 {
-	/* Use Read LE Buffer Size V2 if supported */
-	if (hdev->commands[41] & 0x20)
-		return __hci_cmd_sync_status(hdev,
-					     HCI_OP_LE_READ_BUFFER_SIZE_V2,
-					     0, NULL, HCI_CMD_TIMEOUT);
-
 	return __hci_cmd_sync_status(hdev, HCI_OP_READ_BUFFER_SIZE,
 				     0, NULL, HCI_CMD_TIMEOUT);
 }
@@ -3558,6 +3552,12 @@ static const struct hci_init_stage hci_init2[] = {
 /* Read LE Buffer Size */
 static int hci_le_read_buffer_size_sync(struct hci_dev *hdev)
 {
+	/* Use Read LE Buffer Size V2 if supported */
+	if (hdev->commands[41] & 0x20)
+		return __hci_cmd_sync_status(hdev,
+					     HCI_OP_LE_READ_BUFFER_SIZE_V2,
+					     0, NULL, HCI_CMD_TIMEOUT);
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_READ_BUFFER_SIZE,
 				     0, NULL, HCI_CMD_TIMEOUT);
 }
-- 
2.37.2

