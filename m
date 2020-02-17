Return-Path: <SRS0=SJVD=4F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66B5C7619F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Feb 2020 09:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7907A20718
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Feb 2020 09:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDGNVQw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgBQJGK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:06:10 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37030 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbgBQJGK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Feb 2020 04:06:10 -0500
Received: by mail-pg1-f193.google.com with SMTP id z12so8735293pgl.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2020 01:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=80rs4W6R0HIIbQ770wNeQg7LbJLKILfAsUBfyaO5AKc=;
        b=nDGNVQw4/2gUArMIB+co59GbuvYlqkH9na/STD2Q7Jtw8Yld29CSPRMKpB8YRR8sFo
         5306RmEkQT2yWCT1rTnlJYbcKj5jDQFOoEHrBBPSNKpYQSM0mGHUAHzADu4hwfIi9M2D
         e9HRCWitZ7jdzGlLqPUSYzVsu++O3wfTrmJF+qg/+pMPlLFgSp317y6zWJRPrnVlVyeD
         gw+OQ5e4los/kkVAGQkOxL9PhBQSIs91kCFR8z/9/Fxh4RugmAorM0lB1t218lSU4ov3
         vXakH9TmhSSDpD75kGpAtqeK7awt9lp1iyYDjR1qNc7Db/7tJnD+XznNkbRcbU9gW5Wq
         6Fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=80rs4W6R0HIIbQ770wNeQg7LbJLKILfAsUBfyaO5AKc=;
        b=IzSkKc0yD2rqNzb+nY+07hj8wzf0MQcVIkxIGJlN8DkgMYsvJmlRjpeMRIGfpsrTEK
         OgjL5Y9AbNcnyY/v7LYlesEmCc/9PTiox/dR/VsdaDJ2DgFKo+hxYGZf9x3RHEUfC9P1
         NfwOJrzXlBR4cX33Y8nm1/lvy05hnazZSPkJTi4bCbJpAv3NjYpWZiz11PTwSU6Zp8Jr
         RBJ84rI8oiPBuRpJ0aL19M+jhTz3lrs9N0oR81flfRU7Ql4A/YgxLpvem849RYpT9NJx
         fu7NbUVorqQSflPZE/R+Pkks6kPucwL55g0HlWeAosgIYwMRfj85eCxhF8/1A1SiVR4B
         ENvQ==
X-Gm-Message-State: APjAAAVwQmRyE/L/7+U6W5b3PQxFgkSH0hXDwXIwSmj4ETimXe6aeLUY
        o3DlLDz3Jm3YMmnEFjvoOl3XooktkIOyow==
X-Google-Smtp-Source: APXvYqzzumKyoln9iPrikag+NzeYo1qOnRiNQ7aeTQrRixYBj6cEYoBWO4ZrFPyRkQ6jGxAY0sx4lw==
X-Received: by 2002:a17:90a:e291:: with SMTP id d17mr19430352pjz.116.1581930369169;
        Mon, 17 Feb 2020 01:06:09 -0800 (PST)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.41])
        by smtp.gmail.com with ESMTPSA id b42sm15900337pjc.27.2020.02.17.01.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 01:06:08 -0800 (PST)
From:   Sathish Narsimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narsimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org, nsathish41@gmail.com
Cc:     Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH] Bluetooth: FIX - Disable EXT Adv if enabled
Date:   Mon, 17 Feb 2020 14:37:44 +0530
Message-Id: <20200217090744.909-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Disabling LEGACY_ADV when EXT_ADV is enabled causes
'command disallowed' during DIRECTED_ADV. This Patch fixes this
issue.

Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
---
 net/bluetooth/hci_conn.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 65fa44cbe514..a582c676e584 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1029,11 +1029,8 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	 * anyway have to disable it in order to start directed
 	 * advertising.
 	 */
-	if (hci_dev_test_flag(hdev, HCI_LE_ADV)) {
-		u8 enable = 0x00;
-		hci_req_add(&req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable),
-			    &enable);
-	}
+	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
+		 __hci_req_disable_advertising(&req);
 
 	/* If requested to connect as slave use directed advertising */
 	if (conn->role == HCI_ROLE_SLAVE) {
-- 
2.17.1

