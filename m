Return-Path: <SRS0=glhu=BC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B20C433E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 12:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6602620768
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 12:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t54Jm1mi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgGWMfL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGWMfK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jul 2020 08:35:10 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A881AC0619DC
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 05:35:10 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 1so2940276pfn.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 05:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xSub10RztAkAVkR7dQ1tuib+ohmh4r9LyvxXZPcSzms=;
        b=t54Jm1miiYNTB34tY64pYv+E9aKT8h/8GNbf10lz/YcAJZPt/KM7p7Z5oktdRwSDug
         fo6RPfuSHjheWzwfNEjlR72nyFjwIwfSTu5LAVGepzfIqHxMmLPoUxxQdmkO6n5+j4eq
         K/0wuKl7c0ewyMAcAaBP27nJ7p9U5REeYYTJD6Q2n9oaP6Icj3Kw8JRDu4sHWyy5sJOH
         j6z12sx0loPkTNuHRskcsqhBFxzNyGyGMe1lww7S1QdX32lnSPxN3WeOGqDFYJrsJXd9
         BxB2YUCDpr3wx9ByG0RdWU4ndmCUIbi4THWd+2NhCoSFaJChtUgi0EUWv0SpDBvOivtL
         Hfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xSub10RztAkAVkR7dQ1tuib+ohmh4r9LyvxXZPcSzms=;
        b=X+Wh/0jVu/ICm2CpB9KHLK75kaRMGT7E6XzzF8qwatNZmdDl/NH878K26Y3sZ1D0dn
         2RNLM1IuKIMsxImBDVFa1zUfYy+guvzWlOUe6/+kwP5LwyKJ/DDnR6J84xUdk2xKi3jt
         NDu9N1GJv3VVtZNh/nG+u+ieVx7LBUQLNS2Xi5GV7TE46oYQmO5e7oNelUKaqrqgMhFh
         shkkjdg/z2/emu4liTiCHfLp0U2FdrEtHuxQ5xEYUXgx2sc/yYAwTb6ct3p69Uv4lM7v
         2q+tecflb4pr+EStLPdt0SEGpEzgg98ZxXfghgCFkLBaH30cbjueUAqDEKtDm0HaMKg7
         PypA==
X-Gm-Message-State: AOAM533SVCGD18Mox+qhylwaxpt/QJtHY/iHR6dtFbR4W3qZwVx5iBhw
        zuo5avbmtUtnZGxh+fyu742bWXJwWhY=
X-Google-Smtp-Source: ABdhPJySZiGS7k6bdZiOmiFZxrcilAlnr37VheiGYs7PRAwVtzPB0RXtUSsr7kFcZrdUMPmzY2y7zw==
X-Received: by 2002:a65:5502:: with SMTP id f2mr3857382pgr.375.1595507709769;
        Thu, 23 Jul 2020 05:35:09 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id z11sm2849823pfr.71.2020.07.23.05.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:35:09 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH v5 1/8] Bluetooth: Translate additional address type correctly
Date:   Thu, 23 Jul 2020 18:08:56 +0530
Message-Id: <20200723123903.29337-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
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

