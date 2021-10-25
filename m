Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF8CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 23:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC4560F46
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 23:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbhJYXnr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 19:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbhJYXnm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 19:43:42 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE37C061220
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 16:41:19 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id z11so1072067plg.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 16:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xxDbx7zNYLVpmSHkOThYw0BP07xgwIZOMfeavxbN9ok=;
        b=ayi4YogdUijok1gOhPGky6SOsAP4XDltBLrNZZrgOnByo9hZgIxhLnBrVJJenw7rNN
         SuL/8ARCRkoUKUfiB7yZnfNhag95RNibzHhLNFTFkb6WRY/RyToNVPXRfJyd4buJQ/bb
         jKHDz3P8T5sHg5S3tQAZhMiTaLotICK3eOI6TiUFfi7QaOkjg6OmmvT7f9gL337GDYSa
         GYXCsRQvPi9MxCKYLN0LY+GFH3P4Y2e7SXpFzXAdsaLtN4LcKIZG6GTZGow6vJjHIJHX
         zeA3xC3yiplhAH9Nm2i4HFnw3s2IqxVXlpiPbCXLZP9EyNvCFeuqEuS7Hw6MX5FR0ju9
         Ox2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xxDbx7zNYLVpmSHkOThYw0BP07xgwIZOMfeavxbN9ok=;
        b=2V+rK9AefBry5wDl5K4VPiAwoaMmdgq33FkfUy7wH0Rfo+Huyzq43sbyhuI6auOXed
         aMEawYAirN8SgvQaglup7p7rk0KRUJmW76Dq+Rt8A3hHj/eZembmwG7i2VWVbO8PX/zk
         XQX+hPFGneySNQYup8yfBodkzeNDuK+kv2zkCGFWy6RgTSsR1AnB4v0qNUFaMxA5pDaZ
         I2r/vj5xHNxJtV9FW1PglmZQ2WjcXBGYHxsjlS0lE+DYIrbmbT9a2+BnFRtWgeZJunRu
         DPFTN8doovBnLFP/9puTQJLiGCFFpFat0fWwARxsEqLRnT7FzovTHCfIEBgSWDawU6n+
         G4QA==
X-Gm-Message-State: AOAM531aAZwUlETE2RvUmBgFQJRf/sPOIOBW+d1h6ANwVgYdMbO0JJOW
        6TgC5v+EH6g+TtSequLXbyIsFR96J4s=
X-Google-Smtp-Source: ABdhPJxvd27NP+SIkYzEFgUgnMnP1KknJZd2VIbJNu0rgBWirSeT0L9AF7lsw8KWz6zrLIeQidg3hg==
X-Received: by 2002:a17:903:1248:b0:13f:cd7d:69eb with SMTP id u8-20020a170903124800b0013fcd7d69ebmr19063998plh.23.1635205278849;
        Mon, 25 Oct 2021 16:41:18 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g7sm16607133pgp.17.2021.10.25.16.41.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 16:41:18 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 20/23] Bluetooth: hci_sync: Convert adv_expire
Date:   Mon, 25 Oct 2021 16:40:59 -0700
Message-Id: <20211025234102.1140719-21-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025234102.1140719-1-luiz.dentz@gmail.com>
References: <20211025234102.1140719-1-luiz.dentz@gmail.com>
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
 net/bluetooth/mgmt.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 23f98bdcd022..5fa7ed45ccb1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3217,33 +3217,28 @@ static int user_passkey_neg_reply(struct sock *sk, struct hci_dev *hdev,
 				 HCI_OP_USER_PASSKEY_NEG_REPLY, 0);
 }
 
-static void adv_expire(struct hci_dev *hdev, u32 flags)
+static int adv_expire_sync(struct hci_dev *hdev, void *data)
 {
 	struct adv_info *adv_instance;
-	struct hci_request req;
-	int err;
+	u32 flags = PTR_ERR(data);
 
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
 }
 
 static void set_name_complete(struct hci_dev *hdev, void *data, int err)
@@ -3262,7 +3257,8 @@ static void set_name_complete(struct hci_dev *hdev, void *data, int err)
 				  cp, sizeof(*cp));
 
 		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
-			adv_expire(hdev, MGMT_ADV_FLAG_LOCAL_NAME);
+			hci_cmd_sync_queue(hdev, adv_expire_sync,
+				ERR_PTR(MGMT_ADV_FLAG_LOCAL_NAME), NULL);
 	}
 
 	mgmt_pending_remove(cmd);
@@ -3368,7 +3364,8 @@ static int set_appearance(struct sock *sk, struct hci_dev *hdev, void *data,
 		hdev->appearance = appearance;
 
 		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
-			adv_expire(hdev, MGMT_ADV_FLAG_APPEARANCE);
+			hci_cmd_sync_queue(hdev, adv_expire_sync,
+				ERR_PTR(MGMT_ADV_FLAG_APPEARANCE), NULL);
 
 		ext_info_changed(hdev, sk);
 	}
-- 
2.31.1

