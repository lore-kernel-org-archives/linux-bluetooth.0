Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9027C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95ECD610C8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhJ0WUv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 18:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhJ0WUs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 18:20:48 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E53C061745
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:21 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e65so4364483pgc.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WQp1eRvZyG5z2C8hHO+xiwc4UgE4FClF8EhPxKqDgtE=;
        b=a+ZB4Kz2rZ913wetATaRNva+tNHRBVjSsNw0Y4WmLZzt9v2QEu4lv9URVIB0l137oi
         dsOJSm11+d1H+nHQeGP6c9x0xxPBLF/ti5foevaeWoy31c1M4r4z+oF9Q/lgmExPEuTO
         ER7tUbvGEHADnESvet3rzPJHPF8ZlDiZI/iWMQQtlf+YEJKJnmBcAA2PoGNAcYtK0+4Q
         gJPSb5P2YaQoC5JmnRxIx6L5AfvDucWlwc8eRM23ogDQO/ZjRT/driInybodGU6RGZIk
         HGFom41tvY9DcJ1eJ5+B33yhsjpWdUjuno/2AG8jr8TXhGrwO5MgOpHb/8rRBWGfziXI
         llKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQp1eRvZyG5z2C8hHO+xiwc4UgE4FClF8EhPxKqDgtE=;
        b=XpXrQM6KgzkFF2VWKJY0W8k5KiUDlFsnlBnLhqUsW3PWs3llVT58tOQSslr+jUQiW2
         GvbzU0qOfC4E4xoqZu239s/ir3gB2FDpIZs17bKQ2Kohx534VcoVs+cm2iGqJAWFVLYf
         5faJCJRtew/efRy0If2mHP13XXzYT6JlPkNEWeVv1x5L6R4JUbo5OMnd4SAtvdkc4maf
         i9DFnGS9lEwDn0nP/OTrUUVTq3mz6vJmyYRSPma4aN6y7s3ejBWrgA6Bsj31poePLhwy
         HyDr+8xXfI3uGC7my5Ibaw2O35MmYwuj1g+1Mu8hZeI2ASqGKMtJiuB/R9I9Kyv2Jco1
         GLWg==
X-Gm-Message-State: AOAM532l/D+SyJ+HG8IEIK0kRzxtM8gT+ow+Rl6lBNyEVI3YSR/npdPl
        zIYnTirSxDE3hRp5OFn6HH9KnyFoiFw=
X-Google-Smtp-Source: ABdhPJyW/g0bLV06Aj08BKJQFbYabi6rh/5aUbrfWOT562h+24x5wqqHLYxAg9MoaN+GsWtE8JYpCQ==
X-Received: by 2002:a63:ae09:: with SMTP id q9mr337566pgf.63.1635373100684;
        Wed, 27 Oct 2021 15:18:20 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a25sm902760pfl.115.2021.10.27.15.18.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 15:18:20 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 20/23] Bluetooth: hci_sync: Convert adv_expire
Date:   Wed, 27 Oct 2021 15:17:59 -0700
Message-Id: <20211027221802.1851851-21-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027221802.1851851-1-luiz.dentz@gmail.com>
References: <20211027221802.1851851-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

mgmt-test paths:
Set Advertising on - Appearance 1
Set Advertising on - Local name 1
Set Advertising on - Name + Appear 1
Set Local Name - Success 2
Set Local Name - Success 3
Add Advertising - Success (Empty ScRsp)
Add Advertising - Success (ScRsp appear)
Add Advertising - Invalid Params (ScRsp appear long)
Add Advertising - Success (Complete name)
Add Advertising - Success (Shortened name)
Add Advertising - Success (Short name)
Add Advertising - Success (Name + data)
Add Advertising - Invalid Params (Name + data)
Add Advertising - Success (Name+data+appear)
Set appearance - BR/EDR LE
Set appearance - LE only
Add Ext Advertising - Success (Empty ScRsp)
Add Ext Advertising - Success (ScRsp appear)
Add Ext Advertising - Invalid Params (ScRsp appear long)
Add Ext Advertising - Success (Complete name)
Add Ext Advertising - Success (Shortened name)
Add Ext Advertising - Success (Short name)
Add Ext Advertising - Success (Name + data)
Add Ext Advertising - Invalid Params (Name + data)
Add Ext Advertising - Success (Name+data+appear)

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 net/bluetooth/mgmt.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 391d87f85294..0a1c19087f2f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3217,33 +3217,32 @@ static int user_passkey_neg_reply(struct sock *sk, struct hci_dev *hdev,
 				 HCI_OP_USER_PASSKEY_NEG_REPLY, 0);
 }
 
-static void adv_expire(struct hci_dev *hdev, u32 flags)
+static int adv_expire_sync(struct hci_dev *hdev, u32 flags)
 {
 	struct adv_info *adv_instance;
-	struct hci_request req;
-	int err;
 
 	adv_instance = hci_find_adv_instance(hdev, hdev->cur_adv_instance);
 	if (!adv_instance)
-		return;
+		return 0;
 
 	/* stop if current instance doesn't need to be changed */
 	if (!(adv_instance->flags & flags))
-		return;
+		return 0;
 
 	cancel_adv_timeout(hdev);
 
 	adv_instance = hci_get_next_instance(hdev, adv_instance->instance);
 	if (!adv_instance)
-		return;
+		return 0;
 
-	hci_req_init(&req, hdev);
-	err = __hci_req_schedule_adv_instance(&req, adv_instance->instance,
-					      true);
-	if (err)
-		return;
+	hci_schedule_adv_instance_sync(hdev, adv_instance->instance, true);
 
-	hci_req_run(&req, NULL);
+	return 0;
+}
+
+static int name_changed_sync(struct hci_dev *hdev, void *data)
+{
+	return adv_expire_sync(hdev, MGMT_ADV_FLAG_LOCAL_NAME);
 }
 
 static void set_name_complete(struct hci_dev *hdev, void *data, int err)
@@ -3262,7 +3261,7 @@ static void set_name_complete(struct hci_dev *hdev, void *data, int err)
 				  cp, sizeof(*cp));
 
 		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
-			adv_expire(hdev, MGMT_ADV_FLAG_LOCAL_NAME);
+			hci_cmd_sync_queue(hdev, name_changed_sync, NULL, NULL);
 	}
 
 	mgmt_pending_remove(cmd);
@@ -3347,6 +3346,11 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
+static int appearance_changed_sync(struct hci_dev *hdev, void *data)
+{
+	return adv_expire_sync(hdev, MGMT_ADV_FLAG_APPEARANCE);
+}
+
 static int set_appearance(struct sock *sk, struct hci_dev *hdev, void *data,
 			  u16 len)
 {
@@ -3368,7 +3372,8 @@ static int set_appearance(struct sock *sk, struct hci_dev *hdev, void *data,
 		hdev->appearance = appearance;
 
 		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
-			adv_expire(hdev, MGMT_ADV_FLAG_APPEARANCE);
+			hci_cmd_sync_queue(hdev, appearance_changed_sync, NULL,
+					   NULL);
 
 		ext_info_changed(hdev, sk);
 	}
-- 
2.31.1

