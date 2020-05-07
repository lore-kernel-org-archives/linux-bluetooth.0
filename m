Return-Path: <SRS0=Gf0L=6V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7C6C38A2A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 21:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E576E20663
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 21:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ibNgTHVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgEGVLN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 May 2020 17:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgEGVLN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 May 2020 17:11:13 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0E9C05BD43
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2020 14:11:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x15so3628365pfa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2020 14:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XENfBiTJw9E9Rtbe0OzRWQ3FYDRuG6S5hHWv6IBsaso=;
        b=ibNgTHVrzD1E/Y3o4X7uGQ7f+68HYK9rpAZGI0XAxEMmRWqmDdwQAL47zysW0sVd6W
         KElTkvpOoeUFhF9UUDiya3NF7d+95zoWpECN//URXeMOtI4ppBSp75cOxj2Hig/NL+4f
         DEun6nsfMQN89Q+tnpOlz1Th1EwudCIP+VzsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XENfBiTJw9E9Rtbe0OzRWQ3FYDRuG6S5hHWv6IBsaso=;
        b=aS9b6yi9TkyJX79zVpatD8NviBoX8j/wyRSatH3la/IXywd9dNRNdjBEKQoB8d+OV6
         hZQRUIRsjM/dx9wez5gUWc+dWVo2ezE3nKUfTLKar85ZYgpVQw6uz3kn2G0emFpFvGIz
         nS3ui2bmB1pvlKEss6E8HQKNxbk8NDuOLL4nHNvWG+2waHr4bNukQ7HJFPlRqkyvnKhA
         CJFmjPWbKfLfsbFsg+XIYrOEuTU6NNyo0ARY68yJXXY61K/tGbTTzLBg9Zoo+xG91BZH
         XyrnOuUaoEszeSe+4HeNJbod6fjITtJ9z2rAurdInPgi9bP36yaP/aZERsjFNHOdFM5G
         gvHw==
X-Gm-Message-State: AGi0PubEyWmhlALjifG+EMSi8wufRG1X/tw3O8SYBOGW2p96PL/DXfMp
        3N0V1Smg/WAvjxkpHpsVNXQbvibn/PM=
X-Google-Smtp-Source: APiQypL93WDkqegJ0m3rM2KZTMJMY5ps5/3QJIXKxeI7gYOFZ8KyZLX4JKt319MJVXh1iVlwVkio+g==
X-Received: by 2002:a63:1961:: with SMTP id 33mr13425718pgz.282.1588885871147;
        Thu, 07 May 2020 14:11:11 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id 16sm623156pjg.56.2020.05.07.14.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:11:10 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [Bluez PATCH] shared/gatt-db: Check for null pointers
Date:   Thu,  7 May 2020 14:11:00 -0700
Message-Id: <20200507141055.Bluez.1.Ie4c027829af0f3ca2ba0e532706584a554a69d38@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Make sure the attribute, service and service attributes are not null
before accessing them.

The problem was seen with the following stack trace:

 0  bluetoothd!gatt_db_attribute_get_service_data [gatt-db.c : 1648 + 0x0]
    rax = 0x0000000000000000   rdx = 0x00007ffce8cf70ec
    rcx = 0x0000000000000000   rbx = 0x0000000000000000
    rsi = 0x00007ffce8cf70ee   rdi = 0x00005a56611f05c0
    rbp = 0x00007ffce8cf70d0   rsp = 0x00007ffce8cf70b0
     r8 = 0x0000000000000000    r9 = 0x0000000000000050
    r10 = 0x0000000000000073   r11 = 0x0000000000000246
    r12 = 0x00005a56611cea10   r13 = 0x00005a56611efd90
    r14 = 0x0000000000000000   r15 = 0x00005a565f3eed8d
    rip = 0x00005a565f48147e
    Found by: given as instruction pointer in context
 1  bluetoothd!discovery_op_complete [gatt-client.c : 386 + 0x14]
    rbx = 0x00005a56611e9d30   rbp = 0x00007ffce8cf7120
    rsp = 0x00007ffce8cf70e0   r12 = 0x00005a56611cea10
    r13 = 0x00005a56611efd90   r14 = 0x00007ffce8cf70ec
    r15 = 0x00005a565f3eed8d   rip = 0x00005a565f47a6bc
    Found by: call frame info
 2  bluetoothd!discover_chrcs_cb [gatt-client.c : 1000 + 0xf]
    rbx = 0x0000000000000000   rbp = 0x00007ffce8cf71d0
    rsp = 0x00007ffce8cf7130   r12 = 0x000000000000000a
    r13 = 0x00005a56611de920   r14 = 0x00005a56611cea10
    r15 = 0x00007ffce8cf7188   rip = 0x00005a565f47b18a
    Found by: call frame info
 3  bluetoothd!discovery_op_complete [gatt-helpers.c : 628 + 0xc]
    rbx = 0x00005a56611f0430   rbp = 0x00007ffce8cf71f0
    rsp = 0x00007ffce8cf71e0   r12 = 0x00005a56611ea5a0
    r13 = 0x00005a56611cd430   r14 = 0x00005a56611f0430
    r15 = 0x00005a566119bc01   rip = 0x00005a565f47d60e
    Found by: call frame info
 4  bluetoothd!discover_chrcs_cb [gatt-helpers.c : 1250 + 0xe]
    rbx = 0x00005a56611bf0f1   rbp = 0x00007ffce8cf7240
    rsp = 0x00007ffce8cf7200   r12 = 0x00005a56611ea5a0
    r13 = 0x00005a56611cd430   r14 = 0x00005a56611f0430
    r15 = 0x00005a566119bc01   rip = 0x00005a565f47cc7a
    Found by: call frame info

---

 src/shared/gatt-db.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index b44f7b5e9..2432bdfd4 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -513,6 +513,7 @@ bool gatt_db_remove_service(struct gatt_db *db,
 		return false;
 
 	service = attrib->service;
+	attrib->service = NULL;
 
 	queue_remove(db->services, service);
 
@@ -1605,7 +1606,7 @@ bool gatt_db_attribute_get_service_data(const struct gatt_db_attribute *attrib,
 	struct gatt_db_service *service;
 	struct gatt_db_attribute *decl;
 
-	if (!attrib)
+	if (!(attrib && attrib->service && attrib->service->attributes))
 		return false;
 
 	service = attrib->service;
-- 
2.26.2.645.ge9eca65c58-goog

