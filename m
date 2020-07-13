Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A644C433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFDA207BC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPd7Sm4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgGMGIf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgGMGIf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 02:08:35 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D4FC061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:08:35 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id z5so5577067pgb.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xSub10RztAkAVkR7dQ1tuib+ohmh4r9LyvxXZPcSzms=;
        b=CPd7Sm4TlRPWYosX9tW/r3dPGBy0AvY3Bh/M6+lf1lmsS1eV1GJJxepMVj+lgInh3G
         uMfGUDlI5jh8grnmG+h1wUxqNSule4RZkHwTAvDn+QZKridnb8Es9BBcMbB+zq6ffM/m
         7LOo8Z5ZLWrTHQmrDo7uQoAAFUFqAIQDLdMxLJHalBIqkyGoIwb4L38oHx5XIr57GTss
         z17BE5cEHrL/5njPAd9jO1GlvQ9+yq7MTpvSlc8Sfo5YMdjmeRmG1kX5AXuZ8FKzt5Xh
         Qio+ITndxr1IS0NWdWX1/SPGTx8NyOSLuH4JCTpefswlmiAdcnECMUsOBCvg6eMT7vQ0
         hG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xSub10RztAkAVkR7dQ1tuib+ohmh4r9LyvxXZPcSzms=;
        b=DvXSLy6J1hOeQUHBS2oFfK0sC6iyQs/0vMGUaCpK03FuAB3zm6eU6wUux25Na0u02n
         L7on3STheFYdHf3XAkdm/1UTMbxADJggCBsqKAYNjuttkjobELJQSfsJy9PGyY3SR7Cc
         zrBrxOP8jMjD5/oa59cVUCcaD07osU+7m83rwc2qqznsA7H5ZyRAmydtDvWo+CXiwf0q
         eeqRAlU+iTKIEuve7dL9M9aXofgbbJuXvZjYtDMsqEBGjEuh1MQ+vsaOQR3B/9w3L0RK
         ROyedp7/Vc4OivuiCdi1+nQY+ZC9QqcjXagPVHpA3hAUDyCarmJPZcPOMxWIxB7tAnFy
         lWmA==
X-Gm-Message-State: AOAM531OFgLOrHqC98eaEfJoAyVVys1GLXQRFlULvOLSXzofFBQMzMCC
        1STjx92tAR46YHOTGzECuCRRDOvKrBwsCA==
X-Google-Smtp-Source: ABdhPJyhnSC8rE3wulFMuWP6H7sWccibZlpM1+tMTVQZayNiuaBSX95D23frXmrh78ALllah5SUMDA==
X-Received: by 2002:aa7:858c:: with SMTP id w12mr53777378pfn.143.1594620514778;
        Sun, 12 Jul 2020 23:08:34 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id e5sm12787172pjy.26.2020.07.12.23.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 23:08:34 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH 1/8] Bluetooth: Translate additional address type correctly
Date:   Mon, 13 Jul 2020 11:42:13 +0530
Message-Id: <20200713061220.3252-2-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713061220.3252-1-sathish.narasimman@intel.com>
References: <20200713061220.3252-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Marcel Holtmann <marcel@holtmann.org>

When using controller based address resolution, then the new address
types 0x02 and 0x03 are used. These types need to be converted back into
either public address or random address types.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
---
 include/net/bluetooth/hci.h | 6 ++++--
 net/bluetooth/hci_core.c    | 9 +++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1f18f71363e9..abab8b5981a7 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2268,8 +2268,10 @@ struct hci_ev_le_conn_complete {
 #define LE_EXT_ADV_SCAN_RSP		0x0008
 #define LE_EXT_ADV_LEGACY_PDU		0x0010
 
-#define ADDR_LE_DEV_PUBLIC	0x00
-#define ADDR_LE_DEV_RANDOM	0x01
+#define ADDR_LE_DEV_PUBLIC		0x00
+#define ADDR_LE_DEV_RANDOM		0x01
+#define ADDR_LE_DEV_PUBLIC_RESOLVED	0x02
+#define ADDR_LE_DEV_RANDOM_RESOLVED	0x03
 
 #define HCI_EV_LE_ADVERTISING_REPORT	0x02
 struct hci_ev_le_advertising_info {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6509f785dd14..4af208b82138 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3290,6 +3290,15 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 {
 	struct hci_conn_params *param;
 
+	switch (addr_type) {
+	case ADDR_LE_DEV_PUBLIC_RESOLVED:
+		addr_type = ADDR_LE_DEV_PUBLIC;
+		break;
+	case ADDR_LE_DEV_RANDOM_RESOLVED:
+		addr_type = ADDR_LE_DEV_RANDOM;
+		break;
+	}
+
 	list_for_each_entry(param, list, action) {
 		if (bacmp(&param->addr, addr) == 0 &&
 		    param->addr_type == addr_type)
-- 
2.17.1

