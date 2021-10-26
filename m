Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9879C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0C8610E5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240183AbhJZXGJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Oct 2021 19:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240181AbhJZXGG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Oct 2021 19:06:06 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1613FC061767
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:42 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id y1-20020a17090a134100b001a27a7e9c8dso3166554pjf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=V1ZgTLkk9AWmWliAzoFzQFkR/qzvpzHog73LJmcY6B8=;
        b=LVUrqQqWiizl7Or/I9PL2LTCSYXi2S/iL/IZfRKxXh4gDxRrfpGKad1HY41kHpEnWh
         4HzUriHqNRij3rs22Ruu2QZOSVV29KxDBYxbsR/UA2yqHuXMu1YC3egdJApjS3w0Cb5W
         NYvjz38Pu+ewNlaZP5HbcM+5eFryV18r3DEXwuAFwm6BADR0pN/kTS4ClseNhGHkjwUO
         d46duh87IFPYdsOrb5QQu6r49CtoTz2+3aivWjqdh4oOupz96uZjxUJ/IV3gRAVeCjvR
         Lh3fMXppodgd3nJAzck4s88WgP/C0OzW6u292aklX09So38wqP2YxfkgxifKIOiHcXX4
         YoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V1ZgTLkk9AWmWliAzoFzQFkR/qzvpzHog73LJmcY6B8=;
        b=RGcvNpMyBinICsET33Ow0r1cQWzzxcpgkQrXC1vpg7cC1V4d33hSqM/73hVQBAloVX
         kNjPW6jgCon9PYoAh5UAZso+/7AIIcWRiJHfmf1d6OT0kEvZ6zj6CDEsSTP2wuGmaUdv
         OEVtGZ0tqeG7JLa1qy+HEaqRZNC1obSyBa6EbqHp+liRzEYQyqmVmgC1dg6njkuE1bOO
         +tVeNQb6/ukna06EZKJ6sgKB6hdWWreOAFK+Th/DSB8yfvfrwcguQvmWpi6ge7cr9R7l
         YZJ1x7uuZErELojWXz/PrzcPF8qOsgW2TET4W7Kjk27T5Y1c9McWuF2U3f7sGNksmdGk
         QCsQ==
X-Gm-Message-State: AOAM5309+26NDW6DsaT52/F1cRWJbta4gftc+2BHkFDE2F4K8uNp37O7
        Ykxp+0d5xkRloXELTFo0ojcLmpxIy5Q=
X-Google-Smtp-Source: ABdhPJzZy8XCbyFQLDqdxJ8FXG1khDiLlQZVLrcttbovNiwuZU3x5Bnv+CUrs0zJj8CZCenpV8slFQ==
X-Received: by 2002:a17:902:c410:b0:13e:cfac:45ad with SMTP id k16-20020a170902c41000b0013ecfac45admr25316141plk.68.1635289421381;
        Tue, 26 Oct 2021 16:03:41 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a2sm20697558pgn.20.2021.10.26.16.03.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:03:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 20/23] Bluetooth: hci_sync: Convert adv_expire
Date:   Tue, 26 Oct 2021 16:03:21 -0700
Message-Id: <20211026230324.1533907-21-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026230324.1533907-1-luiz.dentz@gmail.com>
References: <20211026230324.1533907-1-luiz.dentz@gmail.com>
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
index 22c6e4aab926..a14d3c26331c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3218,33 +3218,32 @@ static int user_passkey_neg_reply(struct sock *sk, struct hci_dev *hdev,
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
@@ -3263,7 +3262,7 @@ static void set_name_complete(struct hci_dev *hdev, void *data, int err)
 				  cp, sizeof(*cp));
 
 		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
-			adv_expire(hdev, MGMT_ADV_FLAG_LOCAL_NAME);
+			hci_cmd_sync_queue(hdev, name_changed_sync, NULL, NULL);
 	}
 
 	mgmt_pending_remove(cmd);
@@ -3348,6 +3347,11 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
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
@@ -3369,7 +3373,8 @@ static int set_appearance(struct sock *sk, struct hci_dev *hdev, void *data,
 		hdev->appearance = appearance;
 
 		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
-			adv_expire(hdev, MGMT_ADV_FLAG_APPEARANCE);
+			hci_cmd_sync_queue(hdev, appearance_changed_sync, NULL,
+					   NULL);
 
 		ext_info_changed(hdev, sk);
 	}
-- 
2.31.1

