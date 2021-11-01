Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1D0C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 16:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006DA611C9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 16:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhKAQzQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 12:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhKAQzP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 12:55:15 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D65C061767
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Nov 2021 09:52:42 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id a9so7192429pgg.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Nov 2021 09:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qSJb4EHFpcg31hSEerygHqT9wyQWv1SThBibu9vMDPc=;
        b=V41OFns1fatfwcfSwjpIH/fDRP02f6uNlTzHg/p5qQS1vcCRzuHFVpo3pXxJkDVHua
         RwZ2tS6V/BTJThIo+0RB54jFQRGRgeEp06F4q2sM22dnhbCqU0cJjkj6v9h2MboaVxjj
         F+k+bp9psjDJuODFWJEkdO4CmgameJSq8o98CWxO0jYSM+Bxp3PV5hH1TaoOR4lDF2LD
         +7jRddlqO34TW/E2z06V4LE6Ll7vZtD90G2w8O9+nMMiIaLj8PASco/sBfiecpDR9nzo
         ikRrJ+avGj5msdDUSEOCm5B5eCvvj2+UZvZfhO6//iEdNDyvDye8I9uYSdvhqXFwfRkf
         7PxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qSJb4EHFpcg31hSEerygHqT9wyQWv1SThBibu9vMDPc=;
        b=dHdl6sVJZQaL+4bIJcY/wyvQYEP/pMR5HR3ihhiQ4QiVzo1IMfYG2ui9E+xA+pp0rr
         NxtQIpwqC5THuD4aTZMleWGylxqxUyveW9ETic+CGF/1290sUda9OFrYP412lTPhmhlJ
         fZjhdcG5Z8xdrBkUAHcFQPtTcxvAcei7feQneDUhnSto8l33jkOsl2gYXpmIx6ypc/vX
         Q/kocmpX7yk9UoIWE70xEKauXTPZ4oPhGC7RxClj/QxlEHtR8g+4vXbJ9KHmS7Q+R4wR
         A08LxxONIIbi2vHWFU11YmQL+Ql4PqKUEefW567kDT6a2gjrBAyWelT76N3Lt+sLdk7A
         APfA==
X-Gm-Message-State: AOAM532C8zLWbjnl9OLgT9GfoT+S70mKCu/zWzTyBMDUkbD9OR/Kn6N+
        bdzdmDGMZJ/Xrk2cSsvqUwY5e6JlvEw=
X-Google-Smtp-Source: ABdhPJw3HlWu0Q75l5IGa+9I4HkrgF8cz6/ZpPXfxG7LyNacoADmPBhY5sIM2YiUgJ4Rbn6vCUuVfQ==
X-Received: by 2002:a63:89c3:: with SMTP id v186mr8262032pgd.57.1635785561539;
        Mon, 01 Nov 2021 09:52:41 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f8sm12690818pfj.36.2021.11.01.09.52.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:52:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_sync: Fix missing static warnings
Date:   Mon,  1 Nov 2021 09:52:40 -0700
Message-Id: <20211101165240.2707193-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following warnings:

>> net/bluetooth/hci_sync.c:1333:5: warning: no previous prototype for
'hci_scan_disable_sync' [-Wmissing-prototypes]
    1333 | int hci_scan_disable_sync(struct hci_dev *hdev, bool rpa_le_conn)
         |     ^~~~~~~~~~~~~~~~~~~~~
>> net/bluetooth/hci_sync.c:1762:5: warning: no previous prototype for
'hci_passive_scan_sync' [-Wmissing-prototypes]
    1762 | int hci_passive_scan_sync(struct hci_dev *hdev)
         |     ^~~~~~~~~~~~~~~~~~~~~

Fixes: e8907f76544f ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 3")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e3f44e621b7f..fb7ecf24b89a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1397,7 +1397,7 @@ static int hci_le_set_addr_resolution_enable_sync(struct hci_dev *hdev, u8 val)
 				     sizeof(val), &val, HCI_CMD_TIMEOUT);
 }
 
-int hci_scan_disable_sync(struct hci_dev *hdev)
+static int hci_scan_disable_sync(struct hci_dev *hdev)
 {
 	int err;
 
@@ -1968,7 +1968,7 @@ static int hci_start_scan_sync(struct hci_dev *hdev, u8 type, u16 interval,
 	return hci_le_set_scan_enable_sync(hdev, LE_SCAN_ENABLE, filter_dup);
 }
 
-int hci_passive_scan_sync(struct hci_dev *hdev)
+static int hci_passive_scan_sync(struct hci_dev *hdev)
 {
 	u8 own_addr_type;
 	u8 filter_policy;
-- 
2.31.1

