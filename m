Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCED8C00140
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Aug 2022 03:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbiHODNr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Aug 2022 23:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbiHODNq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Aug 2022 23:13:46 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5696913E9E
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Aug 2022 20:13:45 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r69so5568370pgr.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Aug 2022 20:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=D7WubgfLGh4Txwp4GSb0Ehoc6LqsJZj/Z/4ejrIVpus=;
        b=RSy/HsWnM93ELa2iCKW8e9Bqe9wdxXKc/N34rV4Z6i6cCoczMyjeHP+BLVJQzbiwTp
         xft7uLWF93I2VTKYqki6Idt7QYhwhd8l+w08HU7i6hb/5tm6P4WhEmDpR+5LHrQBNj3l
         f6bLGnof4Nk/k1Z4MQx8oYtUikz+/VwRvpKDp+16V32UGUsoGQ/jgJtJatBYbZ0dYdAA
         Kr6Kd76J3DzBA8uNV3ExctGaNPdfizL1rlyAC5F28taZybAeSD4Oq2QgwUWWnQenuAUE
         GBj4aBTU9O7XjV/JsUjo+apiKtTxo7fPITNakozFNAj9tuoNr8kqD5pRKxYmpJnAhx7X
         t28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=D7WubgfLGh4Txwp4GSb0Ehoc6LqsJZj/Z/4ejrIVpus=;
        b=nLCOSbqgW7zWhddyJqnnz56aC+Vvwqdpn63ohbtx0mRCl+Yi3MJwf6eoUT0KHqVQli
         bfL26xYDwYvaVmdvID1E24jByB9DoPWz5IFUPNRUFH2TEPZia7M7EfwTXOLnG19HddCG
         3OXCujQlt+FhcCcZBpx2yaWVZsMxKlcQpwxMf5nhl2jwRemtRNd7THeacmpS/QVAe8kP
         WiAfQQ6JrLdRSDDkeZdA6kdKKWOGXty5nFN/lXpLp1jZfd4PqYG8O59qQx6d3ydyfvGC
         V8i1Z7xjzSfNyQA5nDFtCuYrTvPtx6mGZ9OoObqq3BZmZuseXwW8xOy5p86ZeleHi8P+
         Tzxw==
X-Gm-Message-State: ACgBeo1S38tz7qNSbJKRx0MtC75LNWGTMkPvAs2XNxk/HtjZLQpSTs6q
        xhFRDb+MAH+gB2vy+5JaKLU=
X-Google-Smtp-Source: AA6agR7Nes8J6UkcMkl5tPm7rj+dUjXgJVnV22IR08mbeJc2Ci2+eBLNKMhKWEmaNzeFEaLezX8WUA==
X-Received: by 2002:a05:6a00:1709:b0:52e:677b:702b with SMTP id h9-20020a056a00170900b0052e677b702bmr14484918pfc.19.1660533224809;
        Sun, 14 Aug 2022 20:13:44 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s23-20020a170902a51700b0016bf4428586sm6039085plq.208.2022.08.14.20.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 20:13:44 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     luiz.dentz@gmail.com
Cc:     marcel@holtmann.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        linux-bluetooth@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] Bluetooth: hci_conn:Use kzalloc instead of kmalloc/memset
Date:   Mon, 15 Aug 2022 03:13:32 +0000
Message-Id: <20220815031332.64190-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

From the coccinelle check:

./net/bluetooth/hci_conn.c
WARNING  kzalloc should be used for d, instead of kmalloc/memset

Use kzalloc rather than duplicating its implementation, which
makes code simple and easy to understand.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 net/bluetooth/hci_conn.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 337e74d0f8b1..184c790af045 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -824,11 +824,10 @@ static int hci_le_terminate_big(struct hci_dev *hdev, u8 big, u8 bis)
 
 	bt_dev_dbg(hdev, "big 0x%2.2x bis 0x%2.2x", big, bis);
 
-	d = kmalloc(sizeof(*d), GFP_KERNEL);
+	d = kzalloc(sizeof(*d), GFP_KERNEL);
 	if (!d)
 		return -ENOMEM;
 
-	memset(d, 0, sizeof(*d));
 	d->big = big;
 	d->bis = bis;
 
@@ -861,11 +860,10 @@ static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, u16 sync_handle)
 
 	bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", big, sync_handle);
 
-	d = kmalloc(sizeof(*d), GFP_KERNEL);
+	d = kzalloc(sizeof(*d), GFP_KERNEL);
 	if (!d)
 		return -ENOMEM;
 
-	memset(d, 0, sizeof(*d));
 	d->big = big;
 	d->sync_handle = sync_handle;
 
@@ -2034,7 +2032,7 @@ int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
 	if (hci_dev_test_and_set_flag(hdev, HCI_PA_SYNC))
 		return -EBUSY;
 
-	cp = kmalloc(sizeof(*cp), GFP_KERNEL);
+	cp = kzalloc(sizeof(*cp), GFP_KERNEL);
 	if (!cp) {
 		hci_dev_clear_flag(hdev, HCI_PA_SYNC);
 		return -ENOMEM;
@@ -2046,7 +2044,6 @@ int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
 	else
 		dst_type = ADDR_LE_DEV_RANDOM;
 
-	memset(cp, 0, sizeof(*cp));
 	cp->sid = sid;
 	cp->addr_type = dst_type;
 	bacpy(&cp->addr, dst);
-- 
2.25.1
