Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E323C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 23:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45C91610CB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 23:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhJ1ABq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 20:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhJ1ABn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 20:01:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D439C061745
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 16:59:17 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id l203so4268104pfd.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 16:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OwDWiQHGjIVbhNRrhcx3QVZhfVUXoH+hrcomsKcZOus=;
        b=PqWZw81tlWG+GYRFzrYunb+d1ilKGPr4gw12VdCfxvXVWXNdkDwukwkESjgGVSKctt
         eDRuju9pk63ehr2291C/rGrtJ6rPY/tTEhJXZbKgWFRtDsnC6GsQRqVvP0jE7NK4HMU0
         bzssYHobmgH2OY2lK5Wc6+9UFIjEkdBi1dTKgJu/xW1XLkTG0akoBUoOig5nUVAX8cSr
         Wr+z82h5YiviZTsD/ddt32s44kmaeQWHC3pUGXHReOPjmGlNwFvR4gZKaWCHgyVm3fV1
         D2drbybcWEtJYcfXDKqGaUdruhaCatvyXg5YPsvuGU3SF5XjDD8kt4NzjtsuWhd2Nwbs
         bpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OwDWiQHGjIVbhNRrhcx3QVZhfVUXoH+hrcomsKcZOus=;
        b=PflsXhzMHrPGCgN0jAGbTEPMi+KSSfcLKEITkIRRTtzV8HvDhXTJ/uW1EI5EIEhKnv
         QyKHs75d0HZew2f/UujmK6COB4jjgu6FzK3fAVrkv49CXYEJIfD2Vnj+O/pnsDMa9af1
         XKCXsX5N9xd2SHXFqDImN1TbTKAi2+heYGtS4wrf3vqXxwUc/ZRI0lakPAk7vyrOKji0
         iJc+/ULJlCtS/TEwOtle+ODD0kbIexgfnounN7fLlmGlNYBfDhbUAGyNW2HVSJEcx6NY
         1dbklBiJZloaq2DTvQKWhsBvm440M1VFtBmH0SvQp/YW6+49xDXf8f3KtLTBGSNSkaK9
         Xj/A==
X-Gm-Message-State: AOAM533qX51kX8EikJOvvPACI8qGNwGhJA2vzJ5A7tAdn+11+PaGyj3d
        Fr2/2+xqJJp+dyfw2M9ZqVYKSSpL+0g=
X-Google-Smtp-Source: ABdhPJzP0v7iuD8M2L9HvM+KZ+tgzqoGwMbtTriLNGAXBZcx4Twlo7jggA0g4R5aN3dHllUS6Xfygg==
X-Received: by 2002:a63:df06:: with SMTP id u6mr694520pgg.148.1635379156738;
        Wed, 27 Oct 2021 16:59:16 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 142sm807908pgh.22.2021.10.27.16.59.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 16:59:16 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 20/23] Bluetooth: hci_sync: Convert adv_expire
Date:   Wed, 27 Oct 2021 16:58:57 -0700
Message-Id: <20211027235900.1882863-21-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027235900.1882863-1-luiz.dentz@gmail.com>
References: <20211027235900.1882863-1-luiz.dentz@gmail.com>
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
index 48a901c93141..ee144fadcab6 100644
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

