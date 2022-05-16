Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E989C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 May 2022 17:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344128AbiEPRFG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 May 2022 13:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344135AbiEPRFA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 May 2022 13:05:00 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16A42A272
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 May 2022 10:04:54 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id v10so14636069pgl.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 May 2022 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9+uANn3l31var8yu5aBA2DkhqU3A/cNGB0PonZfMGTs=;
        b=ZIan1eYZKgT5Z/Ki4DHW5zjuv6pwcpOR6lGq964tVI8T7cNC3OMV7aBX9+kYU8cK+8
         Xt6r37CVNQWOMFWbnGuWsSNzv/sEnnqfcbm5To4E7yHPgs3QBuudnsXaOVw/nVit7Sy/
         i5RVdXoP+HgimLcQoprmiIGT3vozRlAdAeVRDqf2V3PwdQWFL+5UXMN8z0GOBCjoVEf0
         iZikvhyZ7wtFqhPrZ6kLDY3Z3ru/mXUvaiALE4vD7IyCQBWIhEPoZlxjT1LC2iAznQFl
         dn1U1kx3IRdyGBljXJUYFJdoJkxDd50OxmppiTYgn53J2ENW0EBrKPQtfN4xRrTR/uAf
         pigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9+uANn3l31var8yu5aBA2DkhqU3A/cNGB0PonZfMGTs=;
        b=CLosJwodifuFShfPUN0NuYo7GQ8eMWWchkDJsDcJD4IgR+4nstJYUa+sWsJVqJMdYX
         wYd6yXTYmecP8PIojG3zTJHq5gP1IQCn3Tn/7c553o7+ddj57Yom29Fu+1fRDOW1YS3M
         oueHA+8SOPz0IclI+BpWtA4+eB/GVYvj1Ls1GW0RdCa1we5b+negFDhQk/n5z4E5AYfZ
         iKVBVhOwTeArqOnDOYSvRKVG3Iunh+uVsQ+E6bQguR04YQwYIkC23ptCH8GKMPsFvsCD
         bkWJsldrJcE/xUtTu8UOV7gzZBULTGvZn/t4XyRFlBgYwwjSbuvZPHYsjERiR78JaDs2
         mEIw==
X-Gm-Message-State: AOAM531QkO+DgaybIFf8hn9oYEXS2MDMLGUW/ZwAYQy4fIynUkJH0B9V
        yEUXsZZ/hGQfjIH8pYcLpqhkDxHkd7s=
X-Google-Smtp-Source: ABdhPJw15/SEbmab4vdiRlDlMPH16g/QdQa/rPiDzlXySlw6bFwafykvmyexwcYQ3jBhvEAm1p1Mzw==
X-Received: by 2002:a05:6a00:2310:b0:4fa:7eb1:e855 with SMTP id h16-20020a056a00231000b004fa7eb1e855mr18716531pfh.14.1652720694063;
        Mon, 16 May 2022 10:04:54 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id cv15-20020a17090afd0f00b001df67a6da6asm1691119pjb.7.2022.05.16.10.04.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 10:04:53 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: MGMT: Replace uses of bitmap_from_u64 with bitmap_from_arr32
Date:   Mon, 16 May 2022 10:04:52 -0700
Message-Id: <20220516170452.1642546-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bitmap_from_u64 expects at least 8 bytes to be declared since it doesn't
take any parameter regarding the number of bits causing the following
warnings:

In file included from include/linux/cpumask.h:12,
                 from include/linux/mm_types_task.h:14,
                 from include/linux/mm_types.h:5,
                 from include/linux/buildid.h:5,
                 from include/linux/module.h:14,
                 from net/bluetooth/mgmt.c:27:
In function 'bitmap_copy',
    inlined from 'bitmap_copy_clear_tail' at include/linux/bitmap.h:270:2,
    inlined from 'bitmap_from_u64' at include/linux/bitmap.h:622:2,
    inlined from 'set_device_flags' at net/bluetooth/mgmt.c:4534:4:
include/linux/bitmap.h:261:9: warning: 'memcpy' forming offset [4, 7] is
out of the bounds [0, 4] of object 'flags' with type
'long unsigned int[1]' [-Warray-bounds]
  261 |         memcpy(dst, src, len);
      |         ^~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/kasan-checks.h:5,
                 from include/asm-generic/rwonce.h:26,
                 from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from include/linux/compiler.h:248,
                 from include/linux/build_bug.h:5,
                 from include/linux/container_of.h:5,
                 from include/linux/list.h:5,
                 from include/linux/module.h:12,
                 from net/bluetooth/mgmt.c:27:
net/bluetooth/mgmt.c: In function 'set_device_flags':
net/bluetooth/mgmt.c:4532:40: note: 'flags' declared here
 4532 |                         DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS);
      |                                        ^~~~~
include/linux/types.h:11:23: note: in definition of macro 'DECLARE_BITMAP'
   11 |         unsigned long name[BITS_TO_LONGS(bits)]
      |                       ^~~~

In order to fix the above this replaces the uses of bitmap_from_u64 with
bitmap_from_arr32 wich does takes the properly take the number of bits.

Fixes: a9a347655d22 ("Bluetooth: MGMT: Add conditions for setting HCI_CONN_FLAG_REMOTE_WAKEUP")
Reported-By: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 74937a834648..878be1cac5b7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4519,7 +4519,8 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 							      cp->addr.type);
 
 		if (br_params) {
-			bitmap_from_u64(br_params->flags, current_flags);
+			bitmap_from_arr32(br_params->flags, &current_flags,
+					  __HCI_CONN_NUM_FLAGS);
 			status = MGMT_STATUS_SUCCESS;
 		} else {
 			bt_dev_warn(hdev, "No such BR/EDR device %pMR (0x%x)",
@@ -4531,7 +4532,8 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (params) {
 			DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS);
 
-			bitmap_from_u64(flags, current_flags);
+			bitmap_from_arr32(flags, &current_flags,
+					  __HCI_CONN_NUM_FLAGS);
 
 			/* Devices using RPAs can only be programmed in the
 			 * acceptlist LL Privacy has been enable otherwise they
@@ -4546,7 +4548,8 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 				goto unlock;
 			}
 
-			bitmap_from_u64(params->flags, current_flags);
+			bitmap_from_arr32(params->flags, &current_flags,
+					  __HCI_CONN_NUM_FLAGS);
 			status = MGMT_STATUS_SUCCESS;
 
 			/* Update passive scan if HCI_CONN_FLAG_DEVICE_PRIVACY
-- 
2.35.1

