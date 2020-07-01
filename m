Return-Path: <SRS0=mBsK=AM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A31C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 10:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11E982073E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 10:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPIyk2MQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgGAKBF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgGAKBF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jul 2020 06:01:05 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E820C061755
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2020 03:01:05 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k71so7264505pje.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2020 03:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XQsMIxXrDju3xAGiOt+lQ1c1a9XOuAjcFVyUXi9Jbzc=;
        b=qPIyk2MQ7xE5iit4ig06C+IlJAqBoFofUEB3fixTef2LJinF5BBVdOSZ32dvyDYGjA
         /cLvq91XC6c+wLfj+9998vpSRxamJ8YiDXeL8eVjTjhrlnVPcGDIs4zJ48oAWseaY1iG
         6ANcNHxfgxoNW8oZe3Zozw821niCI/k/8b9TeGcj4FtzVneby7XuBiVfQk0eVSc5jZDB
         gjZ8KTzKxUFngKo7JmLtSutFfYT8gT4WgOKj7+qS51SGebMHSkhM7kiw1cmC+CHWRUfr
         +icEev1RiKhQwGqY4H1259hOL+lNaEluPwh8W64WGOWgV4b7c3vkuHhLG24R0zhvS9V1
         ivSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XQsMIxXrDju3xAGiOt+lQ1c1a9XOuAjcFVyUXi9Jbzc=;
        b=o2+uMZYzSfzz/vIa80pbySq2BVtM+2elkVo88N/LoCeFIkiCM2FUQg+yGeLxPCOLId
         ycS4JaOVxJMURTBIlVx9cN8mQeh5JcpVAb7dOTgIYcsNS+d0ODbIRg3fNWz5M2pAE0IW
         UGnP5ABfnH2OVGMxiLBsXhoOl95KskyPkRh5nfqKNFdh+rML0103mXqLF9iy7vKEcYV4
         oOyjKmYFQ/0esbRe/c12GhtQP1Aza9e1YHcTETUzKg5QbRuGWH2Am/ovWYqxVgVPwwxv
         ECE+1EwVLrVSBKy1d8lAzNaGKwjsinzJMPbWc9eUVrvWt4WksFy6BNKMtMI7xZodRlSK
         qD6w==
X-Gm-Message-State: AOAM5316USq6PZocLzHVdwfeLHMTLvjAsKYEWl0Q+VBNqMltw/zAgtza
        /cvDSvfeXo7TYvnFw10yuXGyHXAooP6Cmw==
X-Google-Smtp-Source: ABdhPJxeXuLH4fet/q2DK7GV3yM5Don8vOyea4yvctMPCuNcv4RaTPfj8DROHZBCfcNxxi5IR23YTA==
X-Received: by 2002:a17:902:9309:: with SMTP id bc9mr22102673plb.232.1593597664642;
        Wed, 01 Jul 2020 03:01:04 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id d37sm5381961pgd.18.2020.07.01.03.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 03:01:04 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH v3 1/8] Bluetooth: Translate additional address type correctly
Date:   Wed,  1 Jul 2020 15:34:25 +0530
Message-Id: <20200701100432.28038-2-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701100432.28038-1-sathish.narasimman@intel.com>
References: <20200701100432.28038-1-sathish.narasimman@intel.com>
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
index 5577cf9e2c7c..604a411a9b8f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3292,6 +3292,15 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
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

