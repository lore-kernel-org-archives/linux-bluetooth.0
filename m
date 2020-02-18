Return-Path: <SRS0=m/C2=4G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4463C34026
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 12:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7974B206F4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 12:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIm8cyt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgBRMgh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Feb 2020 07:36:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33036 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgBRMgg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Feb 2020 07:36:36 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so10906224pgk.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2020 04:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hZ3DX26wZMAKcheoiq0ujRr9oBErAtuhMtcmr305aMo=;
        b=NIm8cyt1o3h3vkiilwTJtwEu3YZKXyy5T7wT2StMknwCgDOvVct+QRApcY5siSYV0b
         2JOd1neoPYsRDFa84pn0Ne7MZ5dP3NZRurWO4L/L8Ppt9iaX88i5S5LiFo2BgtAI64HP
         yYvQ4cbqZaK9HqU+9ectm6YChV7bqA5cPuXyI0ZqCk7WKqh3CUnOyGGyiCfJ3moRNVkc
         qP4NbvfSl3pj5PWGUM4qz7vcS0E+fuIf+dx4+aPOYJDrJw7ZazEaCgRyFOfZLVFMFoog
         F0at0gJsE1ychcwuaOGPHJO8+tyayNo43Ezo9w6NlDXSNT/PgiT+n0tO9eIBhAVidpUh
         +wEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hZ3DX26wZMAKcheoiq0ujRr9oBErAtuhMtcmr305aMo=;
        b=Vzts8/WefH4AeW70tdbX7mevBgGRjMcslbbdIrqPgZE+dibwuaLngUDG/y/f4Z9k6K
         eeJDarirc0Uhr/j/yQ8awfQfUCdoFf8VyrgsweHf+eqVhd4pFOUPLs/xzOjxcBwPNzSv
         GQvEdfOUuLBcarHrnYcP/LE3VnNtxIiL8x399Ht+pps7cKQC5MpU5Vju4jLDuNyeZdxc
         xVx/h0wR0AVhRWPzZywoz1yJCIMr9/7ij6HUVIZing2LkKRhr2z05iwtaLUJYOTXdTsy
         qIBCdWd7a+gk/FxR/GjC4uHDGps6hX/ubfPGATBRn1tj610U01h3uomZvta3TMlM1Ix+
         mHfQ==
X-Gm-Message-State: APjAAAV8OGNaBGyZC2yqarN6kY7iKo2LF05mmHE2pNmpnnadgjOVgiQk
        Bz+2dRxc05P9aI2kNF/+445fiAnii3Q=
X-Google-Smtp-Source: APXvYqzMyabQYQHfq2Tkd37sgzSd4Hs+/XTzXQ003x2qzX4KToxjHQMyNur+hrpRsLvZEo1NSB69Kg==
X-Received: by 2002:a62:f94d:: with SMTP id g13mr21112309pfm.60.1582029391792;
        Tue, 18 Feb 2020 04:36:31 -0800 (PST)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id p24sm4613859pgk.19.2020.02.18.04.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 04:36:31 -0800 (PST)
From:   Sathish Narsimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narsimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org, nsathish41@gmail.com
Cc:     Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH] Bluetooth: Fix - During le_conn_timeout disable EXT_ADV
Date:   Tue, 18 Feb 2020 18:07:47 +0530
Message-Id: <20200218123747.3006-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Disabling LE_LEGACY_ADV when LE_EXT_ADV is enabled causes 'command
disallowed . This patch fixes that issue and disables EXT_ADV if
enabled.

Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
---
 net/bluetooth/hci_conn.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a582c676e584..a8d8a876363c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -481,9 +481,19 @@ static void le_conn_timeout(struct work_struct *work)
 	 * (which doesn't have a timeout of its own).
 	 */
 	if (conn->role == HCI_ROLE_SLAVE) {
-		u8 enable = 0x00;
-		hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable),
-			     &enable);
+		if (ext_adv_capable(hdev)) {
+			struct hci_cp_le_set_ext_adv_enable cp;
+
+			cp.enable = 0x00;
+			cp.num_of_sets = 0x00;
+
+			hci_send_cmd(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE,
+				     sizeof(cp), &cp);
+		} else {
+			u8 enable = 0x00;
+			hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE,
+				     sizeof(enable), &enable);
+		}
 		hci_le_conn_failed(conn, HCI_ERROR_ADVERTISING_TIMEOUT);
 		return;
 	}
-- 
2.17.1

