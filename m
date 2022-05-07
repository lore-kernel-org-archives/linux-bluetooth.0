Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F58C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 May 2022 12:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242692AbiEGMhQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 May 2022 08:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiEGMhN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 May 2022 08:37:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808FD10FE4
        for <linux-bluetooth@vger.kernel.org>; Sat,  7 May 2022 05:33:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q23so13399456wra.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 May 2022 05:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uAMT/vodZl+FVN3nPbHGuvnaOQU0eGLHYODulInt4eo=;
        b=lswj+Q4jSef9nhVSApy1E0vCvwMzfYWnzPMhYS7zHHnvUz3oGF7n7H0Q7dqe3o1NzI
         cjlgsU+/jvfZWSUmNjAow2sVVrgOHX8PyNMxmat7faOQES8btohZC7qR/DLc+8zxGyzD
         3Vm1CNeP0Q/2SVJmKtlK8cOUWI4cZ587VhICcXzJORJsco8kuIrM/Cxr4Tt9KHzQTqiM
         Dj82AdY8TQYIcXOBXZb5GUxSgW2c5LFY5qAzE6j3cqqRBvRkAneqf8K83U+ZSaIhJYha
         zEwskHUST6QWaMNH4iIgnFhamOmRS+9AKbklJFgapnwanC5tLsrTA+nKMgl8yY3cUYvO
         msCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uAMT/vodZl+FVN3nPbHGuvnaOQU0eGLHYODulInt4eo=;
        b=EFVezFIjyezbGIVjxhlLXsk3BE/GS59sfohKzwFd7sGMxgJgH+W9oy+Vx5mXNGfFng
         kwhLX3v1Vhn4UDd8MsVW+7YeDl0prRSqJgz8jwOlUPTOFxehuoZEOgFLGOulkWFn0R/x
         xxcjcioDhzaTGhwfobtfGzvV0lo6KXp9E14WL7i96KVJR320XQ6ZnujmroeiDHss0va6
         0IG9gjUWWb8RirytNr7Ejkgu0nLtUTLWDURtUbh1gQJme6f3AwlLj8LYQgGkJr/omwm5
         NC4W/3Vqseo4+aXhU/YnHTkkt82ggdJoaJl6vRDPVhkP7OnkCPvYeF8gZVzimYy7ZaON
         fQ5Q==
X-Gm-Message-State: AOAM533a4axkfh08Q0W00G0D5+iPS3z4/E90Qj7uQ1mBbqs1lypniQyu
        KfpGIug8GBPWumrs1C1yTgfmWGMxUov6Uw==
X-Google-Smtp-Source: ABdhPJzXmwyDLaS5SnSLu417d9nBSXGEB1gR+H12IEVvugqD8dbYDolYAPSurCUtM8Kb0bMkjEeXyA==
X-Received: by 2002:a05:6000:2a7:b0:20c:4d42:189b with SMTP id l7-20020a05600002a700b0020c4d42189bmr6613107wry.16.1651926805822;
        Sat, 07 May 2022 05:33:25 -0700 (PDT)
Received: from localhost.localdomain ([176.228.146.249])
        by smtp.gmail.com with ESMTPSA id bw26-20020a0560001f9a00b0020ac8c19ecfsm5699140wrb.3.2022.05.07.05.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 05:33:25 -0700 (PDT)
From:   Itay Iellin <ieitayie@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Subject: [PATCH] Bluetooth: Fix the creation of hdev->name
Date:   Sat,  7 May 2022 08:32:48 -0400
Message-Id: <20220507123248.432213-1-ieitayie@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Set a size limit of 8 bytes of the written buffer to "hdev->name"
including the terminating null byte, as the size of "hdev->name" is 8
bytes. If an id value which is greater than 9999 is allocated,
then the "snprintf(hdev->name, sizeof(hdev->name), "hci%d", id)"
function call would lead to a truncation of the id value in decimal
notation.

Set an explicit maximum id parameter in the id allocation function call.
The id allocation function defines the maximum allocated id value as the
maximum id parameter value minus one. Therefore, HCI_MAX_ID is defined
as 10000.

Signed-off-by: Itay Iellin <ieitayie@gmail.com>
---
 include/net/bluetooth/hci_core.h | 3 +++
 net/bluetooth/hci_core.c         | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 64d3a63759a8..5a52a2018b56 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -36,6 +36,9 @@
 /* HCI priority */
 #define HCI_PRIO_MAX	7
 
+/* HCI maximum id value */
+#define HCI_MAX_ID 10000
+
 /* HCI Core structures */
 struct inquiry_data {
 	bdaddr_t	bdaddr;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ad4f4ab0afca..5abb2ca5b129 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2555,10 +2555,10 @@ int hci_register_dev(struct hci_dev *hdev)
 	 */
 	switch (hdev->dev_type) {
 	case HCI_PRIMARY:
-		id = ida_simple_get(&hci_index_ida, 0, 0, GFP_KERNEL);
+		id = ida_simple_get(&hci_index_ida, 0, HCI_MAX_ID, GFP_KERNEL);
 		break;
 	case HCI_AMP:
-		id = ida_simple_get(&hci_index_ida, 1, 0, GFP_KERNEL);
+		id = ida_simple_get(&hci_index_ida, 1, HCI_MAX_ID, GFP_KERNEL);
 		break;
 	default:
 		return -EINVAL;
@@ -2567,7 +2567,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (id < 0)
 		return id;
 
-	sprintf(hdev->name, "hci%d", id);
+	snprintf(hdev->name, sizeof(hdev->name), "hci%d", id);
 	hdev->id = id;
 
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
-- 
2.30.2

