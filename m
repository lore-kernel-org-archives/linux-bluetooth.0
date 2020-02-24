Return-Path: <SRS0=SAxJ=4M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96270C3567B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 05:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB6A20661
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 05:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqMVMN2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgBXFWK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Feb 2020 00:22:10 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40408 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgBXFWK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Feb 2020 00:22:10 -0500
Received: by mail-pg1-f193.google.com with SMTP id t24so123311pgj.7
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Feb 2020 21:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Yz1o/o6tGznMg7VG4DjGlf61tnjwj/8JdaaNdxd6SB8=;
        b=cqMVMN2flaRSDeUIO/vvTn8X2n96w26CNd1s6GEHQSYBv0RHGXbJB0m8KT0+YjteyQ
         F3O6AOmgK0STLsQQXKTG5M2SYcbdimyPywZBgKJ5ZvJ3/ly2Eb0TQ/3PhZpmINxRbWHX
         djdBEwNO91a+rqyh4iaIq9q3hVQ/npS4n0iHe8cr6OuOwHN72vjd5Mkd84QBXTtVIJNQ
         0r4r0S/bdja3bLan2l+YuAogv+W6z/9Ri3oz62fd6t0GJQJS7+jpxr9Jumo0T6IjxHPN
         onjsgj657RlpPtRS3yPPXRsx3wnDkWzp+0lfttSPXj1daxuQeXzZumd484k2szzAQzOO
         LAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Yz1o/o6tGznMg7VG4DjGlf61tnjwj/8JdaaNdxd6SB8=;
        b=nFSeXpsdOFG5cQRlGk3/MuYZasf2dwwP1vxV5vOTSk4rwvqTsd9xdZXxNcJ5W/dDmz
         +YMJ7/6uL0NTUfxvJeS33qXelz3pxBG9+dyLX8OucFLDa+N/oKagLtuIzM0lt+ffqCeh
         lD8+2bR6tbfygHi4xLReDwwEeL8dKNpUUIevbypf1KbREuG+JZSZX3xTnN5GHpAA7i1z
         cp++v9l6LIhRBrq89S2pQabEHiUbQeX6y/FCZ6vAsM8AJ8UwfizRpI0VTpmZOdYZCuAe
         +qEz/NN3650u66lBE9rMEjXAlwn7BnWwEZJigJ4Paf3zsy8HEizlwRR6PD8j5yZHC2QN
         UeYg==
X-Gm-Message-State: APjAAAV/FKyAUF5vdyONMjeuGccUEWZLDNMBkRd7y09WevH7ltS72L6R
        MJa7mzMh5kEFExYVqVhw0AyptUrK
X-Google-Smtp-Source: APXvYqzL61uzRRqMNhZntUsW5fTTTEmwkFDg6+oGGpTlQlvOIwAI/A+jW0Q8xWJjy/+OMRK0P9FcIA==
X-Received: by 2002:a63:8149:: with SMTP id t70mr52346801pgd.215.1582521729419;
        Sun, 23 Feb 2020 21:22:09 -0800 (PST)
Received: from nsathish-Latitude-7480.iind.intel.com ([134.134.137.79])
        by smtp.gmail.com with ESMTPSA id g9sm11006595pfm.150.2020.02.23.21.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 21:22:08 -0800 (PST)
From:   Sathish Narsimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narsimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org, nsathish41@gmail.com
Cc:     Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH v2] Bluetooth: Fix - During le_conn_timeout disable EXT_ADV
Date:   Mon, 24 Feb 2020 10:53:40 +0530
Message-Id: <20200224052340.14409-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sathish Narsimman <nsathish41@gmail.com>

Disabling LE_LEGACY_ADV when LE_EXT_ADV is enabled causes 'command
disallowed . This patch fixes that issue and disables EXT_ADV if
enabled.

Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
---
 net/bluetooth/hci_conn.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a582c676e584..358c58c198f5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -467,6 +467,23 @@ static void hci_conn_auto_accept(struct work_struct *work)
 		     &conn->dst);
 }
 
+static void le_disable_advertising(struct hci_dev *hdev)
+{
+	if (ext_adv_capable(hdev)) {
+		struct hci_cp_le_set_ext_adv_enable cp;
+
+		cp.enable = 0x00;
+		cp.num_of_sets = 0x00;
+
+		hci_send_cmd(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE, sizeof(cp),
+			     &cp);
+	} else {
+		u8 enable = 0x00;
+		hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable),
+			     &enable);
+	}
+}
+
 static void le_conn_timeout(struct work_struct *work)
 {
 	struct hci_conn *conn = container_of(work, struct hci_conn,
@@ -481,9 +498,8 @@ static void le_conn_timeout(struct work_struct *work)
 	 * (which doesn't have a timeout of its own).
 	 */
 	if (conn->role == HCI_ROLE_SLAVE) {
-		u8 enable = 0x00;
-		hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable),
-			     &enable);
+		/* Disable LE Advertising */
+		le_disable_advertising(hdev);
 		hci_le_conn_failed(conn, HCI_ERROR_ADVERTISING_TIMEOUT);
 		return;
 	}
-- 
2.17.1

