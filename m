Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD63C00140
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 02:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiHPCuq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Aug 2022 22:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiHPCuZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Aug 2022 22:50:25 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9319C2BB5CD
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 16:18:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id z187so7852168pfb.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 16:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=TzZmD3GbRQlajNIhZamfR7nU43gU0yqKwmRroEkX7tM=;
        b=Jrgt0B6XI/fvheVJOD4E/cnEb0PavV4oVUDir2YXkgege9qmOwPSuGu1NGnUaPb5hR
         82gctYFV0F69wPkZK+/bQiniXVsu6yS1ecLfBLhNG+outrm+iG0G71td6y00bFT8WSfR
         pap8RPV0w7BbOyl0jtTdm2o1yilFyrDNotVkecYjumFMHQTJT1L3vRNG2f8a148Fa3qf
         gqB3/pBl8fzje2ciaXVGxJmyqqOzkFHOSAAKTvhuc4Y9TdbCVNwVaTJRUy/gltr1lQHQ
         08I1IJ+7YKdNJNIfp8vtbfUwfIoXw4V8V4a5mzWVoWSFPQyr2W5qkQhI+CngpGmilwAQ
         iFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=TzZmD3GbRQlajNIhZamfR7nU43gU0yqKwmRroEkX7tM=;
        b=FMfXyezMeUCKNXAofPOchi7991tQkHaUHW2TrUD6Ln7NWaTe/OALdUGO5A5yzWPNE5
         Ubbya1AfrhtHmVpGVtLAus1uaCku/AsvtCp9nJvt68XHRRKbB5GKJp7HyfhaqJAfV/RZ
         aegDhDIB4QktaKxiuzaQKV5SOiK8B+zWELo0emJEE6dQqVDEoMjTxYgUw0S3rlTXEQsT
         WIsGsdI3sWrap9zmhgQxJLbI/OI3boJMl7qckuD+gW1CsjcENlX5wf3jVC+/Iprbrj0p
         lGNZgGph0bo9wchIRA6Z3A1Ckwhsl6rsL6CPcWFw5xJeWFXkRVuo0owMFCGk/Tbe2Kdh
         8CaA==
X-Gm-Message-State: ACgBeo35crJlps3EixdPryy3oYsIlgzzkpxL1N+EluyfiPueuecUj/Pv
        RiBd6QxeVecWKn2KaPca9oZ2XuSqInTSDw==
X-Google-Smtp-Source: AA6agR4Z8Luun1hsB8T6w277RYZMmjakuFivEJ9arfGJO7xiTT7nLyNjG4qo6wrMu3qeveuxOHuTLg==
X-Received: by 2002:a05:6a00:1907:b0:534:f847:b495 with SMTP id y7-20020a056a00190700b00534f847b495mr5202237pfi.47.1660605533339;
        Mon, 15 Aug 2022 16:18:53 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d2-20020a631d02000000b0041b823d4179sm6256007pgd.22.2022.08.15.16.18.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 16:18:52 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: MGMT: Fix Get Device Flags
Date:   Mon, 15 Aug 2022 16:18:48 -0700
Message-Id: <20220815231848.1252347-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Get Device Flags don't check if device does actually use an RPA in which
case it shall only set HCI_CONN_FLAG_REMOTE_WAKEUP if LL Privacy is
enabled.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 73 ++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 30 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index df20e15a05da..1cd7d6572892 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4546,6 +4546,22 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
 			       MGMT_STATUS_NOT_SUPPORTED);
 }
 
+static u32 get_params_flags(struct hci_dev *hdev,
+			    struct hci_conn_params *params)
+{
+	u32 flags = hdev->conn_flags;
+
+	/* Devices using RPAs can only be programmed in the acceptlist if
+	 * LL Privacy has been enable otherwise they cannot mark
+	 * HCI_CONN_FLAG_REMOTE_WAKEUP.
+	 */
+	if ((flags & HCI_CONN_FLAG_REMOTE_WAKEUP) && !use_ll_privacy(hdev) &&
+	    hci_find_irk_by_addr(hdev, &params->addr, params->addr_type))
+		flags &= ~HCI_CONN_FLAG_REMOTE_WAKEUP;
+
+	return flags;
+}
+
 static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 			    u16 data_len)
 {
@@ -4577,10 +4593,10 @@ static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 	} else {
 		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
 						le_addr_type(cp->addr.type));
-
 		if (!params)
 			goto done;
 
+		supported_flags = get_params_flags(hdev, params);
 		current_flags = params->flags;
 	}
 
@@ -4648,38 +4664,35 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 			bt_dev_warn(hdev, "No such BR/EDR device %pMR (0x%x)",
 				    &cp->addr.bdaddr, cp->addr.type);
 		}
-	} else {
-		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
-						le_addr_type(cp->addr.type));
-		if (params) {
-			/* Devices using RPAs can only be programmed in the
-			 * acceptlist LL Privacy has been enable otherwise they
-			 * cannot mark HCI_CONN_FLAG_REMOTE_WAKEUP.
-			 */
-			if ((current_flags & HCI_CONN_FLAG_REMOTE_WAKEUP) &&
-			    !use_ll_privacy(hdev) &&
-			    hci_find_irk_by_addr(hdev, &params->addr,
-						 params->addr_type)) {
-				bt_dev_warn(hdev,
-					    "Cannot set wakeable for RPA");
-				goto unlock;
-			}
 
-			params->flags = current_flags;
-			status = MGMT_STATUS_SUCCESS;
-
-			/* Update passive scan if HCI_CONN_FLAG_DEVICE_PRIVACY
-			 * has been set.
-			 */
-			if (params->flags & HCI_CONN_FLAG_DEVICE_PRIVACY)
-				hci_update_passive_scan(hdev);
-		} else {
-			bt_dev_warn(hdev, "No such LE device %pMR (0x%x)",
-				    &cp->addr.bdaddr,
-				    le_addr_type(cp->addr.type));
-		}
+		goto unlock;
 	}
 
+	params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
+					le_addr_type(cp->addr.type));
+	if (!params) {
+		bt_dev_warn(hdev, "No such LE device %pMR (0x%x)",
+			    &cp->addr.bdaddr, le_addr_type(cp->addr.type));
+		goto unlock;
+	}
+
+	supported_flags = get_params_flags(hdev, params);
+
+	if ((supported_flags | current_flags) != supported_flags) {
+		bt_dev_warn(hdev, "Bad flag given (0x%x) vs supported (0x%0x)",
+			    current_flags, supported_flags);
+		goto unlock;
+	}
+
+	params->flags = current_flags;
+	status = MGMT_STATUS_SUCCESS;
+
+	/* Update passive scan if HCI_CONN_FLAG_DEVICE_PRIVACY
+	 * has been set.
+	 */
+	if (params->flags & HCI_CONN_FLAG_DEVICE_PRIVACY)
+		hci_update_passive_scan(hdev);
+
 unlock:
 	hci_dev_unlock(hdev);
 
-- 
2.37.2

